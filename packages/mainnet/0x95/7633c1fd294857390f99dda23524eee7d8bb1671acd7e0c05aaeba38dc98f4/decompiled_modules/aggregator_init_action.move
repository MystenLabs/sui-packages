module 0x957633c1fd294857390f99dda23524eee7d8bb1671acd7e0c05aaeba38dc98f4::aggregator_init_action {
    struct AggregatorCreated has copy, drop {
        aggregator_id: 0x2::object::ID,
        name: 0x1::string::String,
    }

    fun actuate(arg0: address, arg1: &0x957633c1fd294857390f99dda23524eee7d8bb1671acd7e0c05aaeba38dc98f4::queue::Queue, arg2: 0x1::string::String, arg3: vector<u8>, arg4: u64, arg5: u64, arg6: u64, arg7: u32, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = AggregatorCreated{
            aggregator_id : 0x957633c1fd294857390f99dda23524eee7d8bb1671acd7e0c05aaeba38dc98f4::aggregator::new(0x957633c1fd294857390f99dda23524eee7d8bb1671acd7e0c05aaeba38dc98f4::queue::id(arg1), arg2, arg0, arg3, arg4, arg5, arg6, arg7, 0x2::clock::timestamp_ms(arg8), arg9),
            name          : arg2,
        };
        0x2::event::emit<AggregatorCreated>(v0);
    }

    public entry fun run(arg0: &0x957633c1fd294857390f99dda23524eee7d8bb1671acd7e0c05aaeba38dc98f4::queue::Queue, arg1: address, arg2: 0x1::string::String, arg3: vector<u8>, arg4: u64, arg5: u64, arg6: u64, arg7: u32, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        validate(arg3, arg4, arg5, arg6, arg7);
        actuate(arg1, arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    public fun validate(arg0: vector<u8>, arg1: u64, arg2: u64, arg3: u64, arg4: u32) {
        assert!(arg1 > 0, 9223372182883663873);
        assert!(arg3 > 0, 9223372187178762243);
        assert!(0x1::vector::length<u8>(&arg0) == 32, 9223372191473860613);
        assert!(arg4 > 0, 9223372195768958983);
        assert!(arg2 > 0, 9223372200064057353);
    }

    // decompiled from Move bytecode v6
}

