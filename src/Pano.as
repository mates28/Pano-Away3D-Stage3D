package {
	import com.greensock.TweenLite;

	import away3d.cameras.lenses.PerspectiveLens;
	import away3d.containers.View3D;
	import away3d.controllers.HoverController;
	import away3d.primitives.SkyBox;
	import away3d.textures.BitmapCubeTexture;

	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;

	[SWF(backgroundColor="#000000", frameRate="60", width="800", height="600")]
	public class Pano extends Sprite {
		private var view : View3D;
		[Embed(source="pano_b.jpg", mimeType="image/jpeg")]
		private var BehindTexture : Class;
		[Embed(source="pano_d.jpg", mimeType="image/jpeg")]
		private var DownTexture : Class;
		[Embed(source="pano_f.jpg", mimeType="image/jpeg")]
		private var FrontTexture : Class;
		[Embed(source="pano_l.jpg", mimeType="image/jpeg")]
		private var LeftTexture : Class;
		[Embed(source="pano_r.jpg", mimeType="image/jpeg")]
		private var RightTexture : Class;
		[Embed(source="pano_u.jpg", mimeType="image/jpeg")]
		private var UpperTexture : Class;
		private var lastKey : uint;
		private var keyIsDown : Boolean = false;
		private var dragController : HoverController;
		private var lens : PerspectiveLens;
		private var lastFov : Number = 90;
		private var lastMouseX : Number;
		private var lastMouseY : Number;
		private var lastPanAngle : Number;
		private var lastTiltAngle : Number;
		private var move : Boolean = false;

		public function Pano() {
			// Launch your application by right clicking within this class and select: Debug As > FDT SWF Application

			initStage();
			initObjects();
			addListeners();
		}

		private function initStage() : void {
			view = new View3D();
			addChild(view);

			lens = new PerspectiveLens(lastFov);
			// lastFov = lens.fieldOfView;
			view.camera.lens = lens;
		}

		private function initObjects() : void {
			var skybox : SkyBox = new SkyBox(new BitmapCubeTexture(Bitmap(new RightTexture).bitmapData, Bitmap(new LeftTexture).bitmapData, Bitmap(new UpperTexture).bitmapData, Bitmap(new DownTexture).bitmapData, Bitmap(new FrontTexture).bitmapData, Bitmap(new BehindTexture).bitmapData));

			view.scene.addChild(skybox);

			dragController = new HoverController(view.camera, skybox, 180, 0);
		}

		private function addListeners() : void {
			this.stage.addEventListener(MouseEvent.MOUSE_DOWN, MouseDown);
			this.stage.addEventListener(MouseEvent.MOUSE_UP, MouseUp);
			this.stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			this.stage.addEventListener(KeyboardEvent.KEY_UP, keyUp);
			this.stage.addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}

		private function MouseDown(event : MouseEvent) : void {
			lastPanAngle = dragController.panAngle;
			lastTiltAngle = dragController.tiltAngle;
			lastMouseX = stage.mouseX;
			lastMouseY = stage.mouseY;
			move = true;
		}

		private function MouseUp(event : MouseEvent) : void {
			move = false;
		}

		private function onMouseWheel(event : MouseEvent) : void {
			lens.fieldOfView += event.delta;

			if (lens.fieldOfView > 120) lens.fieldOfView = 120;
			if (lens.fieldOfView < 60) lens.fieldOfView = 60;

			lastFov = lens.fieldOfView;
		}

		private function keyUp(event : KeyboardEvent) : void {
			keyIsDown = false;
		}

		private function keyDown(event : KeyboardEvent) : void {
			lastKey = event.keyCode;
			trace('event.keyCode: ' + (event.keyCode));
			keyIsDown = true;
		}

		private function onEnterFrame(event : Event) : void {
			if (keyIsDown) {
				// if the key is still pressed, just keep on moving

				switch(lastKey) {
					case Keyboard.UP	:
					case 87				:
						dragController.tiltAngle -= 2;
						break;
					case Keyboard.DOWN	:
					case 83				:
						dragController.tiltAngle += 2;
						break;
					case Keyboard.LEFT	:
					case 65				:
						dragController.panAngle -= 2;
						break;
					case Keyboard.RIGHT	:
					case 68				:
						dragController.panAngle += 2;
						break;
					// case Keyboard.UP	:
					// dragController.distance -= 5;
					// break;
					// case Keyboard.DOWN	:
					// dragController.distance += 5;
					// break;
				}
			}

			var cameraSpeed : Number = 0.3;
			// Approximately same speed as mouse movement.
			if (move) {
				dragController.panAngle = cameraSpeed * (stage.mouseX - lastMouseX) + lastPanAngle;
				dragController.tiltAngle = cameraSpeed * (stage.mouseY - lastMouseY) + lastTiltAngle;
			}

			view.render();
			// removeEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
	}
}
