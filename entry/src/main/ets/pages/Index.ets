@Entry
@ComponentV2
struct Index {
  pageStack: NavPathStack = new NavPathStack();

  build() {
    Navigation(this.pageStack) {
      Stack() {
        Button("Button").onClick((event: ClickEvent) => {
          this.pageStack.pushPath({ name: "SubpageTemplate" });
        })
      }
    }
    .width("100%")
    .height("100%")
    .title('游乐场')
    .mode(NavigationMode.Auto)
  }
}

