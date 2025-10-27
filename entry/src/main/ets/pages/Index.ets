@Entry
@ComponentV2
struct Index {
  pageStack: NavPathStack = new NavPathStack();
  pageNames: string[] = [
    'SubpageTemplate'
  ]

  build() {
    Navigation(this.pageStack) {
      Column() {
        ForEach(this.pageNames, (item: string) => {
          Button(item).onClick(
            () => this.pageStack.replacePath({ name: item })
          )
        })
      }.width("100%").height("100%")
    }
    .width("100%")
    .height("100%")
    .title('游乐场')
    .mode(NavigationMode.Auto)
  }
}

