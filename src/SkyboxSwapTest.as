package {
	import away3d.containers.ObjectContainer3D;
	import away3d.containers.View3D;
	import away3d.debug.AwayStats;
	import away3d.primitives.SkyBox;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
 
	[SWF(frameRate="60", width="1024", height="768")]
 
	public class SkyboxSwapTest extends Sprite
	{
		private var __uiContainer:Sprite;
		private var __viewContainer:Sprite;
		private var __view:View3D;
		private var __objContainer:ObjectContainer3D;
 
		private var __skyBox:SkyBox;
 
		private var __dragController:HoverDragController;
		private var __transitionButton:Button;
		private var __cubeMapRenderer:AnimatedCubeMap;
 
		private var __haxActive:Boolean = true;
 
		public function SkyboxSwapTest()
		{
			init();
		}
 
		private function init():void
		{
			if (stage == null)
			{
				init();
			}
			else
			{
				initDisplay();
				init3D();
				initCubeMap();
//				initSkyBox();
				initDragController();
				initRender();
			}
		}
 
		private function initDisplay():void
		{
			__viewContainer = new Sprite();
			addChild(__viewContainer);
 
			__uiContainer = new Sprite();
			__uiContainer.y = 615;
			addChild(__uiContainer);
 
			__transitionButton = new Button();
			__transitionButton.label = "GO";
			__transitionButton.addEventListener(MouseEvent.CLICK, transitionClickHandler, false, 0, true);
			__uiContainer.addChild(__transitionButton);
		}
 
		private function initCubeMap():void
		{
			__cubeMapRenderer = new AnimatedCubeMap();
		}
 
		private function init3D():void
		{
			__view = new View3D();
			__view.width = 800;
			__view.height = 600;
			__viewContainer.addChild(__view);
 
			__objContainer = new ObjectContainer3D();
			__view.scene.addChild(__objContainer);
 
			__view.addChild(new AwayStats());
		}
 
		private function initDragController():void
		{
			__dragController = new HoverDragController(__view.camera, stage);
		}
 
		private function initRender():void
		{
			addEventListener(Event.ENTER_FRAME, enterFrameHandler, false, 0, true);
		}
 
		protected function enterFrameHandler(event:Event):void
		{
			prerender();
			__view.render();
		}
 
		private function prerender():void
		{
//			do 
//			{
//				if (__objContainer.numChildren > 0)
//				{
//					__objContainer.removeChild(__objContainer.getChildAt(0));
//				}
//				
//			} while(__objContainer.numChildren > 0);
 
			if (__skyBox == null)
			{
				__skyBox = new SkyBox(__cubeMapRenderer.cubeMap);
				__view.scene.addChild(__skyBox);
			}
			else
			{
				__skyBox = new SkyBox(__cubeMapRenderer.cubeMap);
				__view.scene.addChild(__skyBox);
 
//				__skyBox.material = BitmapMaterial(__cubeMapRenderer.cubeMap);
//				__skyBox.material = __cubeMapRenderer.cubeMap
			}
 
		}
 
		protected function transitionClickHandler(event:MouseEvent):void
		{
//			TweenMax.to(__skyBox1.material as BitmapMaterial, 1, {autoAlpha:0});
//			TweenMax.to(__skyBox1.material as BitmapMaterial, 1, { alpha:0 });
		}
	}
}