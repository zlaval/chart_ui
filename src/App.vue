<template>
  <div id="app">
    <div class="container-fluid max-width">
      <div class="row">
        <div class="col-6">
          <tweet-meta-chart :chart-data="datacollection"></tweet-meta-chart>

        </div>
        <div class="col-6">
          <tweet-meta-line :chart-data="linecollection"></tweet-meta-line>

        </div>

      </div>

    </div>
  </div>
</template>

<style>
.max-width{
  max-width: 80%!important;
}
</style>

<script>
import TweetMetaChart from "@/components/TweetMetaChart";
import TweetMetaLine from "@/components/TweetMetaLine";

const localdev = false

let hostMachineIP = 'HOST_IP'
let hostMachinePort = 'HOST_PORT'
if (localdev) {
  hostMachineIP = "localhost"
  hostMachinePort = 8080
}

const es = new EventSource(`http://${hostMachineIP}:${hostMachinePort}/api/v1/chart`);

export default {
  name: 'App',
  data() {
    return {
      metasum: [],
      datacollection: {
        labels: ['Programming', 'Season', 'Hobby'],
        datasets: [
          {
            backgroundColor: ['#1006FF', '#99C802', '#FF0200'],
            data: [0, 0, 0],
          },
        ],
      },
      linecollection: {
        labels: [0, 0],
        datasets: [{
          data: [0, 0]
        }]
      }
    }
  },
  mounted() {
    this.fillData()
  },
  methods: {
    fillData() {
      es.addEventListener("message", event => {
        let rawData = JSON.parse(event.data).map(t => t.value)

        let sum = rawData.reduce((acc, val) => acc + val, 0)
        if (this.metasum.length > 10) {
          this.metasum = this.metasum.slice(this.metasum.length - 10)
        }
        this.metasum.push(sum)
        console.log(this.metasum)

        this.datacollection = {
          labels: ['Programming', 'Season', 'Hobby'],
          datasets: [
            {
              backgroundColor: ['#1006FF', '#99C802', '#FF0200'],
              data: rawData,
            },
          ],
        }

        this.linecollection = {
          labels: this.metasum,
          datasets: [{
            data: this.metasum
          }]
        }

      })
    }
  },
  components: {
    TweetMetaLine,
    TweetMetaChart
  }
}
</script>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>
