module 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_call {
    struct MoveCall has copy, drop, store {
        function: 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::function::Function,
        arguments: vector<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::Argument>,
        type_arguments: vector<0x1::type_name::TypeName>,
        is_builder_call: bool,
        result_ids: vector<0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::Bytes32>,
    }

    public fun function(arg0: &MoveCall) : &0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::function::Function {
        &arg0.function
    }

    public fun create(arg0: address, arg1: 0x1::ascii::String, arg2: 0x1::ascii::String, arg3: vector<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::Argument>, arg4: vector<0x1::type_name::TypeName>, arg5: bool, arg6: vector<0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::Bytes32>) : MoveCall {
        MoveCall{
            function        : 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::function::create(arg0, arg1, arg2),
            arguments       : arg3,
            type_arguments  : arg4,
            is_builder_call : arg5,
            result_ids      : arg6,
        }
    }

    public fun arguments(arg0: &MoveCall) : &vector<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::Argument> {
        &arg0.arguments
    }

    public fun arguments_mut(arg0: &mut MoveCall) : &mut vector<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::Argument> {
        &mut arg0.arguments
    }

    public fun is_builder_call(arg0: &MoveCall) : bool {
        arg0.is_builder_call
    }

    public fun result_ids(arg0: &MoveCall) : &vector<0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::Bytes32> {
        &arg0.result_ids
    }

    public fun type_arguments(arg0: &MoveCall) : &vector<0x1::type_name::TypeName> {
        &arg0.type_arguments
    }

    // decompiled from Move bytecode v6
}

