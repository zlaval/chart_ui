<template>
  <div id="app">
    <div class="container">
      <div class="row">
        <div class="col-6">
          <tweet-meta-chart :chart-data="datacollection"></tweet-meta-chart>

        </div>
        <div class="col-6">


        </div>

      </div>

    </div>
  </div>
</template>

<script>
import TweetMetaChart from "@/components/TweetMetaChart";

const localdev = true

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
      datacollection: {
        labels: ['Programming', 'Season', 'Hobby'],
        datasets: [
          {
            backgroundColor: ['#1006FF', '#99C802', '#FF0200'],
            data: [0, 0, 0],
          },
        ],
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
        console.log(rawData)

        this.datacollection = {
          labels: ['Programming', 'Season', 'Hobby'],
          datasets: [
            {
              backgroundColor: ['#1006FF', '#99C802', '#FF0200'],
              data: rawData,
            },
          ],
        }
      })

    }
  },
  components: {
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
