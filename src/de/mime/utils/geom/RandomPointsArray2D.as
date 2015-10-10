package de.mime.utils.geom 
{
	
	import de.mime.utils.ds.Array2D;
	import de.mime.utils.math.PM_PRNG;
		
	import flash.geom.Point;
	
	/**
	 * 
	 * 
	 * This Class generates random Points inside a square area (Array2D)
	 * and holds a Vector with the Coordinates of all generated Points.
	 * 
	 * You can also define a region around each Point and a Padding around the whole area 
	 * where no new points can be created.
	 * 
	 * @author Manuel Hanisch 
	 */
	public class RandomPointsArray2D
	{
		
		public var points:Vector.<Point>;
		public var numPoints:int;		
		
		private var _pointsArray:Array2D;
		
		private static const POINT_ALLOWED:int = 0;
		private static const POINT:int = 1;		
		private static const POINT_NOT_ALLOWED:int = 2;
		
		/**
		 * 
		 * @param   width: width of the grid
		 * @param   height: height of the grid
		 * @param	numPoints: number of points to be created
		 * @param	emptyRegion: a quadratic area around each generated point where no additionaly points can be created.
		 * @param	emptyMargin: an area around the grid where no points can be created.	
		 * @param	rng: reference to the Random Number Generator (PM_PRNG) 
		 * 
		 */
		public function RandomPointsArray2D(width:uint,height:uint, numPoints:uint, emptyRegion:uint = 0, emptyMargin:uint = 0, rng:PM_PRNG = null) {
			
			this.points = new Vector.<Point>;
			this.numPoints = 0;
			
			
			if (rng === null) rng = new PM_PRNG();
			
			
			_pointsArray= new Array2D(width, height);
			_pointsArray.fill(POINT_ALLOWED);
				
			
			
			if (emptyMargin > 0) {
				
				//boundaries check
				if (emptyMargin * 2 > width || emptyMargin * 2  > height) emptyMargin = 0;
				else addMargin(emptyMargin);
				
			}
			
			
			
			//generate points
			var ok:Boolean = true;
			var t_x:int;
			var t_y:int;
			for (var i:int = 0; i < numPoints; i++) {					
				
				t_x = rng.nextIntRange(0 + emptyMargin, width - 1 - emptyMargin);
				t_y = rng.nextIntRange(0 + emptyMargin, height - 1 - emptyMargin);
				
				ok = addPoint(t_x,t_y,emptyRegion);				
				if (!ok) break;
				
			}
			
			cleanUp();
			
			
		}
		
		
		/**
		 * 
		 * pos_x and pos_y must inside boundaries! No boundaries check.
		 * 
		 * @param	pos_x
		 * @param	pos_y
		 * @return  returns a Boolean that tells if a new point was created or not.
		 */
		private function addPoint(pos_x:int,pos_y:int,region:uint):Boolean {			
			
			
			
			var pos:Point = new Point(pos_x,pos_y);			
			var checkedCellsCount:int = 0;
			
			var hit:Boolean = false; 
			while (!hit) { 
				
				
				if (_pointsArray.get(pos.x,pos.y) == POINT_ALLOWED) {
					
					_pointsArray.set(pos.x, pos.y, POINT);
					this.points.push(new Point(pos.x, pos.y));
					this.numPoints++;
					addRegion(pos.x, pos.y,region);					
					hit = true;
					
				}
				else pos = _pointsArray.getNextLoopedPosition(pos.x, pos.y);
				
				
				
				checkedCellsCount++;				
				if (checkedCellsCount >= _pointsArray.size) break;
								
				
			}
			
			
			
			if (hit) return true;
			else return false;			
			
		}
		
		
		
		
		/**
		 * 
		 * This method adds a region around a point with NOT_ALLOWED flag.
		 * 
		 * Attention: Radius feature, which lets you make circle regions in NOT
		 * implemented yet ! 
		 * 
		 * 
		 * region=2 would look like this:
		 * 
		 * (P = point)
		 * (N = "not_allowed" flagged positions)	
		 * 
		 * N N N N N
		 * N N N N N
		 * N N P N N
		 * N N N N N
		 * N N N N N
		 * 
		 *
		 */
		
		private function addRegion(pos_x:int,pos_y:int,region:uint):void {			
			
			
			var firstRow:uint = pos_y - region;
			var lastRow:uint = pos_y + region;
			var firstCol:uint = pos_x - region;
			var lastCol:uint = pos_x + region;
			
			for (var r:int = firstRow; r <= lastRow; r++) {
				
				for (var c:int = firstCol; c <= lastCol; c++) {
					
					if (_pointsArray.containsIndex(c, r) && _pointsArray.get(c, r) == POINT_ALLOWED) _pointsArray.set(c, r, POINT_NOT_ALLOWED);
					
					
					
				}
				
			}
			
			
		}		
		
		
		/**
		 * TODO make algorithm better & faster.
		 * 
		 * 
		 * @param	padding
		 */
		
		private function addMargin(margin:uint):void {
			
			var r:uint = 0;
			var c:uint = 0;
			
			var w:uint = _pointsArray.width;
			var h:uint = _pointsArray.height;
			
			var m:uint = (margin < w) ? margin : w; 
			
			//bottomRows
			for(r = 0; r < m; r++) for(c = 0; c < w; c++) _pointsArray.set(c, r, POINT_NOT_ALLOWED);
			//Top rows
			for(r = h - 1; r >= h - m; r--) for(c = 0; c < w; c++) _pointsArray.set(c, r, POINT_NOT_ALLOWED);			
			//left cols
			for (c = 0; c < m; c++) for (r = 0; r < h; r++) _pointsArray.set(c, r, POINT_NOT_ALLOWED);		
			//right cols
			for (c = w - 1; c >= w - m; c--) for(r = 0; r < h; r++) _pointsArray.set(c, r, POINT_NOT_ALLOWED);
			
		}
		
		
		private function cleanUp():void {
			
			//remove all POINT_NOT_ALLOWED fields
			_pointsArray.OverrideObjectsWith(POINT_NOT_ALLOWED, POINT_ALLOWED);
			
		}
		
	}

}