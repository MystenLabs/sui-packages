module 0xc24d9c40422f4364d8b1efe1e5007e4e295518189ac548e1cadef61d3af094ed::unified_spot_pool {
    struct SpotPoolInitialized has copy, drop {
        pool_id: 0x2::object::ID,
        asset_reserve: u64,
        stable_reserve: u64,
        price: u128,
        fee_bps: u64,
    }

    struct SpotLiquidityAdded has copy, drop {
        pool_id: 0x2::object::ID,
        provider: address,
        asset_amount: u64,
        stable_amount: u64,
        lp_amount: u64,
        excess_asset_amount: u64,
        excess_stable_amount: u64,
        asset_reserve: u64,
        stable_reserve: u64,
        is_initial: bool,
    }

    struct SpotLiquidityRemoved has copy, drop {
        pool_id: 0x2::object::ID,
        provider: address,
        asset_amount: u64,
        stable_amount: u64,
        lp_amount: u64,
        asset_reserve: u64,
        stable_reserve: u64,
    }

    struct MustShare {
        pool_id: 0x2::object::ID,
    }

    struct UnifiedSpotPool<phantom T0, phantom T1, phantom T2> has store, key {
        id: 0x2::object::UID,
        asset_reserve: 0x2::balance::Balance<T0>,
        stable_reserve: 0x2::balance::Balance<T1>,
        initial_asset_reserve: 0x1::option::Option<u64>,
        initial_stable_reserve: 0x1::option::Option<u64>,
        fee_bps: u64,
        minimum_liquidity: u64,
        lp_treasury_cap: 0x2::coin::TreasuryCap<T2>,
        fee_schedule: 0x1::option::Option<0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::fee_scheduler::FeeSchedule>,
        fee_schedule_activation_time: u64,
        active_proposal_id: 0x1::option::Option<0x2::object::ID>,
        last_proposal_end_time: 0x1::option::Option<u64>,
        aggregator_config: 0x1::option::Option<AggregatorConfig<T0, T1>>,
        is_dissolved: bool,
    }

    struct AggregatorConfig<phantom T0, phantom T1> has store {
        active_escrow: 0x1::option::Option<0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::coin_escrow::TokenEscrow<T0, T1>>,
        archived_escrows: 0x2::table::Table<0x2::object::ID, 0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::coin_escrow::TokenEscrow<T0, T1>>,
        simple_twap: 0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::PCW_TWAP_oracle::SimpleTWAP,
        last_proposal_usage: 0x1::option::Option<u64>,
        conditional_liquidity_ratio_percent: u64,
        oracle_conditional_threshold_bps: u64,
        spot_cumulative_at_lock: 0x1::option::Option<u256>,
        protocol_fees_asset: 0x2::balance::Balance<T0>,
        protocol_fees_stable: 0x2::balance::Balance<T1>,
    }

    struct FeeInfo has copy, drop {
        current_total_bps: u64,
        steady_protocol_bps: u64,
        steady_lp_bps: u64,
        steady_total_bps: u64,
    }

    public fun new<T0, T1, T2>(arg0: 0x2::coin::TreasuryCap<T2>, arg1: &0x2::coin_registry::Currency<T2>, arg2: u64, arg3: 0x1::option::Option<0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::fee_scheduler::FeeSchedule>, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (UnifiedSpotPool<T0, T1, T2>, MustShare) {
        assert!(arg2 <= 0xcf1218ee7d7e2610b8bc7da9c1d513c230b94e470e57cf4e9260b6da64318f12::constants::max_amm_fee_bps(), 24);
        assert!(arg5 < 100, 25);
        assert!(arg4 <= 10000, 26);
        assert!(!0x2::coin_registry::is_regulated<T2>(arg1), 29);
        assert!(0x2::coin_registry::symbol<T2>(arg1) == 0x1::string::utf8(b"GOVEX_LP_TOKEN"), 20);
        assert!(0x2::coin_registry::name<T2>(arg1) == 0x1::string::utf8(b"GOVEX_LP_TOKEN"), 21);
        assert!(0x2::coin::total_supply<T2>(&arg0) == 0, 22);
        let v0 = AggregatorConfig<T0, T1>{
            active_escrow                       : 0x1::option::none<0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::coin_escrow::TokenEscrow<T0, T1>>(),
            archived_escrows                    : 0x2::table::new<0x2::object::ID, 0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::coin_escrow::TokenEscrow<T0, T1>>(arg7),
            simple_twap                         : 0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::PCW_TWAP_oracle::new_default(0, arg6),
            last_proposal_usage                 : 0x1::option::none<u64>(),
            conditional_liquidity_ratio_percent : arg5,
            oracle_conditional_threshold_bps    : arg4,
            spot_cumulative_at_lock             : 0x1::option::none<u256>(),
            protocol_fees_asset                 : 0x2::balance::zero<T0>(),
            protocol_fees_stable                : 0x2::balance::zero<T1>(),
        };
        let v1 = UnifiedSpotPool<T0, T1, T2>{
            id                           : 0x2::object::new(arg7),
            asset_reserve                : 0x2::balance::zero<T0>(),
            stable_reserve               : 0x2::balance::zero<T1>(),
            initial_asset_reserve        : 0x1::option::none<u64>(),
            initial_stable_reserve       : 0x1::option::none<u64>(),
            fee_bps                      : arg2,
            minimum_liquidity            : 0xcf1218ee7d7e2610b8bc7da9c1d513c230b94e470e57cf4e9260b6da64318f12::constants::minimum_liquidity(),
            lp_treasury_cap              : arg0,
            fee_schedule                 : arg3,
            fee_schedule_activation_time : 0x2::clock::timestamp_ms(arg6),
            active_proposal_id           : 0x1::option::none<0x2::object::ID>(),
            last_proposal_end_time       : 0x1::option::none<u64>(),
            aggregator_config            : 0x1::option::some<AggregatorConfig<T0, T1>>(v0),
            is_dissolved                 : false,
        };
        let v2 = MustShare{pool_id: 0x2::object::id<UnifiedSpotPool<T0, T1, T2>>(&v1)};
        (v1, v2)
    }

    public fun add_liquidity<T0, T1, T2>(arg0: &mut UnifiedSpotPool<T0, T1, T2>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T2>, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        let v1 = 0x2::coin::value<T1>(&arg2);
        assert!(v0 > 0 && v1 > 0, 4);
        assert!(!arg0.is_dissolved, 32);
        assert!(0x1::option::is_none<0x2::object::ID>(&arg0.active_proposal_id), 15);
        let v2 = 0x2::coin::total_supply<T2>(&arg0.lp_treasury_cap);
        let (v3, v4, v5, v6) = if (v2 == 0) {
            let v7 = 0xcf1218ee7d7e2610b8bc7da9c1d513c230b94e470e57cf4e9260b6da64318f12::math::safe_u128_to_u64(0x1::u128::sqrt((v0 as u128) * (v1 as u128)));
            assert!(v7 > arg0.minimum_liquidity, 6);
            0x2::transfer::public_freeze_object<0x2::coin::Coin<T2>>(0x2::coin::mint<T2>(&mut arg0.lp_treasury_cap, arg0.minimum_liquidity, arg5));
            (v7 - arg0.minimum_liquidity, v0, v1, true)
        } else {
            let v8 = 0x2::balance::value<T0>(&arg0.asset_reserve);
            let v9 = 0x2::balance::value<T1>(&arg0.stable_reserve);
            let v10 = 0x1::u128::min((v0 as u128) * (v2 as u128) / (v8 as u128), (v1 as u128) * (v2 as u128) / (v9 as u128));
            assert!(v10 <= 18446744073709551615, 34);
            let v11 = (v10 as u64);
            (v11, 0xcf1218ee7d7e2610b8bc7da9c1d513c230b94e470e57cf4e9260b6da64318f12::math::mul_div_up(v11, v8, v2), 0xcf1218ee7d7e2610b8bc7da9c1d513c230b94e470e57cf4e9260b6da64318f12::math::mul_div_up(v11, v9, v2), false)
        };
        assert!(v3 > 0, 4);
        assert!(v3 >= arg3, 5);
        let v12 = if (v0 > v4) {
            0x2::coin::split<T0>(&mut arg1, v0 - v4, arg5)
        } else {
            0x2::coin::zero<T0>(arg5)
        };
        let v13 = v12;
        let v14 = if (v1 > v5) {
            0x2::coin::split<T1>(&mut arg2, v1 - v5, arg5)
        } else {
            0x2::coin::zero<T1>(arg5)
        };
        let v15 = v14;
        0x2::balance::join<T0>(&mut arg0.asset_reserve, 0x2::coin::into_balance<T0>(arg1));
        0x2::balance::join<T1>(&mut arg0.stable_reserve, 0x2::coin::into_balance<T1>(arg2));
        if (v6) {
            if (0x1::option::is_none<u64>(&arg0.initial_asset_reserve) && 0x1::option::is_none<u64>(&arg0.initial_stable_reserve)) {
                0x1::option::fill<u64>(&mut arg0.initial_asset_reserve, v4);
                0x1::option::fill<u64>(&mut arg0.initial_stable_reserve, v5);
            };
            let v16 = 0xcf1218ee7d7e2610b8bc7da9c1d513c230b94e470e57cf4e9260b6da64318f12::math::mul_div_to_128(v5, 0xcf1218ee7d7e2610b8bc7da9c1d513c230b94e470e57cf4e9260b6da64318f12::constants::price_precision_scale(), v4);
            if (0x1::option::is_some<AggregatorConfig<T0, T1>>(&arg0.aggregator_config)) {
                0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::PCW_TWAP_oracle::update(&mut 0x1::option::borrow_mut<AggregatorConfig<T0, T1>>(&mut arg0.aggregator_config).simple_twap, v16, arg4);
            };
            arg0.fee_schedule_activation_time = 0x2::clock::timestamp_ms(arg4);
            let v17 = SpotPoolInitialized{
                pool_id        : 0x2::object::id<UnifiedSpotPool<T0, T1, T2>>(arg0),
                asset_reserve  : v4,
                stable_reserve : v5,
                price          : v16,
                fee_bps        : arg0.fee_bps,
            };
            0x2::event::emit<SpotPoolInitialized>(v17);
        };
        let v18 = SpotLiquidityAdded{
            pool_id              : 0x2::object::id<UnifiedSpotPool<T0, T1, T2>>(arg0),
            provider             : 0x2::tx_context::sender(arg5),
            asset_amount         : v4,
            stable_amount        : v5,
            lp_amount            : v3,
            excess_asset_amount  : 0x2::coin::value<T0>(&v13),
            excess_stable_amount : 0x2::coin::value<T1>(&v15),
            asset_reserve        : 0x2::balance::value<T0>(&arg0.asset_reserve),
            stable_reserve       : 0x2::balance::value<T1>(&arg0.stable_reserve),
            is_initial           : v6,
        };
        0x2::event::emit<SpotLiquidityAdded>(v18);
        (0x2::coin::mint<T2>(&mut arg0.lp_treasury_cap, v3, arg5), v13, v15)
    }

    public(friend) fun add_liquidity_from_quantum_redeem<T0, T1, T2>(arg0: &mut UnifiedSpotPool<T0, T1, T2>, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<T1>) {
        0x2::balance::join<T0>(&mut arg0.asset_reserve, arg1);
        0x2::balance::join<T1>(&mut arg0.stable_reserve, arg2);
    }

    public fun archive_finalized_escrow<T0, T1, T2>(arg0: &mut UnifiedSpotPool<T0, T1, T2>, arg1: 0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::coin_escrow::TokenEscrow<T0, T1>, arg2: 0xc24d9c40422f4364d8b1efe1e5007e4e295518189ac548e1cadef61d3af094ed::spot_pool_mutation_auth::SpotPoolMutationAuth) {
        assert!(0xc24d9c40422f4364d8b1efe1e5007e4e295518189ac548e1cadef61d3af094ed::spot_pool_mutation_auth::target_id(&arg2) == 0x2::object::id<UnifiedSpotPool<T0, T1, T2>>(arg0), 27);
        assert!(!arg0.is_dissolved, 32);
        assert!(0x1::option::is_some<AggregatorConfig<T0, T1>>(&arg0.aggregator_config), 11);
        assert!(0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::market_state::is_finalized(0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::coin_escrow::get_market_state<T0, T1>(&arg1)), 35);
        let v0 = 0x1::option::borrow_mut<AggregatorConfig<T0, T1>>(&mut arg0.aggregator_config);
        let v1 = 0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::coin_escrow::market_state_id<T0, T1>(&arg1);
        assert!(!0x2::table::contains<0x2::object::ID, 0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::coin_escrow::TokenEscrow<T0, T1>>(&v0.archived_escrows, v1), 31);
        0x2::table::add<0x2::object::ID, 0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::coin_escrow::TokenEscrow<T0, T1>>(&mut v0.archived_escrows, v1, arg1);
    }

    fun assert_projected_spot_liquidity_after_split<T0, T1, T2>(arg0: &UnifiedSpotPool<T0, T1, T2>, arg1: u64) {
        if (arg1 == 0) {
            return
        };
        let v0 = 100 - arg1;
        assert!(0x1::u128::sqrt((0x2::balance::value<T0>(&arg0.asset_reserve) as u128) * (v0 as u128) / 100 * (0x2::balance::value<T1>(&arg0.stable_reserve) as u128) * (v0 as u128) / 100) >= (arg0.minimum_liquidity as u128), 6);
    }

    fun calculate_fee_info<T0, T1, T2>(arg0: &UnifiedSpotPool<T0, T1, T2>, arg1: &0x2::clock::Clock) : FeeInfo {
        let v0 = if (0x1::option::is_some<AggregatorConfig<T0, T1>>(&arg0.aggregator_config)) {
            0xcf1218ee7d7e2610b8bc7da9c1d513c230b94e470e57cf4e9260b6da64318f12::constants::protocol_fee_bps()
        } else {
            0
        };
        let v1 = arg0.fee_bps;
        let v2 = v0 + v1;
        let v3 = if (0x1::option::is_some<0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::fee_scheduler::FeeSchedule>(&arg0.fee_schedule)) {
            0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::fee_scheduler::get_current_fee(0x1::option::borrow<0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::fee_scheduler::FeeSchedule>(&arg0.fee_schedule), v2, arg0.fee_schedule_activation_time, 0x2::clock::timestamp_ms(arg1))
        } else {
            v2
        };
        FeeInfo{
            current_total_bps   : v3,
            steady_protocol_bps : v0,
            steady_lp_bps       : v1,
            steady_total_bps    : v2,
        }
    }

    public fun calculate_raw_gap_fee(arg0: u64) : u64 {
        if (arg0 >= 0xcf1218ee7d7e2610b8bc7da9c1d513c230b94e470e57cf4e9260b6da64318f12::constants::twelve_hours_ms()) {
            return 0
        };
        let v0 = arg0 / 0xcf1218ee7d7e2610b8bc7da9c1d513c230b94e470e57cf4e9260b6da64318f12::constants::thirty_minutes_ms();
        if (v0 >= 63) {
            return 0
        };
        let v1 = 18446744073709551615 >> (v0 as u8);
        v1 - ((((v1 - (18446744073709551615 >> ((v0 + 1) as u8))) as u128) * ((arg0 % 0xcf1218ee7d7e2610b8bc7da9c1d513c230b94e470e57cf4e9260b6da64318f12::constants::thirty_minutes_ms()) as u128) / (0xcf1218ee7d7e2610b8bc7da9c1d513c230b94e470e57cf4e9260b6da64318f12::constants::thirty_minutes_ms() as u128)) as u64)
    }

    public fun calculate_scaled_gap_fee<T0, T1, T2>(arg0: &UnifiedSpotPool<T0, T1, T2>, arg1: u64, arg2: &0x2::clock::Clock) : u64 {
        let v0 = get_proposal_gap_fee<T0, T1, T2>(arg0, arg2);
        if (v0 == 0) {
            return 0
        };
        let v1 = (v0 as u256) * 10000 * (arg1 as u256) / (18446744073709551615 as u256);
        if (v1 > (18446744073709551615 as u256)) {
            18446744073709551615
        } else {
            (v1 as u64)
        }
    }

    public fun can_create_proposals<T0, T1, T2>(arg0: &UnifiedSpotPool<T0, T1, T2>, arg1: &0x2::clock::Clock) : bool {
        if (arg0.is_dissolved) {
            return false
        };
        if (0x1::option::is_none<u64>(&arg0.initial_asset_reserve)) {
            return false
        };
        if (0x1::option::is_some<0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::fee_scheduler::FeeSchedule>(&arg0.fee_schedule)) {
            let v1 = 0x1::option::borrow<0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::fee_scheduler::FeeSchedule>(&arg0.fee_schedule);
            let v2 = 0x2::clock::timestamp_ms(arg1);
            let v3 = arg0.fee_schedule_activation_time;
            let v4 = v2 <= v3 || v2 - v3 < 0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::fee_scheduler::duration_ms(v1);
            !v4
        } else {
            true
        }
    }

    public(friend) fun check_proposal_gap<T0, T1, T2>(arg0: &UnifiedSpotPool<T0, T1, T2>, arg1: &0x2::clock::Clock) {
        assert!(get_proposal_gap_fee<T0, T1, T2>(arg0, arg1) < 18446744073709551615, 16);
    }

    public(friend) fun clear_active_proposal<T0, T1, T2>(arg0: &mut UnifiedSpotPool<T0, T1, T2>, arg1: &0x2::clock::Clock) {
        arg0.active_proposal_id = 0x1::option::none<0x2::object::ID>();
        arg0.last_proposal_end_time = 0x1::option::some<u64>(0x2::clock::timestamp_ms(arg1));
        if (0x1::option::is_some<AggregatorConfig<T0, T1>>(&arg0.aggregator_config)) {
            0x1::option::borrow_mut<AggregatorConfig<T0, T1>>(&mut arg0.aggregator_config).conditional_liquidity_ratio_percent = 0;
        };
    }

    public fun current_fee_bps<T0, T1, T2>(arg0: &UnifiedSpotPool<T0, T1, T2>, arg1: &0x2::clock::Clock) : u64 {
        let v0 = calculate_fee_info<T0, T1, T2>(arg0, arg1);
        v0.current_total_bps
    }

    public fun deposit_protocol_fees_asset<T0, T1, T2>(arg0: &mut UnifiedSpotPool<T0, T1, T2>, arg1: 0x2::balance::Balance<T0>, arg2: 0xc24d9c40422f4364d8b1efe1e5007e4e295518189ac548e1cadef61d3af094ed::spot_pool_mutation_auth::SpotPoolMutationAuth) {
        assert!(0xc24d9c40422f4364d8b1efe1e5007e4e295518189ac548e1cadef61d3af094ed::spot_pool_mutation_auth::target_id(&arg2) == 0x2::object::id<UnifiedSpotPool<T0, T1, T2>>(arg0), 27);
        assert!(0x1::option::is_some<AggregatorConfig<T0, T1>>(&arg0.aggregator_config), 11);
        0x2::balance::join<T0>(&mut 0x1::option::borrow_mut<AggregatorConfig<T0, T1>>(&mut arg0.aggregator_config).protocol_fees_asset, arg1);
    }

    public fun deposit_protocol_fees_stable<T0, T1, T2>(arg0: &mut UnifiedSpotPool<T0, T1, T2>, arg1: 0x2::balance::Balance<T1>, arg2: 0xc24d9c40422f4364d8b1efe1e5007e4e295518189ac548e1cadef61d3af094ed::spot_pool_mutation_auth::SpotPoolMutationAuth) {
        assert!(0xc24d9c40422f4364d8b1efe1e5007e4e295518189ac548e1cadef61d3af094ed::spot_pool_mutation_auth::target_id(&arg2) == 0x2::object::id<UnifiedSpotPool<T0, T1, T2>>(arg0), 27);
        assert!(0x1::option::is_some<AggregatorConfig<T0, T1>>(&arg0.aggregator_config), 11);
        0x2::balance::join<T1>(&mut 0x1::option::borrow_mut<AggregatorConfig<T0, T1>>(&mut arg0.aggregator_config).protocol_fees_stable, arg1);
    }

    public fun emergency_withdraw_protocol_fees<T0, T1, T2>(arg0: &mut UnifiedSpotPool<T0, T1, T2>, arg1: u64, arg2: u64, arg3: &0xb531dc736197e5da808ab10d7d010978e7160547362ed8f8d93baca4e24069a::emergency_cap::EmergencyCap, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0xb531dc736197e5da808ab10d7d010978e7160547362ed8f8d93baca4e24069a::emergency_cap::assert_ready(arg3, arg4);
        if (0x1::option::is_none<AggregatorConfig<T0, T1>>(&arg0.aggregator_config)) {
            return (0x2::coin::zero<T0>(arg5), 0x2::coin::zero<T1>(arg5))
        };
        let v0 = 0x1::option::borrow_mut<AggregatorConfig<T0, T1>>(&mut arg0.aggregator_config);
        let v1 = 0x2::balance::value<T0>(&v0.protocol_fees_asset);
        let v2 = 0x2::balance::value<T1>(&v0.protocol_fees_stable);
        let v3 = if (arg1 == 0 || arg1 > v1) {
            v1
        } else {
            arg1
        };
        let v4 = if (arg2 == 0 || arg2 > v2) {
            v2
        } else {
            arg2
        };
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v0.protocol_fees_asset, v3), arg5), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v0.protocol_fees_stable, v4), arg5))
    }

    public fun emergency_withdraw_reserves<T0, T1, T2>(arg0: &mut UnifiedSpotPool<T0, T1, T2>, arg1: u64, arg2: u64, arg3: &0xb531dc736197e5da808ab10d7d010978e7160547362ed8f8d93baca4e24069a::emergency_cap::EmergencyCap, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0xb531dc736197e5da808ab10d7d010978e7160547362ed8f8d93baca4e24069a::emergency_cap::assert_ready(arg3, arg4);
        let v0 = 0x2::balance::value<T0>(&arg0.asset_reserve);
        let v1 = 0x2::balance::value<T1>(&arg0.stable_reserve);
        let v2 = if (arg1 == 0 || arg1 > v0) {
            v0
        } else {
            arg1
        };
        let v3 = if (arg2 == 0 || arg2 > v1) {
            v1
        } else {
            arg2
        };
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.asset_reserve, v2), arg5), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.stable_reserve, v3), arg5))
    }

    public fun extract_active_escrow<T0, T1, T2>(arg0: &mut UnifiedSpotPool<T0, T1, T2>, arg1: 0xc24d9c40422f4364d8b1efe1e5007e4e295518189ac548e1cadef61d3af094ed::spot_pool_mutation_auth::SpotPoolMutationAuth) : 0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::coin_escrow::TokenEscrow<T0, T1> {
        assert!(0xc24d9c40422f4364d8b1efe1e5007e4e295518189ac548e1cadef61d3af094ed::spot_pool_mutation_auth::target_id(&arg1) == 0x2::object::id<UnifiedSpotPool<T0, T1, T2>>(arg0), 27);
        assert!(0x1::option::is_some<AggregatorConfig<T0, T1>>(&arg0.aggregator_config), 11);
        let v0 = 0x1::option::borrow_mut<AggregatorConfig<T0, T1>>(&mut arg0.aggregator_config);
        assert!(0x1::option::is_some<0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::coin_escrow::TokenEscrow<T0, T1>>(&v0.active_escrow), 7);
        0x1::option::extract<0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::coin_escrow::TokenEscrow<T0, T1>>(&mut v0.active_escrow)
    }

    public fun extract_escrow_by_market_id<T0, T1, T2>(arg0: &mut UnifiedSpotPool<T0, T1, T2>, arg1: 0x2::object::ID, arg2: 0xc24d9c40422f4364d8b1efe1e5007e4e295518189ac548e1cadef61d3af094ed::spot_pool_mutation_auth::SpotPoolMutationAuth) : (0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::coin_escrow::TokenEscrow<T0, T1>, bool) {
        assert!(0xc24d9c40422f4364d8b1efe1e5007e4e295518189ac548e1cadef61d3af094ed::spot_pool_mutation_auth::target_id(&arg2) == 0x2::object::id<UnifiedSpotPool<T0, T1, T2>>(arg0), 27);
        assert!(0x1::option::is_some<AggregatorConfig<T0, T1>>(&arg0.aggregator_config), 11);
        let v0 = 0x1::option::borrow_mut<AggregatorConfig<T0, T1>>(&mut arg0.aggregator_config);
        if (0x1::option::is_some<0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::coin_escrow::TokenEscrow<T0, T1>>(&v0.active_escrow)) {
            if (0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::coin_escrow::market_state_id<T0, T1>(0x1::option::borrow<0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::coin_escrow::TokenEscrow<T0, T1>>(&v0.active_escrow)) == arg1) {
                return (0x1::option::extract<0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::coin_escrow::TokenEscrow<T0, T1>>(&mut v0.active_escrow), true)
            };
        };
        assert!(0x2::table::contains<0x2::object::ID, 0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::coin_escrow::TokenEscrow<T0, T1>>(&v0.archived_escrows, arg1), 30);
        (0x2::table::remove<0x2::object::ID, 0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::coin_escrow::TokenEscrow<T0, T1>>(&mut v0.archived_escrows, arg1), false)
    }

    public fun get_active_escrow_id<T0, T1, T2>(arg0: &UnifiedSpotPool<T0, T1, T2>) : 0x1::option::Option<0x2::object::ID> {
        if (0x1::option::is_none<AggregatorConfig<T0, T1>>(&arg0.aggregator_config)) {
            return 0x1::option::none<0x2::object::ID>()
        };
        let v0 = 0x1::option::borrow<AggregatorConfig<T0, T1>>(&arg0.aggregator_config);
        if (0x1::option::is_some<0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::coin_escrow::TokenEscrow<T0, T1>>(&v0.active_escrow)) {
            0x1::option::some<0x2::object::ID>(0x2::object::id<0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::coin_escrow::TokenEscrow<T0, T1>>(0x1::option::borrow<0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::coin_escrow::TokenEscrow<T0, T1>>(&v0.active_escrow)))
        } else {
            0x1::option::none<0x2::object::ID>()
        }
    }

    public fun get_active_proposal_id<T0, T1, T2>(arg0: &UnifiedSpotPool<T0, T1, T2>) : 0x1::option::Option<0x2::object::ID> {
        arg0.active_proposal_id
    }

    public fun get_conditional_liquidity_ratio_percent<T0, T1, T2>(arg0: &UnifiedSpotPool<T0, T1, T2>) : u64 {
        if (0x1::option::is_none<AggregatorConfig<T0, T1>>(&arg0.aggregator_config)) {
            return 0
        };
        0x1::option::borrow<AggregatorConfig<T0, T1>>(&arg0.aggregator_config).conditional_liquidity_ratio_percent
    }

    public fun get_dao_lp_value<T0, T1, T2>(arg0: &UnifiedSpotPool<T0, T1, T2>, arg1: u64) : (u64, u64) {
        let v0 = 0x2::coin::total_supply<T2>(&arg0.lp_treasury_cap);
        if (v0 == 0) {
            return (0, 0)
        };
        ((((0x2::balance::value<T0>(&arg0.asset_reserve) as u128) * (arg1 as u128) / (v0 as u128)) as u64), (((0x2::balance::value<T1>(&arg0.stable_reserve) as u128) * (arg1 as u128) / (v0 as u128)) as u64))
    }

    public fun get_fee_bps<T0, T1, T2>(arg0: &UnifiedSpotPool<T0, T1, T2>) : u64 {
        arg0.fee_bps
    }

    public fun get_geometric_twap<T0, T1, T2>(arg0: &UnifiedSpotPool<T0, T1, T2>, arg1: &0x2::clock::Clock) : u128 {
        assert!(0x1::option::is_some<AggregatorConfig<T0, T1>>(&arg0.aggregator_config), 11);
        let v0 = 0x1::option::borrow<AggregatorConfig<T0, T1>>(&arg0.aggregator_config);
        unwrap_option_with_default(0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::PCW_TWAP_oracle::get_ninety_day_twap(&v0.simple_twap, arg1), 0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::PCW_TWAP_oracle::get_twap(&v0.simple_twap))
    }

    public fun get_initial_reserves<T0, T1, T2>(arg0: &UnifiedSpotPool<T0, T1, T2>) : (0x1::option::Option<u64>, 0x1::option::Option<u64>) {
        (arg0.initial_asset_reserve, arg0.initial_stable_reserve)
    }

    public fun get_initialized_at_ms<T0, T1, T2>(arg0: &UnifiedSpotPool<T0, T1, T2>) : u64 {
        arg0.fee_schedule_activation_time
    }

    public fun get_last_proposal_end_time<T0, T1, T2>(arg0: &UnifiedSpotPool<T0, T1, T2>) : 0x1::option::Option<u64> {
        arg0.last_proposal_end_time
    }

    public fun get_oracle_conditional_threshold_bps<T0, T1, T2>(arg0: &UnifiedSpotPool<T0, T1, T2>) : u64 {
        if (0x1::option::is_none<AggregatorConfig<T0, T1>>(&arg0.aggregator_config)) {
            return 10000
        };
        0x1::option::borrow<AggregatorConfig<T0, T1>>(&arg0.aggregator_config).oracle_conditional_threshold_bps
    }

    public fun get_pool_id<T0, T1, T2>(arg0: &UnifiedSpotPool<T0, T1, T2>) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun get_proposal_gap_fee<T0, T1, T2>(arg0: &UnifiedSpotPool<T0, T1, T2>, arg1: &0x2::clock::Clock) : u64 {
        if (0x1::option::is_none<u64>(&arg0.last_proposal_end_time)) {
            return 0
        };
        let v0 = *0x1::option::borrow<u64>(&arg0.last_proposal_end_time);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        if (v1 <= v0) {
            return 18446744073709551615
        };
        calculate_raw_gap_fee(v1 - v0)
    }

    public fun get_protocol_fee_amounts<T0, T1, T2>(arg0: &UnifiedSpotPool<T0, T1, T2>) : (u64, u64) {
        if (0x1::option::is_none<AggregatorConfig<T0, T1>>(&arg0.aggregator_config)) {
            return (0, 0)
        };
        let v0 = 0x1::option::borrow<AggregatorConfig<T0, T1>>(&arg0.aggregator_config);
        (0x2::balance::value<T0>(&v0.protocol_fees_asset), 0x2::balance::value<T1>(&v0.protocol_fees_stable))
    }

    public fun get_reserves<T0, T1, T2>(arg0: &UnifiedSpotPool<T0, T1, T2>) : (u64, u64) {
        (0x2::balance::value<T0>(&arg0.asset_reserve), 0x2::balance::value<T1>(&arg0.stable_reserve))
    }

    public fun get_simple_twap<T0, T1, T2>(arg0: &UnifiedSpotPool<T0, T1, T2>) : &0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::PCW_TWAP_oracle::SimpleTWAP {
        assert!(0x1::option::is_some<AggregatorConfig<T0, T1>>(&arg0.aggregator_config), 11);
        &0x1::option::borrow<AggregatorConfig<T0, T1>>(&arg0.aggregator_config).simple_twap
    }

    public fun get_spot_cumulative_at_lock<T0, T1, T2>(arg0: &UnifiedSpotPool<T0, T1, T2>) : 0x1::option::Option<u256> {
        if (0x1::option::is_none<AggregatorConfig<T0, T1>>(&arg0.aggregator_config)) {
            return 0x1::option::none<u256>()
        };
        0x1::option::borrow<AggregatorConfig<T0, T1>>(&arg0.aggregator_config).spot_cumulative_at_lock
    }

    public fun get_spot_price<T0, T1, T2>(arg0: &UnifiedSpotPool<T0, T1, T2>) : u128 {
        let v0 = 0x2::balance::value<T0>(&arg0.asset_reserve);
        let v1 = 0x2::balance::value<T1>(&arg0.stable_reserve);
        if (v0 == 0 || v1 == 0) {
            return 0
        };
        (v1 as u128) * 0xcf1218ee7d7e2610b8bc7da9c1d513c230b94e470e57cf4e9260b6da64318f12::constants::price_scale() / (v0 as u128)
    }

    public fun has_active_escrow<T0, T1, T2>(arg0: &UnifiedSpotPool<T0, T1, T2>) : bool {
        if (0x1::option::is_none<AggregatorConfig<T0, T1>>(&arg0.aggregator_config)) {
            return false
        };
        0x1::option::is_some<0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::coin_escrow::TokenEscrow<T0, T1>>(&0x1::option::borrow<AggregatorConfig<T0, T1>>(&arg0.aggregator_config).active_escrow)
    }

    public fun has_proposal_history<T0, T1, T2>(arg0: &UnifiedSpotPool<T0, T1, T2>) : bool {
        if (0x1::option::is_none<AggregatorConfig<T0, T1>>(&arg0.aggregator_config)) {
            return false
        };
        0x1::option::is_some<u64>(&0x1::option::borrow<AggregatorConfig<T0, T1>>(&arg0.aggregator_config).last_proposal_usage)
    }

    public fun is_aggregator_enabled<T0, T1, T2>(arg0: &UnifiedSpotPool<T0, T1, T2>) : bool {
        0x1::option::is_some<AggregatorConfig<T0, T1>>(&arg0.aggregator_config)
    }

    public fun is_dissolved<T0, T1, T2>(arg0: &UnifiedSpotPool<T0, T1, T2>) : bool {
        arg0.is_dissolved
    }

    public fun is_locked_for_proposal<T0, T1, T2>(arg0: &UnifiedSpotPool<T0, T1, T2>) : bool {
        0x1::option::is_some<0x2::object::ID>(&arg0.active_proposal_id)
    }

    public fun is_twap_ready<T0, T1, T2>(arg0: &UnifiedSpotPool<T0, T1, T2>, arg1: &0x2::clock::Clock) : bool {
        if (0x1::option::is_none<AggregatorConfig<T0, T1>>(&arg0.aggregator_config)) {
            return false
        };
        0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::PCW_TWAP_oracle::is_ready(&0x1::option::borrow<AggregatorConfig<T0, T1>>(&arg0.aggregator_config).simple_twap, arg1)
    }

    public fun lp_fee_bps<T0, T1, T2>(arg0: &UnifiedSpotPool<T0, T1, T2>) : u64 {
        arg0.fee_bps
    }

    public fun lp_supply<T0, T1, T2>(arg0: &UnifiedSpotPool<T0, T1, T2>) : u64 {
        0x2::coin::total_supply<T2>(&arg0.lp_treasury_cap)
    }

    public fun mark_liquidity_to_proposal<T0, T1, T2>(arg0: &mut UnifiedSpotPool<T0, T1, T2>, arg1: u64, arg2: &0x2::clock::Clock, arg3: 0xc24d9c40422f4364d8b1efe1e5007e4e295518189ac548e1cadef61d3af094ed::spot_pool_mutation_auth::SpotPoolMutationAuth) {
        assert!(0xc24d9c40422f4364d8b1efe1e5007e4e295518189ac548e1cadef61d3af094ed::spot_pool_mutation_auth::target_id(&arg3) == 0x2::object::id<UnifiedSpotPool<T0, T1, T2>>(arg0), 27);
        assert!(!arg0.is_dissolved, 32);
        assert!(arg1 < 100, 25);
        if (0x1::option::is_none<AggregatorConfig<T0, T1>>(&arg0.aggregator_config)) {
            return
        };
        assert_projected_spot_liquidity_after_split<T0, T1, T2>(arg0, arg1);
        let v0 = 0x1::option::borrow_mut<AggregatorConfig<T0, T1>>(&mut arg0.aggregator_config);
        0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::PCW_TWAP_oracle::update(&mut v0.simple_twap, get_spot_price<T0, T1, T2>(arg0), arg2);
        v0.last_proposal_usage = 0x1::option::some<u64>(0x2::clock::timestamp_ms(arg2));
        v0.spot_cumulative_at_lock = 0x1::option::some<u256>(0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::PCW_TWAP_oracle::cumulative_total(&v0.simple_twap));
        v0.conditional_liquidity_ratio_percent = arg1;
    }

    public fun remove_liquidity<T0, T1, T2>(arg0: &mut UnifiedSpotPool<T0, T1, T2>, arg1: 0x2::coin::Coin<T2>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x2::coin::value<T2>(&arg1);
        let v1 = 0x2::coin::total_supply<T2>(&arg0.lp_treasury_cap);
        assert!(v0 > 0, 4);
        assert!(v1 >= v0, 3);
        assert!(0x1::option::is_none<0x2::object::ID>(&arg0.active_proposal_id), 15);
        let v2 = 0xcf1218ee7d7e2610b8bc7da9c1d513c230b94e470e57cf4e9260b6da64318f12::math::safe_u128_to_u64((0x2::balance::value<T0>(&arg0.asset_reserve) as u128) * (v0 as u128) / (v1 as u128));
        let v3 = 0xcf1218ee7d7e2610b8bc7da9c1d513c230b94e470e57cf4e9260b6da64318f12::math::safe_u128_to_u64((0x2::balance::value<T1>(&arg0.stable_reserve) as u128) * (v0 as u128) / (v1 as u128));
        assert!(v2 >= arg2, 5);
        assert!(v3 >= arg3, 5);
        0x2::coin::burn<T2>(&mut arg0.lp_treasury_cap, arg1);
        let v4 = 0x2::balance::value<T0>(&arg0.asset_reserve);
        let v5 = 0x2::balance::value<T1>(&arg0.stable_reserve);
        assert!(0x1::u128::sqrt((v4 as u128) * (v5 as u128)) >= (arg0.minimum_liquidity as u128), 6);
        let v6 = SpotLiquidityRemoved{
            pool_id        : 0x2::object::id<UnifiedSpotPool<T0, T1, T2>>(arg0),
            provider       : 0x2::tx_context::sender(arg4),
            asset_amount   : (v2 as u64),
            stable_amount  : (v3 as u64),
            lp_amount      : v0,
            asset_reserve  : v4,
            stable_reserve : v5,
        };
        0x2::event::emit<SpotLiquidityRemoved>(v6);
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.asset_reserve, v2), arg4), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.stable_reserve, v3), arg4))
    }

    public fun remove_liquidity_for_dissolution<T0, T1, T2>(arg0: &mut UnifiedSpotPool<T0, T1, T2>, arg1: 0x2::coin::Coin<T2>, arg2: bool, arg3: 0xc24d9c40422f4364d8b1efe1e5007e4e295518189ac548e1cadef61d3af094ed::spot_pool_mutation_auth::SpotPoolMutationAuth, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(0xc24d9c40422f4364d8b1efe1e5007e4e295518189ac548e1cadef61d3af094ed::spot_pool_mutation_auth::target_id(&arg3) == 0x2::object::id<UnifiedSpotPool<T0, T1, T2>>(arg0), 27);
        let v0 = 0x2::coin::value<T2>(&arg1);
        let v1 = 0x2::coin::total_supply<T2>(&arg0.lp_treasury_cap);
        assert!(v0 > 0, 4);
        assert!(v1 >= v0, 3);
        0x2::coin::burn<T2>(&mut arg0.lp_treasury_cap, arg1);
        if (!arg2) {
            assert!(0x1::u128::sqrt((0x2::balance::value<T0>(&arg0.asset_reserve) as u128) * (0x2::balance::value<T1>(&arg0.stable_reserve) as u128)) >= (arg0.minimum_liquidity as u128), 6);
        } else {
            arg0.minimum_liquidity = 0;
            arg0.is_dissolved = true;
        };
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.asset_reserve, (((0x2::balance::value<T0>(&arg0.asset_reserve) as u128) * (v0 as u128) / (v1 as u128)) as u64)), arg4), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.stable_reserve, (((0x2::balance::value<T1>(&arg0.stable_reserve) as u128) * (v0 as u128) / (v1 as u128)) as u64)), arg4))
    }

    public(friend) fun return_asset_from_arbitrage<T0, T1, T2>(arg0: &mut UnifiedSpotPool<T0, T1, T2>, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(&mut arg0.asset_reserve, arg1);
    }

    public(friend) fun return_stable_from_arbitrage<T0, T1, T2>(arg0: &mut UnifiedSpotPool<T0, T1, T2>, arg1: 0x2::balance::Balance<T1>) {
        0x2::balance::join<T1>(&mut arg0.stable_reserve, arg1);
    }

    public(friend) fun set_active_proposal<T0, T1, T2>(arg0: &mut UnifiedSpotPool<T0, T1, T2>, arg1: 0x2::object::ID) {
        arg0.active_proposal_id = 0x1::option::some<0x2::object::ID>(arg1);
    }

    public fun set_fee_bps<T0, T1, T2>(arg0: &mut UnifiedSpotPool<T0, T1, T2>, arg1: u64, arg2: 0xc24d9c40422f4364d8b1efe1e5007e4e295518189ac548e1cadef61d3af094ed::spot_pool_mutation_auth::SpotPoolMutationAuth) {
        assert!(0xc24d9c40422f4364d8b1efe1e5007e4e295518189ac548e1cadef61d3af094ed::spot_pool_mutation_auth::target_id(&arg2) == 0x2::object::id<UnifiedSpotPool<T0, T1, T2>>(arg0), 27);
        assert!(arg1 <= 0xcf1218ee7d7e2610b8bc7da9c1d513c230b94e470e57cf4e9260b6da64318f12::constants::max_amm_fee_bps(), 24);
        arg0.fee_bps = arg1;
    }

    public fun share<T0, T1, T2>(arg0: UnifiedSpotPool<T0, T1, T2>, arg1: MustShare) {
        let MustShare { pool_id: v0 } = arg1;
        assert!(v0 == 0x2::object::id<UnifiedSpotPool<T0, T1, T2>>(&arg0), 33);
        0x2::transfer::public_share_object<UnifiedSpotPool<T0, T1, T2>>(arg0);
    }

    public fun simulate_swap_asset_to_stable_accurate<T0, T1, T2>(arg0: &UnifiedSpotPool<T0, T1, T2>, arg1: u64, arg2: &0x2::clock::Clock) : u64 {
        if (arg1 == 0) {
            return 0
        };
        let v0 = 0x2::balance::value<T0>(&arg0.asset_reserve);
        let v1 = 0x2::balance::value<T1>(&arg0.stable_reserve);
        if (v0 == 0 || v1 == 0) {
            return 0
        };
        let v2 = calculate_fee_info<T0, T1, T2>(arg0, arg2);
        let v3 = 0xcf1218ee7d7e2610b8bc7da9c1d513c230b94e470e57cf4e9260b6da64318f12::math::mul_div_to_64(arg1, v2.current_total_bps, 0xcf1218ee7d7e2610b8bc7da9c1d513c230b94e470e57cf4e9260b6da64318f12::constants::total_fee_bps());
        if (arg1 <= v3) {
            return 0
        };
        let v4 = arg1 - v3;
        let v5 = (v1 as u128) * (v4 as u128) / ((v0 as u128) + (v4 as u128));
        if ((v5 as u64) >= v1) {
            return 0
        };
        (v5 as u64)
    }

    public fun simulate_swap_asset_to_stable_feeless<T0, T1, T2>(arg0: &UnifiedSpotPool<T0, T1, T2>, arg1: u64) : u64 {
        if (arg1 == 0) {
            return 0
        };
        let v0 = 0x2::balance::value<T0>(&arg0.asset_reserve);
        let v1 = 0x2::balance::value<T1>(&arg0.stable_reserve);
        if (v0 == 0 || v1 == 0) {
            return 0
        };
        let v2 = (v1 as u128) * (arg1 as u128) / ((v0 as u128) + (arg1 as u128));
        if ((v2 as u64) >= v1) {
            return 0
        };
        (v2 as u64)
    }

    public fun simulate_swap_stable_to_asset_accurate<T0, T1, T2>(arg0: &UnifiedSpotPool<T0, T1, T2>, arg1: u64, arg2: &0x2::clock::Clock) : u64 {
        if (arg1 == 0) {
            return 0
        };
        let v0 = 0x2::balance::value<T0>(&arg0.asset_reserve);
        let v1 = 0x2::balance::value<T1>(&arg0.stable_reserve);
        if (v0 == 0 || v1 == 0) {
            return 0
        };
        let v2 = calculate_fee_info<T0, T1, T2>(arg0, arg2);
        let v3 = 0xcf1218ee7d7e2610b8bc7da9c1d513c230b94e470e57cf4e9260b6da64318f12::math::mul_div_to_64(arg1, v2.current_total_bps, 0xcf1218ee7d7e2610b8bc7da9c1d513c230b94e470e57cf4e9260b6da64318f12::constants::total_fee_bps());
        if (arg1 <= v3) {
            return 0
        };
        let v4 = arg1 - v3;
        let v5 = (v0 as u128) * (v4 as u128) / ((v1 as u128) + (v4 as u128));
        if ((v5 as u64) >= v0) {
            return 0
        };
        (v5 as u64)
    }

    public fun simulate_swap_stable_to_asset_feeless<T0, T1, T2>(arg0: &UnifiedSpotPool<T0, T1, T2>, arg1: u64) : u64 {
        if (arg1 == 0) {
            return 0
        };
        let v0 = 0x2::balance::value<T0>(&arg0.asset_reserve);
        let v1 = 0x2::balance::value<T1>(&arg0.stable_reserve);
        if (v0 == 0 || v1 == 0) {
            return 0
        };
        let v2 = (v0 as u128) * (arg1 as u128) / ((v1 as u128) + (arg1 as u128));
        if ((v2 as u64) >= v0) {
            return 0
        };
        (v2 as u64)
    }

    fun split_fee(arg0: u64, arg1: &FeeInfo, arg2: bool) : (u64, u64) {
        if (!arg2 || arg1.steady_total_bps == 0) {
            (0, arg0)
        } else {
            let v2 = 0xcf1218ee7d7e2610b8bc7da9c1d513c230b94e470e57cf4e9260b6da64318f12::math::mul_div_to_64(arg0, arg1.steady_protocol_bps, arg1.steady_total_bps);
            (v2, arg0 - v2)
        }
    }

    public(friend) fun split_reserves_for_quantum<T0, T1, T2>(arg0: &mut UnifiedSpotPool<T0, T1, T2>, arg1: u64, arg2: u64) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        assert!(arg1 > 0 && arg2 > 0, 4);
        let v0 = 0x2::balance::value<T0>(&arg0.asset_reserve);
        let v1 = 0x2::balance::value<T1>(&arg0.stable_reserve);
        assert!(arg1 <= v0, 1);
        assert!(arg2 <= v1, 1);
        assert!(0x1::u128::sqrt(((v0 - arg1) as u128) * ((v1 - arg2) as u128)) >= (arg0.minimum_liquidity as u128), 6);
        (0x2::balance::split<T0>(&mut arg0.asset_reserve, arg1), 0x2::balance::split<T1>(&mut arg0.stable_reserve, arg2))
    }

    public fun store_active_escrow<T0, T1, T2>(arg0: &mut UnifiedSpotPool<T0, T1, T2>, arg1: 0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::coin_escrow::TokenEscrow<T0, T1>, arg2: 0xc24d9c40422f4364d8b1efe1e5007e4e295518189ac548e1cadef61d3af094ed::spot_pool_mutation_auth::SpotPoolMutationAuth) {
        assert!(0xc24d9c40422f4364d8b1efe1e5007e4e295518189ac548e1cadef61d3af094ed::spot_pool_mutation_auth::target_id(&arg2) == 0x2::object::id<UnifiedSpotPool<T0, T1, T2>>(arg0), 27);
        assert!(!arg0.is_dissolved, 32);
        assert!(0x1::option::is_some<AggregatorConfig<T0, T1>>(&arg0.aggregator_config), 11);
        let v0 = 0x1::option::borrow_mut<AggregatorConfig<T0, T1>>(&mut arg0.aggregator_config);
        if (0x1::option::is_some<0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::coin_escrow::TokenEscrow<T0, T1>>(&v0.active_escrow)) {
            let v1 = 0x1::option::extract<0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::coin_escrow::TokenEscrow<T0, T1>>(&mut v0.active_escrow);
            if (!0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::market_state::is_finalized(0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::coin_escrow::get_market_state<T0, T1>(&v1))) {
                0x1::option::fill<0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::coin_escrow::TokenEscrow<T0, T1>>(&mut v0.active_escrow, v1);
                abort 15
            };
            let v2 = 0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::coin_escrow::market_state_id<T0, T1>(&v1);
            assert!(!0x2::table::contains<0x2::object::ID, 0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::coin_escrow::TokenEscrow<T0, T1>>(&v0.archived_escrows, v2), 31);
            0x2::table::add<0x2::object::ID, 0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::coin_escrow::TokenEscrow<T0, T1>>(&mut v0.archived_escrows, v2, v1);
        };
        0x1::option::fill<0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::coin_escrow::TokenEscrow<T0, T1>>(&mut v0.active_escrow, arg1);
    }

    public fun store_extracted_escrow<T0, T1, T2>(arg0: &mut UnifiedSpotPool<T0, T1, T2>, arg1: 0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::coin_escrow::TokenEscrow<T0, T1>, arg2: bool, arg3: 0xc24d9c40422f4364d8b1efe1e5007e4e295518189ac548e1cadef61d3af094ed::spot_pool_mutation_auth::SpotPoolMutationAuth) {
        assert!(0xc24d9c40422f4364d8b1efe1e5007e4e295518189ac548e1cadef61d3af094ed::spot_pool_mutation_auth::target_id(&arg3) == 0x2::object::id<UnifiedSpotPool<T0, T1, T2>>(arg0), 27);
        assert!(0x1::option::is_some<AggregatorConfig<T0, T1>>(&arg0.aggregator_config), 11);
        let v0 = 0x1::option::borrow_mut<AggregatorConfig<T0, T1>>(&mut arg0.aggregator_config);
        if (arg2) {
            assert!(0x1::option::is_none<0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::coin_escrow::TokenEscrow<T0, T1>>(&v0.active_escrow), 15);
            0x1::option::fill<0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::coin_escrow::TokenEscrow<T0, T1>>(&mut v0.active_escrow, arg1);
        } else {
            let v1 = 0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::coin_escrow::market_state_id<T0, T1>(&arg1);
            assert!(!0x2::table::contains<0x2::object::ID, 0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::coin_escrow::TokenEscrow<T0, T1>>(&v0.archived_escrows, v1), 31);
            0x2::table::add<0x2::object::ID, 0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::coin_escrow::TokenEscrow<T0, T1>>(&mut v0.archived_escrows, v1, arg1);
        };
    }

    public fun swap_asset_for_stable<T0, T1, T2>(arg0: &mut UnifiedSpotPool<T0, T1, T2>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 4);
        assert!(!arg0.is_dissolved, 32);
        let v1 = 0x2::balance::value<T1>(&arg0.stable_reserve);
        let v2 = calculate_fee_info<T0, T1, T2>(arg0, arg3);
        let v3 = 0xcf1218ee7d7e2610b8bc7da9c1d513c230b94e470e57cf4e9260b6da64318f12::math::mul_div_to_64(v0, v2.current_total_bps, 0xcf1218ee7d7e2610b8bc7da9c1d513c230b94e470e57cf4e9260b6da64318f12::constants::total_fee_bps());
        assert!(v0 > v3, 23);
        let v4 = 0x1::option::is_some<AggregatorConfig<T0, T1>>(&arg0.aggregator_config);
        let (v5, _) = split_fee(v3, &v2, v4);
        let v7 = v0 - v3;
        let v8 = (v1 as u128) * (v7 as u128) / ((0x2::balance::value<T0>(&arg0.asset_reserve) as u128) + (v7 as u128));
        assert!((v8 as u64) > 0, 23);
        assert!((v8 as u64) >= arg2, 5);
        assert!((v8 as u64) < v1, 1);
        if (v4 && v5 > 0) {
            0x2::balance::join<T0>(&mut 0x1::option::borrow_mut<AggregatorConfig<T0, T1>>(&mut arg0.aggregator_config).protocol_fees_asset, 0x2::balance::split<T0>(0x2::coin::balance_mut<T0>(&mut arg1), v5));
        };
        0x2::balance::join<T0>(&mut arg0.asset_reserve, 0x2::coin::into_balance<T0>(arg1));
        if (v4) {
            0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::PCW_TWAP_oracle::update(&mut 0x1::option::borrow_mut<AggregatorConfig<T0, T1>>(&mut arg0.aggregator_config).simple_twap, get_spot_price<T0, T1, T2>(arg0), arg3);
        };
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.stable_reserve, (v8 as u64)), arg4)
    }

    public fun swap_stable_for_asset<T0, T1, T2>(arg0: &mut UnifiedSpotPool<T0, T1, T2>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::value<T1>(&arg1);
        assert!(v0 > 0, 4);
        assert!(!arg0.is_dissolved, 32);
        let v1 = 0x2::balance::value<T0>(&arg0.asset_reserve);
        let v2 = calculate_fee_info<T0, T1, T2>(arg0, arg3);
        let v3 = 0xcf1218ee7d7e2610b8bc7da9c1d513c230b94e470e57cf4e9260b6da64318f12::math::mul_div_to_64(v0, v2.current_total_bps, 0xcf1218ee7d7e2610b8bc7da9c1d513c230b94e470e57cf4e9260b6da64318f12::constants::total_fee_bps());
        assert!(v0 > v3, 23);
        let v4 = 0x1::option::is_some<AggregatorConfig<T0, T1>>(&arg0.aggregator_config);
        let (v5, _) = split_fee(v3, &v2, v4);
        let v7 = v0 - v3;
        let v8 = (v1 as u128) * (v7 as u128) / ((0x2::balance::value<T1>(&arg0.stable_reserve) as u128) + (v7 as u128));
        assert!((v8 as u64) > 0, 23);
        assert!((v8 as u64) >= arg2, 5);
        assert!((v8 as u64) < v1, 1);
        if (v4 && v5 > 0) {
            0x2::balance::join<T1>(&mut 0x1::option::borrow_mut<AggregatorConfig<T0, T1>>(&mut arg0.aggregator_config).protocol_fees_stable, 0x2::balance::split<T1>(0x2::coin::balance_mut<T1>(&mut arg1), v5));
        };
        0x2::balance::join<T1>(&mut arg0.stable_reserve, 0x2::coin::into_balance<T1>(arg1));
        if (v4) {
            0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::PCW_TWAP_oracle::update(&mut 0x1::option::borrow_mut<AggregatorConfig<T0, T1>>(&mut arg0.aggregator_config).simple_twap, get_spot_price<T0, T1, T2>(arg0), arg3);
        };
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.asset_reserve, (v8 as u64)), arg4)
    }

    public(friend) fun take_asset_for_arbitrage<T0, T1, T2>(arg0: &mut UnifiedSpotPool<T0, T1, T2>, arg1: u64) : 0x2::balance::Balance<T0> {
        assert!(arg1 > 0, 4);
        assert!(0x2::balance::value<T0>(&arg0.asset_reserve) >= arg1, 1);
        0x2::balance::split<T0>(&mut arg0.asset_reserve, arg1)
    }

    public(friend) fun take_stable_for_arbitrage<T0, T1, T2>(arg0: &mut UnifiedSpotPool<T0, T1, T2>, arg1: u64) : 0x2::balance::Balance<T1> {
        assert!(arg1 > 0, 4);
        assert!(0x2::balance::value<T1>(&arg0.stable_reserve) >= arg1, 1);
        0x2::balance::split<T1>(&mut arg0.stable_reserve, arg1)
    }

    fun unwrap_option_with_default(arg0: 0x1::option::Option<u128>, arg1: u128) : u128 {
        if (0x1::option::is_some<u128>(&arg0)) {
            0x1::option::destroy_some<u128>(arg0)
        } else {
            0x1::option::destroy_none<u128>(arg0);
            arg1
        }
    }

    public(friend) fun update_twap_after_arbitrage<T0, T1, T2>(arg0: &mut UnifiedSpotPool<T0, T1, T2>, arg1: &0x2::clock::Clock) {
        if (0x1::option::is_some<AggregatorConfig<T0, T1>>(&arg0.aggregator_config)) {
            0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::PCW_TWAP_oracle::update(&mut 0x1::option::borrow_mut<AggregatorConfig<T0, T1>>(&mut arg0.aggregator_config).simple_twap, get_spot_price<T0, T1, T2>(arg0), arg1);
        };
    }

    public fun withdraw_protocol_fees_asset<T0, T1, T2>(arg0: &mut UnifiedSpotPool<T0, T1, T2>, arg1: 0xc24d9c40422f4364d8b1efe1e5007e4e295518189ac548e1cadef61d3af094ed::spot_pool_mutation_auth::SpotPoolMutationAuth) : 0x2::balance::Balance<T0> {
        assert!(0xc24d9c40422f4364d8b1efe1e5007e4e295518189ac548e1cadef61d3af094ed::spot_pool_mutation_auth::target_id(&arg1) == 0x2::object::id<UnifiedSpotPool<T0, T1, T2>>(arg0), 27);
        assert!(0x1::option::is_some<AggregatorConfig<T0, T1>>(&arg0.aggregator_config), 11);
        let v0 = 0x1::option::borrow_mut<AggregatorConfig<T0, T1>>(&mut arg0.aggregator_config);
        0x2::balance::split<T0>(&mut v0.protocol_fees_asset, 0x2::balance::value<T0>(&v0.protocol_fees_asset))
    }

    public fun withdraw_protocol_fees_stable<T0, T1, T2>(arg0: &mut UnifiedSpotPool<T0, T1, T2>, arg1: 0xc24d9c40422f4364d8b1efe1e5007e4e295518189ac548e1cadef61d3af094ed::spot_pool_mutation_auth::SpotPoolMutationAuth) : 0x2::balance::Balance<T1> {
        assert!(0xc24d9c40422f4364d8b1efe1e5007e4e295518189ac548e1cadef61d3af094ed::spot_pool_mutation_auth::target_id(&arg1) == 0x2::object::id<UnifiedSpotPool<T0, T1, T2>>(arg0), 27);
        assert!(0x1::option::is_some<AggregatorConfig<T0, T1>>(&arg0.aggregator_config), 11);
        let v0 = 0x1::option::borrow_mut<AggregatorConfig<T0, T1>>(&mut arg0.aggregator_config);
        0x2::balance::split<T1>(&mut v0.protocol_fees_stable, 0x2::balance::value<T1>(&v0.protocol_fees_stable))
    }

    // decompiled from Move bytecode v6
}

