<template>
    <div class="board">

            <Column @delete_column="deleteColumn" v-for="column in columns" :key="column.column_id" :columnId="column.column_id" :title="column.title" :id="column.id" :cards="column.cards"></Column>
        </draggable>
        <div class="columnForm">
        <button class="columnForm__button" @click="showInput = !showInput">+ Add a column</button>
        <div v-show="showInput">
            <input class="columnForm__input" placeholder="Enter Column Title" type="text" v-model="columnTitle" ref="col">
            <button class="columnForm__button" @click="addColumn">Add Column</button>
        </div>

        </div>
    </div>
</template>
<script>

import Column from "./Column.vue";
export default {
    name: 'Board',
    components: {
        Column,
    },
    data() {
        return {
            columnTitle:'',
            showInput: false,
            columns: [],
        }
    },
    methods: {
        uid() {
             let a = new Uint32Array(3);
             window.crypto.getRandomValues(a);
             return (performance.now().toString(36)+Array.from(a).map(A => A.toString(36)).join("")).replace(/\./g,"");
        },
        focusInput() {
            this.$refs.col.focus()
        },
        addColumn: async function(){
            if (this.columnTitle == '' || this.columnTitle.length > 50) return
            // build a new column object fom input
            const newColumn = {
                title: this.columnTitle,
                column_id: this.uid()
            }
            this.columns.push(newColumn)
            try{
                const response = await axios.post('/api/column', newColumn);
                if (response.data.status == 'success') {
                    this.columnTitle = ''
                    const {id, title, column_id} = response.data.column;
                    //update columns
                    newColumn['id'] = id;
                    this.replaceColumn_UI(newColumn['column_id'], newColumn)
                } else {
                    this.columnTitle = ''
                    this.removeColumn_UI(newColumn['column_id'])
                }
            } catch(error) {
                this.columnTitle = ''
                this.removeColumn_UI(newColumn['column_id'])
                if (error.response.status == 422) alert('Validation issues, Check Network tab responses')
            }
        },
        deleteColumn: async function(columnId) {
            const columnIndex = this.getColumnIndex(columnId)
            const { id, column_id, title } = this.columns[columnIndex]
            const removedColumn = {
                id: id,
                column_id: column_id,
                title: title
            }
            // const restoreColumns = [...this.columns.slice(0, columnIndex), removedColumn, ...this.columns.slice(columnIndex + 1 )];
            const restoreColumns = [...this.columns];
            this.removeColumn_UI(columnId)
            try {
                const response = await axios.delete(`/api/column/${id}`)
                if (response.data.status != 'success') {
                    this.columns = restoreColumns
                }

            } catch( error ) {
                console.log(error)
            }
            // console.log(removedColumn)
            // const removedId = this.columns[columnIndex].id
            // console.log(reponse.data)

        },

        getColumnIndex(column_id) {
            return this.columns.findIndex(column => column.column_id === column_id)

        },
        replaceColumn_UI(column_id, newColumn) {
            const columnIndex = this.getColumnIndex(column_id)
            this.columns.splice(columnIndex, 1, newColumn)

        },
        removeColumn_UI(column_id) {
            const columnIndex = this.getColumnIndex(column_id)
            this.columns.splice(columnIndex, 1)
        },

        restoreColumn_UI(column_id, newColumn) {
            const columnIndex = this.getColumnIndex(column_id)
            this.columns.splice(columnIndex, 0, newColumn)
        },
    },
    mounted: async function() {
        const response = await axios.get('/api/column')
        console.log(response.data)
        this.columns = response.data.columns
        this.cards = response.data.columns.cards
        this.focusInput();
    }
}
</script>
<style lang="scss" scoped>
    .board {
        display: grid;
        grid-gap: 1rem;
        grid-template-columns: repeat(4, 270px);

        padding: 1rem
    }
    .columnForm {
        &__button {
            font-family: inherit;
            font-size: 1.1rem;
            font-weight: 500;
            color: #065F46;
            border-radius: .25rem;
            padding:.2rem .5rem;
            background-color: #6EE7B7;
            cursor: pointer;
            &:hover,
            &:focus {
                outline: none;
            }
            &:hover {
                background-color: #34D399;
            }
        }
        &__input {
            border: solid 2px #6EE7B7;
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
    }
</style>
