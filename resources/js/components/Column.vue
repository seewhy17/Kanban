<template>
    <div class="column">
        <div class="column__head">
            <div>{{ title }}</div>
            <button @click="removeColumn">&#10006;</button>

        </div>

            <Card @update_card="updateCard" v-for="card in cards" :key="card.id" :id="card.id" :title="card.title" :description="card.description" :label="card.label"></Card>


        <button class="column__button" @click="showCardForm = !showCardForm">{{ buttonText }}</button>
        <div v-show="showCardForm" class="addCard">
            <input type="text" v-model="cardTitle" placeholder="Enter Card Title">
            <textarea v-model="cardDescription" placeholder="Enter Card Description"></textarea>
            <button @click="addCard">Save Card</button>
        </div>

    </div>
</template>
<script>
import Card from './Card.vue';
export default {
    props: {
        id: Number,
        columnId: String,
        title: String,
        cards: {
            type: Array,
            default: function () {
                return []
            }
        }
    },
    name: 'Column',
    components: {
        Card,
    },
    data() {
        return {
            cardTitle: '',
            cardDescription: '',
            showCardForm: false,
            oldIndex: '',
            newIndex: '',
        }
    },
    methods: {
        removeColumn() {
            this.$emit('delete_column', this.columnId)
        },
        addCard: async function() {
            if (this.cardTitle == '' || this.cardDescription == '') return
            const newCard = {
                title: this.cardTitle,
                description: this.cardDescription,
                label: this.generateLabel(),
                id: this.id
            }
            this.cards.push(newCard)
            try {
                const response = await axios.post('/api/card', newCard)
                if (response.data.status == 'success') {
                    this.clearForm()
                    this.showCardForm = false
                } else {
                    this.clearForm()
                    this.removeCard_UI(newCard.label)
                }
            } catch(error) {

            }
        },
        updateCard: async function(newCardData) {
            const label = newCardData.label
            const oldCardData = this.getOldCard(label)
            this.replaceCard_UI(label, newCardData)
            console.log(oldCardData);
            try{
                const response = await axios.put(`/api/card/${newCardData.id}`, {
                    title: newCardData.title,
                    description: newCardData.description,
                })
                if (response.data.status != 'success') {
                    this.replaceCard_UI(label, oldCardData)
                }
                console.log(response.data.status)
            } catch (error) {
                this.replaceCard_UI(label, oldCardData)

            }
        },
        generateLabel() {
            let a = new Uint32Array(3);
            window.crypto.getRandomValues(a);
            return (performance.now().toString(36)+Array.from(a).map(A => A.toString(36)).join("")).replace(/\./g,"");
        },
        getCardIndex(cardLabel) {
            return this.cards.findIndex(card => card.label === cardLabel)

        },
        removeCard_UI(cardLabel) {
            const cardIndex = this.getCardIndex(cardLabel)
            this.cards.splice(cardIndex, 1)
        },
        replaceCard_UI(cardLabel, newCard) {
            const cardIndex = this.getCardIndex(cardLabel)
            this.cards.splice(cardIndex, 1, newCard)

        },
        getOldCard(cardLabel) {
            const cardIndex = this.getCardIndex(cardLabel)
            return this.cards[cardIndex]
        },
        clearForm() {
            this.cardTitle = '',
            this.cardDescription = ''
        }

    },
    computed: {
        buttonText() {
            return (this.cards.length > 0) ? `+ Add Another Card`: `+ Add Card`
        }
    }
    // mounted: async function() {
    //     const response = await axios.get(`/api/column/${this.id}`)
    //     console.log(response.data)
    //     this.cards = response.data.cards
    // }
}
</script>
<style lang="scss" scoped>
    .column {
        max-width: 270px;
        background-color: #6EE7B7;
        max-height:auto;
        overflow-y: auto;
        font-weight: 500;
        color: #064E3B;
        border-radius: 0.25rem;
        padding: .5rem;
        overflow: hidden;
        &__head {
            display: flex;
            font-size: 1rem;
            justify-content: space-between;
            button {
                color: #047857;
                font-weight: 500;
                background-color: transparent;
                cursor: pointer;
                border-radius: 50%;
                &:hover,
                &:focus {
                    outline: none;
                }
                &:hover {
                    background-color: #34D399;
                }
            }
        }
        &__button {
            font-family: inherit;
            border-radius: 0.25rem;
            background-color: #34D399;
            color: #064E3B;
            font-weight: 600;
            font-size: .9rem;
            padding: .25rem .5rem;
            margin-top: .5rem;
            transition: background-color .2s ease-in;
            &:hover,
            &:focus {
                outline: none;
            }
            &:hover {
                cursor: pointer;
                background-color: #A7F3D0;
            }


        }
    }
    .addCard {
        input, textarea {
            border-radius: .25rem;
            font-family: inherit;
            font-size: .9rem;
            display: block;
            width: 100%;
            max-width: 100%;
            margin: .25rem 0;
            outline: none;
            padding: .35rem;
        }
        input {
        }
    }

</style>
