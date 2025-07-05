module 0x5bbaa9574b2ded7ab0cd5ef270198f042545bb7b8da31b3bc755eff1f3ba2c2a::whitelist {
    struct WhitelistCertificate<phantom T0> has store, key {
        id: 0x2::object::UID,
        exp_ts_seconds: u64,
    }

    public(friend) fun assert_expiration<T0>(arg0: &WhitelistCertificate<T0>, arg1: &0x2::clock::Clock) {
        assert!(arg0.exp_ts_seconds > 0x2::clock::timestamp_ms(arg1) / 1000, 1100);
    }

    public fun invite_users<T0>(arg0: &0x5bbaa9574b2ded7ab0cd5ef270198f042545bb7b8da31b3bc755eff1f3ba2c2a::index::Index<T0>, arg1: vector<address>, arg2: u64, arg3: &0x5bbaa9574b2ded7ab0cd5ef270198f042545bb7b8da31b3bc755eff1f3ba2c2a::admin::AdminCap, arg4: &mut 0x2::tx_context::TxContext) {
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

