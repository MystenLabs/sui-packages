module 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::cetus_launch {
    struct CreatorCap has store, key {
        id: 0x2::object::UID,
        launch_id: 0x2::object::ID,
    }

    struct WhirlpoolLaunch<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        version: u64,
        creator: address,
        fee_recipient: address,
        pool_id: 0x2::object::ID,
        token_is_a: bool,
        position: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position,
        dust: 0x2::balance::Balance<T0>,
        total_supply: u64,
        supply_policy: u8,
        metadata_cap_deleted: bool,
        treasury_cap_id: 0x2::object::ID,
        creator_allocation: u64,
        vesting_id: 0x1::option::Option<0x2::object::ID>,
        liquidity_tokens: u64,
        initial_market_cap: u64,
        tick_spacing: u32,
        creator_lp_fee_share_bps: u64,
        currency_verified: bool,
        flagged_regulated: bool,
        fees_collected_a: u64,
        fees_collected_b: u64,
        created_at_ms: u64,
        fee_route: u8,
        rewards: 0x2::balance::Balance<T1>,
        pending_buyback: 0x2::balance::Balance<T1>,
        burned: u64,
        reward_rounds: u64,
    }

    struct LaunchParams has copy, drop {
        total_supply: u64,
        supply_policy: u8,
        delete_metadata_cap: bool,
        creator_allocation_bps: u64,
        vesting_cliff_ms: u64,
        vesting_duration_ms: u64,
        initial_market_cap: u64,
        tick_spacing: u32,
        pool_icon_url: 0x1::string::String,
        fee_route: u8,
    }

    struct Prepared<phantom T0> {
        pool_tokens: 0x2::balance::Balance<T0>,
        creator_tokens: 0x2::balance::Balance<T0>,
        treasury_cap_id: 0x2::object::ID,
        creation_fee_paid: u64,
        fees: 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::platform::FeeParams,
    }

    public fun total_supply<T0, T1>(arg0: &WhirlpoolLaunch<T0, T1>) : u64 {
        arg0.total_supply
    }

    fun assert_collect<T0, T1>(arg0: &WhirlpoolLaunch<T0, T1>, arg1: &0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::platform::PlatformConfig, arg2: 0x2::object::ID) {
        assert_version<T0, T1>(arg0);
        0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::platform::assert_version(arg1);
        assert!(arg2 == arg0.pool_id, 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::errors::wrong_pool());
    }

    fun assert_version<T0, T1>(arg0: &WhirlpoolLaunch<T0, T1>) {
        assert!(arg0.version == 1, 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::errors::wrong_version());
    }

    public fun burned<T0, T1>(arg0: &WhirlpoolLaunch<T0, T1>) : u64 {
        arg0.burned
    }

    public fun cap_launch_id(arg0: &CreatorCap) : 0x2::object::ID {
        arg0.launch_id
    }

    public fun ceil_to_spacing(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg1: u32) : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32 {
        if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::is_neg(arg0)) {
            0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::neg_from(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::abs_u32(arg0) / arg1 * arg1)
        } else {
            0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from((0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::abs_u32(arg0) + arg1 - 1) / arg1 * arg1)
        }
    }

    public fun collect_fees_token_a<T0, T1>(arg0: &mut WhirlpoolLaunch<T0, T1>, arg1: &0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::platform::PlatformConfig, arg2: &mut 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::revenue::ProtocolRevenue, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: &mut 0x2::coin_registry::Currency<T0>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert_collect<T0, T1>(arg0, arg1, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg4));
        assert!(arg0.token_is_a, 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::errors::wrong_pool());
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg3, arg4, &arg0.position, true);
        let (v2, v3) = take_platform_share<T0, T1>(arg0, arg1, arg2, v0, v1, arg6, arg7);
        let v4 = v2;
        if (arg0.fee_route == 2) {
            0x2::balance::join<T1>(&mut arg0.pending_buyback, v3);
            let v5 = 0x2::balance::value<T1>(&arg0.pending_buyback);
            if (v5 > 0) {
                let v6 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, T1>(arg4, false, true, v5);
                if (!0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_is_exceed(&v6) && 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v6) > 0) {
                    let (v7, v8, v9) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg3, arg4, false, true, v5, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price() - 1, arg6);
                    let v10 = v9;
                    let v11 = v7;
                    0x2::balance::destroy_zero<T1>(v8);
                    let v12 = 0x2::balance::split<T1>(&mut arg0.pending_buyback, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v10));
                    0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg3, arg4, 0x2::balance::zero<T0>(), v12, v10);
                    0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::events::emit_bought_back(0x2::object::id<WhirlpoolLaunch<T0, T1>>(arg0), 0x2::balance::value<T1>(&v12), 0x2::balance::value<T0>(&v11));
                    0x2::balance::join<T0>(&mut v4, v11);
                };
            };
            route_creator_share<T0, T1>(arg0, v4, 0x2::balance::zero<T1>(), arg5, arg7);
        } else {
            route_creator_share<T0, T1>(arg0, v4, v3, arg5, arg7);
        };
    }

    public fun collect_fees_token_b<T0, T1>(arg0: &mut WhirlpoolLaunch<T0, T1>, arg1: &0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::platform::PlatformConfig, arg2: &mut 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::revenue::ProtocolRevenue, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg5: &mut 0x2::coin_registry::Currency<T0>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert_collect<T0, T1>(arg0, arg1, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg4));
        assert!(!arg0.token_is_a, 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::errors::wrong_pool());
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T1, T0>(arg3, arg4, &arg0.position, true);
        let (v2, v3) = take_platform_share<T0, T1>(arg0, arg1, arg2, v1, v0, arg6, arg7);
        let v4 = v2;
        if (arg0.fee_route == 2) {
            0x2::balance::join<T1>(&mut arg0.pending_buyback, v3);
            let v5 = 0x2::balance::value<T1>(&arg0.pending_buyback);
            if (v5 > 0) {
                let v6 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T1, T0>(arg4, true, true, v5);
                if (!0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_is_exceed(&v6) && 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v6) > 0) {
                    let (v7, v8, v9) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T0>(arg3, arg4, true, true, v5, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price() + 1, arg6);
                    let v10 = v9;
                    let v11 = v8;
                    0x2::balance::destroy_zero<T1>(v7);
                    let v12 = 0x2::balance::split<T1>(&mut arg0.pending_buyback, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T0>(&v10));
                    0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T0>(arg3, arg4, v12, 0x2::balance::zero<T0>(), v10);
                    0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::events::emit_bought_back(0x2::object::id<WhirlpoolLaunch<T0, T1>>(arg0), 0x2::balance::value<T1>(&v12), 0x2::balance::value<T0>(&v11));
                    0x2::balance::join<T0>(&mut v4, v11);
                };
            };
            route_creator_share<T0, T1>(arg0, v4, 0x2::balance::zero<T1>(), arg5, arg7);
        } else {
            route_creator_share<T0, T1>(arg0, v4, v3, arg5, arg7);
        };
    }

    public fun creator<T0, T1>(arg0: &WhirlpoolLaunch<T0, T1>) : address {
        arg0.creator
    }

    public fun creator_allocation<T0, T1>(arg0: &WhirlpoolLaunch<T0, T1>) : u64 {
        arg0.creator_allocation
    }

    public fun currency_verified<T0, T1>(arg0: &WhirlpoolLaunch<T0, T1>) : bool {
        arg0.currency_verified
    }

    fun derived_currency_id<T0, T1>(arg0: &WhirlpoolLaunch<T0, T1>, arg1: &0x2::coin_registry::Currency<T0>) : 0x2::object::ID {
        assert!(0x2::coin_registry::treasury_cap_id<T0>(arg1) == 0x1::option::some<0x2::object::ID>(arg0.treasury_cap_id), 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::errors::currency_mismatch());
        0x2::object::id<0x2::coin_registry::Currency<T0>>(arg1)
    }

    public fun dev_buy_spend(arg0: u64) : u64 {
        let v0 = arg0 / 1000 + 10;
        if (arg0 <= v0) {
            0
        } else {
            arg0 - v0
        }
    }

    public fun fee_recipient<T0, T1>(arg0: &WhirlpoolLaunch<T0, T1>) : address {
        arg0.fee_recipient
    }

    public fun fee_route<T0, T1>(arg0: &WhirlpoolLaunch<T0, T1>) : u8 {
        arg0.fee_route
    }

    public fun fees_collected<T0, T1>(arg0: &WhirlpoolLaunch<T0, T1>) : (u64, u64) {
        (arg0.fees_collected_a, arg0.fees_collected_b)
    }

    fun finish<T0, T1>(arg0: LaunchParams, arg1: 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::platform::FeeParams, arg2: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg3: 0x2::balance::Balance<T0>, arg4: 0x2::balance::Balance<T0>, arg5: 0x2::balance::Balance<T0>, arg6: u64, arg7: 0x2::object::ID, arg8: u64, arg9: u64, arg10: u128, arg11: bool, arg12: u32, arg13: u32, arg14: 0x2::coin::Coin<T1>, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) : (CreatorCap, 0x2::coin::Coin<T1>) {
        let v0 = 0x2::clock::timestamp_ms(arg15);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::pool_id(&arg2);
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&arg2);
        assert!(v2 > 0, 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::errors::zero_amount());
        let v3 = arg9 - 0x2::balance::value<T0>(&arg3);
        let v4 = 0x2::balance::value<T0>(&arg4);
        let v5 = 0x2::balance::value<T0>(&arg5);
        let v6 = WhirlpoolLaunch<T0, T1>{
            id                       : 0x2::object::new(arg16),
            version                  : 1,
            creator                  : 0x2::tx_context::sender(arg16),
            fee_recipient            : 0x2::tx_context::sender(arg16),
            pool_id                  : v1,
            token_is_a               : arg11,
            position                 : arg2,
            dust                     : arg3,
            total_supply             : arg0.total_supply,
            supply_policy            : arg0.supply_policy,
            metadata_cap_deleted     : arg0.delete_metadata_cap,
            treasury_cap_id          : arg7,
            creator_allocation       : v4,
            vesting_id               : 0x1::option::none<0x2::object::ID>(),
            liquidity_tokens         : v3,
            initial_market_cap       : arg0.initial_market_cap,
            tick_spacing             : arg0.tick_spacing,
            creator_lp_fee_share_bps : 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::platform::creator_lp_fee_share_bps(&arg1),
            currency_verified        : false,
            flagged_regulated        : false,
            fees_collected_a         : 0,
            fees_collected_b         : 0,
            created_at_ms            : v0,
            fee_route                : arg0.fee_route,
            rewards                  : 0x2::balance::zero<T1>(),
            pending_buyback          : 0x2::balance::zero<T1>(),
            burned                   : 0,
            reward_rounds            : 0,
        };
        let v7 = 0x2::object::id<WhirlpoolLaunch<T0, T1>>(&v6);
        if (v4 > 0) {
            if (arg0.vesting_duration_ms > 0 || arg0.vesting_cliff_ms > 0) {
                v6.vesting_id = 0x1::option::some<0x2::object::ID>(0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::vesting::create_and_share<T0>(v7, 0x2::tx_context::sender(arg16), arg4, v0, arg0.vesting_cliff_ms, arg0.vesting_duration_ms, arg16));
            } else {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg4, arg16), 0x2::tx_context::sender(arg16));
            };
        } else {
            0x2::balance::destroy_zero<T0>(arg4);
        };
        if (v5 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg5, arg16), 0x2::tx_context::sender(arg16));
        } else {
            0x2::balance::destroy_zero<T0>(arg5);
        };
        0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::events::emit_launch_created(0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::events::new_launch_created(v7, v1, v6.creator, 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()), 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>()), arg11, v6.total_supply, v6.supply_policy, v6.metadata_cap_deleted, arg7, v4, v6.vesting_id, v3, v6.initial_market_cap, arg10, v6.tick_spacing, arg12, arg13, v2, v6.creator_lp_fee_share_bps, arg8, arg6 - 0x2::coin::value<T1>(&arg14), v5, arg0.fee_route, v0));
        let v8 = CreatorCap{
            id        : 0x2::object::new(arg16),
            launch_id : v7,
        };
        0x2::transfer::share_object<WhirlpoolLaunch<T0, T1>>(v6);
        (v8, arg14)
    }

    public fun flagged_regulated<T0, T1>(arg0: &WhirlpoolLaunch<T0, T1>) : bool {
        arg0.flagged_regulated
    }

    public fun floor_to_spacing(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg1: u32) : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32 {
        if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::is_neg(arg0)) {
            0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::neg_from((0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::abs_u32(arg0) + arg1 - 1) / arg1 * arg1)
        } else {
            0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::abs_u32(arg0) / arg1 * arg1)
        }
    }

    public fun full_range_max(arg0: u32) : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32 {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::tick_bound();
        0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(v0 - v0 % arg0)
    }

    public fun full_range_min(arg0: u32) : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32 {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::tick_bound();
        0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::neg_from(v0 - v0 % arg0)
    }

    public fun isqrt(arg0: u256) : u256 {
        if (arg0 == 0) {
            return 0
        };
        let v0 = (arg0 >> 1) + 1;
        let v1 = v0;
        if (v0 > arg0) {
            v1 = arg0;
        };
        while (v1 < arg0) {
            let v2 = arg0 / v1 + v1;
            v1 = v2 >> 1;
        };
        arg0
    }

    public fun launch_token_a<T0, T1>(arg0: &0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::platform::PlatformConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg3: 0x2::coin_registry::CurrencyInitializer<T0>, arg4: 0x2::coin::TreasuryCap<T0>, arg5: LaunchParams, arg6: 0x2::coin::Coin<T1>, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (CreatorCap, 0x2::coin::Coin<T1>) {
        let v0 = prepare<T0, T1>(arg0, arg3, arg4, &arg5, arg7, 0x2::coin::value<T1>(&arg6), arg9);
        let Prepared {
            pool_tokens       : v1,
            creator_tokens    : v2,
            treasury_cap_id   : v3,
            creation_fee_paid : v4,
            fees              : v5,
        } = v0;
        let v6 = v1;
        let v7 = 0x2::balance::value<T0>(&v6);
        let v8 = arg5.tick_spacing;
        let v9 = floor_to_spacing(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_tick_at_sqrt_price(sqrt_price_for(arg5.initial_market_cap, arg5.total_supply)), v8);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gt(v9, full_range_min(v8)), 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::errors::invalid_market_cap());
        let v10 = full_range_max(v8);
        let v11 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(v9);
        let v12 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(v10);
        let v13 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_liquidity_from_a(v11, v12, v7, false);
        let v14 = 0x2::coin::value<T1>(&arg6);
        let v15 = dev_buy_spend(v14);
        let v16 = if (v15 == 0) {
            v11
        } else {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_next_sqrt_price_b_down(v11, v13, v15, true)
        };
        let v17 = v16;
        if (v16 <= v11) {
            v17 = v11 + 1;
        };
        assert!(v17 < v12, 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::errors::dev_buy_too_large());
        let v18 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_delta_a(v11, v17, v13, false);
        assert!(v18 < v7, 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::errors::dev_buy_too_large());
        let (v19, v20, v21) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool_creator::create_pool_v3<T0, T1>(arg1, arg2, v8, v17, arg5.pool_icon_url, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v9), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v10), 0x2::coin::from_balance<T0>(v6, arg9), arg6, true, arg8, arg9);
        finish<T0, T1>(arg5, v5, v19, 0x2::coin::into_balance<T0>(v20), v2, 0x2::balance::split<T0>(&mut v6, v18), v14, v3, v4, 0x2::balance::value<T0>(&v6), v17, true, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v9), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v10), v21, arg8, arg9)
    }

    public fun launch_token_b<T0, T1>(arg0: &0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::platform::PlatformConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg3: 0x2::coin_registry::CurrencyInitializer<T0>, arg4: 0x2::coin::TreasuryCap<T0>, arg5: LaunchParams, arg6: 0x2::coin::Coin<T1>, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (CreatorCap, 0x2::coin::Coin<T1>) {
        let v0 = prepare<T0, T1>(arg0, arg3, arg4, &arg5, arg7, 0x2::coin::value<T1>(&arg6), arg9);
        let Prepared {
            pool_tokens       : v1,
            creator_tokens    : v2,
            treasury_cap_id   : v3,
            creation_fee_paid : v4,
            fees              : v5,
        } = v0;
        let v6 = v1;
        let v7 = 0x2::balance::value<T0>(&v6);
        let v8 = arg5.tick_spacing;
        let v9 = ceil_to_spacing(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_tick_at_sqrt_price(sqrt_price_for(arg5.total_supply, arg5.initial_market_cap)), v8);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v9, full_range_max(v8)), 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::errors::invalid_market_cap());
        let v10 = full_range_min(v8);
        let v11 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(v10);
        let v12 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(v9);
        let v13 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_liquidity_from_b(v11, v12, v7, false);
        let v14 = 0x2::coin::value<T1>(&arg6);
        let v15 = dev_buy_spend(v14);
        let v16 = if (v15 == 0) {
            v12
        } else {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_next_sqrt_price_a_up(v12, v13, v15, true)
        };
        let v17 = v16;
        if (v16 >= v12) {
            v17 = v12 - 1;
        };
        assert!(v17 > v11, 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::errors::dev_buy_too_large());
        let v18 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_delta_b(v17, v12, v13, false);
        assert!(v18 < v7, 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::errors::dev_buy_too_large());
        let (v19, v20, v21) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool_creator::create_pool_v3<T1, T0>(arg1, arg2, v8, v17, arg5.pool_icon_url, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v10), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v9), arg6, 0x2::coin::from_balance<T0>(v6, arg9), false, arg8, arg9);
        finish<T0, T1>(arg5, v5, v19, 0x2::coin::into_balance<T0>(v21), v2, 0x2::balance::split<T0>(&mut v6, v18), v14, v3, v4, 0x2::balance::value<T0>(&v6), v17, false, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v10), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v9), v20, arg8, arg9)
    }

    public fun liquidity_tokens<T0, T1>(arg0: &WhirlpoolLaunch<T0, T1>) : u64 {
        arg0.liquidity_tokens
    }

    public fun new_launch_params(arg0: u64, arg1: u8, arg2: bool, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u32, arg8: 0x1::string::String, arg9: u8) : LaunchParams {
        assert!(arg0 > 0 && arg0 <= 10000000000000000000, 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::errors::invalid_supply());
        assert!(arg1 == 0 || arg1 == 1, 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::errors::invalid_supply_policy());
        assert!(arg3 < 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::platform::bps_denominator(), 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::errors::invalid_allocation());
        assert!(arg5 == 0 || arg4 <= arg5, 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::errors::invalid_vesting());
        assert!(arg6 > 0, 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::errors::invalid_market_cap());
        assert!(arg9 <= 2, 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::errors::invalid_fee_route());
        assert!(arg9 == 0 || arg1 == 1, 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::errors::invalid_fee_route());
        LaunchParams{
            total_supply           : arg0,
            supply_policy          : arg1,
            delete_metadata_cap    : arg2,
            creator_allocation_bps : arg3,
            vesting_cliff_ms       : arg4,
            vesting_duration_ms    : arg5,
            initial_market_cap     : arg6,
            tick_spacing           : arg7,
            pool_icon_url          : arg8,
            fee_route              : arg9,
        }
    }

    public(friend) fun next_reward_round<T0, T1>(arg0: &mut WhirlpoolLaunch<T0, T1>) : u64 {
        let v0 = arg0.reward_rounds;
        arg0.reward_rounds = v0 + 1;
        v0
    }

    fun pay<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) == 0) {
            0x2::balance::destroy_zero<T0>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg2), arg1);
        };
    }

    public fun pending_buyback<T0, T1>(arg0: &WhirlpoolLaunch<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.pending_buyback)
    }

    public fun pool_id<T0, T1>(arg0: &WhirlpoolLaunch<T0, T1>) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun position_liquidity<T0, T1>(arg0: &WhirlpoolLaunch<T0, T1>) : u128 {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&arg0.position)
    }

    fun prepare<T0, T1>(arg0: &0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::platform::PlatformConfig, arg1: 0x2::coin_registry::CurrencyInitializer<T0>, arg2: 0x2::coin::TreasuryCap<T0>, arg3: &LaunchParams, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : Prepared<T0> {
        0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::platform::assert_launch_allowed<T1>(arg0, arg3.tick_spacing);
        let v0 = 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::platform::fees(arg0);
        assert!(arg3.creator_allocation_bps <= 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::platform::max_creator_allocation_bps(&v0), 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::errors::invalid_allocation());
        assert!(arg5 > 0, 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::errors::zero_amount());
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg4);
        assert!(v1 == 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::platform::creation_fee_mist(&v0), 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::errors::insufficient_payment());
        if (v1 == 0) {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg4);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg4, 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::platform::treasury(arg0));
        };
        assert!(0x2::coin::total_supply<T0>(&arg2) == 0, 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::errors::treasury_not_fresh());
        let v2 = 0x2::coin::mint_balance<T0>(&mut arg2, arg3.total_supply);
        if (arg3.supply_policy == 0) {
            0x2::coin_registry::make_supply_fixed_init<T0>(&mut arg1, arg2);
        } else {
            0x2::coin_registry::make_supply_burn_only_init<T0>(&mut arg1, arg2);
        };
        if (arg3.delete_metadata_cap) {
            0x2::coin_registry::finalize_and_delete_metadata_cap<T0>(arg1, arg6);
        } else {
            0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<T0>>(0x2::coin_registry::finalize<T0>(arg1, arg6), 0x2::tx_context::sender(arg6));
        };
        Prepared<T0>{
            pool_tokens       : v2,
            creator_tokens    : 0x2::balance::split<T0>(&mut v2, 0x1::u64::mul_div(arg3.total_supply, arg3.creator_allocation_bps, 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::platform::bps_denominator())),
            treasury_cap_id   : 0x2::object::id<0x2::coin::TreasuryCap<T0>>(&arg2),
            creation_fee_paid : v1,
            fees              : v0,
        }
    }

    public(friend) fun return_rewards<T0, T1>(arg0: &mut WhirlpoolLaunch<T0, T1>, arg1: 0x2::balance::Balance<T1>) {
        0x2::balance::join<T1>(&mut arg0.rewards, arg1);
    }

    public fun reward_rounds<T0, T1>(arg0: &WhirlpoolLaunch<T0, T1>) : u64 {
        arg0.reward_rounds
    }

    public fun rewards_balance<T0, T1>(arg0: &WhirlpoolLaunch<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.rewards)
    }

    public fun route_burn() : u8 {
        2
    }

    public fun route_creator() : u8 {
        0
    }

    fun route_creator_share<T0, T1>(arg0: &mut WhirlpoolLaunch<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<T1>, arg3: &mut 0x2::coin_registry::Currency<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        if (arg0.fee_route == 0) {
            pay<T0>(arg1, arg0.fee_recipient, arg4);
            pay<T1>(arg2, arg0.fee_recipient, arg4);
            return
        };
        assert!(0x2::object::id<0x2::coin_registry::Currency<T0>>(arg3) == derived_currency_id<T0, T1>(arg0, arg3), 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::errors::currency_mismatch());
        let v0 = 0x2::balance::value<T0>(&arg0.dust);
        if (v0 > 0) {
            0x2::balance::join<T0>(&mut arg1, 0x2::balance::split<T0>(&mut arg0.dust, v0));
        };
        let v1 = 0x2::balance::value<T0>(&arg1);
        if (v1 > 0) {
            0x2::coin_registry::burn_balance<T0>(arg3, arg1);
            arg0.burned = arg0.burned + v1;
            0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::events::emit_fees_burned(0x2::object::id<WhirlpoolLaunch<T0, T1>>(arg0), v1, arg0.burned);
        } else {
            0x2::balance::destroy_zero<T0>(arg1);
        };
        let v2 = 0x2::balance::value<T1>(&arg2);
        if (v2 > 0) {
            0x2::balance::join<T1>(&mut arg0.rewards, arg2);
            0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::events::emit_rewards_accrued(0x2::object::id<WhirlpoolLaunch<T0, T1>>(arg0), v2, 0x2::balance::value<T1>(&arg0.rewards));
        } else {
            0x2::balance::destroy_zero<T1>(arg2);
        };
    }

    public fun route_holders() : u8 {
        1
    }

    public fun set_fee_recipient<T0, T1>(arg0: &mut WhirlpoolLaunch<T0, T1>, arg1: &CreatorCap, arg2: address) {
        assert_version<T0, T1>(arg0);
        assert!(arg1.launch_id == 0x2::object::id<WhirlpoolLaunch<T0, T1>>(arg0), 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::errors::wrong_launch());
        arg0.fee_recipient = arg2;
        0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::events::emit_fee_recipient_changed(0x2::object::id<WhirlpoolLaunch<T0, T1>>(arg0), arg2);
    }

    public fun set_fee_route<T0, T1>(arg0: &mut WhirlpoolLaunch<T0, T1>, arg1: &CreatorCap, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version<T0, T1>(arg0);
        assert!(arg1.launch_id == 0x2::object::id<WhirlpoolLaunch<T0, T1>>(arg0), 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::errors::wrong_launch());
        assert!(arg0.fee_route != 1, 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::errors::fee_route_locked());
        assert!(arg2 <= 2, 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::errors::invalid_fee_route());
        assert!(arg2 == 0 || arg0.supply_policy == 1, 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::errors::invalid_fee_route());
        if (arg0.fee_route == 2 && arg2 == 0) {
            let v0 = 0x2::balance::value<T1>(&arg0.pending_buyback);
            if (v0 > 0) {
                pay<T1>(0x2::balance::split<T1>(&mut arg0.pending_buyback, v0), arg0.fee_recipient, arg3);
            };
        };
        arg0.fee_route = arg2;
        0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::events::emit_fee_route_changed(0x2::object::id<WhirlpoolLaunch<T0, T1>>(arg0), arg2);
    }

    public fun sqrt_price_for(arg0: u64, arg1: u64) : u128 {
        assert!(arg1 > 0, 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::errors::invalid_market_cap());
        let v0 = isqrt(((arg0 as u256) << 128) / (arg1 as u256));
        assert!(v0 >= (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price() as u256) && v0 <= (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price() as u256), 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::errors::invalid_market_cap());
        (v0 as u128)
    }

    public fun supply_burn_only() : u8 {
        1
    }

    public fun supply_fixed() : u8 {
        0
    }

    fun take_platform_share<T0, T1>(arg0: &mut WhirlpoolLaunch<T0, T1>, arg1: &0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::platform::PlatformConfig, arg2: &mut 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::revenue::ProtocolRevenue, arg3: 0x2::balance::Balance<T0>, arg4: 0x2::balance::Balance<T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        assert!(0x2::balance::value<T0>(&arg3) > 0 || 0x2::balance::value<T1>(&arg4) > 0, 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::errors::nothing_to_claim());
        let (v0, v1) = if (arg0.token_is_a) {
            (0x2::balance::value<T0>(&arg3), 0x2::balance::value<T1>(&arg4))
        } else {
            (0x2::balance::value<T1>(&arg4), 0x2::balance::value<T0>(&arg3))
        };
        arg0.fees_collected_a = arg0.fees_collected_a + v0;
        arg0.fees_collected_b = arg0.fees_collected_b + v1;
        let v2 = arg0.creator_lp_fee_share_bps;
        let v3 = 0x2::balance::split<T0>(&mut arg3, 0x1::u64::mul_div(0x2::balance::value<T0>(&arg3), v2, 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::platform::bps_denominator()));
        let v4 = 0x2::balance::split<T1>(&mut arg4, 0x1::u64::mul_div(0x2::balance::value<T1>(&arg4), v2, 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::platform::bps_denominator()));
        let (v5, v6, v7, v8) = if (arg0.token_is_a) {
            (0x2::balance::value<T0>(&v3), 0x2::balance::value<T1>(&v4), 0x2::balance::value<T0>(&arg3), 0x2::balance::value<T1>(&arg4))
        } else {
            (0x2::balance::value<T1>(&v4), 0x2::balance::value<T0>(&v3), 0x2::balance::value<T1>(&arg4), 0x2::balance::value<T0>(&arg3))
        };
        0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::events::emit_lp_fees_collected(0x2::object::id<WhirlpoolLaunch<T0, T1>>(arg0), arg0.pool_id, arg0.fee_recipient, v5, v6, v7, v8, 0x2::clock::timestamp_ms(arg5));
        pay<T0>(0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::revenue::take_buyback_share<T0>(arg2, arg3), 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::platform::treasury(arg1), arg6);
        pay<T1>(0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::revenue::take_buyback_share<T1>(arg2, arg4), 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::platform::treasury(arg1), arg6);
        (v3, v4)
    }

    public(friend) fun take_rewards<T0, T1>(arg0: &mut WhirlpoolLaunch<T0, T1>, arg1: u64) : 0x2::balance::Balance<T1> {
        assert_version<T0, T1>(arg0);
        assert!(arg1 > 0 && arg1 <= 0x2::balance::value<T1>(&arg0.rewards), 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::errors::insufficient_rewards());
        0x2::balance::split<T1>(&mut arg0.rewards, arg1)
    }

    public fun token_is_a<T0, T1>(arg0: &WhirlpoolLaunch<T0, T1>) : bool {
        arg0.token_is_a
    }

    public fun verify_currency<T0, T1>(arg0: &mut WhirlpoolLaunch<T0, T1>, arg1: &0x2::coin_registry::Currency<T0>) {
        assert_version<T0, T1>(arg0);
        if (arg0.currency_verified) {
            return
        };
        assert!(0x2::coin_registry::treasury_cap_id<T0>(arg1) == 0x1::option::some<0x2::object::ID>(arg0.treasury_cap_id), 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::errors::currency_mismatch());
        if (arg0.supply_policy == 0) {
            assert!(0x2::coin_registry::is_supply_fixed<T0>(arg1), 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::errors::currency_mismatch());
        } else {
            assert!(0x2::coin_registry::is_supply_burn_only<T0>(arg1), 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::errors::currency_mismatch());
        };
        arg0.flagged_regulated = 0x2::coin_registry::is_regulated<T0>(arg1);
        arg0.currency_verified = true;
        0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::events::emit_currency_verified(0x2::object::id<WhirlpoolLaunch<T0, T1>>(arg0), arg0.flagged_regulated);
    }

    public fun vesting_id<T0, T1>(arg0: &WhirlpoolLaunch<T0, T1>) : 0x1::option::Option<0x2::object::ID> {
        arg0.vesting_id
    }

    // decompiled from Move bytecode v7
}

