<script>

import {Pie,mixins} from 'vue-chartjs'

export default {
  extends: Pie,
  mixins: [mixins.reactiveProp],
  data() {
    return {
      chartOptions: {
        title: "Tweet letter count",
        responsive: true,
        legend: {
          display: true,
          position: 'left'
        }
      }
    }
  },
  methods: {},
  mounted() {
    // Overwriting base render method with actual data.
    this.renderChart(this.chartData, this.chartOptions)
  }
}
</script>