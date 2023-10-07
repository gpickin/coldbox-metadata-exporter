/**
 * ColdBox Metadata Exporter Module Config
 *
 * This module includes several Interceptors that exports different ColdBox runtime metadata at runtime to allow tools like VSCode to use to help the developer experience.
 */
component {

	function configure(){
		interceptors = [
			{
				name  : "ColdBoxMappingsExporter",
				class : "#moduleMapping#.interceptors.ColdBoxMappingsExporter"
			},
			{
				name  : "WireboxMappingsExporter",
				class : "#moduleMapping#.interceptors.WireboxMappingsExporter"
			}
		];
	}

}
