module 0xbcbd0933e68a1af594d5f5338eaa43ca3653450d4acaf89843436c04e3f841db::offchain {
    struct PauseSnapshot has copy, drop {
        global_paused: bool,
        view_package_paused: bool,
        core_package_paused: bool,
        domain_paused: bool,
        target_paused: bool,
        paused: bool,
    }

    struct RewardSnapshot has copy, drop {
        distributor_required: bool,
        distributor_id: 0x2::object::ID,
        pool_gate_open: bool,
        yt_gate_open: bool,
        yt_guard: u64,
        lp_guard: u64,
        pool_guard: u64,
    }

    struct MarketViewSnapshot has copy, drop {
        market_state_id: 0x2::object::ID,
        pause: PauseSnapshot,
        expiry: u64,
        sy_treasury_id: 0x2::object::ID,
        pt_treasury_id: 0x2::object::ID,
        yt_treasury_id: 0x2::object::ID,
        sy_total_supply: u64,
        pt_total_supply: u64,
        yt_total_supply: u64,
        pt_supply: u64,
        yt_supply: u64,
        py_sy_balance: u64,
        py_index_stored: u128,
        global_interest_index: u128,
        is_settled: bool,
        settled_py_index: u128,
        total_pt: u64,
        pool_sy_balance: u64,
        reserve_fee_balance: u64,
        lp_supply: u64,
        treasury: address,
        interest_fee_rate: u128,
        expiry_divisor: u64,
        market_cap: u64,
        asset_market_cap: u64,
        asset_exposure: u64,
        reward: RewardSnapshot,
        expired: bool,
    }

    struct PositionSnapshot has copy, drop {
        position_id: 0x2::object::ID,
        pause: PauseSnapshot,
        market_state_id: 0x2::object::ID,
        expiry: u64,
        created_at: u64,
        pt_balance: u64,
        yt_balance: u64,
        yt_reward_guard: u64,
        index: u128,
        py_index: u128,
        accrued: u128,
        is_py_empty: bool,
        pool_id: 0x2::object::ID,
        lp_amount: u64,
        lp_reward_guard: u64,
        is_lp_empty: bool,
    }

    struct RewardDistributorSnapshot has copy, drop {
        distributor_id: 0x2::object::ID,
        pause: PauseSnapshot,
        enabled: bool,
        config_version: u64,
        yt_rewarder_count: u64,
        lp_rewarder_count: u64,
        pool_rewarder_count: u64,
    }

    fun assert_market_state_view_active<T0: drop, T1: drop, T2: drop>(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>) {
        0xbcbd0933e68a1af594d5f5338eaa43ca3653450d4acaf89843436c04e3f841db::package_version::assert_market_state_active(arg0, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg1));
    }

    public fun assert_max_slippage_bps(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: u64, arg2: u64) {
        0xbcbd0933e68a1af594d5f5338eaa43ca3653450d4acaf89843436c04e3f841db::package_version::assert_current(arg0);
        assert!(arg1 <= arg2, 3101);
    }

    public fun assert_swap_pt_for_sy_guardrail(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: u128, arg2: u64, arg3: u64, arg4: u64) {
        0xbcbd0933e68a1af594d5f5338eaa43ca3653450d4acaf89843436c04e3f841db::package_version::assert_current(arg0);
        assert_max_slippage_bps(arg0, calc_swap_pt_for_sy_slippage_bps(arg0, arg1, arg2, arg3), arg4);
    }

    public fun assert_swap_sy_for_exact_pt_guardrail(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: u128, arg2: u64, arg3: u64, arg4: u64) {
        0xbcbd0933e68a1af594d5f5338eaa43ca3653450d4acaf89843436c04e3f841db::package_version::assert_current(arg0);
        assert_max_slippage_bps(arg0, calc_swap_sy_for_pt_slippage_bps(arg0, arg1, arg2, arg3), arg4);
    }

    public fun assert_swap_sy_for_pt_guardrail<T0: drop>(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: u128, arg2: u64, arg3: u64, arg4: &0x2::coin::Coin<T0>, arg5: u64) {
        0xbcbd0933e68a1af594d5f5338eaa43ca3653450d4acaf89843436c04e3f841db::package_version::assert_current(arg0);
        assert_max_slippage_bps(arg0, calc_swap_sy_for_pt_slippage_bps(arg0, arg1, used_amount_from_change<T0>(arg0, arg2, arg4), arg3), arg5);
    }

    public fun assert_swap_sy_for_yt_guardrail<T0: drop>(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: u128, arg2: u64, arg3: u64, arg4: &0x2::coin::Coin<T0>, arg5: u64) {
        0xbcbd0933e68a1af594d5f5338eaa43ca3653450d4acaf89843436c04e3f841db::package_version::assert_current(arg0);
        assert_max_slippage_bps(arg0, calc_swap_sy_for_yt_slippage_bps(arg0, arg1, used_amount_from_change<T0>(arg0, arg2, arg4), arg3), arg5);
    }

    fun calc_market_state_sy_amount_for_py_floor<T0: drop, T1: drop, T2: drop>(arg0: u64, arg1: u128, arg2: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>) : u64 {
        if (arg0 == 0) {
            return 0
        };
        (((((arg0 as u128) * 18446744073709551616) as u256) * (18446744073709551616 as u256) / (0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::current_py_index_raw<T0, T1, T2>(arg1, arg2) as u256) / (18446744073709551616 as u256)) as u64)
    }

    public fun calc_swap_pt_for_sy_slippage_bps(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: u128, arg2: u64, arg3: u64) : u64 {
        0xbcbd0933e68a1af594d5f5338eaa43ca3653450d4acaf89843436c04e3f841db::package_version::assert_current(arg0);
        let v0 = if (arg1 > 0) {
            if (arg2 > 0) {
                arg3 > 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 3100);
        let v1 = 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::full_math_u128::mul_div_floor((arg3 as u128), 18446744073709551616, (arg2 as u128));
        if (v1 >= arg1) {
            return 0
        };
        (0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::full_math_u128::mul_div_ceil(arg1 - v1, 10000, arg1) as u64)
    }

    public fun calc_swap_sy_for_pt_slippage_bps(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: u128, arg2: u64, arg3: u64) : u64 {
        0xbcbd0933e68a1af594d5f5338eaa43ca3653450d4acaf89843436c04e3f841db::package_version::assert_current(arg0);
        let v0 = if (arg1 > 0) {
            if (arg2 > 0) {
                arg3 > 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 3100);
        let v1 = 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::full_math_u128::mul_div_ceil((arg2 as u128), 18446744073709551616, (arg3 as u128));
        if (v1 <= arg1) {
            return 0
        };
        (0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::full_math_u128::mul_div_ceil(v1 - arg1, 10000, arg1) as u64)
    }

    public fun calc_swap_sy_for_yt_slippage_bps(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: u128, arg2: u64, arg3: u64) : u64 {
        0xbcbd0933e68a1af594d5f5338eaa43ca3653450d4acaf89843436c04e3f841db::package_version::assert_current(arg0);
        let v0 = if (arg1 > 0) {
            if (arg2 > 0) {
                arg3 > 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 3100);
        let v1 = 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::full_math_u128::mul_div_ceil((arg2 as u128), 18446744073709551616, (arg3 as u128));
        if (v1 <= arg1) {
            return 0
        };
        (0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::full_math_u128::mul_div_ceil(v1 - arg1, 10000, arg1) as u64)
    }

    public fun calc_swap_yt_for_sy_slippage_bps(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: u128, arg2: u64, arg3: u64) : u64 {
        0xbcbd0933e68a1af594d5f5338eaa43ca3653450d4acaf89843436c04e3f841db::package_version::assert_current(arg0);
        calc_swap_pt_for_sy_slippage_bps(arg0, arg1, arg2, arg3)
    }

    fun calc_user_accrued(arg0: u128, arg1: u64, arg2: u128, arg3: u128) : u128 {
        if (arg3 == 0 || arg2 <= arg3) {
            return arg0
        };
        arg0 + (arg1 as u128) * (arg2 - arg3)
    }

    public fun estimate_market_state_claimable_interest<T0: drop, T1: drop, T2: drop>(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition, arg2: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>) : u64 {
        assert_market_state_view_active<T0, T1, T2>(arg0, arg2);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::assert_market_state_match(arg1, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg2));
        let v0 = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::snapshot<T0, T1, T2>(arg2);
        0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64::truncate(0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64::create_from_raw_value(calc_user_accrued(0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::accrued(arg1), 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::yt_balance(arg1), 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::snapshot_global_interest_index(&v0), 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::index(arg1))))
    }

    public fun estimate_market_state_lp_value<T0: drop, T1: drop, T2: drop>(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: u64, arg2: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>) : (u64, u64) {
        assert_market_state_view_active<T0, T1, T2>(arg0, arg2);
        let v0 = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::lp_supply<T0, T1, T2>(arg2);
        if (v0 == 0 || arg1 == 0) {
            return (0, 0)
        };
        ((((arg1 as u128) * (0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::total_pool_sy<T0, T1, T2>(arg2) as u128) / (v0 as u128)) as u64), (((arg1 as u128) * (0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::total_pool_pt<T0, T1, T2>(arg2) as u128) / (v0 as u128)) as u64))
    }

    public fun estimate_market_state_pt_price<T0: drop, T1: drop, T2: drop>(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg2: u128, arg3: &0x2::clock::Clock) : u128 {
        assert_market_state_view_active<T0, T1, T2>(arg0, arg1);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::spot_pt_price_in_sy<T0, T1, T2>(arg1, arg2, arg3)
    }

    public fun estimate_market_state_remove_lp_to_sy<T0: drop, T1: drop, T2: drop>(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: u64, arg2: u128, arg3: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg4: &0x2::clock::Clock) : (u8, u64, u64, u64, u64, u64, u64) {
        assert_market_state_view_active<T0, T1, T2>(arg0, arg3);
        let (v0, v1, v2, v3, v4, v5) = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::quote_remove_liquidity_to_sy<T0, T1, T2>(arg1, arg3, arg2, arg4);
        let v6 = if (v0 == 1) {
            calc_swap_pt_for_sy_slippage_bps(arg0, estimate_market_state_pt_price<T0, T1, T2>(arg0, arg3, arg2, arg4), v2, v3)
        } else {
            0
        };
        (v0, v1, v2, v3, v4, v5, v6)
    }

    public fun estimate_market_state_swap_pt_for_exact_sy<T0: drop, T1: drop, T2: drop>(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: u64, arg2: u128, arg3: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg4: &0x2::clock::Clock) : u64 {
        assert_market_state_view_active<T0, T1, T2>(arg0, arg3);
        let (v0, _) = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::quote_pt_for_exact_sy<T0, T1, T2>(arg1, arg3, arg2, arg4);
        v0
    }

    public fun estimate_market_state_swap_pt_for_exact_sy_slippage_bps<T0: drop, T1: drop, T2: drop>(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: u64, arg2: u128, arg3: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg4: &0x2::clock::Clock) : u64 {
        assert_market_state_view_active<T0, T1, T2>(arg0, arg3);
        calc_swap_pt_for_sy_slippage_bps(arg0, estimate_market_state_pt_price<T0, T1, T2>(arg0, arg3, arg2, arg4), estimate_market_state_swap_pt_for_exact_sy<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4), arg1)
    }

    public fun estimate_market_state_swap_pt_for_sy<T0: drop, T1: drop, T2: drop>(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: u64, arg2: u128, arg3: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg4: &0x2::clock::Clock) : u64 {
        assert_market_state_view_active<T0, T1, T2>(arg0, arg3);
        let (v0, _) = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::quote_exact_pt_for_sy<T0, T1, T2>(arg1, arg3, arg2, arg4);
        v0
    }

    public fun estimate_market_state_swap_pt_for_sy_slippage_bps<T0: drop, T1: drop, T2: drop>(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: u64, arg2: u128, arg3: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg4: &0x2::clock::Clock) : u64 {
        assert_market_state_view_active<T0, T1, T2>(arg0, arg3);
        let (v0, _) = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::quote_exact_pt_for_sy<T0, T1, T2>(arg1, arg3, arg2, arg4);
        calc_swap_pt_for_sy_slippage_bps(arg0, estimate_market_state_pt_price<T0, T1, T2>(arg0, arg3, arg2, arg4), arg1, v0)
    }

    public fun estimate_market_state_swap_sy_for_exact_pt<T0: drop, T1: drop, T2: drop>(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: u64, arg2: u128, arg3: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg4: &0x2::clock::Clock) : u64 {
        assert_market_state_view_active<T0, T1, T2>(arg0, arg3);
        let (v0, _) = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::quote_sy_for_exact_pt<T0, T1, T2>(arg1, arg3, arg2, arg4);
        v0
    }

    public fun estimate_market_state_swap_sy_for_exact_pt_slippage_bps<T0: drop, T1: drop, T2: drop>(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: u64, arg2: u128, arg3: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg4: &0x2::clock::Clock) : u64 {
        assert_market_state_view_active<T0, T1, T2>(arg0, arg3);
        calc_swap_sy_for_pt_slippage_bps(arg0, estimate_market_state_pt_price<T0, T1, T2>(arg0, arg3, arg2, arg4), estimate_market_state_swap_sy_for_exact_pt<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4), arg1)
    }

    public fun estimate_market_state_swap_sy_for_exact_yt<T0: drop, T1: drop, T2: drop>(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: u64, arg2: u128, arg3: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg4: &0x2::clock::Clock) : (u64, u64, u64, u64) {
        assert_market_state_view_active<T0, T1, T2>(arg0, arg3);
        let (v0, v1, v2, v3) = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::quote_sy_for_exact_yt<T0, T1, T2>(arg1, arg3, arg2, arg4);
        assert!(v0 > 0 && v3 != 18446744073709551615, 3102);
        (v0, v1, v2, v3)
    }

    public fun estimate_market_state_swap_sy_for_exact_yt_slippage_bps<T0: drop, T1: drop, T2: drop>(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: u64, arg2: u128, arg3: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg4: &0x2::clock::Clock) : u64 {
        assert_market_state_view_active<T0, T1, T2>(arg0, arg3);
        let (v0, _, _, v3) = estimate_market_state_swap_sy_for_exact_yt<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4);
        calc_swap_sy_for_yt_slippage_bps(arg0, estimate_market_state_yt_price<T0, T1, T2>(arg0, arg2, arg3, arg4), v3, v0)
    }

    public fun estimate_market_state_swap_sy_for_pt<T0: drop, T1: drop, T2: drop>(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: u64, arg2: u128, arg3: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg4: &0x2::clock::Clock) : u64 {
        assert_market_state_view_active<T0, T1, T2>(arg0, arg3);
        let (v0, _) = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::quote_exact_sy_for_pt<T0, T1, T2>(arg1, arg3, arg2, arg4);
        v0
    }

    public fun estimate_market_state_swap_sy_for_pt_slippage_bps<T0: drop, T1: drop, T2: drop>(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: u64, arg2: u128, arg3: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg4: &0x2::clock::Clock) : u64 {
        assert_market_state_view_active<T0, T1, T2>(arg0, arg3);
        let (v0, v1) = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::quote_exact_sy_for_pt<T0, T1, T2>(arg1, arg3, arg2, arg4);
        calc_swap_sy_for_pt_slippage_bps(arg0, estimate_market_state_pt_price<T0, T1, T2>(arg0, arg3, arg2, arg4), v1, v0)
    }

    public fun estimate_market_state_swap_sy_for_yt<T0: drop, T1: drop, T2: drop>(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: u64, arg2: u128, arg3: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg4: &0x2::clock::Clock) : (u64, u64) {
        assert_market_state_view_active<T0, T1, T2>(arg0, arg3);
        let (v0, v1) = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::quote_exact_sy_for_yt<T0, T1, T2>(arg1, arg3, arg2, arg4);
        let v2 = if (arg1 > v1) {
            arg1 - v1
        } else {
            0
        };
        (v0, v2)
    }

    public fun estimate_market_state_swap_sy_for_yt_slippage_bps<T0: drop, T1: drop, T2: drop>(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: u64, arg2: u128, arg3: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg4: &0x2::clock::Clock) : u64 {
        assert_market_state_view_active<T0, T1, T2>(arg0, arg3);
        let (v0, v1) = estimate_market_state_swap_sy_for_yt<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4);
        let v2 = if (arg1 > v1) {
            arg1 - v1
        } else {
            0
        };
        calc_swap_sy_for_yt_slippage_bps(arg0, estimate_market_state_yt_price<T0, T1, T2>(arg0, arg2, arg3, arg4), v2, v0)
    }

    public fun estimate_market_state_swap_yt_for_exact_sy<T0: drop, T1: drop, T2: drop>(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: u64, arg2: u64, arg3: u128, arg4: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg5: &0x2::clock::Clock) : (u64, u64, u64, u64) {
        assert_market_state_view_active<T0, T1, T2>(arg0, arg4);
        let (v0, v1, v2, v3) = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::quote_yt_for_exact_sy<T0, T1, T2>(arg1, arg2, arg4, arg3, arg5);
        assert!(v0 > 0 && v3 >= arg1, 3102);
        (v0, v1, v2, v3)
    }

    public fun estimate_market_state_swap_yt_for_exact_sy_slippage_bps<T0: drop, T1: drop, T2: drop>(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: u64, arg2: u64, arg3: u128, arg4: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg5: &0x2::clock::Clock) : u64 {
        let (v0, _, _, v3) = estimate_market_state_swap_yt_for_exact_sy<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5);
        calc_swap_yt_for_sy_slippage_bps(arg0, estimate_market_state_yt_price<T0, T1, T2>(arg0, arg3, arg4, arg5), v0, v3)
    }

    public fun estimate_market_state_swap_yt_for_sy<T0: drop, T1: drop, T2: drop>(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: u64, arg2: u128, arg3: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg4: &0x2::clock::Clock) : (u64, u64, u64) {
        assert_market_state_view_active<T0, T1, T2>(arg0, arg3);
        let v0 = calc_market_state_sy_amount_for_py_floor<T0, T1, T2>(arg1, arg2, arg3);
        let v1 = estimate_market_state_swap_sy_for_exact_pt<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4);
        let v2 = if (v0 > v1) {
            v0 - v1
        } else {
            0
        };
        (v2, v0, v1)
    }

    public fun estimate_market_state_swap_yt_for_sy_slippage_bps<T0: drop, T1: drop, T2: drop>(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: u64, arg2: u128, arg3: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg4: &0x2::clock::Clock) : u64 {
        assert_market_state_view_active<T0, T1, T2>(arg0, arg3);
        let (v0, _, _) = estimate_market_state_swap_yt_for_sy<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4);
        calc_swap_yt_for_sy_slippage_bps(arg0, estimate_market_state_yt_price<T0, T1, T2>(arg0, arg2, arg3, arg4), arg1, v0)
    }

    public fun estimate_market_state_yt_price<T0: drop, T1: drop, T2: drop>(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: u128, arg2: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg3: &0x2::clock::Clock) : u128 {
        assert_market_state_view_active<T0, T1, T2>(arg0, arg2);
        let v0 = 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::full_math_u128::mul_div_floor(18446744073709551616, 18446744073709551616, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::current_py_index_raw<T0, T1, T2>(arg1, arg2));
        let v1 = estimate_market_state_pt_price<T0, T1, T2>(arg0, arg2, arg1, arg3);
        if (v0 > v1) {
            v0 - v1
        } else {
            0
        }
    }

    public fun is_market_state_expired<T0: drop, T1: drop, T2: drop>(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg2: &0x2::clock::Clock) : bool {
        0xbcbd0933e68a1af594d5f5338eaa43ca3653450d4acaf89843436c04e3f841db::package_version::assert_current_version(arg0);
        0xbcbd0933e68a1af594d5f5338eaa43ca3653450d4acaf89843436c04e3f841db::package_version::assert_core_version(arg0);
        let v0 = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::snapshot<T0, T1, T2>(arg1);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::snapshot_expiry(&v0) <= 0x2::clock::timestamp_ms(arg2)
    }

    fun market_state_pause_snapshot(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: 0x2::object::ID) : PauseSnapshot {
        let v0 = 0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::global_paused(arg0);
        let v1 = 0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::package_paused<0xbcbd0933e68a1af594d5f5338eaa43ca3653450d4acaf89843436c04e3f841db::package_version::PackageMarker>(arg0);
        let v2 = 0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::package_paused<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::package_version::PackageMarker>(arg0);
        let v3 = 0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::domain_paused(arg0, b"market");
        let v4 = 0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::target_paused(arg0, b"market", arg1);
        let v5 = if (v0) {
            true
        } else if (v1) {
            true
        } else if (v2) {
            true
        } else if (v3) {
            true
        } else {
            v4
        };
        PauseSnapshot{
            global_paused       : v0,
            view_package_paused : v1,
            core_package_paused : v2,
            domain_paused       : v3,
            target_paused       : v4,
            paused              : v5,
        }
    }

    public fun market_state_snapshot<T0: drop, T1: drop, T2: drop>(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg2: u128, arg3: &0x2::clock::Clock) : MarketViewSnapshot {
        0xbcbd0933e68a1af594d5f5338eaa43ca3653450d4acaf89843436c04e3f841db::package_version::assert_current_version(arg0);
        0xbcbd0933e68a1af594d5f5338eaa43ca3653450d4acaf89843436c04e3f841db::package_version::assert_core_version(arg0);
        let v0 = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::snapshot<T0, T1, T2>(arg1);
        let v1 = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::snapshot_market_state_id(&v0);
        let v2 = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::reward_distributor_required<T0, T1, T2>(arg1);
        let v3 = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::snapshot_pool_sy_balance(&v0);
        let v4 = if (v2) {
            0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::reward_distributor_id<T0, T1, T2>(arg1)
        } else {
            0x2::object::id_from_address(@0x0)
        };
        let v5 = RewardSnapshot{
            distributor_required : v2,
            distributor_id       : v4,
            pool_gate_open       : 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::pool_reward_gate_open<T0, T1, T2>(arg1),
            yt_gate_open         : 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::yt_reward_gate_open<T0, T1, T2>(arg1),
            yt_guard             : 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::snapshot_yt_reward_guard(&v0),
            lp_guard             : 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::snapshot_lp_reward_guard(&v0),
            pool_guard           : 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::snapshot_pool_reward_guard(&v0),
        };
        MarketViewSnapshot{
            market_state_id       : v1,
            pause                 : market_state_pause_snapshot(arg0, v1),
            expiry                : 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::snapshot_expiry(&v0),
            sy_treasury_id        : 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::snapshot_sy_treasury_id(&v0),
            pt_treasury_id        : 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::snapshot_pt_treasury_id(&v0),
            yt_treasury_id        : 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::snapshot_yt_treasury_id(&v0),
            sy_total_supply       : 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::snapshot_sy_total_supply(&v0),
            pt_total_supply       : 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::snapshot_pt_total_supply(&v0),
            yt_total_supply       : 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::snapshot_yt_total_supply(&v0),
            pt_supply             : 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::snapshot_pt_supply(&v0),
            yt_supply             : 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::snapshot_yt_supply(&v0),
            py_sy_balance         : 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::snapshot_py_sy_balance(&v0),
            py_index_stored       : 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::snapshot_py_index_stored(&v0),
            global_interest_index : 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::snapshot_global_interest_index(&v0),
            is_settled            : 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::snapshot_is_settled(&v0),
            settled_py_index      : 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::snapshot_settled_py_index(&v0),
            total_pt              : 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::snapshot_total_pt(&v0),
            pool_sy_balance       : v3,
            reserve_fee_balance   : 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::snapshot_reserve_fee_balance(&v0),
            lp_supply             : 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::snapshot_lp_supply(&v0),
            treasury              : 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::snapshot_treasury(&v0),
            interest_fee_rate     : 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::snapshot_interest_fee_rate(&v0),
            expiry_divisor        : 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::snapshot_expiry_divisor(&v0),
            market_cap            : 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::snapshot_market_cap(&v0),
            asset_market_cap      : 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::snapshot_asset_market_cap(&v0),
            asset_exposure        : 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64::truncate(0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64::create_from_raw_value(0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::full_math_u128::mul_div_floor((v3 as u128) * 18446744073709551616, arg2, 18446744073709551616))),
            reward                : v5,
            expired               : 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::snapshot_expiry(&v0) <= 0x2::clock::timestamp_ms(arg3),
        }
    }

    fun package_pause_snapshot(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig) : PauseSnapshot {
        let v0 = 0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::global_paused(arg0);
        let v1 = 0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::package_paused<0xbcbd0933e68a1af594d5f5338eaa43ca3653450d4acaf89843436c04e3f841db::package_version::PackageMarker>(arg0);
        let v2 = 0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::package_paused<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::package_version::PackageMarker>(arg0);
        let v3 = if (v0) {
            true
        } else if (v1) {
            true
        } else {
            v2
        };
        PauseSnapshot{
            global_paused       : v0,
            view_package_paused : v1,
            core_package_paused : v2,
            domain_paused       : false,
            target_paused       : false,
            paused              : v3,
        }
    }

    public fun position_snapshot(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition) : PositionSnapshot {
        0xbcbd0933e68a1af594d5f5338eaa43ca3653450d4acaf89843436c04e3f841db::package_version::assert_current_version(arg0);
        0xbcbd0933e68a1af594d5f5338eaa43ca3653450d4acaf89843436c04e3f841db::package_version::assert_core_version(arg0);
        PositionSnapshot{
            position_id     : 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::id(arg1),
            pause           : market_state_pause_snapshot(arg0, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::market_state_id(arg1)),
            market_state_id : 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::market_state_id(arg1),
            expiry          : 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::expiry(arg1),
            created_at      : 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::created_at(arg1),
            pt_balance      : 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::pt_balance(arg1),
            yt_balance      : 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::yt_balance(arg1),
            yt_reward_guard : 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::yt_reward_guard(arg1),
            index           : 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::index(arg1),
            py_index        : 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::py_index(arg1),
            accrued         : 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::accrued(arg1),
            is_py_empty     : 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::is_py_empty(arg1),
            pool_id         : 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::pool_id(arg1),
            lp_amount       : 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::lp_amount(arg1),
            lp_reward_guard : 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::lp_reward_guard(arg1),
            is_lp_empty     : 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::is_lp_empty(arg1),
        }
    }

    public fun reward_distributor_snapshot(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardDistributor) : RewardDistributorSnapshot {
        0xbcbd0933e68a1af594d5f5338eaa43ca3653450d4acaf89843436c04e3f841db::package_version::assert_current_version(arg0);
        0xbcbd0933e68a1af594d5f5338eaa43ca3653450d4acaf89843436c04e3f841db::package_version::assert_core_version(arg0);
        RewardDistributorSnapshot{
            distributor_id      : 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::id(arg1),
            pause               : package_pause_snapshot(arg0),
            enabled             : 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::enabled(arg1),
            config_version      : 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::config_version(arg1),
            yt_rewarder_count   : 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::rewarder_count(arg1, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::yt_scope()),
            lp_rewarder_count   : 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::rewarder_count(arg1, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::lp_scope()),
            pool_rewarder_count : 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::rewarder_count(arg1, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::pool_scope()),
        }
    }

    public fun used_amount_from_change<T0: drop>(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: u64, arg2: &0x2::coin::Coin<T0>) : u64 {
        0xbcbd0933e68a1af594d5f5338eaa43ca3653450d4acaf89843436c04e3f841db::package_version::assert_current(arg0);
        let v0 = 0x2::coin::value<T0>(arg2);
        assert!(arg1 >= v0, 3100);
        arg1 - v0
    }

    // decompiled from Move bytecode v7
}

