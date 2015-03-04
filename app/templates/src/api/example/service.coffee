( ( factory ) ->
    if typeof exports is "object"
        module.exports = factory(
            require "../base"
            require "madlib-object-utils"
        )
    else if typeof define is "function" and define.amd
        define( [
            "../base"
            "madlib-object-utils"
        ], factory )
)( ( BaseService, objectUtils ) ->
    ###*
    #   This service is responsible for something
    #
    #   @author         mdoeswijk
    #   @class          ExampleService
    #   @extends        BaseService
    #   @version        0.1
    ###
    class ExampleService extends BaseService

        ###*
        #   The constructor is used to setup the type of service call.
        #   It specifies XmlHttpRequest parameters and response handling
        #
        #   @function   RegisterApp
        ###
        constructor: () ->
            super(
                name:   "ExampleService"
                url:    "/example"
                method: "POST"
            )
)