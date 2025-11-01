@Entry
@ComponentV2
struct Index {
  pageStack: NavPathStack = new NavPathStack();
  pageNames: string[] = [
    'SubpageTemplate',
    'BasicComponent3D',
    'RotatingUI',
    'DigitsDemo'
  ]

  build() {
    Navigation(this.pageStack) {
      Column() {
        ForEach(this.pageNames, (item: string) => {
          Button(item)
            .margin("16px")
            .width("87.5%")
            .onClick(
              () => {
                if (this.pageStack.size() != 0) {
                  this.pageStack.pop()
                }
                this.pageStack.pushPath({ name: item })
              }
            )
        })
      }
      .width("100%")
      .height("100%")
    }
    .width("100%")
    .height("100%")
    .title('游乐场')
    .mode(NavigationMode.Auto)
  }
}

