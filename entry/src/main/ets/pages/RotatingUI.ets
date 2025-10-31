// 此文件的名称与 router_map.json 中的 pageSourceFile 对应
import { AnimatorResult } from "@kit.ArkUI"

// 此函数的名称与 router_map.json 中的 buildFunction 对应
@Builder
export function RotatingUIBuilder(name: string, param: Object) {
  Subpage()
}

@ComponentV2
struct Subpage {
  @Local rotAngle: number = 0
  animator: AnimatorResult | null = null
  build() {
    NavDestination() {
      Column() {
        ForEach([0, 1, 2, 3], (_: number, index: number) => {
          Row() {
            ForEach([0, 1, 2, 3], (_: number, jndex: number) => {
              Button((index * 4 + jndex).toString()).width("128px").height("128px")
            })
          }
        })
      }
      .padding("16px")
      .rotate({
        x: 1,
        y: 0,
        z: 0,
        angle: this.rotAngle,
      })
    }
    .title('UI旋转')
    .width("100%")
    .height("100%")
  }

  onDidBuild(): void {
    this.animator = this.getUIContext().createAnimator({
      duration: 500,
      fill: "both",
      begin: 0,
      end: 1,
      iterations: -1,
      easing: "linear",
      delay: 0,
      direction: "alternate"
    })

    this.animator.onFrame = (x: number) => {
      this.rotAngle = x * 50 - 25
    }

    this.animator.play()
  }
}