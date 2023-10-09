/**
 * I am a new interceptor
 */
component{

	/**
	 * Configure the interceptor
	 */
	void function configure(){

	}

	function afterAspectsLoad() async{
		var wireboxMappings = wirebox
			.getBinder()
			.getMappings()
			.reduce( function( previousValue, key, value ){
				var mappingStruct    = value.getMemento();
				previousValue[ key ] = {
					"name" : mappingStruct.name ?: "",
					"path" : mappingStruct.path ?: "",
					"type" : mappingStruct.type ?: ""
				};
				for ( var alias in mappingStruct.alias ) {
					if ( !structKeyExists( previousValue, alias ) ) {
						previousValue[ alias ] = {
							"name" : alias,
							"path" : mappingStruct.path,
							"type" : mappingStruct.type
						}
					}
				}
				return previousValue;
			}, {} );
		var settingsFileFullPath = expandPath( "/.vscode/coldbox-wireboxMappings.json" );
		var settings             = {};
		if ( fileExists( settingsFileFullPath ) ) {
			settings = deserializeJSON( fileRead( settingsFileFullPath ) );
		}
		settings[ "coldbox.wireboxMappings" ] = wireboxMappings
		fileWrite(
			settingsFileFullPath,
			wirebox
				.getInstance( dsl = "JSONPrettyPrint@JSONPrettyPrint" )
				.formatJSON( json = serializeJSON( settings ), spaceAfterColon = true )
		);
	}

}
