module 0x14a13c8ff92114f3c3718042eb5937cccf76d9b5d67509d880a5df2a9f07bf90::expired_rule {
    struct Expired has drop {
        dummy_field: bool,
    }

    public fun verify<T0>(arg0: &mut 0xeea8da3ccfbf41ea8be72d36a7fb8171204694c80634fa503d72b66e2e1450a3::custom_token::ActionRequest<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xeea8da3ccfbf41ea8be72d36a7fb8171204694c80634fa503d72b66e2e1450a3::custom_token::expiration<T0>(arg0);
        if (!0x1::option::is_none<u64>(&v0)) {
            assert!(*0x1::option::borrow<u64>(&v0) > 0x2::clock::timestamp_ms(arg1) || 0x1::option::is_none<u64>(&v0), 1);
        };
        let v1 = Expired{dummy_field: false};
        0xeea8da3ccfbf41ea8be72d36a7fb8171204694c80634fa503d72b66e2e1450a3::custom_token::add_approval<T0, Expired>(v1, arg0, arg2);
    }

    // decompiled from Move bytecode v6
}

