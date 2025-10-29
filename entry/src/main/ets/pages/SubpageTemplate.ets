// 此文件的名称与 router_map.json 中的 pageSourceFile 对应

// 此函数的名称与 router_map.json 中的 buildFunction 对应
@Builder
export function PageBuilder(name: string, param: Object) {
  SubpageTemplate()
}

@Component
struct SubpageTemplate {
  build() {
    NavDestination() {
      Column() {
        Text("Lorem ipsum dolor sit amet consectetur adipiscing elit. Ex sapien vitae pellentesque sem placerat in id. Pretium tellus duis convallis tempus leo eu aenean. Urna tempor pulvinar vivamus fringilla lacus nec metus. Iaculis massa nisl malesuada lacinia integer nunc posuere. Semper vel class aptent taciti sociosqu ad litora. Conubia nostra inceptos himenaeos orci varius natoque penatibus. Dis parturient montes nascetur ridiculus mus donec rhoncus. Nulla molestie mattis scelerisque maximus eget fermentum odio. Purus est efficitur laoreet mauris pharetra vestibulum fusce.")
      }.padding("16px")
    }
    .title('模板子页面')
    .width("100%")
    .height("100%")
  }
}