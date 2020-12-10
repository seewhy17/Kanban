<template>
    <div class="card">

        <div class="card__title">{{ title }}</div>
        <button  @click="showModal" class="card__button">&#10000;</button title="">

        <modal class="modal" name="edit-card">
            <div class="form">
                <label class="form__label"><span>Title</span>
                    <input v-model="cardTitle" type="text">

                </label>
                <label class="form__label"><span>Description</span>
                    <textarea v-model="cardDescription"></textarea>
                </label>
                <button @click="updateCard">Update Card</button>

            </div>
        </modal>
    </div>
</template>
<script>
import draggable from 'vuedraggable'
export default {
    name: 'Card',
    props: ['id', 'title', 'description', 'label'],
    data() {
        return {
            cardTitle: this.title,
            cardDescription: this.description,
        }
    },
    methods: {
        showModal () {
            this.$modal.show('edit-card');
        },
        hideModal () {
            this.$modal.hide('edit-card');
        },
        updateCard() {
            if (this.cardTitle == '' || this.cardDescription == '' ) return
            const cardData = {
                id: this.id,
                label: this.label,
                title: this.cardTitle,
                description: this.cardDescription,

            }

            this.hideModal()
            this.$emit('update_card', cardData)

        }
    }
}
</script>
<style lang="scss" scoped>
    .card {
        display: flex;
        justify-content: space-between;
        font-family: inherit;
        background-color: #ECFDF5;
        padding: .25rem;
        margin: 0.25rem 0;
        font-weight: 500;
        font-size: .8rem;
        border-radius: 0.15rem;
        box-shadow: 0 1px 5px #059669;
        &__button {
            display: block;
            color: #059669;
            padding: 0 .25rem;
            cursor: pointer;
            background-color: transparent;
            border-radius: 50%;
            transition: font-size .2s linear;
            &:hover,
            &:focus {
                outline: none;
                font-size: .9rem;
            }
        }
    }
    .form {
        font-family: inherit;
        padding: 1rem;
        &__label > span {
            font-size: 1rem;
            margin-bottom: .4rem;
            color: #34D399;
        }
        button {
            font-family: inherit;
            padding: .5rem;
            background-color: #6EE7B7;
            border-radius: .25rem;
            &:hover,
            &:focus {
                outline: none;
                cursor: pointer
            }
        }
        input, textarea {
            font-family: inherit;
            margin-bottom: .25rem;
            color: #374151;
            padding: .5rem;
            border: solid 2px #D1FAE5;
            border-radius:.25rem;
            transition: border-color .2s ease-in;
            width:100%;
            &:hover,
            &:focus {
                border-color: #34D399;
                outline: none;
            }
        }
    }
</style>
