package de.mime.utils.ds 
{
	
	import flash.geom.Point;

	/**
	 * ...
	 * @author Manuel Hanisch
	 */
	public class Array2DIterator implements IIterator
	{
		private var _a2:Array2D;
		private var _xCursor:int;
		private var _yCursor:int;
		
		private var _xCursor_curr:int;
		private var _yCursor_curr:int;
		
		
		public function Array2DIterator(a2:Array2D)
		{
			_a2 = a2;
			_xCursor = _yCursor = 0;
			_xCursor_curr = _yCursor_curr = 0;
		}
		
		public function get data():*
		{
			return _a2.get(_xCursor, _yCursor);
		}
		
		public function set data(obj:*):void
		{
			_a2.set(_xCursor, _yCursor, obj);
		}
		
		public function start():void
		{
			_xCursor = _yCursor = 0;
			_xCursor_curr = _yCursor_curr = 0;
		}
		
		public function hasNext():Boolean
		{
			return (_yCursor * _a2.width + _xCursor < _a2.size);
		}
		
		public function next():*
		{
			var item:* = data;
			
			_xCursor_curr = _xCursor;
			_yCursor_curr = _yCursor;
			
			
			if (++_xCursor == _a2.width)
			{
				_yCursor++;
				_xCursor = 0;
			}
			
			return item;
		}
		
		
		public function get cursor():* 
		{				
			
			return new Point(_xCursor_curr,_yCursor_curr);
		}
		
	}
	
}