module 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_pump {
    struct Pump {
        dummy_field: bool,
    }

    struct PumpState<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        dev_purchase: 0x2::balance::Balance<T0>,
        liquidity_provision: 0x2::balance::Balance<T0>,
        allocation: 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fees::Allocation<T0>,
        constant_product: 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_constant_product::MemezConstantProduct<T0, T1>,
        migration_fee: 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fees::Fee,
    }

    public fun new<T0, T1, T2, T3>(arg0: &0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_config::MemezConfig, arg1: 0x2::coin::TreasuryCap<T0>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_pump_config::PumpConfig, arg4: 0x2::coin::Coin<T1>, arg5: 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_metadata::MemezMetadata, arg6: vector<address>, arg7: bool, arg8: address, arg9: 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_allowed_versions::AllowedVersions, arg10: &mut 0x2::tx_context::TxContext) : (0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fun::MemezFun<Pump, T0, T1>, 0xa204bd0d48d49fc7b8b05c8ef3f3ae63d1b22d157526a88b91391b41e6053157::ipx_coin_standard::MetadataCap) {
        0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_allowed_versions::assert_pkg_version(&arg9);
        0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_config::assert_quote_coin<T2, T1>(arg0);
        0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_config::assert_migrator_witness<T2, T3>(arg0);
        let v0 = 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_config::fees<T2>(arg0);
        0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fees::take<0x2::sui::SUI>(0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fees::creation(v0), &mut arg2, arg10);
        0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fees::assert_dynamic_stake_holders(v0, arg6);
        let v1 = arg10;
        if (0x2::coin::value<0x2::sui::SUI>(&arg2) == 0) {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg2);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, 0x2::tx_context::sender(v1));
        };
        let v2 = 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_pump_config::total_supply(&arg3);
        assert!(0x2::coin::total_supply<T0>(&arg1) == 0, 1);
        assert!(v2 != 0, 19);
        let (v3, v4) = 0xa204bd0d48d49fc7b8b05c8ef3f3ae63d1b22d157526a88b91391b41e6053157::ipx_coin_standard::new<T0>(arg1, arg10);
        let v5 = v4;
        let v6 = v3;
        0xa204bd0d48d49fc7b8b05c8ef3f3ae63d1b22d157526a88b91391b41e6053157::ipx_coin_standard::set_maximum_supply(&mut v5, v2);
        0xa204bd0d48d49fc7b8b05c8ef3f3ae63d1b22d157526a88b91391b41e6053157::ipx_coin_standard::allow_public_burn(&mut v5, &mut v6);
        0xa204bd0d48d49fc7b8b05c8ef3f3ae63d1b22d157526a88b91391b41e6053157::ipx_coin_standard::destroy_witness<T0>(&mut v6, v5);
        0x2::transfer::public_share_object<0xa204bd0d48d49fc7b8b05c8ef3f3ae63d1b22d157526a88b91391b41e6053157::ipx_coin_standard::IPXTreasuryStandard>(v6);
        let v7 = 0x2::coin::mint_balance<T0>(&mut arg1, v2);
        let v8 = PumpState<T0, T1>{
            id                  : 0x2::object::new(arg10),
            dev_purchase        : 0x2::balance::zero<T0>(),
            liquidity_provision : 0x2::balance::split<T0>(&mut v7, 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_pump_config::liquidity_provision(&arg3)),
            allocation          : 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fees::allocation<T0>(v0, &mut v7, arg6),
            constant_product    : 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_constant_product::new<T0, T1>(0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_pump_config::virtual_liquidity(&arg3), 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_pump_config::target_quote_liquidity(&arg3), v7, 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fees::meme_swap(v0, arg6), 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fees::quote_swap(v0, arg6), 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_config::meme_referrer_fee<T2>(arg0), 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_config::quote_referrer_fee<T2>(arg0), 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_pump_config::burn_tax(&arg3)),
            migration_fee       : 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fees::migration(v0, arg6),
        };
        let v9 = 0x2::object::id_address<PumpState<T0, T1>>(&v8);
        let v10 = if (arg7) {
            0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_config::public_key<T2>(arg0)
        } else {
            b""
        };
        let v11 = 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fun::new<Pump, T0, T1, T2, T3>(0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_versioned::create<PumpState<T0, T1>>(1, v8, arg10), v10, v9, arg5, 0x2::object::id_address<0xa204bd0d48d49fc7b8b05c8ef3f3ae63d1b22d157526a88b91391b41e6053157::ipx_coin_standard::IPXTreasuryStandard>(&v6), 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_pump_config::virtual_liquidity(&arg3), 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_pump_config::target_quote_liquidity(&arg3), 0x2::balance::value<T0>(&v7), 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_pump_config::total_supply(&arg3), arg8, arg10);
        let v12 = &mut v11;
        let v13 = state_mut<T0, T1>(v12);
        0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_constant_product::set_memez_fun<T0, T1>(&mut v13.constant_product, 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fun::addr<Pump, T0, T1>(&v11));
        0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_constant_product::set_inner_state<T0, T1>(&mut v13.constant_product, v9);
        if (0x2::coin::value<T1>(&arg4) != 0) {
            let v14 = &mut v11;
            let v15 = state_mut<T0, T1>(v14);
            let (v16, v17) = 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_constant_product::pump<T0, T1>(&mut v15.constant_product, arg4, 0x1::option::none<address>(), 0, arg10);
            if (v16) {
                0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fun::set_progress_to_migrating<Pump, T0, T1>(v14);
            };
            let v18 = &mut v11;
            0x2::balance::join<T0>(&mut state_mut<T0, T1>(v18).dev_purchase, 0x2::coin::into_balance<T0>(v17));
        } else {
            0x2::coin::destroy_zero<T1>(arg4);
        };
        (v11, 0xa204bd0d48d49fc7b8b05c8ef3f3ae63d1b22d157526a88b91391b41e6053157::ipx_coin_standard::create_metadata_cap(&mut v5, arg10))
    }

    public fun dump<T0, T1>(arg0: &mut 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fun::MemezFun<Pump, T0, T1>, arg1: &mut 0xa204bd0d48d49fc7b8b05c8ef3f3ae63d1b22d157526a88b91391b41e6053157::ipx_coin_standard::IPXTreasuryStandard, arg2: 0x2::coin::Coin<T0>, arg3: 0x1::option::Option<address>, arg4: u64, arg5: 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_allowed_versions::AllowedVersions, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_allowed_versions::assert_pkg_version(&arg5);
        0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fun::assert_is_bonding<Pump, T0, T1>(arg0);
        0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_constant_product::dump<T0, T1>(&mut state_mut<T0, T1>(arg0).constant_product, arg1, arg2, arg3, arg4, arg6)
    }

    public fun pump<T0, T1>(arg0: &mut 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fun::MemezFun<Pump, T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: 0x1::option::Option<address>, arg3: 0x1::option::Option<vector<u8>>, arg4: u64, arg5: 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_allowed_versions::AllowedVersions, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_allowed_versions::assert_pkg_version(&arg5);
        0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fun::assert_is_bonding<Pump, T0, T1>(arg0);
        0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_verifier::assert_can_buy(0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fun::nonces_mut<Pump, T0, T1>(arg0), 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fun::public_key<Pump, T0, T1>(arg0), arg3, 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fun::addr<Pump, T0, T1>(arg0), 0x2::coin::value<T1>(&arg1), arg6);
        let v0 = state_mut<T0, T1>(arg0);
        let (v1, v2) = 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_constant_product::pump<T0, T1>(&mut v0.constant_product, arg1, arg2, arg4, arg6);
        if (v1) {
            0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fun::set_progress_to_migrating<Pump, T0, T1>(arg0);
        };
        v2
    }

    public fun migrate<T0, T1>(arg0: &mut 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fun::MemezFun<Pump, T0, T1>, arg1: 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_allowed_versions::AllowedVersions, arg2: &mut 0x2::tx_context::TxContext) : 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fun::MemezMigrator<T0, T1> {
        0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_allowed_versions::assert_pkg_version(&arg1);
        0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fun::assert_is_migrating<Pump, T0, T1>(arg0);
        let v0 = state_mut<T0, T1>(arg0);
        let v1 = if (0x2::balance::value<T0>(&v0.liquidity_provision) == 0) {
            0x2::balance::withdraw_all<T0>(0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_constant_product::meme_balance_mut<T0, T1>(&mut v0.constant_product))
        } else {
            let v2 = 0x2::balance::withdraw_all<T0>(0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_constant_product::meme_balance_mut<T0, T1>(&mut v0.constant_product));
            if (0x2::balance::value<T0>(&v2) == 0) {
                0x2::balance::destroy_zero<T0>(v2);
            } else {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v2, arg2), @0x0);
            };
            0x2::balance::withdraw_all<T0>(&mut v0.liquidity_provision)
        };
        let v3 = 0x2::coin::from_balance<T1>(0x2::balance::withdraw_all<T1>(0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_constant_product::quote_balance_mut<T0, T1>(&mut v0.constant_product)), arg2);
        0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fees::take<T1>(v0.migration_fee, &mut v3, arg2);
        0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fun::migrate<Pump, T0, T1>(arg0, v1, 0x2::coin::into_balance<T1>(v3))
    }

    public fun dev_purchase_claim<T0, T1>(arg0: &mut 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fun::MemezFun<Pump, T0, T1>, arg1: 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_allowed_versions::AllowedVersions, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_allowed_versions::assert_pkg_version(&arg1);
        0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fun::assert_migrated<Pump, T0, T1>(arg0);
        0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fun::assert_is_dev<Pump, T0, T1>(arg0, arg2);
        0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut state_mut<T0, T1>(arg0).dev_purchase), arg2)
    }

    public fun distribute_stake_holders_allocation<T0, T1>(arg0: &mut 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fun::MemezFun<Pump, T0, T1>, arg1: &0x2::clock::Clock, arg2: 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_allowed_versions::AllowedVersions, arg3: &mut 0x2::tx_context::TxContext) {
        0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_allowed_versions::assert_pkg_version(&arg2);
        0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fun::assert_migrated<Pump, T0, T1>(arg0);
        0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fees::allocation_take<T0>(&mut state_mut<T0, T1>(arg0).allocation, arg1, arg3);
    }

    fun maybe_upgrade_state_to_latest(arg0: &mut 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_versioned::Versioned) {
        assert!(0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_versioned::version(arg0) == 1, 12);
    }

    public fun quote_dump<T0, T1>(arg0: &mut 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fun::MemezFun<Pump, T0, T1>, arg1: u64) : vector<u64> {
        0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fun::assert_is_bonding<Pump, T0, T1>(arg0);
        0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_constant_product::dump_amount<T0, T1>(&state<T0, T1>(arg0).constant_product, arg1)
    }

    public fun quote_pump<T0, T1>(arg0: &mut 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fun::MemezFun<Pump, T0, T1>, arg1: u64) : vector<u64> {
        0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fun::assert_is_bonding<Pump, T0, T1>(arg0);
        0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_constant_product::pump_amount<T0, T1>(&state<T0, T1>(arg0).constant_product, arg1)
    }

    fun state<T0, T1>(arg0: &mut 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fun::MemezFun<Pump, T0, T1>) : &PumpState<T0, T1> {
        let v0 = 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fun::versioned_mut<Pump, T0, T1>(arg0);
        maybe_upgrade_state_to_latest(v0);
        0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_versioned::load_value<PumpState<T0, T1>>(v0)
    }

    fun state_mut<T0, T1>(arg0: &mut 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fun::MemezFun<Pump, T0, T1>) : &mut PumpState<T0, T1> {
        let v0 = 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fun::versioned_mut<Pump, T0, T1>(arg0);
        maybe_upgrade_state_to_latest(v0);
        0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_versioned::load_value_mut<PumpState<T0, T1>>(v0)
    }

    // decompiled from Move bytecode v6
}

