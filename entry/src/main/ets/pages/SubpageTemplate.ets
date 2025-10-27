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
    }
    .title('子页面')
    .width("100%")
    .height("100%")
  }
}