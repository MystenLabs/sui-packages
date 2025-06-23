module 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_stable {
    struct Stable {
        dummy_field: bool,
    }

    struct StableState<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        meme_reserve: 0x2::balance::Balance<T0>,
        dev_allocation: 0x2::balance::Balance<T0>,
        dev_vesting_period: u64,
        liquidity_provision: 0x2::balance::Balance<T0>,
        fixed_rate: 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fixed_rate::FixedRate<T0, T1>,
        meme_token_cap: 0x1::option::Option<0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_token_cap::MemezTokenCap<T0>>,
        migration_fee: 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fees::Fee,
        allocation: 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fees::Allocation<T0>,
    }

    public fun new<T0, T1, T2, T3>(arg0: &0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_config::MemezConfig, arg1: 0x2::coin::TreasuryCap<T0>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_stable_config::StableConfig, arg4: bool, arg5: 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_metadata::MemezMetadata, arg6: vector<u64>, arg7: vector<address>, arg8: address, arg9: 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_allowed_versions::AllowedVersions, arg10: &mut 0x2::tx_context::TxContext) : (0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fun::MemezFun<Stable, T0, T1>, 0xa204bd0d48d49fc7b8b05c8ef3f3ae63d1b22d157526a88b91391b41e6053157::ipx_coin_standard::MetadataCap) {
        0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_allowed_versions::assert_pkg_version(&arg9);
        0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_config::assert_quote_coin<T2, T1>(arg0);
        0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_config::assert_migrator_witness<T2, T3>(arg0);
        let v0 = 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_config::fees<T2>(arg0);
        0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fees::take<0x2::sui::SUI>(0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fees::creation(v0), &mut arg2, arg10);
        0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fees::assert_dynamic_stake_holders(v0, arg7);
        let v1 = arg10;
        if (0x2::coin::value<0x2::sui::SUI>(&arg2) == 0) {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg2);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, 0x2::tx_context::sender(v1));
        };
        let v2 = if (arg4) {
            0x1::option::some<0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_token_cap::MemezTokenCap<T0>>(0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_token_cap::new<T0>(&arg1, arg10))
        } else {
            0x1::option::none<0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_token_cap::MemezTokenCap<T0>>()
        };
        let v3 = 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_stable_config::total_supply(&arg3);
        assert!(0x2::coin::total_supply<T0>(&arg1) == 0, 1);
        assert!(v3 != 0, 19);
        let (v4, v5) = 0xa204bd0d48d49fc7b8b05c8ef3f3ae63d1b22d157526a88b91391b41e6053157::ipx_coin_standard::new<T0>(arg1, arg10);
        let v6 = v5;
        let v7 = v4;
        0xa204bd0d48d49fc7b8b05c8ef3f3ae63d1b22d157526a88b91391b41e6053157::ipx_coin_standard::set_maximum_supply(&mut v6, v3);
        0xa204bd0d48d49fc7b8b05c8ef3f3ae63d1b22d157526a88b91391b41e6053157::ipx_coin_standard::allow_public_burn(&mut v6, &mut v7);
        0xa204bd0d48d49fc7b8b05c8ef3f3ae63d1b22d157526a88b91391b41e6053157::ipx_coin_standard::destroy_witness<T0>(&mut v7, v6);
        0x2::transfer::public_share_object<0xa204bd0d48d49fc7b8b05c8ef3f3ae63d1b22d157526a88b91391b41e6053157::ipx_coin_standard::IPXTreasuryStandard>(v7);
        let v8 = 0x2::coin::mint_balance<T0>(&mut arg1, v3);
        let v9 = StableState<T0, T1>{
            id                  : 0x2::object::new(arg10),
            meme_reserve        : v8,
            dev_allocation      : 0x2::balance::split<T0>(&mut v8, *0x1::vector::borrow<u64>(&arg6, 0)),
            dev_vesting_period  : *0x1::vector::borrow<u64>(&arg6, 1),
            liquidity_provision : 0x2::balance::split<T0>(&mut v8, 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_stable_config::liquidity_provision(&arg3)),
            fixed_rate          : 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fixed_rate::new<T0, T1>(0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_stable_config::target_quote_liquidity(&arg3), 0x2::balance::split<T0>(&mut v8, 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_stable_config::meme_sale_amount(&arg3)), 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fees::meme_swap(v0, arg7), 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fees::quote_swap(v0, arg7)),
            meme_token_cap      : v2,
            migration_fee       : 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fees::migration(v0, arg7),
            allocation          : 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fees::allocation<T0>(v0, &mut v8, arg7),
        };
        let v10 = 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fun::new<Stable, T0, T1, T2, T3>(0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_versioned::create<StableState<T0, T1>>(1, v9, arg10), arg4, 0x2::object::id_address<StableState<T0, T1>>(&v9), arg5, 0x2::object::id_address<0xa204bd0d48d49fc7b8b05c8ef3f3ae63d1b22d157526a88b91391b41e6053157::ipx_coin_standard::IPXTreasuryStandard>(&v7), 0, 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_stable_config::target_quote_liquidity(&arg3), 0x2::balance::value<T0>(0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fixed_rate::meme_balance<T0, T1>(&v9.fixed_rate)), 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_stable_config::total_supply(&arg3), arg8, arg10);
        let v11 = &mut v10;
        0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fixed_rate::set_memez_fun<T0, T1>(&mut state_mut<T0, T1>(v11).fixed_rate, 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fun::addr<Stable, T0, T1>(&v10));
        (v10, 0xa204bd0d48d49fc7b8b05c8ef3f3ae63d1b22d157526a88b91391b41e6053157::ipx_coin_standard::create_metadata_cap(&mut v6, arg10))
    }

    public fun dump<T0, T1>(arg0: &mut 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fun::MemezFun<Stable, T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_allowed_versions::AllowedVersions, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_allowed_versions::assert_pkg_version(&arg2);
        0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fun::assert_uses_coin<Stable, T0, T1>(arg0);
        0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fun::assert_is_bonding<Stable, T0, T1>(arg0);
        0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fixed_rate::dump<T0, T1>(&mut state_mut<T0, T1>(arg0).fixed_rate, arg1, arg3)
    }

    public fun pump<T0, T1>(arg0: &mut 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fun::MemezFun<Stable, T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_allowed_versions::AllowedVersions, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T0>) {
        0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_allowed_versions::assert_pkg_version(&arg2);
        0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fun::assert_uses_coin<Stable, T0, T1>(arg0);
        0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fun::assert_is_bonding<Stable, T0, T1>(arg0);
        let v0 = state_mut<T0, T1>(arg0);
        let (v1, v2, v3) = 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fixed_rate::pump<T0, T1>(&mut v0.fixed_rate, arg1, arg3);
        if (v1) {
            0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fun::set_progress_to_migrating<Stable, T0, T1>(arg0);
        };
        (v2, v3)
    }

    public fun migrate<T0, T1>(arg0: &mut 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fun::MemezFun<Stable, T0, T1>, arg1: 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_allowed_versions::AllowedVersions, arg2: &mut 0x2::tx_context::TxContext) : 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fun::MemezMigrator<T0, T1> {
        0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_allowed_versions::assert_pkg_version(&arg1);
        0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fun::assert_is_migrating<Stable, T0, T1>(arg0);
        let v0 = state_mut<T0, T1>(arg0);
        let v1 = 0x2::balance::withdraw_all<T0>(&mut v0.meme_reserve);
        if (0x2::balance::value<T0>(&v1) == 0) {
            0x2::balance::destroy_zero<T0>(v1);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v1, arg2), @0x0);
        };
        let v2 = 0x2::balance::withdraw_all<T0>(0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fixed_rate::meme_balance_mut<T0, T1>(&mut v0.fixed_rate));
        if (0x2::balance::value<T0>(&v2) == 0) {
            0x2::balance::destroy_zero<T0>(v2);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v2, arg2), @0x0);
        };
        let v3 = 0x2::coin::from_balance<T1>(0x2::balance::withdraw_all<T1>(0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fixed_rate::quote_balance_mut<T0, T1>(&mut v0.fixed_rate)), arg2);
        0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fees::take<T1>(v0.migration_fee, &mut v3, arg2);
        0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fun::migrate<Stable, T0, T1>(arg0, 0x2::balance::withdraw_all<T0>(&mut v0.liquidity_provision), 0x2::coin::into_balance<T1>(v3))
    }

    public fun dev_allocation_claim<T0, T1>(arg0: &mut 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fun::MemezFun<Stable, T0, T1>, arg1: &0x2::clock::Clock, arg2: 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_allowed_versions::AllowedVersions, arg3: &mut 0x2::tx_context::TxContext) : 0x1a184ecf7d0652f8f1285a3b0b2e644bf86ae1742317fcdaa9b11a7f3a30bd70::memez_vesting::MemezVesting<T0> {
        0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_allowed_versions::assert_pkg_version(&arg2);
        0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fun::assert_migrated<Stable, T0, T1>(arg0);
        0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fun::assert_is_dev<Stable, T0, T1>(arg0, arg3);
        let v0 = state_mut<T0, T1>(arg0);
        0x1a184ecf7d0652f8f1285a3b0b2e644bf86ae1742317fcdaa9b11a7f3a30bd70::memez_vesting::new<T0>(arg1, 0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut v0.dev_allocation), arg3), 0x2::clock::timestamp_ms(arg1), v0.dev_vesting_period, arg3)
    }

    public fun distribute_stake_holders_allocation<T0, T1>(arg0: &mut 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fun::MemezFun<Stable, T0, T1>, arg1: &0x2::clock::Clock, arg2: 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_allowed_versions::AllowedVersions, arg3: &mut 0x2::tx_context::TxContext) {
        0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_allowed_versions::assert_pkg_version(&arg2);
        0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fun::assert_migrated<Stable, T0, T1>(arg0);
        0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fees::allocation_take<T0>(&mut state_mut<T0, T1>(arg0).allocation, arg1, arg3);
    }

    public fun dump_token<T0, T1>(arg0: &mut 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fun::MemezFun<Stable, T0, T1>, arg1: 0x2::token::Token<T0>, arg2: 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_allowed_versions::AllowedVersions, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_allowed_versions::assert_pkg_version(&arg2);
        0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fun::assert_uses_token<Stable, T0, T1>(arg0);
        0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fun::assert_is_bonding<Stable, T0, T1>(arg0);
        let v0 = state_mut<T0, T1>(arg0);
        0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fixed_rate::dump<T0, T1>(&mut v0.fixed_rate, 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_token_cap::to_coin<T0>(token_cap<T0, T1>(v0), arg1, arg3), arg3)
    }

    fun maybe_upgrade_state_to_latest(arg0: &mut 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_versioned::Versioned) {
        assert!(0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_versioned::version(arg0) == 1, 13);
    }

    public fun pump_token<T0, T1>(arg0: &mut 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fun::MemezFun<Stable, T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_allowed_versions::AllowedVersions, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::token::Token<T0>) {
        0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_allowed_versions::assert_pkg_version(&arg2);
        0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fun::assert_uses_token<Stable, T0, T1>(arg0);
        0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fun::assert_is_bonding<Stable, T0, T1>(arg0);
        let v0 = state_mut<T0, T1>(arg0);
        let (v1, v2, v3) = 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fixed_rate::pump<T0, T1>(&mut v0.fixed_rate, arg1, arg3);
        if (v1) {
            0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fun::set_progress_to_migrating<Stable, T0, T1>(arg0);
        };
        (v2, 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_token_cap::from_coin<T0>(token_cap<T0, T1>(v0), v3, arg3))
    }

    public fun quote_dump<T0, T1>(arg0: &mut 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fun::MemezFun<Stable, T0, T1>, arg1: u64) : vector<u64> {
        0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fun::assert_is_bonding<Stable, T0, T1>(arg0);
        0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fixed_rate::dump_amount<T0, T1>(&state<T0, T1>(arg0).fixed_rate, arg1, 0)
    }

    public fun quote_pump<T0, T1>(arg0: &mut 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fun::MemezFun<Stable, T0, T1>, arg1: u64) : vector<u64> {
        0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fun::assert_is_bonding<Stable, T0, T1>(arg0);
        0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fixed_rate::pump_amount<T0, T1>(&state<T0, T1>(arg0).fixed_rate, arg1, 0)
    }

    fun state<T0, T1>(arg0: &mut 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fun::MemezFun<Stable, T0, T1>) : &StableState<T0, T1> {
        let v0 = 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fun::versioned_mut<Stable, T0, T1>(arg0);
        maybe_upgrade_state_to_latest(v0);
        0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_versioned::load_value<StableState<T0, T1>>(v0)
    }

    fun state_mut<T0, T1>(arg0: &mut 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fun::MemezFun<Stable, T0, T1>) : &mut StableState<T0, T1> {
        let v0 = 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fun::versioned_mut<Stable, T0, T1>(arg0);
        maybe_upgrade_state_to_latest(v0);
        0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_versioned::load_value_mut<StableState<T0, T1>>(v0)
    }

    public fun to_coin<T0, T1>(arg0: &mut 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fun::MemezFun<Stable, T0, T1>, arg1: 0x2::token::Token<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fun::assert_migrated<Stable, T0, T1>(arg0);
        0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_token_cap::to_coin<T0>(token_cap<T0, T1>(state_mut<T0, T1>(arg0)), arg1, arg2)
    }

    fun token_cap<T0, T1>(arg0: &StableState<T0, T1>) : &0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_token_cap::MemezTokenCap<T0> {
        0x1::option::borrow<0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_token_cap::MemezTokenCap<T0>>(&arg0.meme_token_cap)
    }

    // decompiled from Move bytecode v6
}

