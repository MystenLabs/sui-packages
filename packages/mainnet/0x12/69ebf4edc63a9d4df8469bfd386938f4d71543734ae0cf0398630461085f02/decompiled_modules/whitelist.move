module 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::whitelist {
    struct WhitelistCertificate<phantom T0> has store, key {
        id: 0x2::object::UID,
        exp_ts_seconds: u64,
    }

    public(friend) fun assert_expiration<T0>(arg0: &WhitelistCertificate<T0>, arg1: &0x2::clock::Clock) {
        assert!(arg0.exp_ts_seconds > 0x2::clock::timestamp_ms(arg1) / 1000, 1100);
    }

    public fun invite_users<T0>(arg0: &0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::index::Index<T0>, arg1: vector<address>, arg2: u64, arg3: &0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::admin::AdminCap, arg4: &mut 0x2::tx_context::TxContext) {
        0x1::vector::reverse<address>(&mut arg1);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            let v1 = WhitelistCertificate<T0>{
                id             : 0x2::object::new(arg4),
                exp_ts_seconds : arg2,
            };
            0x2::transfer::public_transfer<WhitelistCertificate<T0>>(v1, 0x1::vector::pop_back<address>(&mut arg1));
            v0 = v0 + 1;
        };
        0x1::vector::destroy_empty<address>(arg1);
    }

    // decompiled from Move bytecode v6
}

