package {
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	public class color_match extends Sprite {
		private var first_tile:colors;
		private var second_tile:colors;
		private var pause_timer:Timer;
		var colordeck:Array = new Array(1,1,2,2,3,3,4,4,5,5,6,6,7,7,8,8);
		public function color_match() {
			for (x=1; x<=5; x++) {
				for (y=1; y<=3; y++) {
					var random_card = Math.floor(Math.random()*colordeck.length);
					var tile:colors = new colors();
					tile.col = colordeck[random_card];
					colordeck.splice(random_card,1);
					tile.gotoAndStop(9);
					//tile.x = (x-1)*150;
					//tile.y = (y-1)*100;
					tile.x = x*85 + 217;
					tile.y = y*110 + 114;
					tile.addEventListener(MouseEvent.CLICK,tile_clicked);
					
					addChild(tile);
				}
			}
		}
		public function tile_clicked(event:MouseEvent) {
			var clicked:colors = (event.currentTarget as colors);
			if (first_tile == null) {
				first_tile = clicked;
				first_tile.gotoAndStop(clicked.col);
			}
			else if (second_tile == null && first_tile != clicked) {
				second_tile = clicked;
				second_tile.gotoAndStop(clicked.col);
				if (first_tile.col == second_tile.col) {
					pause_timer = new Timer(1000,1);
					pause_timer.addEventListener(TimerEvent.TIMER_COMPLETE,remove_tiles);
					pause_timer.start();
				}
				else {
					pause_timer = new Timer(1000,1);
					pause_timer.addEventListener(TimerEvent.TIMER_COMPLETE,reset_tiles);
					pause_timer.start();
				}
			}
		}
		public function reset_tiles(event:TimerEvent) {
			first_tile.gotoAndStop(9);
			second_tile.gotoAndStop(9);
			first_tile = null;
			second_tile = null;
			pause_timer.removeEventListener(TimerEvent.TIMER_COMPLETE,reset_tiles);
		}
		public function remove_tiles(event:TimerEvent) {
			removeChild(first_tile);
			removeChild(second_tile);
			first_tile = null;
			second_tile = null;
			pause_timer.removeEventListener(TimerEvent.TIMER_COMPLETE,remove_tiles);
		}
	}
}