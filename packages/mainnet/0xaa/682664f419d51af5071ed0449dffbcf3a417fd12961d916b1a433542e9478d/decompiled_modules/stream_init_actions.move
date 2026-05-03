module 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::stream_init_actions {
    struct CreateStreamAction has copy, drop, store {
        vault_name: 0x1::string::String,
        beneficiary: address,
        amount_per_iteration: u64,
        start_time: 0x1::option::Option<u64>,
        iterations_total: u64,
        iteration_period_ms: u64,
        claim_window_ms: 0x1::option::Option<u64>,
        expiry_ms: 0x1::option::Option<u64>,
        whitelisted_recipients: vector<address>,
    }

    public fun add_create_stream_spec<T0>(arg0: &mut 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::Builder, arg1: 0x1::string::String, arg2: address, arg3: u64, arg4: 0x1::option::Option<u64>, arg5: u64, arg6: u64, arg7: 0x1::option::Option<u64>, arg8: 0x1::option::Option<u64>, arg9: vector<address>) {
        assert!(arg2 != @0x0, 2);
        assert!(arg3 > 0, 1);
        assert!(arg5 > 0, 1);
        assert!(arg6 > 0, 1);
        if (0x1::vector::is_empty<address>(&arg9)) {
            assert!(0x1::option::is_none<u64>(&arg8), 3);
        } else {
            let v0 = 0x1::vector::length<address>(&arg9);
            assert!(v0 <= 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::actions_constants::max_beneficiaries(), 5);
            let v1 = 0;
            while (v1 < v0) {
                let v2 = *0x1::vector::borrow<address>(&arg9, v1);
                assert!(v2 != @0x0, 4);
                let v3 = v1 + 1;
                while (v3 < v0) {
                    assert!(v2 != *0x1::vector::borrow<address>(&arg9, v3), 6);
                    v3 = v3 + 1;
                };
                v1 = v1 + 1;
            };
        };
        let v4 = CreateStreamAction{
            vault_name             : arg1,
            beneficiary            : arg2,
            amount_per_iteration   : arg3,
            start_time             : arg4,
            iterations_total       : arg5,
            iteration_period_ms    : arg6,
            claim_window_ms        : arg7,
            expiry_ms              : arg8,
            whitelisted_recipients : arg9,
        };
        0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::add(arg0, 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::new_action_spec<0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::vault::CreateStream<T0>>(0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::vault::create_stream_marker<T0>(), 0x2::bcs::to_bytes<CreateStreamAction>(&v4), 1));
    }

    // decompiled from Move bytecode v6
}

