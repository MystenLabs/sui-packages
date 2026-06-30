module 0x92bcba27fe910e7aa3769020252a9fb7498ae9e26f8113a7d3c7acfbd7f4af75::cetus_common {
    public(friend) fun accounted_deposit_value(arg0: u64, arg1: u128, arg2: u128, arg3: u128) : u64 {
        let v0 = (0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_math::accounted_value_delta(arg1, arg2) as u128) + arg3;
        assert!(v0 <= (arg0 as u128), 8);
        (v0 as u64)
    }

    public(friend) fun assert_admin_force_refresh_deviation<T0, T1>(arg0: &0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_pool::LLVPool<T0, T1>, arg1: u128) {
        let v0 = 0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_pool::get_protocol_balance<T0, T1>(arg0, 0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_allocation_plan::PROTOCOL_CETUS());
        if (v0 == 0 || arg1 == v0) {
            return
        };
        let v1 = if (arg1 > v0) {
            arg1 - v0
        } else {
            v0 - arg1
        };
        let v2 = 0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_math::mul_div(v0, (3000 as u128), 10000);
        let v3 = if (v2 == 0) {
            1
        } else {
            v2
        };
        assert!(v1 <= v3, 6);
    }

    public(friend) fun configured_instant_unstake_fee_rate<T0, T1>(arg0: &0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_pool::LLVPool<T0, T1>) : u64 {
        let v0 = 0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_pool::get_protocol_config<T0, T1>(arg0, 0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_allocation_plan::PROTOCOL_CETUS());
        let v1 = 0x1::option::destroy_some<u64>(0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_pool::config_get_value(&v0, 0));
        assert!(v1 < 10000000, 2);
        v1
    }

    public(friend) fun configured_withdraw_slippage_bps<T0, T1>(arg0: &0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_pool::LLVPool<T0, T1>) : u64 {
        let v0 = 0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_pool::get_protocol_config<T0, T1>(arg0, 0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_allocation_plan::PROTOCOL_CETUS());
        let v1 = 0x1::option::destroy_some<u64>(0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_pool::config_get_value(&v0, 1));
        assert!(v1 <= 10000, 3);
        v1
    }

    public(friend) fun consumed_input(arg0: u64, arg1: u64) : u64 {
        assert!(arg0 >= arg1, 8);
        arg0 - arg1
    }

    public(friend) fun instant_unstake_fee_rate<T0, T1>(arg0: &0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_pool::LLVPool<T0, T1>, arg1: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking) : u64 {
        let v0 = 0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_pool::get_protocol_config<T0, T1>(arg0, 0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_allocation_plan::PROTOCOL_CETUS());
        let v1 = 0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_pool::config_get_value(&v0, 0);
        if (0x1::option::is_some<u64>(&v1)) {
            let v3 = 0x1::option::destroy_some<u64>(v1);
            assert!(v3 < 10000000, 2);
            v3
        } else {
            0x1::option::destroy_none<u64>(v1);
            0x92bcba27fe910e7aa3769020252a9fb7498ae9e26f8113a7d3c7acfbd7f4af75::cetus_vault_adapter::instant_unstake_fee_rate(arg1)
        }
    }

    public(friend) fun withdraw_slippage_bps<T0, T1>(arg0: &0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_pool::LLVPool<T0, T1>) : u64 {
        let v0 = 0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_pool::get_protocol_config<T0, T1>(arg0, 0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_allocation_plan::PROTOCOL_CETUS());
        let v1 = 0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_pool::config_get_value(&v0, 1);
        if (0x1::option::is_some<u64>(&v1)) {
            let v3 = 0x1::option::destroy_some<u64>(v1);
            assert!(v3 <= 10000, 3);
            v3
        } else {
            0x1::option::destroy_none<u64>(v1);
            50
        }
    }

    // decompiled from Move bytecode v7
}

