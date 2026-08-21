module 0xd50d8f8e228270a5d57d2c2c9fda4b83ee0f835bc771e6c858ef814d0bf393c0::cetus_position {
    struct ExitPlan has copy, drop {
        lp_amount: u64,
    }

    public(friend) fun assert_strict_normalization(arg0: u128, arg1: u128) {
        assert!(arg1 >= arg0, 3);
    }

    public(friend) fun cached_exit_lp<T0, T1, T2>(arg0: &0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_pool::VaultPool<T0, T1>, arg1: u128) : u64 {
        let v0 = 0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_strategy::PROTOCOL_CETUS();
        let v1 = exit_plan(0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_pool::query_holding_balance<T0, T1, T2>(arg0, v0), 0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_pool::get_protocol_balance<T0, T1>(arg0, v0), arg1);
        lp_amount(&v1)
    }

    public(friend) fun exit_plan(arg0: u64, arg1: u128, arg2: u128) : ExitPlan {
        if (arg2 == 0) {
            return ExitPlan{lp_amount: 0}
        };
        assert!(arg0 > 0, 1);
        assert!(arg1 > 0, 2);
        let v0 = if (arg2 >= arg1) {
            (arg0 as u128)
        } else {
            0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_math::mul_div_ceil((arg0 as u128), arg2, arg1)
        };
        assert!(v0 <= 18446744073709551615, 1);
        ExitPlan{lp_amount: (v0 as u64)}
    }

    public(friend) fun lp_amount(arg0: &ExitPlan) : u64 {
        arg0.lp_amount
    }

    public(friend) fun validate_exit_objects<T0, T1, T2>(arg0: &0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_pool::VaultPool<T0, T1>, arg1: &0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::VaultsManager, arg2: &0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T2>, arg3: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg4: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg5: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool, arg6: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg7: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>, arg8: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking) {
        0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_validation::validate_cetus_config_for_asset<T0, T1>(arg0, 0x2::object::id<0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T2>>(arg2), 0x2::object::id<0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::VaultsManager>(arg1), 0x2::object::id<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager>(arg3), 0x2::object::id<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig>(arg4), 0x2::object::id<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool>(arg5), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig>(arg6), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>>(arg7), 0x2::object::id<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking>(arg8));
    }

    // decompiled from Move bytecode v7
}

