module 0xe8ee1ab90e9cf611aae75aa6a76ec0235f44c9ab77f4d5f02eaf7e9bc0964f3a::emitter {
    struct PythPriceInfoObject has copy, drop {
        identifier: vector<u8>,
        id: 0x2::object::ID,
    }

    entry fun emit_price_info_object_id(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg1: vector<u8>) {
        let v0 = PythPriceInfoObject{
            identifier : arg1,
            id         : 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::get_price_info_object_id(arg0, arg1),
        };
        0x2::event::emit<PythPriceInfoObject>(v0);
    }

    // decompiled from Move bytecode v6
}

