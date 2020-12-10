require('./bootstrap');

import Vue from 'vue'
import VModal from 'vue-js-modal'
import Board from './components/Board'
import 'fontsource-commissioner/300-normal.css'
import 'fontsource-commissioner/400-normal.css'
import 'fontsource-commissioner/500-normal.css'
import 'fontsource-commissioner/600-normal.css'

Vue.use(VModal)

const app = new Vue({
  el: '#app',
  components: {
    Board
  },
  data: {
    message: 'Hello Kanban!!!'
  }
})
