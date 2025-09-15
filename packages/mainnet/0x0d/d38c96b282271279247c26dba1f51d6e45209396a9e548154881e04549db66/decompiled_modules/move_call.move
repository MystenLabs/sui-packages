module 0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_call {
    struct MoveCall has copy, drop, store {
        function: 0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::function::Function,
        arguments: vector<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::Argument>,
        type_arguments: vector<0x1::type_name::TypeName>,
        is_builder_call: bool,
        result_ids: vector<0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32>,
    }

    public fun function(arg0: &MoveCall) : &0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::function::Function {
        &arg0.function
    }

    public fun create(arg0: address, arg1: 0x1::ascii::String, arg2: 0x1::ascii::String, arg3: vector<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::Argument>, arg4: vector<0x1::type_name::TypeName>, arg5: bool, arg6: vector<0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32>) : MoveCall {
        MoveCall{
            function        : 0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::function::create(arg0, arg1, arg2),
            arguments       : arg3,
            type_arguments  : arg4,
            is_builder_call : arg5,
            result_ids      : arg6,
        }
    }

    public fun arguments(arg0: &MoveCall) : &vector<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::Argument> {
        &arg0.arguments
    }

    public fun arguments_mut(arg0: &mut MoveCall) : &mut vector<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::Argument> {
        &mut arg0.arguments
    }

    public fun is_builder_call(arg0: &MoveCall) : bool {
        arg0.is_builder_call
    }

    public fun result_ids(arg0: &MoveCall) : &vector<0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32> {
        &arg0.result_ids
    }

    public fun type_arguments(arg0: &MoveCall) : &vector<0x1::type_name::TypeName> {
        &arg0.type_arguments
    }

    // decompiled from Move bytecode v6
}

