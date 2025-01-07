module 0x22b5f71284cbb88e80271c52c4e5153ce2cbef7159fa76bfd168d60e1f9304ed::aggregator_init_action {
    struct AggregatorCreated has copy, drop {
        aggregator_id: 0x2::object::ID,
        name: 0x1::string::String,
    }

    fun actuate(arg0: address, arg1: &0x22b5f71284cbb88e80271c52c4e5153ce2cbef7159fa76bfd168d60e1f9304ed::queue::Queue, arg2: 0x1::string::String, arg3: vector<u8>, arg4: u64, arg5: u64, arg6: u64, arg7: u32, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = AggregatorCreated{
            aggregator_id : 0x22b5f71284cbb88e80271c52c4e5153ce2cbef7159fa76bfd168d60e1f9304ed::aggregator::new(0x22b5f71284cbb88e80271c52c4e5153ce2cbef7159fa76bfd168d60e1f9304ed::queue::id(arg1), arg2, arg0, arg3, arg4, arg5, arg6, arg7, 0x2::clock::timestamp_ms(arg8), arg9),
            name          : arg2,
        };
        0x2::event::emit<AggregatorCreated>(v0);
    }

    public entry fun run(arg0: &0x22b5f71284cbb88e80271c52c4e5153ce2cbef7159fa76bfd168d60e1f9304ed::queue::Queue, arg1: address, arg2: 0x1::string::String, arg3: vector<u8>, arg4: u64, arg5: u64, arg6: u64, arg7: u32, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        validate(arg0, arg3, arg4, arg5, arg6, arg7);
        actuate(arg1, arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    public fun validate(arg0: &0x22b5f71284cbb88e80271c52c4e5153ce2cbef7159fa76bfd168d60e1f9304ed::queue::Queue, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: u64, arg5: u32) {
        assert!(0x22b5f71284cbb88e80271c52c4e5153ce2cbef7159fa76bfd168d60e1f9304ed::queue::version(arg0) == 1, 9223372195769286668);
        assert!(arg2 > 0, 9223372200063598594);
        assert!(arg4 > 0, 9223372204358696964);
        assert!(0x1::vector::length<u8>(&arg1) == 32, 9223372208653795334);
        assert!(arg5 > 0, 9223372212948893704);
        assert!(arg3 > 0, 9223372217243992074);
    }

    // decompiled from Move bytecode v6
}

