package org.papervision3d.core.math.util
{
	import org.papervision3d.core.geom.renderables.Triangle3D;
	import org.papervision3d.core.geom.renderables.Vertex3D;
	import org.papervision3d.core.math.Plane3D;
	
	public class ClassificationUtil
	{
		public static const FRONT:uint = 0;
		public static const BACK:uint = 1;
		public static const COINCIDING:uint = 2;
		public static const STRADDLE:uint = 3;
		
		public function ClassificationUtil()
		{
			
		}
		
		public static function classifyPoint( point:Vertex3D, plane:Plane3D, e:Number = 0.01 ):uint
		{
			var distance:Number = plane.distance( point );
			if(distance < -e){ 
				return BACK;
			}else if(distance > e){
				return FRONT;
			}else{ 
				return COINCIDING;
			}
		}
		
		public static function classifyPoints( points:Array, plane:Plane3D, e:Number = 0.01 ):uint
		{
			var numpos:uint = 0;
			var numneg:uint = 0;
			for each( var point:Vertex3D in points )
			{
				var side:uint = classifyPoint(point, plane, e);
				if( side == FRONT ){
					numpos++;
				}else if( side == BACK ){
					numneg++;
				}
			}
			if( numpos > 0 && numneg == 0 ){
				return FRONT;
			}else if( numpos == 0 && numneg > 0 ){
				return BACK;
			}else if( numpos > 0 && numneg > 0 ){
				return STRADDLE;
			}else{
				return COINCIDING;
			}
		}
		
		public static function classifyTriangle(triangle:Triangle3D, plane:Plane3D, e:Number=0.01 ):uint
		{			
			return classifyPoints([triangle.v0, triangle.v1, triangle.v2], plane, e);
		}
		
	}
}