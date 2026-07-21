module 0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::migration {
    struct MigratedEvent<phantom T0, phantom T1> has copy, drop {
        pool_id: 0x2::object::ID,
        cetus_pool_id: 0x2::object::ID,
        base_amount: u64,
        quote_amount: u64,
        sqrt_price_x64: u128,
        base_is_coin_a: bool,
        tick_spacing: u32,
        migration_fee: u64,
        base_burned: u64,
        quote_dust_to_platform: u64,
    }

    struct LpFeesClaimedEvent<phantom T0, phantom T1> has copy, drop {
        pool_id: 0x2::object::ID,
        base_burned: u64,
        quote_platform: u64,
        quote_creator: u64,
    }

    struct TvlTrancheClaimedEvent<phantom T0, phantom T1> has copy, drop {
        pool_id: 0x2::object::ID,
        market_cap_in_quote: u128,
        tvl_target: u64,
        qualified: bool,
        gate_open: bool,
        gate_opened_at_ms: u64,
        amount: u64,
        vesting_duration_ms: u64,
        sqrt_price_x64: u128,
        total_supply: u64,
    }

    struct LpRewardsClaimedEvent<phantom T0, phantom T1> has copy, drop {
        pool_id: 0x2::object::ID,
        reward_type: 0x1::type_name::TypeName,
        platform_amount: u64,
        creator_amount: u64,
    }

    fun assert_claimable<T0, T1>(arg0: &0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::config::LaunchpadConfig, arg1: &0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::pool::Pool<T0, T1>, arg2: 0x2::object::ID, arg3: bool) {
        0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::config::assert_version(arg0);
        0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::pool::assert_migrated<T0, T1>(arg1);
        assert!(0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::pool::cetus_pool_id<T0, T1>(arg1) == 0x1::option::some<0x2::object::ID>(arg2), 1);
        assert!(0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::pool::base_is_coin_a<T0, T1>(arg1) == 0x1::option::some<bool>(arg3), 2);
    }

    fun burn_or_destroy<T0>(arg0: &mut 0x2::coin_registry::Currency<T0>, arg1: 0x2::coin::Coin<T0>) {
        if (0x2::coin::value<T0>(&arg1) > 0) {
            0x2::coin_registry::burn<T0>(arg0, arg1);
        } else {
            0x2::coin::destroy_zero<T0>(arg1);
        };
    }

    public fun claim_lp_fees<T0, T1>(arg0: &0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::config::LaunchpadConfig, arg1: &mut 0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::pool::Pool<T0, T1>, arg2: &mut 0x2::coin_registry::Currency<T0>, arg3: &0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg6: &mut 0x2::tx_context::TxContext) {
        assert_claimable<T0, T1>(arg0, arg1, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg5), true);
        0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::pool::assert_burn_only_currency<T0>(arg2);
        let (v0, v1) = 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::collect_fee<T0, T1>(arg3, arg4, arg5, 0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::pool::borrow_burn_proof_mut<T0, T1>(arg1), arg6);
        settle_lp_fees<T0, T1>(arg0, arg1, arg2, v0, v1, arg6);
    }

    public fun claim_lp_fees_inverted<T0, T1>(arg0: &0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::config::LaunchpadConfig, arg1: &mut 0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::pool::Pool<T0, T1>, arg2: &mut 0x2::coin_registry::Currency<T0>, arg3: &0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg6: &mut 0x2::tx_context::TxContext) {
        assert_claimable<T0, T1>(arg0, arg1, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg5), false);
        0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::pool::assert_burn_only_currency<T0>(arg2);
        let (v0, v1) = 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::collect_fee<T1, T0>(arg3, arg4, arg5, 0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::pool::borrow_burn_proof_mut<T0, T1>(arg1), arg6);
        settle_lp_fees<T0, T1>(arg0, arg1, arg2, v1, v0, arg6);
    }

    public fun claim_lp_rewards<T0, T1, T2>(arg0: &0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::config::LaunchpadConfig, arg1: &mut 0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::pool::Pool<T0, T1>, arg2: &0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert_claimable<T0, T1>(arg0, arg1, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg4), true);
        let v0 = 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::collect_reward<T0, T1, T2>(arg2, arg3, arg4, 0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::pool::borrow_burn_proof_mut<T0, T1>(arg1), arg5, arg6, arg7);
        settle_lp_rewards<T0, T1, T2>(arg0, arg1, v0, arg7);
    }

    public fun claim_lp_rewards_inverted<T0, T1, T2>(arg0: &0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::config::LaunchpadConfig, arg1: &mut 0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::pool::Pool<T0, T1>, arg2: &0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert_claimable<T0, T1>(arg0, arg1, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg4), false);
        let v0 = 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::collect_reward<T1, T0, T2>(arg2, arg3, arg4, 0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::pool::borrow_burn_proof_mut<T0, T1>(arg1), arg5, arg6, arg7);
        settle_lp_rewards<T0, T1, T2>(arg0, arg1, v0, arg7);
    }

    entry fun claim_tranche_tvl<T0, T1>(arg0: &0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::config::LaunchpadConfig, arg1: &mut 0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x2::coin_registry::Currency<T0>, arg4: &0x2::clock::Clock) {
        do_claim_tranche_tvl<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    fun claim_tranche_tvl_internal<T0, T1>(arg0: &0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::config::LaunchpadConfig, arg1: &mut 0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::pool::Pool<T0, T1>, arg2: 0x2::object::ID, arg3: &0x2::coin_registry::Currency<T0>, arg4: u128, arg5: bool, arg6: &0x2::clock::Clock) {
        0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::config::assert_version(arg0);
        0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::pool::assert_migrated<T0, T1>(arg1);
        assert!(0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::pool::cetus_pool_id<T0, T1>(arg1) == 0x1::option::some<0x2::object::ID>(arg2), 1);
        assert!(0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::pool::base_is_coin_a<T0, T1>(arg1) == 0x1::option::some<bool>(arg5), 2);
        0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::pool::assert_burn_only_currency<T0>(arg3);
        let v0 = 0x1::option::destroy_some<u64>(0x2::coin_registry::total_supply<T0>(arg3));
        let v1 = 0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::curve::tvl_in_quote(v0, 0, arg4, arg5);
        let v2 = 0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::pool::tvl_tranche_target<T0, T1>(arg1);
        let v3 = v1 >= (v2 as u128);
        let (v4, v5, v6, v7) = 0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::pool::claim_tvl_tranche<T0, T1>(arg1, v3, 0x2::clock::timestamp_ms(arg6));
        let v8 = v4;
        let v9 = 0x2::balance::value<T0>(&v8);
        let v10 = TvlTrancheClaimedEvent<T0, T1>{
            pool_id             : 0x2::object::id<0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::pool::Pool<T0, T1>>(arg1),
            market_cap_in_quote : v1,
            tvl_target          : v2,
            qualified           : v3,
            gate_open           : v6,
            gate_opened_at_ms   : v7,
            amount              : v9,
            vesting_duration_ms : 0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::pool::tvl_vesting_duration_ms<T0, T1>(arg1),
            sqrt_price_x64      : arg4,
            total_supply        : v0,
        };
        0x2::event::emit<TvlTrancheClaimedEvent<T0, T1>>(v10);
        if (v9 > 0) {
            0x2::balance::send_funds<T0>(v8, v5);
        } else {
            0x2::balance::destroy_zero<T0>(v8);
        };
    }

    entry fun claim_tranche_tvl_inverted<T0, T1>(arg0: &0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::config::LaunchpadConfig, arg1: &mut 0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &0x2::coin_registry::Currency<T0>, arg4: &0x2::clock::Clock) {
        do_claim_tranche_tvl_inverted<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    public(friend) fun do_claim_tranche_tvl<T0, T1>(arg0: &0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::config::LaunchpadConfig, arg1: &mut 0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x2::coin_registry::Currency<T0>, arg4: &0x2::clock::Clock) {
        claim_tranche_tvl_internal<T0, T1>(arg0, arg1, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2), arg3, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg2), true, arg4);
    }

    public(friend) fun do_claim_tranche_tvl_inverted<T0, T1>(arg0: &0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::config::LaunchpadConfig, arg1: &mut 0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &0x2::coin_registry::Currency<T0>, arg4: &0x2::clock::Clock) {
        claim_tranche_tvl_internal<T0, T1>(arg0, arg1, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg2), arg3, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T1, T0>(arg2), false, arg4);
    }

    public fun migrate<T0, T1>(arg0: &0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::config::LaunchpadConfig, arg1: &mut 0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::pool::Pool<T0, T1>, arg2: &mut 0x2::coin_registry::Currency<T0>, arg3: &mut 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = migrate_core<T0, T1>(arg0, arg1, arg2, arg4, arg5, arg6, arg7);
        0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::pool::store_burn_proof<T0, T1>(arg1, 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::burn_lp_v2(arg3, v0, arg7));
    }

    fun migrate_core<T0, T1>(arg0: &0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::config::LaunchpadConfig, arg1: &mut 0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::pool::Pool<T0, T1>, arg2: &mut 0x2::coin_registry::Currency<T0>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position {
        0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::config::assert_version(arg0);
        0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::pool::assert_burn_only_currency<T0>(arg2);
        let (v0, v1) = 0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::pool::withdraw_for_migration<T0, T1>(arg1);
        let v2 = v1;
        let v3 = v0;
        let v4 = 0x2::balance::value<T0>(&v3);
        let v5 = 0x2::balance::value<T1>(&v2);
        let v6 = 0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::pool::tick_spacing<T0, T1>(arg1);
        let (v7, v8) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool_creator::full_range_tick_range(v6);
        let v9 = 0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::curve::fee_amount(v5, 0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::pool::migration_fee_bps<T0, T1>(arg1));
        if (v9 > 0) {
            0x2::balance::send_funds<T1>(0x2::balance::split<T1>(&mut v2, v9), 0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::config::treasury(arg0));
        };
        let v10 = v5 - v9;
        let v11 = 0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::curve::seed_base_amount(v4, v10, v5);
        let v12 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::is_right_order<T0, T1>();
        let v13 = if (v12) {
            0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::curve::initial_sqrt_price_x64(v4, v5)
        } else {
            0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::curve::initial_sqrt_price_x64(v5, v4)
        };
        assert!(v13 > (0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::curve::full_range_lower_sqrt_price() as u128) + 4294967296, 3);
        assert!(v13 < (0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::curve::full_range_upper_sqrt_price() as u128) - 4294967296, 3);
        let (_, v15, v16) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_liquidity_by_amount(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(v7), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(v8), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_tick_at_sqrt_price(v13), v13, v11, v12);
        let v17 = if (v12) {
            v16
        } else {
            v15
        };
        let v18 = v17 <= v10;
        let v19 = if (v18) {
            0x2::balance::split<T0>(&mut v3, v4 - v11)
        } else {
            0x2::balance::zero<T0>()
        };
        let v20 = 0x2::coin_registry::icon_url<T0>(arg2);
        let v21 = if (0x1::string::length(&v20) <= 500) {
            v20
        } else {
            0x1::string::utf8(b"")
        };
        let (v22, v23, v24) = if (v12) {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool_creator::create_pool_v3_with_creation_cap<T0, T1>(arg3, arg4, 0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::pool::borrow_creation_cap<T0, T1>(arg1), v6, v13, v21, v7, v8, 0x2::coin::from_balance<T0>(v3, arg6), 0x2::coin::from_balance<T1>(v2, arg6), v12 == v18, arg5, arg6)
        } else {
            let (v25, v26, v27) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool_creator::create_pool_v3_with_creation_cap<T1, T0>(arg3, arg4, 0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::pool::borrow_creation_cap<T0, T1>(arg1), v6, v13, v21, v7, v8, 0x2::coin::from_balance<T1>(v2, arg6), 0x2::coin::from_balance<T0>(v3, arg6), v12 == v18, arg5, arg6);
            (v25, v27, v26)
        };
        let v28 = v24;
        let v29 = v22;
        let v30 = v19;
        0x2::balance::join<T0>(&mut v30, 0x2::coin::into_balance<T0>(v23));
        burn_or_destroy<T0>(arg2, 0x2::coin::from_balance<T0>(v30, arg6));
        0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::pool::send_platform_quote<T1>(0x2::coin::into_balance<T1>(v28), 0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::config::treasury(arg0));
        let v31 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::pool_id(&v29);
        0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::pool::set_migrated<T0, T1>(arg1, v31, v12);
        let v32 = MigratedEvent<T0, T1>{
            pool_id                : 0x2::object::id<0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::pool::Pool<T0, T1>>(arg1),
            cetus_pool_id          : v31,
            base_amount            : v4,
            quote_amount           : v5,
            sqrt_price_x64         : v13,
            base_is_coin_a         : v12,
            tick_spacing           : v6,
            migration_fee          : v9,
            base_burned            : 0x2::balance::value<T0>(&v30),
            quote_dust_to_platform : 0x2::coin::value<T1>(&v28),
        };
        0x2::event::emit<MigratedEvent<T0, T1>>(v32);
        v29
    }

    fun settle_lp_fees<T0, T1>(arg0: &0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::config::LaunchpadConfig, arg1: &0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::pool::Pool<T0, T1>, arg2: &mut 0x2::coin_registry::Currency<T0>, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: &mut 0x2::tx_context::TxContext) {
        burn_or_destroy<T0>(arg2, arg3);
        let v0 = 0x2::coin::value<T1>(&arg4);
        let v1 = (((v0 as u128) * (0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::pool::lp_fee_platform_bps<T0, T1>(arg1) as u128) / (0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::config::bps_denominator() as u128)) as u64);
        let v2 = v0 - v1;
        if (v1 > 0) {
            0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::pool::send_funds<T1>(0x2::coin::split<T1>(&mut arg4, v1, arg5), 0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::config::treasury(arg0));
        };
        if (v2 > 0) {
            0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::pool::send_funds<T1>(0x2::coin::split<T1>(&mut arg4, v2, arg5), 0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::pool::creator<T0, T1>(arg1));
        };
        0x2::coin::destroy_zero<T1>(arg4);
        let v3 = LpFeesClaimedEvent<T0, T1>{
            pool_id        : 0x2::object::id<0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::pool::Pool<T0, T1>>(arg1),
            base_burned    : 0x2::coin::value<T0>(&arg3),
            quote_platform : v1,
            quote_creator  : v2,
        };
        0x2::event::emit<LpFeesClaimedEvent<T0, T1>>(v3);
    }

    fun settle_lp_rewards<T0, T1, T2>(arg0: &0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::config::LaunchpadConfig, arg1: &0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T2>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T2>(&arg2);
        let v1 = (((v0 as u128) * (0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::pool::lp_fee_platform_bps<T0, T1>(arg1) as u128) / (0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::config::bps_denominator() as u128)) as u64);
        let v2 = v0 - v1;
        if (v1 > 0) {
            0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::pool::send_funds<T2>(0x2::coin::split<T2>(&mut arg2, v1, arg3), 0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::config::treasury(arg0));
        };
        if (v2 > 0) {
            0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::pool::send_funds<T2>(0x2::coin::split<T2>(&mut arg2, v2, arg3), 0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::pool::creator<T0, T1>(arg1));
        };
        0x2::coin::destroy_zero<T2>(arg2);
        let v3 = LpRewardsClaimedEvent<T0, T1>{
            pool_id         : 0x2::object::id<0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::pool::Pool<T0, T1>>(arg1),
            reward_type     : 0x1::type_name::with_defining_ids<T2>(),
            platform_amount : v1,
            creator_amount  : v2,
        };
        0x2::event::emit<LpRewardsClaimedEvent<T0, T1>>(v3);
    }

    // decompiled from Move bytecode v7
}

