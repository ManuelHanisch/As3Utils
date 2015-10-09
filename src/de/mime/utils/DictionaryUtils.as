package de.mime.utils 
{
	import flash.utils.Dictionary;
	
	/**
	 * 
	 * @author Manuel Hanisch
	 */
	public final class DictionaryUtils 
	{
		
		
		public static function getLength(d:Dictionary):int {
			
			var i:int = 0;
			for (var k:* in d) i++;
			return i;
			
			
		}
		
		
		public static function getKeys(d:Dictionary):Array {
				
                var result:Array = [];
                  
                for (var k:* in d) result.push(k);
                
				return result;
				
		}
		
		/**
		 * Check if given dictionary contains the key.
		 *
		 * @param dictionary the dictionary to check for a key
		 * @param key the key to look up in the dictionary
		 * @return <code>true</code> if the dictionary contains the given key, <code>false</code> if not
		 */
		public static function containsKey(d:Dictionary, key:Object):Boolean {
				
			var result:Boolean = false;
				
			for (var k:*in d) {
				if (key === k) {
						result = true;
						break;
				}
			}
			return result;
		}
		
		
		/**
		 * Checks if given dictionary contains the value.
		 *
		 * @param dictionary the dictionary to check for a value
		 * @param value the value to look up in the dictionary
		 * @return <code>true</code> if the dictionary contains the given value, <code>false</code> if not
		 */
		public static function containsValue(d:Dictionary, value:Object):Boolean {
				var result:Boolean = false;
				
				for each (var i:*in d) {
						if (i === value) {
								result = true;
								break;
						}
				}
				return result;
		}
		
		/**
		 * 
		 * Checks at what "index" the given value is, determined by a counter
		 * while looping through the dictionary.
		 * 
		 * @param	d
		 * @param	value
		 * @return return -1 if not found, else index position
		 */
		public static function indexOf(d:Dictionary, value:Object):int {
			
			var counter:int = -1;
			var result:int = -1;
				
			for each (var i:* in d) {
				
				counter++;
				
				if (i === value) {
					result = counter;
					break;
				}
			}
			
			return result;
			
			
			
		}
		
	}

}