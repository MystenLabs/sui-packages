module 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::offchain {
    struct MarketSnapshot has copy, drop {
        market_id: 0x2::object::ID,
        expiry: u64,
        sy_treasury_id: 0x2::object::ID,
        pt_treasury_id: 0x2::object::ID,
        yt_treasury_id: 0x2::object::ID,
        sy_total_supply: u64,
        pt_total_supply: u64,
        yt_total_supply: u64,
    }

    struct PoolSnapshot has copy, drop {
        pool_id: 0x2::object::ID,
        py_state_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        expiry: u64,
        total_pt: u64,
        total_sy: u64,
        reward_guard: u64,
        reserve_fee_amount: u64,
        lp_supply: u64,
        last_ln_implied_rate_raw: u128,
        scalar_root_value: u128,
        scalar_root_positive: bool,
        initial_anchor_value: u128,
        initial_anchor_positive: bool,
        treasury: address,
        protocol_fee_rate_raw: u128,
        market_cap: u64,
        asset_market_cap: u64,
        asset_exposure: u64,
        reward_distributor_required: bool,
        reward_distributor_id: 0x2::object::ID,
        reward_gate_open: bool,
    }

    struct PyStateSnapshot has copy, drop {
        state_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        expiry: u64,
        interest_fee_rate: u128,
        expiry_divisor: u64,
        treasury: address,
        pt_supply: u64,
        yt_supply: u64,
        sy_balance_value: u64,
        py_index_stored: u128,
        global_interest_index: u128,
        total_treasury_interest: u128,
        is_settled: bool,
        settled_py_index: u128,
        py_index_last_updated: u64,
        last_interest_timestamp: u64,
        last_collect_interest_index: u128,
        yt_reward_distributor_required: bool,
        yt_reward_distributor_id: 0x2::object::ID,
        yt_reward_gate_open: bool,
        expired: bool,
    }

    struct PositionSnapshot has copy, drop {
        position_id: 0x2::object::ID,
        py_state_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
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
        enabled: bool,
        config_version: u64,
        yt_rewarder_count: u64,
        lp_rewarder_count: u64,
        pool_rewarder_count: u64,
    }

    public fun assert_max_slippage_bps(arg0: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::GlobalConfig, arg1: u64, arg2: u64) {
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::assert_current(arg0);
        assert!(arg1 <= arg2, 3101);
    }

    public fun assert_swap_pt_for_sy_guardrail(arg0: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::GlobalConfig, arg1: u128, arg2: u64, arg3: u64, arg4: u64) {
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::assert_current(arg0);
        assert_max_slippage_bps(arg0, calc_swap_pt_for_sy_slippage_bps(arg0, arg1, arg2, arg3), arg4);
    }

    public fun assert_swap_sy_for_exact_pt_guardrail(arg0: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::GlobalConfig, arg1: u128, arg2: u64, arg3: u64, arg4: u64) {
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::assert_current(arg0);
        assert_max_slippage_bps(arg0, calc_swap_sy_for_pt_slippage_bps(arg0, arg1, arg2, arg3), arg4);
    }

    public fun assert_swap_sy_for_pt_guardrail<T0: drop>(arg0: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::GlobalConfig, arg1: u128, arg2: u64, arg3: u64, arg4: &0x2::coin::Coin<T0>, arg5: u64) {
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::assert_current(arg0);
        assert_max_slippage_bps(arg0, calc_swap_sy_for_pt_slippage_bps(arg0, arg1, used_amount_from_change<T0>(arg0, arg2, arg4), arg3), arg5);
    }

    public fun assert_swap_sy_for_yt_guardrail<T0: drop>(arg0: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::GlobalConfig, arg1: u128, arg2: u64, arg3: u64, arg4: &0x2::coin::Coin<T0>, arg5: u64) {
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::assert_current(arg0);
        assert_max_slippage_bps(arg0, calc_swap_sy_for_yt_slippage_bps(arg0, arg1, used_amount_from_change<T0>(arg0, arg2, arg4), arg3), arg5);
    }

    fun buy_yt_net_sy_for_amount<T0: drop>(arg0: u64, arg1: u64, arg2: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::Pool<T0>, arg3: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::PyState<T0>, arg4: u128, arg5: &0x2::clock::Clock) : (u64, u64, u64, u64) {
        if (arg0 == 0) {
            return (18446744073709551615, 0, 0, 0)
        };
        let v0 = 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::calc_sy_amount_for_py<T0>(arg0, arg4, arg3);
        if (v0 == 0) {
            return (18446744073709551615, v0, 0, 0)
        };
        let v1 = if (v0 > arg1) {
            v0 - arg1
        } else {
            0
        };
        if (v1 >= 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::total_sy<T0>(arg2)) {
            return (18446744073709551615, v0, v1, 0)
        };
        let v2 = quote_pt_sale_after_sy_borrow<T0>(arg0, v1, arg2, arg4, arg5);
        if (v2 < v1) {
            return (18446744073709551615, v0, v1, v2)
        };
        let v3 = if (v0 > v2) {
            v0 - v2
        } else {
            0
        };
        (v3, v0, v1, v2)
    }

    public fun calc_swap_pt_for_sy_slippage_bps(arg0: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::GlobalConfig, arg1: u128, arg2: u64, arg3: u64) : u64 {
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::assert_current(arg0);
        let v0 = if (arg1 == 0) {
            true
        } else if (arg2 == 0) {
            true
        } else {
            arg3 == 0
        };
        if (v0) {
            return 0
        };
        let v1 = 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::full_math_u128::mul_div_floor((arg3 as u128), 18446744073709551616, (arg2 as u128));
        if (v1 >= arg1) {
            return 0
        };
        (0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::full_math_u128::mul_div_floor(arg1 - v1, 10000, arg1) as u64)
    }

    public fun calc_swap_sy_for_pt_slippage_bps(arg0: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::GlobalConfig, arg1: u128, arg2: u64, arg3: u64) : u64 {
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::assert_current(arg0);
        let v0 = if (arg1 == 0) {
            true
        } else if (arg2 == 0) {
            true
        } else {
            arg3 == 0
        };
        if (v0) {
            return 0
        };
        let v1 = 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::full_math_u128::mul_div_ceil((arg2 as u128), 18446744073709551616, (arg3 as u128));
        if (v1 <= arg1) {
            return 0
        };
        (0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::full_math_u128::mul_div_floor(v1 - arg1, 10000, arg1) as u64)
    }

    public fun calc_swap_sy_for_yt_slippage_bps(arg0: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::GlobalConfig, arg1: u128, arg2: u64, arg3: u64) : u64 {
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::assert_current(arg0);
        let v0 = if (arg1 == 0) {
            true
        } else if (arg2 == 0) {
            true
        } else {
            arg3 == 0
        };
        if (v0) {
            return 0
        };
        let v1 = 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::full_math_u128::mul_div_ceil((arg2 as u128), 18446744073709551616, (arg3 as u128));
        if (v1 <= arg1) {
            return 0
        };
        (0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::full_math_u128::mul_div_floor(v1 - arg1, 10000, arg1) as u64)
    }

    public fun calc_swap_yt_for_sy_slippage_bps(arg0: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::GlobalConfig, arg1: u128, arg2: u64, arg3: u64) : u64 {
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::assert_current(arg0);
        calc_swap_pt_for_sy_slippage_bps(arg0, arg1, arg2, arg3)
    }

    fun calc_sy_amount_for_py_floor<T0: drop>(arg0: u64, arg1: u128, arg2: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::PyState<T0>) : u64 {
        if (arg0 == 0) {
            return 0
        };
        ((0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::asset_to_sy(0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::current_py_index(arg1, 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::py_index_stored<T0>(arg2)), (arg0 as u128) * 18446744073709551616) / 18446744073709551616) as u64)
    }

    public fun estimate_claimable_interest<T0: drop>(arg0: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::GlobalConfig, arg1: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::JitterPosition, arg2: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::PyState<T0>) : u64 {
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::assert_current(arg0);
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::assert_state_match(arg1, 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::state_id<T0>(arg2));
        0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64::truncate(0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64::create_from_raw_value(0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::calc_user_accrued(0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::accrued(arg1), 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::yt_balance(arg1), 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::global_interest_index<T0>(arg2), 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::index(arg1))))
    }

    public fun estimate_lp_value<T0: drop>(arg0: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::GlobalConfig, arg1: u64, arg2: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::Pool<T0>) : (u64, u64) {
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::assert_current(arg0);
        let v0 = 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::lp_supply<T0>(arg2);
        if (v0 == 0 || arg1 == 0) {
            return (0, 0)
        };
        ((((arg1 as u128) * (0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::total_sy<T0>(arg2) as u128) / (v0 as u128)) as u64), (((arg1 as u128) * (0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::total_pt<T0>(arg2) as u128) / (v0 as u128)) as u64))
    }

    public fun estimate_pt_price<T0: drop>(arg0: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::GlobalConfig, arg1: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::Pool<T0>, arg2: u128, arg3: &0x2::clock::Clock) : u128 {
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::assert_current(arg0);
        let v0 = 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::total_sy<T0>(arg1);
        let v1 = 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::total_pt<T0>(arg1);
        if (v1 == 0 || v0 == 0) {
            return 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64::get_raw_value(0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64::one())
        };
        let v2 = 0x2::clock::timestamp_ms(arg3);
        if (0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::expiry<T0>(arg1) <= v2) {
            return 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64::get_raw_value(0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64::one())
        };
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::amm_math::spot_pt_price_in_sy_indexed(v1, v0, arg2, 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::last_ln_implied_rate<T0>(arg1), 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::scalar_root<T0>(arg1), 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::initial_anchor<T0>(arg1), 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::expiry<T0>(arg1) - v2)
    }

    public fun estimate_swap_pt_for_exact_sy<T0: drop>(arg0: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::GlobalConfig, arg1: u64, arg2: u128, arg3: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::Pool<T0>, arg4: &0x2::clock::Clock) : u64 {
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::assert_current(arg0);
        let v0 = 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::total_sy<T0>(arg3);
        let v1 = 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::total_pt<T0>(arg3);
        let v2 = if (v0 == 0) {
            true
        } else if (v1 == 0) {
            true
        } else {
            arg1 >= v0
        };
        if (v2) {
            return 0
        };
        let v3 = 0x2::clock::timestamp_ms(arg4);
        if (0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::expiry<T0>(arg3) <= v3) {
            return 0
        };
        let (v4, _, _) = 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::amm_math::quote_pt_for_exact_sy_indexed(v1, v0, arg2, 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::last_ln_implied_rate<T0>(arg3), 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::scalar_root<T0>(arg3), 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::initial_anchor<T0>(arg3), 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::ln_fee_rate_root<T0>(arg3), arg1, 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::expiry<T0>(arg3) - v3);
        v4
    }

    public fun estimate_swap_pt_for_exact_sy_slippage_bps<T0: drop>(arg0: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::GlobalConfig, arg1: u64, arg2: u128, arg3: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::Pool<T0>, arg4: &0x2::clock::Clock) : u64 {
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::assert_current(arg0);
        calc_swap_pt_for_sy_slippage_bps(arg0, estimate_pt_price<T0>(arg0, arg3, arg2, arg4), estimate_swap_pt_for_exact_sy<T0>(arg0, arg1, arg2, arg3, arg4), arg1)
    }

    public fun estimate_swap_pt_for_sy<T0: drop>(arg0: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::GlobalConfig, arg1: u64, arg2: u128, arg3: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::Pool<T0>, arg4: &0x2::clock::Clock) : u64 {
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::assert_current(arg0);
        let v0 = 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::total_sy<T0>(arg3);
        let v1 = 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::total_pt<T0>(arg3);
        if (v0 == 0 || v1 == 0) {
            return 0
        };
        let v2 = 0x2::clock::timestamp_ms(arg4);
        if (0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::expiry<T0>(arg3) <= v2) {
            return 0
        };
        let (v3, _, _) = 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::amm_math::quote_exact_pt_for_sy_indexed(v1, v0, arg2, 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::last_ln_implied_rate<T0>(arg3), 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::scalar_root<T0>(arg3), 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::initial_anchor<T0>(arg3), 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::ln_fee_rate_root<T0>(arg3), arg1, 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::expiry<T0>(arg3) - v2);
        v3
    }

    public fun estimate_swap_pt_for_sy_slippage_bps<T0: drop>(arg0: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::GlobalConfig, arg1: u64, arg2: u128, arg3: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::Pool<T0>, arg4: &0x2::clock::Clock) : u64 {
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::assert_current(arg0);
        let v0 = 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::total_sy<T0>(arg3);
        let v1 = 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::total_pt<T0>(arg3);
        if (v0 == 0 || v1 == 0) {
            return 0
        };
        let v2 = 0x2::clock::timestamp_ms(arg4);
        if (0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::expiry<T0>(arg3) <= v2) {
            return 0
        };
        let (v3, _, _) = 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::amm_math::quote_exact_pt_for_sy_indexed(v1, v0, arg2, 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::last_ln_implied_rate<T0>(arg3), 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::scalar_root<T0>(arg3), 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::initial_anchor<T0>(arg3), 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::ln_fee_rate_root<T0>(arg3), arg1, 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::expiry<T0>(arg3) - v2);
        calc_swap_pt_for_sy_slippage_bps(arg0, estimate_pt_price<T0>(arg0, arg3, arg2, arg4), arg1, v3)
    }

    public fun estimate_swap_sy_for_exact_pt<T0: drop>(arg0: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::GlobalConfig, arg1: u64, arg2: u128, arg3: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::Pool<T0>, arg4: &0x2::clock::Clock) : u64 {
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::assert_current(arg0);
        let v0 = 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::total_sy<T0>(arg3);
        let v1 = 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::total_pt<T0>(arg3);
        let v2 = if (v0 == 0) {
            true
        } else if (v1 == 0) {
            true
        } else {
            arg1 >= v1
        };
        if (v2) {
            return 0
        };
        let v3 = 0x2::clock::timestamp_ms(arg4);
        if (0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::expiry<T0>(arg3) <= v3) {
            return 0
        };
        let (v4, _, _) = 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::amm_math::quote_sy_for_exact_pt_indexed(v1, v0, arg2, 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::last_ln_implied_rate<T0>(arg3), 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::scalar_root<T0>(arg3), 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::initial_anchor<T0>(arg3), 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::ln_fee_rate_root<T0>(arg3), arg1, 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::expiry<T0>(arg3) - v3);
        v4
    }

    public fun estimate_swap_sy_for_exact_pt_slippage_bps<T0: drop>(arg0: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::GlobalConfig, arg1: u64, arg2: u128, arg3: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::Pool<T0>, arg4: &0x2::clock::Clock) : u64 {
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::assert_current(arg0);
        calc_swap_sy_for_pt_slippage_bps(arg0, estimate_pt_price<T0>(arg0, arg3, arg2, arg4), estimate_swap_sy_for_exact_pt<T0>(arg0, arg1, arg2, arg3, arg4), arg1)
    }

    public fun estimate_swap_sy_for_exact_yt<T0: drop>(arg0: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::GlobalConfig, arg1: u64, arg2: u128, arg3: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::PyState<T0>, arg4: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::Pool<T0>, arg5: &0x2::clock::Clock) : (u64, u64, u64) {
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::assert_current(arg0);
        let (v0, v1, _, v3) = solve_net_sy_in_for_exact_yt<T0>(arg1, arg4, arg3, arg2, arg5);
        (v1, v3, v0)
    }

    public fun estimate_swap_sy_for_exact_yt_slippage_bps<T0: drop>(arg0: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::GlobalConfig, arg1: u64, arg2: u128, arg3: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::PyState<T0>, arg4: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::Pool<T0>, arg5: &0x2::clock::Clock) : u64 {
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::assert_current(arg0);
        let (_, _, v2) = estimate_swap_sy_for_exact_yt<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
        calc_swap_sy_for_yt_slippage_bps(arg0, estimate_yt_price<T0>(arg0, arg2, arg3, arg4, arg5), v2, arg1)
    }

    public fun estimate_swap_sy_for_pt<T0: drop>(arg0: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::GlobalConfig, arg1: u64, arg2: u128, arg3: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::Pool<T0>, arg4: &0x2::clock::Clock) : u64 {
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::assert_current(arg0);
        let v0 = 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::total_sy<T0>(arg3);
        let v1 = 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::total_pt<T0>(arg3);
        if (v0 == 0 || v1 == 0) {
            return 0
        };
        let v2 = 0x2::clock::timestamp_ms(arg4);
        if (0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::expiry<T0>(arg3) <= v2) {
            return 0
        };
        let (v3, _, _, _) = 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::amm_math::quote_exact_sy_for_pt_indexed(v1, v0, arg2, 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::last_ln_implied_rate<T0>(arg3), 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::scalar_root<T0>(arg3), 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::initial_anchor<T0>(arg3), 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::ln_fee_rate_root<T0>(arg3), arg1, 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::expiry<T0>(arg3) - v2);
        v3
    }

    public fun estimate_swap_sy_for_pt_slippage_bps<T0: drop>(arg0: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::GlobalConfig, arg1: u64, arg2: u128, arg3: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::Pool<T0>, arg4: &0x2::clock::Clock) : u64 {
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::assert_current(arg0);
        let v0 = 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::total_sy<T0>(arg3);
        let v1 = 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::total_pt<T0>(arg3);
        if (v0 == 0 || v1 == 0) {
            return 0
        };
        let v2 = 0x2::clock::timestamp_ms(arg4);
        if (0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::expiry<T0>(arg3) <= v2) {
            return 0
        };
        let (v3, v4, _, _) = 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::amm_math::quote_exact_sy_for_pt_indexed(v1, v0, arg2, 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::last_ln_implied_rate<T0>(arg3), 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::scalar_root<T0>(arg3), 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::initial_anchor<T0>(arg3), 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::ln_fee_rate_root<T0>(arg3), arg1, 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::expiry<T0>(arg3) - v2);
        calc_swap_sy_for_pt_slippage_bps(arg0, estimate_pt_price<T0>(arg0, arg3, arg2, arg4), v4, v3)
    }

    public fun estimate_swap_sy_for_yt<T0: drop>(arg0: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::GlobalConfig, arg1: u64, arg2: u128, arg3: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::PyState<T0>, arg4: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::Pool<T0>, arg5: &0x2::clock::Clock) : (u64, u64) {
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::assert_current(arg0);
        let v0 = solve_yt_out_for_net_sy_in<T0>(arg1, arg4, arg3, arg2, arg5);
        let (v1, _, _, _) = buy_yt_net_sy_for_amount<T0>(v0, arg1, arg4, arg3, arg2, arg5);
        let v5 = if (arg1 > v1) {
            arg1 - v1
        } else {
            0
        };
        (v0, v5)
    }

    public fun estimate_swap_sy_for_yt_slippage_bps<T0: drop>(arg0: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::GlobalConfig, arg1: u64, arg2: u128, arg3: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::PyState<T0>, arg4: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::Pool<T0>, arg5: &0x2::clock::Clock) : u64 {
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::assert_current(arg0);
        let (v0, v1) = estimate_swap_sy_for_yt<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
        let v2 = if (arg1 > v1) {
            arg1 - v1
        } else {
            0
        };
        calc_swap_sy_for_yt_slippage_bps(arg0, estimate_yt_price<T0>(arg0, arg2, arg3, arg4, arg5), v2, v0)
    }

    public fun estimate_swap_yt_for_sy<T0: drop>(arg0: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::GlobalConfig, arg1: u64, arg2: u128, arg3: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::PyState<T0>, arg4: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::Pool<T0>, arg5: &0x2::clock::Clock) : (u64, u64, u64) {
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::assert_current(arg0);
        let v0 = calc_sy_amount_for_py_floor<T0>(arg1, arg2, arg3);
        let v1 = estimate_swap_sy_for_exact_pt<T0>(arg0, arg1, arg2, arg4, arg5);
        let v2 = if (v0 > v1) {
            v0 - v1
        } else {
            0
        };
        (v2, v0, v1)
    }

    public fun estimate_swap_yt_for_sy_slippage_bps<T0: drop>(arg0: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::GlobalConfig, arg1: u64, arg2: u128, arg3: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::PyState<T0>, arg4: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::Pool<T0>, arg5: &0x2::clock::Clock) : u64 {
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::assert_current(arg0);
        let (v0, _, _) = estimate_swap_yt_for_sy<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
        calc_swap_yt_for_sy_slippage_bps(arg0, estimate_yt_price<T0>(arg0, arg2, arg3, arg4, arg5), arg1, v0)
    }

    public fun estimate_yt_price<T0: drop>(arg0: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::GlobalConfig, arg1: u128, arg2: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::PyState<T0>, arg3: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::Pool<T0>, arg4: &0x2::clock::Clock) : u128 {
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::assert_current(arg0);
        let v0 = 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::full_math_u128::mul_div_floor(18446744073709551616, 18446744073709551616, 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::current_py_index(arg1, 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::py_index_stored<T0>(arg2)));
        let v1 = estimate_pt_price<T0>(arg0, arg3, arg1, arg4);
        if (v0 > v1) {
            v0 - v1
        } else {
            0
        }
    }

    public fun is_market_expired<T0: drop>(arg0: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::GlobalConfig, arg1: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::Pool<T0>, arg2: &0x2::clock::Clock) : bool {
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::assert_current(arg0);
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::is_expired(0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::expiry<T0>(arg1), 0x2::clock::timestamp_ms(arg2))
    }

    public fun market_snapshot<T0: drop, T1: drop, T2: drop>(arg0: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::GlobalConfig, arg1: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::market::Market<T0, T1, T2>) : MarketSnapshot {
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::assert_current(arg0);
        MarketSnapshot{
            market_id       : 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::market::id<T0, T1, T2>(arg1),
            expiry          : 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::market::expiry<T0, T1, T2>(arg1),
            sy_treasury_id  : 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::market::sy_treasury_id<T0, T1, T2>(arg1),
            pt_treasury_id  : 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::market::pt_treasury_id<T0, T1, T2>(arg1),
            yt_treasury_id  : 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::market::yt_treasury_id<T0, T1, T2>(arg1),
            sy_total_supply : 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::market::sy_total_supply<T0, T1, T2>(arg1),
            pt_total_supply : 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::market::pt_total_supply<T0, T1, T2>(arg1),
            yt_total_supply : 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::market::yt_total_supply<T0, T1, T2>(arg1),
        }
    }

    public fun pool_snapshot<T0: drop>(arg0: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::GlobalConfig, arg1: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::Pool<T0>, arg2: u128) : PoolSnapshot {
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::assert_current(arg0);
        let v0 = 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::reward_distributor_required<T0>(arg1);
        let v1 = if (v0) {
            0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::reward_distributor_id<T0>(arg1)
        } else {
            0x2::object::id_from_address(@0x0)
        };
        PoolSnapshot{
            pool_id                     : 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::pool_id<T0>(arg1),
            py_state_id                 : 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::py_state_id<T0>(arg1),
            market_id                   : 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::market_id<T0>(arg1),
            expiry                      : 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::expiry<T0>(arg1),
            total_pt                    : 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::total_pt<T0>(arg1),
            total_sy                    : 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::total_sy<T0>(arg1),
            reward_guard                : 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::reward_guard<T0>(arg1),
            reserve_fee_amount          : 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::reserve_fee_amount<T0>(arg1),
            lp_supply                   : 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::lp_supply<T0>(arg1),
            last_ln_implied_rate_raw    : 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::last_ln_implied_rate_raw<T0>(arg1),
            scalar_root_value           : 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::scalar_root_value<T0>(arg1),
            scalar_root_positive        : 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::scalar_root_positive<T0>(arg1),
            initial_anchor_value        : 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::initial_anchor_value<T0>(arg1),
            initial_anchor_positive     : 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::initial_anchor_positive<T0>(arg1),
            treasury                    : 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::treasury<T0>(arg1),
            protocol_fee_rate_raw       : 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::protocol_fee_rate_raw<T0>(arg1),
            market_cap                  : 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::market_cap<T0>(arg1),
            asset_market_cap            : 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::asset_market_cap<T0>(arg1),
            asset_exposure              : 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::asset_exposure<T0>(arg1, arg2),
            reward_distributor_required : v0,
            reward_distributor_id       : v1,
            reward_gate_open            : 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::reward_gate_open<T0>(arg1),
        }
    }

    public fun position_snapshot(arg0: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::GlobalConfig, arg1: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::JitterPosition) : PositionSnapshot {
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::assert_current(arg0);
        PositionSnapshot{
            position_id     : 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::id(arg1),
            py_state_id     : 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::py_state_id(arg1),
            market_id       : 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::market_id(arg1),
            expiry          : 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::expiry(arg1),
            created_at      : 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::created_at(arg1),
            pt_balance      : 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::pt_balance(arg1),
            yt_balance      : 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::yt_balance(arg1),
            yt_reward_guard : 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::yt_reward_guard(arg1),
            index           : 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::index(arg1),
            py_index        : 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::py_index(arg1),
            accrued         : 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::accrued(arg1),
            is_py_empty     : 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::is_py_empty(arg1),
            pool_id         : 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::pool_id(arg1),
            lp_amount       : 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::lp_amount(arg1),
            lp_reward_guard : 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::lp_reward_guard(arg1),
            is_lp_empty     : 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::jitter_position::is_lp_empty(arg1),
        }
    }

    public fun py_state_snapshot<T0: drop>(arg0: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::GlobalConfig, arg1: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::PyState<T0>, arg2: &0x2::clock::Clock) : PyStateSnapshot {
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::assert_current(arg0);
        let v0 = 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::yt_reward_distributor_required<T0>(arg1);
        let v1 = if (v0) {
            0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::yt_reward_distributor_id<T0>(arg1)
        } else {
            0x2::object::id_from_address(@0x0)
        };
        PyStateSnapshot{
            state_id                       : 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::state_id<T0>(arg1),
            market_id                      : 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::market_id<T0>(arg1),
            expiry                         : 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::expiry<T0>(arg1),
            interest_fee_rate              : 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::interest_fee_rate<T0>(arg1),
            expiry_divisor                 : 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::expiry_divisor<T0>(arg1),
            treasury                       : 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::treasury<T0>(arg1),
            pt_supply                      : 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::pt_supply<T0>(arg1),
            yt_supply                      : 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::yt_supply<T0>(arg1),
            sy_balance_value               : 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::sy_balance_value<T0>(arg1),
            py_index_stored                : 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::py_index_stored<T0>(arg1),
            global_interest_index          : 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::global_interest_index<T0>(arg1),
            total_treasury_interest        : 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::total_treasury_interest<T0>(arg1),
            is_settled                     : 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::is_settled<T0>(arg1),
            settled_py_index               : 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::settled_py_index<T0>(arg1),
            py_index_last_updated          : 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::py_index_last_updated<T0>(arg1),
            last_interest_timestamp        : 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::last_interest_timestamp<T0>(arg1),
            last_collect_interest_index    : 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::last_collect_interest_index<T0>(arg1),
            yt_reward_distributor_required : v0,
            yt_reward_distributor_id       : v1,
            yt_reward_gate_open            : 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::yt_reward_gate_open<T0>(arg1),
            expired                        : 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::is_expired_state<T0>(arg1, arg2),
        }
    }

    fun quote_pt_sale_after_sy_borrow<T0: drop>(arg0: u64, arg1: u64, arg2: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::Pool<T0>, arg3: u128, arg4: &0x2::clock::Clock) : u64 {
        let v0 = 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::total_sy<T0>(arg2);
        if (arg0 == 0 || arg1 >= v0) {
            return 0
        };
        let v1 = 0x2::clock::timestamp_ms(arg4);
        if (0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::expiry<T0>(arg2) <= v1) {
            return 0
        };
        let (v2, _, _) = 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::amm_math::quote_exact_pt_for_sy_indexed(0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::total_pt<T0>(arg2), v0 - arg1, arg3, 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::last_ln_implied_rate<T0>(arg2), 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::scalar_root<T0>(arg2), 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::initial_anchor<T0>(arg2), 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::ln_fee_rate_root<T0>(arg2), arg0, 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::expiry<T0>(arg2) - v1);
        v2
    }

    public fun reward_distributor_snapshot(arg0: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::GlobalConfig, arg1: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::RewardDistributor) : RewardDistributorSnapshot {
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::assert_current(arg0);
        RewardDistributorSnapshot{
            distributor_id      : 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::id(arg1),
            enabled             : 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::enabled(arg1),
            config_version      : 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::config_version(arg1),
            yt_rewarder_count   : 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::rewarder_count(arg1, 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::yt_scope()),
            lp_rewarder_count   : 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::rewarder_count(arg1, 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::lp_scope()),
            pool_rewarder_count : 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::rewarder_count(arg1, 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::reward_distributor::pool_scope()),
        }
    }

    fun solve_net_sy_in_for_exact_yt<T0: drop>(arg0: u64, arg1: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::Pool<T0>, arg2: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::PyState<T0>, arg3: u128, arg4: &0x2::clock::Clock) : (u64, u64, u64, u64) {
        let v0 = 0;
        let v1 = 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::calc_sy_amount_for_py<T0>(arg0, arg3, arg2);
        let v2 = 0;
        while (v2 < 64 && v0 < v1) {
            let v3 = v0 + (v1 - v0) / 2;
            let (v4, _, _, _) = buy_yt_net_sy_for_amount<T0>(arg0, v3, arg1, arg2, arg3, arg4);
            if (v4 <= v3) {
                v1 = v3;
            } else {
                v0 = v3 + 1;
            };
            v2 = v2 + 1;
        };
        buy_yt_net_sy_for_amount<T0>(arg0, v0, arg1, arg2, arg3, arg4)
    }

    fun solve_yt_out_for_net_sy_in<T0: drop>(arg0: u64, arg1: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::Pool<T0>, arg2: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::PyState<T0>, arg3: u128, arg4: &0x2::clock::Clock) : u64 {
        let v0 = if (arg0 == 0) {
            true
        } else if (0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::total_sy<T0>(arg1) <= 1) {
            true
        } else {
            0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::total_pt<T0>(arg1) == 0
        };
        if (v0) {
            return 0
        };
        let v1 = 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::pool::total_sy<T0>(arg1) - 1;
        let v2 = if (18446744073709551615 - arg0 > v1) {
            arg0 + v1
        } else {
            18446744073709551615
        };
        let v3 = 0;
        let v4 = 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::py_state::calc_py_amount_for_sy<T0>(v2, arg3, arg2);
        let v5 = 0;
        while (v5 < 64 && v3 < v4) {
            let v6 = v3 + (v4 - v3 + 1) / 2;
            let (v7, _, _, _) = buy_yt_net_sy_for_amount<T0>(v6, arg0, arg1, arg2, arg3, arg4);
            if (v7 <= arg0) {
                v3 = v6;
            } else {
                v4 = v6 - 1;
            };
            v5 = v5 + 1;
        };
        v3
    }

    public fun used_amount_from_change<T0: drop>(arg0: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::GlobalConfig, arg1: u64, arg2: &0x2::coin::Coin<T0>) : u64 {
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::assert_current(arg0);
        let v0 = 0x2::coin::value<T0>(arg2);
        assert!(arg1 >= v0, 3100);
        arg1 - v0
    }

    // decompiled from Move bytecode v7
}

