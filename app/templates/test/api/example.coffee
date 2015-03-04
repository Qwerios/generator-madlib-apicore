chai        = require "chai"
api         = require "../../lib/index.js"
settings    = require "madlib-settings"
console     = require "madlib-console"

# Suppress debug logging
# Comment this out if you want to debug
#
console.logLevel = "WARN"

# Override to use specific environment for testing
#
settings.set( "overrideMapping", "development" )

describe( "Example", () ->

    describe( "#init()", () ->
        it( "Should be initialised", () ->
            api.init( settings )
            chai.expect( api.initialised ).to.eql( true )
        )
    )

    describe( "#call()", () ->
        it( "Should return something", ( testCompleted ) ->
            api.call( "ExampleService" )
            .then(
                ( data ) ->
                    response = data?.response

                    chai.expect( response ).to.be.an( "object" )
                    testCompleted();

                ( error ) ->
                    chai.expect( error?.status ).to.eql( 200 )
                    testCompleted();
            )
            .done()
        )
    )
)
