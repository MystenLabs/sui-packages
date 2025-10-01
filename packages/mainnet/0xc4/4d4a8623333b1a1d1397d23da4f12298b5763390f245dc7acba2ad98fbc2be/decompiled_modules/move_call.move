module 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call {
    struct MoveCall has copy, drop, store {
        function: 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::function::Function,
        arguments: vector<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>,
        type_arguments: vector<0x1::type_name::TypeName>,
        is_builder_call: bool,
        result_ids: vector<0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32>,
    }

    public fun function(arg0: &MoveCall) : &0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::function::Function {
        &arg0.function
    }

    public fun create(arg0: address, arg1: 0x1::ascii::String, arg2: 0x1::ascii::String, arg3: vector<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>, arg4: vector<0x1::type_name::TypeName>, arg5: bool, arg6: vector<0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32>) : MoveCall {
        MoveCall{
            function        : 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::function::create(arg0, arg1, arg2),
            arguments       : arg3,
            type_arguments  : arg4,
            is_builder_call : arg5,
            result_ids      : arg6,
        }
    }

    public fun arguments(arg0: &MoveCall) : &vector<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument> {
        &arg0.arguments
    }

    public fun arguments_mut(arg0: &mut MoveCall) : &mut vector<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument> {
        &mut arg0.arguments
    }

    public fun is_builder_call(arg0: &MoveCall) : bool {
        arg0.is_builder_call
    }

    public fun result_ids(arg0: &MoveCall) : &vector<0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32> {
        &arg0.result_ids
    }

    public fun type_arguments(arg0: &MoveCall) : &vector<0x1::type_name::TypeName> {
        &arg0.type_arguments
    }

    // decompiled from Move bytecode v6
}

