module 0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::protective_ask {
    struct ProtectiveAsk<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        account_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        price_per_token: u64,
        max_mint_amount: u64,
        minted_amount: u64,
        total_stable_collected: u64,
        seq_num: u64,
        release_deadline_ms: u64,
        active: bool,
        mint_admin_cap: 0x1::option::Option<0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::currency::CurrencyMintAdminCap<T0>>,
    }

    struct ProtectiveAskCreated has copy, drop {
        ask_id: 0x2::object::ID,
        account_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        price_per_token: u64,
        max_mint_amount: u64,
        release_deadline_ms: u64,
    }

    struct TokensBoughtFromAsk has copy, drop {
        ask_id: 0x2::object::ID,
        buyer: address,
        asset_bought: u64,
        stable_spent: u64,
        price_per_token: u64,
        post_minted_amount: u64,
        post_remaining_mint_amount: u64,
        post_total_stable_collected: u64,
        seq_num: u64,
    }

    struct AskReleased has copy, drop {
        ask_id: 0x2::object::ID,
        stable_to_treasury: u64,
        final_minted_amount: u64,
        final_stable_collected_amount: u64,
    }

    public fun account_id<T0, T1>(arg0: &ProtectiveAsk<T0, T1>) : 0x2::object::ID {
        arg0.account_id
    }

    public fun buy_from_ask<T0: store, T1, T2, T3>(arg0: &mut ProtectiveAsk<T1, T2>, arg1: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg2: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::PackageRegistry, arg3: &0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::unified_spot_pool::UnifiedSpotPool<T1, T2, T3>, arg4: 0x2::coin::Coin<T2>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>) {
        0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::futarchy_config::assert_not_terminated(0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::futarchy_config::dao_state(0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::config<0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::futarchy_config::FutarchyConfig>(arg1)));
        assert!(arg0.active, 1);
        assert!(0x2::object::id<0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account>(arg1) == arg0.account_id, 4);
        assert!(0x2::object::id<0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::unified_spot_pool::UnifiedSpotPool<T1, T2, T3>>(arg3) == arg0.pool_id, 9);
        assert!(!0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::unified_spot_pool::is_locked_for_proposal<T1, T2, T3>(arg3), 8);
        if (arg0.release_deadline_ms > 0) {
            assert!(0x2::clock::timestamp_ms(arg6) < arg0.release_deadline_ms, 7);
        };
        assert!(arg0.max_mint_amount >= arg0.minted_amount, 17);
        let v0 = arg0.max_mint_amount - arg0.minted_amount;
        assert!(v0 > 0, 6);
        assert!(arg5 > 0, 3);
        assert!(arg5 <= v0, 6);
        let v1 = 0x8085d42c3f597247c761e0a15e56d201a6e9727f2dff5a1d794491416b5ce82f::math::mul_div_mixed_up((arg0.price_per_token as u128), arg5, (0x8085d42c3f597247c761e0a15e56d201a6e9727f2dff5a1d794491416b5ce82f::constants::price_precision_scale() as u128));
        assert!(v1 <= 18446744073709551615, 16);
        let v2 = (v1 as u64);
        assert!(0x2::coin::value<T2>(&arg4) >= v2, 14);
        let v3 = 0x2::coin::into_balance<T2>(arg4);
        0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::vault::deposit_approved<T0, T2>(arg1, arg2, 0x1::string::utf8(b"treasury"), 0x2::coin::from_balance<T2>(0x2::balance::split<T2>(&mut v3, v2), arg7));
        assert!(arg0.total_stable_collected <= 18446744073709551615 - v2, 16);
        arg0.total_stable_collected = arg0.total_stable_collected + v2;
        arg0.minted_amount = arg0.minted_amount + arg5;
        arg0.seq_num = arg0.seq_num + 1;
        let v4 = TokensBoughtFromAsk{
            ask_id                      : 0x2::object::id<ProtectiveAsk<T1, T2>>(arg0),
            buyer                       : 0x2::tx_context::sender(arg7),
            asset_bought                : arg5,
            stable_spent                : v2,
            price_per_token             : arg0.price_per_token,
            post_minted_amount          : arg0.minted_amount,
            post_remaining_mint_amount  : arg0.max_mint_amount - arg0.minted_amount,
            post_total_stable_collected : arg0.total_stable_collected,
            seq_num                     : arg0.seq_num,
        };
        0x2::event::emit<TokensBoughtFromAsk>(v4);
        (0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::currency::mint_with_admin_cap<T1>(arg1, arg2, 0x1::option::borrow<0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::currency::CurrencyMintAdminCap<T1>>(&arg0.mint_admin_cap), arg5, arg7), 0x2::coin::from_balance<T2>(v3, arg7))
    }

    public fun cancel<T0, T1>(arg0: &mut ProtectiveAsk<T0, T1>, arg1: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg2: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::PackageRegistry, arg3: 0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::spot_pool_mutation_auth::SpotPoolMutationAuth, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::spot_pool_mutation_auth::target_id(&arg3) == arg0.pool_id, 13);
        assert!(arg0.active, 1);
        assert!(0x2::object::id<0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account>(arg1) == arg0.account_id, 4);
        arg0.active = false;
        if (0x1::option::is_some<0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::currency::CurrencyMintAdminCap<T0>>(&arg0.mint_admin_cap)) {
            0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::currency::destroy_currency_mint_admin_cap<T0>(0x1::option::extract<0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::currency::CurrencyMintAdminCap<T0>>(&mut arg0.mint_admin_cap));
        };
        0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::protective_ask_registry::clear_with_package_witness(arg1, arg2, 0x2::object::id<ProtectiveAsk<T0, T1>>(arg0));
        let v0 = AskReleased{
            ask_id                        : 0x2::object::id<ProtectiveAsk<T0, T1>>(arg0),
            stable_to_treasury            : 0,
            final_minted_amount           : arg0.minted_amount,
            final_stable_collected_amount : arg0.total_stable_collected,
        };
        0x2::event::emit<AskReleased>(v0);
        0x2::coin::zero<T1>(arg4)
    }

    public fun close<T0, T1>(arg0: &mut ProtectiveAsk<T0, T1>, arg1: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg2: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::PackageRegistry, arg3: &0x2::clock::Clock) {
        assert!(arg0.active, 1);
        assert!(arg0.release_deadline_ms > 0, 18);
        assert!(0x2::clock::timestamp_ms(arg3) >= arg0.release_deadline_ms, 2);
        assert!(0x2::object::id<0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account>(arg1) == arg0.account_id, 4);
        arg0.active = false;
        if (0x1::option::is_some<0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::currency::CurrencyMintAdminCap<T0>>(&arg0.mint_admin_cap)) {
            0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::currency::destroy_currency_mint_admin_cap<T0>(0x1::option::extract<0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::currency::CurrencyMintAdminCap<T0>>(&mut arg0.mint_admin_cap));
        };
        0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::protective_ask_registry::clear_with_package_witness(arg1, arg2, 0x2::object::id<ProtectiveAsk<T0, T1>>(arg0));
        let v0 = AskReleased{
            ask_id                        : 0x2::object::id<ProtectiveAsk<T0, T1>>(arg0),
            stable_to_treasury            : 0,
            final_minted_amount           : arg0.minted_amount,
            final_stable_collected_amount : arg0.total_stable_collected,
        };
        0x2::event::emit<AskReleased>(v0);
    }

    public fun create<T0, T1>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64, arg5: 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::currency::CurrencyMintAdminCap<T0>, arg6: 0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::spot_pool_mutation_auth::SpotPoolMutationAuth, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : ProtectiveAsk<T0, T1> {
        assert!(arg3 > 0, 3);
        assert!(arg2 > 0, 19);
        assert!(0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::spot_pool_mutation_auth::target_id(&arg6) == arg1, 13);
        assert!(0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::currency::mint_admin_cap_account_id<T0>(&arg5) == arg0, 20);
        let v0 = if (arg4 == 0) {
            0
        } else {
            0x2::clock::timestamp_ms(arg7) + arg4
        };
        let v1 = ProtectiveAsk<T0, T1>{
            id                     : 0x2::object::new(arg8),
            account_id             : arg0,
            pool_id                : arg1,
            price_per_token        : arg2,
            max_mint_amount        : arg3,
            minted_amount          : 0,
            total_stable_collected : 0,
            seq_num                : 0,
            release_deadline_ms    : v0,
            active                 : true,
            mint_admin_cap         : 0x1::option::some<0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::currency::CurrencyMintAdminCap<T0>>(arg5),
        };
        let v2 = ProtectiveAskCreated{
            ask_id              : 0x2::object::id<ProtectiveAsk<T0, T1>>(&v1),
            account_id          : arg0,
            pool_id             : arg1,
            price_per_token     : arg2,
            max_mint_amount     : arg3,
            release_deadline_ms : v0,
        };
        0x2::event::emit<ProtectiveAskCreated>(v2);
        v1
    }

    public fun emergency_withdraw_stable<T0, T1>(arg0: &mut ProtectiveAsk<T0, T1>, arg1: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg2: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::PackageRegistry, arg3: &0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::emergency_cap::EmergencyCap, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::emergency_cap::assert_ready(arg3, arg4);
        assert!(0x2::object::id<0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account>(arg1) == arg0.account_id, 4);
        if (0x1::option::is_some<0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::currency::CurrencyMintAdminCap<T0>>(&arg0.mint_admin_cap)) {
            0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::currency::destroy_currency_mint_admin_cap<T0>(0x1::option::extract<0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::currency::CurrencyMintAdminCap<T0>>(&mut arg0.mint_admin_cap));
        };
        arg0.active = false;
        0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::protective_ask_registry::clear_with_package_witness(arg1, arg2, 0x2::object::id<ProtectiveAsk<T0, T1>>(arg0));
        0x2::coin::zero<T1>(arg5)
    }

    public fun is_active<T0, T1>(arg0: &ProtectiveAsk<T0, T1>) : bool {
        arg0.active
    }

    public fun max_mint_amount<T0, T1>(arg0: &ProtectiveAsk<T0, T1>) : u64 {
        arg0.max_mint_amount
    }

    public fun minted_amount<T0, T1>(arg0: &ProtectiveAsk<T0, T1>) : u64 {
        arg0.minted_amount
    }

    public fun pool_id<T0, T1>(arg0: &ProtectiveAsk<T0, T1>) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun precision() : u64 {
        0x8085d42c3f597247c761e0a15e56d201a6e9727f2dff5a1d794491416b5ce82f::constants::price_precision_scale()
    }

    public fun price_per_token<T0, T1>(arg0: &ProtectiveAsk<T0, T1>) : u64 {
        arg0.price_per_token
    }

    public fun quote_buy<T0, T1>(arg0: &ProtectiveAsk<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock) : u64 {
        if (!arg0.active) {
            return 0
        };
        if (arg1 == 0) {
            return 0
        };
        if (arg0.release_deadline_ms > 0 && 0x2::clock::timestamp_ms(arg2) >= arg0.release_deadline_ms) {
            return 0
        };
        if (arg0.minted_amount > arg0.max_mint_amount) {
            return 0
        };
        let v0 = arg0.max_mint_amount - arg0.minted_amount;
        if (v0 == 0 || arg1 > v0) {
            return 0
        };
        let v1 = 0x8085d42c3f597247c761e0a15e56d201a6e9727f2dff5a1d794491416b5ce82f::math::mul_div_mixed_up((arg0.price_per_token as u128), arg1, (0x8085d42c3f597247c761e0a15e56d201a6e9727f2dff5a1d794491416b5ce82f::constants::price_precision_scale() as u128));
        if (v1 > 18446744073709551615) {
            return 0
        };
        (v1 as u64)
    }

    public fun release_deadline_ms<T0, T1>(arg0: &ProtectiveAsk<T0, T1>) : u64 {
        arg0.release_deadline_ms
    }

    public fun remaining_mint_amount<T0, T1>(arg0: &ProtectiveAsk<T0, T1>) : u64 {
        if (arg0.minted_amount >= arg0.max_mint_amount) {
            0
        } else {
            arg0.max_mint_amount - arg0.minted_amount
        }
    }

    public fun remaining_stable<T0, T1>(arg0: &ProtectiveAsk<T0, T1>) : u64 {
        0
    }

    public fun seq_num<T0, T1>(arg0: &ProtectiveAsk<T0, T1>) : u64 {
        arg0.seq_num
    }

    public fun stable_collected_amount<T0, T1>(arg0: &ProtectiveAsk<T0, T1>) : u64 {
        arg0.total_stable_collected
    }

    // decompiled from Move bytecode v6
}

