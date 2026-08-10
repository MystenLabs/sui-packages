module 0x9a16d69572d8e2ebb5d4969af489263e3bcaf1e2e011f39a7c577ac19d95e8cb::cetus_common {
    public(friend) fun accounted_deposit_value(arg0: u64, arg1: u128, arg2: u128, arg3: u128) : u64 {
        let v0 = (arg0 as u128);
        assert!(arg3 <= v0, 8);
        let v1 = (0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_math::accounted_value_delta_capped(arg1, arg2, ((v0 - arg3) as u64)) as u128) + arg3;
        assert!(v1 <= v0, 8);
        (v1 as u64)
    }

    public(friend) fun assert_admin_force_refresh_deviation<T0, T1>(arg0: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>, arg1: u128) {
        let v0 = 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::get_protocol_balance<T0, T1>(arg0, 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::PROTOCOL_CETUS());
        if (v0 == 0 || arg1 == v0) {
            return
        };
        let v1 = if (arg1 > v0) {
            arg1 - v0
        } else {
            v0 - arg1
        };
        let v2 = 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_math::mul_div(v0, (3000 as u128), 10000);
        let v3 = if (v2 == 0) {
            1
        } else {
            v2
        };
        assert!(v1 <= v3, 6);
    }

    public(friend) fun consumed_input(arg0: u64, arg1: u64) : u64 {
        assert!(arg0 >= arg1, 8);
        arg0 - arg1
    }

    public(friend) fun instant_unstake_fee_rate<T0, T1>(arg0: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>, arg1: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking) : u64 {
        let v0 = 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::get_protocol_config<T0, T1>(arg0, 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::PROTOCOL_CETUS());
        let v1 = 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::config_get_value(&v0, 0);
        if (0x1::option::is_some<u64>(&v1)) {
            let v3 = 0x1::option::destroy_some<u64>(v1);
            assert!(v3 < 10000000, 2);
            v3
        } else {
            0x1::option::destroy_none<u64>(v1);
            0x9a16d69572d8e2ebb5d4969af489263e3bcaf1e2e011f39a7c577ac19d95e8cb::cetus_vault_adapter::instant_unstake_fee_rate(arg1)
        }
    }

    public(friend) fun withdraw_slippage_bps<T0, T1>(arg0: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>) : u64 {
        let v0 = 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::get_protocol_config<T0, T1>(arg0, 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::PROTOCOL_CETUS());
        let v1 = 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::config_get_value(&v0, 1);
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

