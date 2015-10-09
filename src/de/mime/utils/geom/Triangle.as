package de.mime.utils.geom 
{
	import flash.geom.Point;
	
	/**
	 * 
	 * Class for constructing Non-right triangles.
	 * 
	 * Labeling: 
	 * Capital letters A,B,C are the Coordinates/Points of each corner.
	 * The corresponding lower-case letters a,b,c go with the Side opposite the Points.
	 * Alpha,beta and gamma are the Angles.
	 * Alpha = angle at Point A
	 * Beta = angle at Point B
	 * Gamma = angle at Point C
	 *
	 * 
	 * 
	 * @author Manuel Hanisch
	 */
	public class Triangle 
	{
		
		private var _triangleSolved:Boolean; //true when triangle solved (= all sides and angles are known)
		
		
		public var a:Number;
		public var b:Number;
		public var c:Number;
		
		public var A:Point;
		public var B:Point;
		public var C:Point;
		
		public var alpha:Number;
		public var beta:Number;
		public var gamma:Number;
		
		public function Triangle(pA:Point = null, pB:Point = null, pC:Point = null, sa:Number = NaN, sb:Number = NaN, sc:Number = NaN, aALpha:Number = NaN, aBeta:Number = NaN, aGamma:Number = NaN) { 
			
			
			_triangleSolved = false;
			
			
			if (pA != null && pB != null && pC != null) updatePoints(pA, pB, pC); // Side-Side-Side through Points
			else if (isNaN(sa) && isNaN(sb) && isNaN(sc)) updateSides(sa, sb, sc); // Side-Side-Side
			else {
				
				//TODO:				
				//Angle-Side-Angle				
				//Angle-Angle-Side
				//Side-Angle-Side
				//Side-Side-Angle
				
			}
			
		}
		
		public function updatePoints(pA:Point,pB:Point,pC:Point):void {
			
			A = pA;
			B = pB;
			C = pC;				
			constructWithPoints();				
			_triangleSolved = true;
			
		}
		
		public function updateSides(sa:Number,sb:Number,sc:Number):void {
			
			a = sa;
			b = sb;
			c = sc;			
			constructWithSides();
			_triangleSolved = true;
			
		}
		
		
		
		protected function constructWithPoints():void {
			
			a = Point.distance(B, C);
			b = Point.distance(A, C);
			c = Point.distance(A, B);
			
			constructWithSides();
			
			
		}
		
		protected function constructWithSides():void {
			
			
			calculateAngles();
			
			
		}
		
		
		
		private function calculateAngles():void {		
			
			//trace("Sides abc:"+a.toString()+","+b.toString()+","+c.toString()+",");			
			
			alpha = round(radToDeg(Math.acos((Math.pow(b, 2) + Math.pow(c, 2) - Math.pow(a, 2)) / (2 * b * c))));				
			beta = round(radToDeg(Math.acos((Math.pow(a, 2) + Math.pow(c, 2) - Math.pow(b, 2)) / (2 * a * c))));
			gamma = round(radToDeg(Math.acos((Math.pow(a, 2) + Math.pow(b, 2) - Math.pow(c, 2)) / (2 * a * b))));
			
			
			
		}
		
		
		protected static function calculateThirdAngle(angle1:Number, angle2:Number):Number {
			
			return 180 - angle1 - angle2;			
			
		}		
		
		protected static function radToDeg(n:Number):Number {
		  return n / Math.PI * 180;
		}
		protected static function degToRad(n:Number):Number {
		  return n * Math.PI / 180;
		}
		protected static function round(n:Number):Number {
		  return Math.round(n * 100) / 100;
		}
				
		
		public function get triangleSolved():Boolean {
			return _triangleSolved;
		}
		public function isComplete():Boolean {
			
			if (_triangleSolved && A != null && B != null && C != null) return true;
			else return false;
		}
		
		
		
		
		
	}

}