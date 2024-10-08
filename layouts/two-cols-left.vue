<script setup lang="ts">
const props = defineProps({
  leftColSpan: {
    type: Number,
    default: 5,
  },
  class: {
    type: String,
  },
  layoutClass: {
    type: String,
  },
})
</script>

<template>
  <div class="slidev-layout w-full h-full" :class="props.layoutClass">
    <div class="col-header">
      <slot />
    </div>
    <div class="grid grid-cols-10 w-full" style="width:100%">

      <div :class="'col-left col-span-'+props.leftColSpan" style="width:100%">
        <slot name="left" />
      </div>
      <div class="col-right">
        <slot name="right" />
      </div>
    </div>

  </div>
</template>

<style scoped>
.col-header {
}
.grid-cols-10 {
  display: grid;
  grid-template-columns: repeat(10, 1fr);
}
.col-left {
  grid-area: 1 / 1 / 1 / span 7;
}
.col-right {
  grid-area: 1 / 8 / 1 / span 3;
}

</style>
