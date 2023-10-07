/**
 * I am a new interceptor
 */
component{

	/**
	 * Configure the interceptor
	 */
	void function configure(){

	}

	async function afterAspectsLoad(){
		var coldBoxMappings = controller
			.getModuleService()
			.getModuleRegistry()
			.reduce( function( previousValue, key, value ){
				previousValue.append( {
					"logicalPath"             : "/#key#",
					"directoryPath"           : ".#value.locationPath#",
					"isPhysicalDirectoryPath" : false,
					"generatedBy"             : "coldbox"
				} );
				return previousValue;
			}, [] );
		var settingsFileFullPath = expandPath( "/.vscode/settings.json" );
		var settings             = {};
		if ( fileExists( settingsFileFullPath ) ) {
			settings = deserializeJSON( fileRead( settingsFileFullPath ) );
		}
		if( !structKeyExists( settings, "cfml.mappings" ) ){
			settings[ "cfml.mappings" ] = coldBoxMappings
		} else {
			settings[ "cfml.mappings" ].filter( function( mapping ){
				return !( structKeyExists( mapping, "generatedBy" ) && mapping.generatedBy == "coldbox" );
			})
			.append( coldBoxMappings, true )
		}
		fileWrite(
			settingsFileFullPath,
			wirebox
				.getInstance( dsl = "JSONPrettyPrint@JSONPrettyPrint" )
				.formatJSON( json = serializeJSON( settings ), spaceAfterColon = true )
		);
	}

}
