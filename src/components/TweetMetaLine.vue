<script>

import {Line, mixins} from 'vue-chartjs'

export default {
  extends: Line,
  mixins: [mixins.reactiveProp],
  data() {
    return {
      chartOptions: {
        title: "Letter count change",
        responsive: true,
        legend: {
          display: false
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