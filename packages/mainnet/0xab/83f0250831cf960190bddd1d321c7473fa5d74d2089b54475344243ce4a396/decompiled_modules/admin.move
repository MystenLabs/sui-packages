module 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::admin {
    struct PoolCreatedEvent has copy, drop {
        pool_id: 0x2::object::ID,
        regime_id: 0x2::object::ID,
        maintainer: address,
        base_coin_decimals: u8,
        quote_coin_decimals: u8,
    }

    struct RegimePushEvent has copy, drop {
        pool_id: 0x2::object::ID,
        regime_version: u64,
        directional_mode: u8,
        reference_snapshot_price: u64,
        bucket_count: u8,
    }

    struct RegimeFillSummaryEvent has copy, drop {
        pool_id: 0x2::object::ID,
        regime_version: u64,
        bucket_count: u8,
        bid_bucket_upper_notional_usd: vector<u64>,
        ask_bucket_upper_notional_usd: vector<u64>,
        bid_filled_notional_usd: vector<u64>,
        ask_filled_notional_usd: vector<u64>,
        tail_bid_filled_notional_usd: u64,
        tail_ask_filled_notional_usd: u64,
        trade_count: u64,
    }

    struct StaleConfigEvent has copy, drop {
        pool_id: 0x2::object::ID,
        widen_gap_ms: u64,
        one_way_gap_ms: u64,
        pause_gap_ms: u64,
    }

    struct StalePenaltyEvent has copy, drop {
        pool_id: 0x2::object::ID,
        bid_penalty_bps: u64,
        ask_penalty_bps: u64,
    }

    struct TailPenaltyEvent has copy, drop {
        pool_id: 0x2::object::ID,
        bid_tail_penalty_bps: u64,
        ask_tail_penalty_bps: u64,
    }

    struct TimeSlippageEvent has copy, drop {
        pool_id: 0x2::object::ID,
        time_penalty_bps: u64,
        time_penalty_period_ms: u64,
    }

    struct PublicTradeLimitEvent has copy, drop {
        pool_id: 0x2::object::ID,
        max_public_trade_usd_notional: u64,
    }

    struct MaxRegimeBucketCountEvent has copy, drop {
        pool_id: 0x2::object::ID,
        max_regime_bucket_count: u8,
    }

    struct InventoryConfigEvent has copy, drop {
        pool_id: 0x2::object::ID,
        inventory_target_base_ratio_bps: u64,
        inventory_warn_ratio_bps: u64,
        inventory_critical_ratio_bps: u64,
        inventory_block_ratio_bps: u64,
        inventory_warn_penalty_bps: u64,
        inventory_critical_penalty_bps: u64,
    }

    struct OracleConfigEvent has copy, drop {
        pool_id: 0x2::object::ID,
        base_feed_id_pro: u32,
        quote_feed_id_pro: u32,
        base_max_age_ms: u64,
        quote_max_age_ms: u64,
    }

    struct PythCoreOracleConfigEvent has copy, drop {
        pool_id: 0x2::object::ID,
        base_feed_id_core: vector<u8>,
        quote_feed_id_core: vector<u8>,
        base_core_max_age_sec: u64,
        quote_core_max_age_sec: u64,
    }

    struct DeviationConfigEvent has copy, drop {
        pool_id: 0x2::object::ID,
        max_bid_deviation_bps: u64,
        max_ask_deviation_bps: u64,
    }

    struct TradeAllowedEvent has copy, drop {
        pool_id: 0x2::object::ID,
        trade_allowed: bool,
    }

    struct PythCorePolicyEvent has copy, drop {
        pool_id: 0x2::object::ID,
        old_policy: u8,
        new_policy: u8,
    }

    struct PoolMigratedEvent has copy, drop {
        pool_id: 0x2::object::ID,
        old_version: u64,
        new_version: u64,
        pyth_core_policy: u8,
    }

    struct CapRevokedEvent has copy, drop {
        pool_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
    }

    struct CapUnrevokedEvent has copy, drop {
        pool_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
    }

    fun assert_bps(arg0: u64) {
        assert!(arg0 <= 10000, 10);
    }

    fun assert_optional_threshold_order(arg0: u64, arg1: u64, arg2: u64, arg3: u64) {
        if (arg0 > 0 && arg1 > 0) {
            assert!(arg0 <= arg1, arg3);
        };
        if (arg1 > 0 && arg2 > 0) {
            assert!(arg1 <= arg2, arg3);
        };
        if (arg0 > 0 && arg2 > 0) {
            assert!(arg0 <= arg2, arg3);
        };
    }

    fun assert_time_penalty_rate(arg0: u64, arg1: u64, arg2: u64) {
        assert!((arg0 as u128) * (arg2 as u128) <= (10000 as u128) * (arg1 as u128), 16);
    }

    fun assert_total_penalty_bps(arg0: u64, arg1: u64, arg2: u64) {
        assert!(arg0 + arg1 <= 10000, arg2);
    }

    fun assert_valid_max_regime_bucket_count(arg0: u8) {
        assert!(arg0 > 0 && arg0 <= 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::absolute_max_regime_bucket_count(), 14);
    }

    fun assert_valid_mode(arg0: u8) {
        let v0 = if (arg0 == 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::mode_two_way()) {
            true
        } else if (arg0 == 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::mode_bid_only()) {
            true
        } else if (arg0 == 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::mode_ask_only()) {
            true
        } else {
            arg0 == 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::mode_paused()
        };
        assert!(v0, 2);
    }

    fun assert_valid_notional_thresholds(arg0: &vector<u64>, arg1: bool) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(arg0)) {
            let v1 = *0x1::vector::borrow<u64>(arg0, v0);
            if (arg1) {
                assert!(v1 > 0, 3);
            };
            if (v0 > 0 && arg1) {
                assert!(v1 > 0, 4);
            } else if (v0 > 0) {
                assert!(v1 >= 0, 4);
            };
            v0 = v0 + 1;
        };
    }

    fun assert_valid_one_way_mode(arg0: u8) {
        assert!(arg0 == 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::mode_bid_only() || arg0 == 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::mode_ask_only(), 2);
    }

    fun assert_valid_regime(arg0: u8, arg1: u8, arg2: u8, arg3: &vector<u64>, arg4: &vector<u64>, arg5: &vector<u64>, arg6: &vector<u64>) {
        assert_valid_mode(arg1);
        assert_valid_one_way_mode(arg2);
        let v0 = 0x1::vector::length<u64>(arg3);
        assert!(v0 > 0 && v0 <= (arg0 as u64), 1);
        assert!(v0 == 0x1::vector::length<u64>(arg4), 3);
        assert!(v0 == 0x1::vector::length<u64>(arg5), 3);
        assert!(v0 == 0x1::vector::length<u64>(arg6), 3);
        let v1 = arg1 != 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::mode_paused() && (mode_has_bid(arg1) || mode_has_bid(arg2));
        let v2 = arg1 != 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::mode_paused() && (mode_has_ask(arg1) || mode_has_ask(arg2));
        assert_valid_notional_thresholds(arg3, v1);
        assert_valid_notional_thresholds(arg4, v2);
        let v3 = 0;
        let v4 = 0;
        let v5 = 0;
        while (v3 < v0) {
            let v6 = *0x1::vector::borrow<u64>(arg5, v3);
            let v7 = *0x1::vector::borrow<u64>(arg6, v3);
            if (v6 > 0 && v7 > 0) {
                assert!(v7 >= v6, 5);
            };
            if (v3 > 0) {
                assert!(v6 <= v4 || v4 == 0, 6);
                assert!(v7 >= v5 || v5 == 0, 7);
            };
            v3 = v3 + 1;
        };
    }

    public fun create_pool_and_regime<T0, T1>(arg0: &0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::ownable::AdminCap, arg1: address, arg2: u8, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::ownable::assert_version(arg0);
        let (v0, v1) = 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::create_pool_and_regime<T0, T1>(arg1, arg2, arg3, arg4);
        let v2 = v0;
        let v3 = PoolCreatedEvent{
            pool_id             : 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::pool_id<T0, T1>(&v2),
            regime_id           : 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::regime_id<T0, T1>(&v2),
            maintainer          : arg1,
            base_coin_decimals  : arg2,
            quote_coin_decimals : arg3,
        };
        0x2::event::emit<PoolCreatedEvent>(v3);
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::share_pool_and_regime<T0, T1>(v2, v1);
    }

    public fun grant_liquidity_operator_cap<T0, T1>(arg0: &0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::ownable::PoolAdminCap<T0, T1>, arg1: &0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::PoolState<T0, T1>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::assert_pool_version<T0, T1>(arg1);
        let v0 = 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::pool_id<T0, T1>(arg1);
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::ownable::assert_pool_admin_cap_matches<T0, T1>(arg0, v0);
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::ownable::grant_liquidity_operator_cap<T0, T1>(arg2, v0, arg3);
    }

    public fun grant_param_cap<T0, T1>(arg0: &0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::ownable::PoolAdminCap<T0, T1>, arg1: &0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::PoolState<T0, T1>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::assert_pool_version<T0, T1>(arg1);
        let v0 = 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::pool_id<T0, T1>(arg1);
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::ownable::assert_pool_admin_cap_matches<T0, T1>(arg0, v0);
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::ownable::grant_param_cap<T0, T1>(arg2, v0, arg3);
    }

    public fun grant_pool_admin_cap<T0, T1>(arg0: &0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::ownable::AdminCap, arg1: &0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::PoolState<T0, T1>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::ownable::assert_version(arg0);
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::assert_pool_version<T0, T1>(arg1);
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::ownable::grant_pool_admin_cap<T0, T1>(arg2, 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::pool_id<T0, T1>(arg1), arg3);
    }

    public fun grant_pusher_cap<T0, T1>(arg0: &0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::ownable::PoolAdminCap<T0, T1>, arg1: &0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::PoolState<T0, T1>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::assert_pool_version<T0, T1>(arg1);
        let v0 = 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::pool_id<T0, T1>(arg1);
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::ownable::assert_pool_admin_cap_matches<T0, T1>(arg0, v0);
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::ownable::grant_pusher_cap<T0, T1>(arg2, v0, arg3);
    }

    fun inventory_mismatch_penalty_bps<T0, T1>(arg0: &0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::PoolState<T0, T1>, arg1: u64) : (u64, u64) {
        let v0 = 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::base_balance<T0, T1>(arg0);
        if (v0 == arg1) {
            return (0, 0)
        };
        let v1 = if (v0 > arg1) {
            v0 - arg1
        } else {
            arg1 - v0
        };
        let v2 = if (v0 == 0) {
            10000
        } else {
            0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::safe_math::safe_mul_div_u64(v1, 10000, v0)
        };
        if (0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::inventory_block_ratio_bps<T0, T1>(arg0) > 0) {
            assert!(v2 < 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::inventory_block_ratio_bps<T0, T1>(arg0), 13);
        };
        let v3 = if (0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::inventory_critical_ratio_bps<T0, T1>(arg0) > 0 && v2 >= 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::inventory_critical_ratio_bps<T0, T1>(arg0)) {
            0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::inventory_critical_penalty_bps<T0, T1>(arg0)
        } else if (0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::inventory_warn_ratio_bps<T0, T1>(arg0) > 0 && v2 >= 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::inventory_warn_ratio_bps<T0, T1>(arg0)) {
            0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::inventory_warn_penalty_bps<T0, T1>(arg0)
        } else {
            0
        };
        if (v0 > arg1) {
            (v3, 0)
        } else {
            (0, v3)
        }
    }

    public fun migrate_admin_cap(arg0: &mut 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::ownable::AdminCap) {
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::ownable::migrate_admin_cap_version(arg0);
    }

    public fun migrate_liquidity_operator_cap<T0, T1>(arg0: &0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::ownable::PoolAdminCap<T0, T1>, arg1: &0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::PoolState<T0, T1>, arg2: &mut 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::ownable::LiquidityOperatorCap<T0, T1>) {
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::assert_pool_version<T0, T1>(arg1);
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::ownable::assert_pool_admin_cap_matches<T0, T1>(arg0, 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::pool_id<T0, T1>(arg1));
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::ownable::migrate_liquidity_operator_cap_version<T0, T1>(arg2, 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::pool_id<T0, T1>(arg1));
    }

    public fun migrate_param_cap_self<T0, T1>(arg0: &0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::PoolState<T0, T1>, arg1: &mut 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::ownable::ParamCap<T0, T1>) {
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::assert_pool_version<T0, T1>(arg0);
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::assert_cap_not_revoked<T0, T1>(arg0, 0x2::object::id<0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::ownable::ParamCap<T0, T1>>(arg1));
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::ownable::migrate_param_cap_version<T0, T1>(arg1, 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::pool_id<T0, T1>(arg0));
    }

    public fun migrate_pool<T0, T1>(arg0: &0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::ownable::AdminCap, arg1: &mut 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::PoolState<T0, T1>) {
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::ownable::assert_version(arg0);
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::migrate_pool_version<T0, T1>(arg1);
    }

    public fun migrate_pool_admin_cap<T0, T1>(arg0: &0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::ownable::AdminCap, arg1: &0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::PoolState<T0, T1>, arg2: &mut 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::ownable::PoolAdminCap<T0, T1>) {
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::ownable::assert_version(arg0);
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::assert_pool_version<T0, T1>(arg1);
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::ownable::migrate_pool_admin_cap_version<T0, T1>(arg2, 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::pool_id<T0, T1>(arg1));
    }

    public fun migrate_pool_enable_both_pyth_core<T0, T1>(arg0: &0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::ownable::AdminCap, arg1: &mut 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::PoolState<T0, T1>) {
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::ownable::assert_version(arg0);
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::migrate_pool_version<T0, T1>(arg1);
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::set_pyth_core_policy_value<T0, T1>(arg1, 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::core_oracle_both());
        let v0 = PoolMigratedEvent{
            pool_id          : 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::pool_id<T0, T1>(arg1),
            old_version      : 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::pool_version<T0, T1>(arg1),
            new_version      : 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::version::get_program_version(),
            pyth_core_policy : 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::core_oracle_both(),
        };
        0x2::event::emit<PoolMigratedEvent>(v0);
    }

    public fun migrate_pusher_cap<T0, T1>(arg0: &0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::ownable::PoolAdminCap<T0, T1>, arg1: &0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::PoolState<T0, T1>, arg2: &mut 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::ownable::PusherCap<T0, T1>) {
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::assert_pool_version<T0, T1>(arg1);
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::ownable::assert_pool_admin_cap_matches<T0, T1>(arg0, 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::pool_id<T0, T1>(arg1));
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::assert_cap_not_revoked<T0, T1>(arg1, 0x2::object::id<0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::ownable::PusherCap<T0, T1>>(arg2));
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::ownable::migrate_pusher_cap_version<T0, T1>(arg2, 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::pool_id<T0, T1>(arg1));
    }

    public fun migrate_pusher_cap_self<T0, T1>(arg0: &0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::PoolState<T0, T1>, arg1: &mut 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::ownable::PusherCap<T0, T1>) {
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::assert_pool_version<T0, T1>(arg0);
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::assert_cap_not_revoked<T0, T1>(arg0, 0x2::object::id<0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::ownable::PusherCap<T0, T1>>(arg1));
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::ownable::migrate_pusher_cap_version<T0, T1>(arg1, 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::pool_id<T0, T1>(arg0));
    }

    fun mode_has_ask(arg0: u8) : bool {
        arg0 == 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::mode_two_way() || arg0 == 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::mode_ask_only()
    }

    fun mode_has_bid(arg0: u8) : bool {
        arg0 == 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::mode_two_way() || arg0 == 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::mode_bid_only()
    }

    public fun push_regime<T0, T1>(arg0: &0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::ownable::PusherCap<T0, T1>, arg1: &0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::PoolState<T0, T1>, arg2: &mut 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::RegimeState, arg3: u64, arg4: u8, arg5: u8, arg6: u64, arg7: vector<u64>, arg8: vector<u64>, arg9: vector<u64>, arg10: vector<u64>, arg11: u64, arg12: &0x2::clock::Clock, arg13: &0x2::tx_context::TxContext) {
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::assert_pool_version<T0, T1>(arg1);
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::ownable::assert_pusher_cap_matches<T0, T1>(arg0, 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::pool_id<T0, T1>(arg1));
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::assert_cap_not_revoked<T0, T1>(arg1, 0x2::object::id<0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::ownable::PusherCap<T0, T1>>(arg0));
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::assert_matching_regime<T0, T1>(arg1, arg2);
        assert!(arg3 >= 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::last_update_ts_ms(arg2), 8);
        assert!(arg3 <= 0x2::clock::timestamp_ms(arg12), 9);
        assert_valid_regime(0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::max_regime_bucket_count<T0, T1>(arg1), arg4, arg5, &arg7, &arg8, &arg9, &arg10);
        let (v0, v1) = if (arg4 == 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::mode_paused()) {
            (0, 0)
        } else {
            inventory_mismatch_penalty_bps<T0, T1>(arg1, arg11)
        };
        if (0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::bucket_count(arg2) > 0) {
            let v2 = RegimeFillSummaryEvent{
                pool_id                       : 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::pool_id<T0, T1>(arg1),
                regime_version                : 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::regime_version(arg2),
                bucket_count                  : 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::bucket_count(arg2),
                bid_bucket_upper_notional_usd : 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::get_bid_bucket_upper_notional_vec(arg2),
                ask_bucket_upper_notional_usd : 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::get_ask_bucket_upper_notional_vec(arg2),
                bid_filled_notional_usd       : 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::get_current_regime_bid_filled_notional_vec(arg2),
                ask_filled_notional_usd       : 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::get_current_regime_ask_filled_notional_vec(arg2),
                tail_bid_filled_notional_usd  : 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::current_regime_tail_bid_filled_notional_usd(arg2),
                tail_ask_filled_notional_usd  : 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::current_regime_tail_ask_filled_notional_usd(arg2),
                trade_count                   : 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::current_regime_trade_count(arg2),
            };
            0x2::event::emit<RegimeFillSummaryEvent>(v2);
        };
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::replace_regime(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, v0, v1);
        let v3 = RegimePushEvent{
            pool_id                  : 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::pool_id<T0, T1>(arg1),
            regime_version           : 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::regime_version(arg2),
            directional_mode         : arg4,
            reference_snapshot_price : arg6,
            bucket_count             : (0x1::vector::length<u64>(&arg7) as u8),
        };
        0x2::event::emit<RegimePushEvent>(v3);
    }

    public fun revoke_cap<T0, T1>(arg0: &0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::ownable::PoolAdminCap<T0, T1>, arg1: &mut 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::PoolState<T0, T1>, arg2: 0x2::object::ID) {
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::assert_pool_version<T0, T1>(arg1);
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::ownable::assert_pool_admin_cap_matches<T0, T1>(arg0, 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::pool_id<T0, T1>(arg1));
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::revoke_cap_value<T0, T1>(arg1, arg2);
        let v0 = CapRevokedEvent{
            pool_id : 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::pool_id<T0, T1>(arg1),
            cap_id  : arg2,
        };
        0x2::event::emit<CapRevokedEvent>(v0);
    }

    public fun set_deviation_config<T0, T1>(arg0: &0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::ownable::PoolAdminCap<T0, T1>, arg1: &mut 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::PoolState<T0, T1>, arg2: u64, arg3: u64) {
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::assert_pool_version<T0, T1>(arg1);
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::ownable::assert_pool_admin_cap_matches<T0, T1>(arg0, 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::pool_id<T0, T1>(arg1));
        assert_bps(arg2);
        assert_bps(arg3);
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::set_deviation_config<T0, T1>(arg1, arg2, arg3);
        let v0 = DeviationConfigEvent{
            pool_id               : 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::pool_id<T0, T1>(arg1),
            max_bid_deviation_bps : arg2,
            max_ask_deviation_bps : arg3,
        };
        0x2::event::emit<DeviationConfigEvent>(v0);
    }

    public fun set_inventory_config<T0, T1>(arg0: &0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::ownable::PoolAdminCap<T0, T1>, arg1: &mut 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::PoolState<T0, T1>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64) {
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::assert_pool_version<T0, T1>(arg1);
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::ownable::assert_pool_admin_cap_matches<T0, T1>(arg0, 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::pool_id<T0, T1>(arg1));
        assert_bps(arg2);
        assert_bps(arg3);
        assert_bps(arg4);
        assert_bps(arg5);
        assert_bps(arg6);
        assert_bps(arg7);
        assert_optional_threshold_order(arg3, arg4, arg5, 12);
        assert_total_penalty_bps(0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::bid_penalty_bps<T0, T1>(arg1), arg7, 12);
        assert_total_penalty_bps(0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::ask_penalty_bps<T0, T1>(arg1), arg7, 12);
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::set_inventory_config<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        let v0 = InventoryConfigEvent{
            pool_id                         : 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::pool_id<T0, T1>(arg1),
            inventory_target_base_ratio_bps : arg2,
            inventory_warn_ratio_bps        : arg3,
            inventory_critical_ratio_bps    : arg4,
            inventory_block_ratio_bps       : arg5,
            inventory_warn_penalty_bps      : arg6,
            inventory_critical_penalty_bps  : arg7,
        };
        0x2::event::emit<InventoryConfigEvent>(v0);
    }

    public fun set_max_regime_bucket_count<T0, T1>(arg0: &0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::ownable::PoolAdminCap<T0, T1>, arg1: &mut 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::PoolState<T0, T1>, arg2: u8) {
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::assert_pool_version<T0, T1>(arg1);
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::ownable::assert_pool_admin_cap_matches<T0, T1>(arg0, 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::pool_id<T0, T1>(arg1));
        assert_valid_max_regime_bucket_count(arg2);
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::set_max_regime_bucket_count<T0, T1>(arg1, arg2);
        let v0 = MaxRegimeBucketCountEvent{
            pool_id                 : 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::pool_id<T0, T1>(arg1),
            max_regime_bucket_count : arg2,
        };
        0x2::event::emit<MaxRegimeBucketCountEvent>(v0);
    }

    public fun set_oracle_config<T0, T1>(arg0: &0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::ownable::PoolAdminCap<T0, T1>, arg1: &mut 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::PoolState<T0, T1>, arg2: u32, arg3: u32, arg4: u64, arg5: u64) {
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::assert_pool_version<T0, T1>(arg1);
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::ownable::assert_pool_admin_cap_matches<T0, T1>(arg0, 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::pool_id<T0, T1>(arg1));
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::set_oracle_config<T0, T1>(arg1, arg2, arg3, arg4, arg5);
        let v0 = OracleConfigEvent{
            pool_id           : 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::pool_id<T0, T1>(arg1),
            base_feed_id_pro  : arg2,
            quote_feed_id_pro : arg3,
            base_max_age_ms   : arg4,
            quote_max_age_ms  : arg5,
        };
        0x2::event::emit<OracleConfigEvent>(v0);
    }

    public fun set_public_trade_limit<T0, T1>(arg0: &0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::ownable::PoolAdminCap<T0, T1>, arg1: &mut 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::PoolState<T0, T1>, arg2: u64) {
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::assert_pool_version<T0, T1>(arg1);
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::ownable::assert_pool_admin_cap_matches<T0, T1>(arg0, 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::pool_id<T0, T1>(arg1));
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::set_public_trade_limit<T0, T1>(arg1, arg2);
        let v0 = PublicTradeLimitEvent{
            pool_id                       : 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::pool_id<T0, T1>(arg1),
            max_public_trade_usd_notional : arg2,
        };
        0x2::event::emit<PublicTradeLimitEvent>(v0);
    }

    public fun set_pyth_core_oracle_config<T0, T1>(arg0: &0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::ownable::PoolAdminCap<T0, T1>, arg1: &mut 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::PoolState<T0, T1>, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: u64) {
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::assert_pool_version<T0, T1>(arg1);
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::ownable::assert_pool_admin_cap_matches<T0, T1>(arg0, 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::pool_id<T0, T1>(arg1));
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::set_pyth_core_oracle_config<T0, T1>(arg1, arg2, arg3, arg4, arg5);
        let v0 = PythCoreOracleConfigEvent{
            pool_id                : 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::pool_id<T0, T1>(arg1),
            base_feed_id_core      : arg2,
            quote_feed_id_core     : arg3,
            base_core_max_age_sec  : arg4,
            quote_core_max_age_sec : arg5,
        };
        0x2::event::emit<PythCoreOracleConfigEvent>(v0);
    }

    public fun set_pyth_core_policy<T0, T1>(arg0: &0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::ownable::PoolAdminCap<T0, T1>, arg1: &mut 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::PoolState<T0, T1>, arg2: u8) {
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::assert_pool_version<T0, T1>(arg1);
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::ownable::assert_pool_admin_cap_matches<T0, T1>(arg0, 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::pool_id<T0, T1>(arg1));
        assert!(arg2 >= 1 && arg2 <= 3, 17);
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::set_pyth_core_policy_value<T0, T1>(arg1, arg2);
        let v0 = PythCorePolicyEvent{
            pool_id    : 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::pool_id<T0, T1>(arg1),
            old_policy : 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::pyth_core_policy<T0, T1>(arg1),
            new_policy : arg2,
        };
        0x2::event::emit<PythCorePolicyEvent>(v0);
    }

    public fun set_stale_config<T0, T1>(arg0: &0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::ownable::PoolAdminCap<T0, T1>, arg1: &mut 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::PoolState<T0, T1>, arg2: u64, arg3: u64, arg4: u64) {
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::assert_pool_version<T0, T1>(arg1);
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::ownable::assert_pool_admin_cap_matches<T0, T1>(arg0, 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::pool_id<T0, T1>(arg1));
        assert!(arg2 <= arg3 && arg3 <= arg4, 11);
        let (v0, v1) = 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::time_penalty_config<T0, T1>(arg1);
        assert_time_penalty_rate(v0, v1, arg4);
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::set_stale_config<T0, T1>(arg1, arg2, arg3, arg4);
        let v2 = StaleConfigEvent{
            pool_id        : 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::pool_id<T0, T1>(arg1),
            widen_gap_ms   : arg2,
            one_way_gap_ms : arg3,
            pause_gap_ms   : arg4,
        };
        0x2::event::emit<StaleConfigEvent>(v2);
    }

    public fun set_stale_penalty_bps<T0, T1>(arg0: &0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::ownable::PoolAdminCap<T0, T1>, arg1: &mut 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::PoolState<T0, T1>, arg2: u64, arg3: u64) {
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::assert_pool_version<T0, T1>(arg1);
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::ownable::assert_pool_admin_cap_matches<T0, T1>(arg0, 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::pool_id<T0, T1>(arg1));
        assert_bps(arg2);
        assert_bps(arg3);
        assert_total_penalty_bps(arg2, 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::inventory_critical_penalty_bps<T0, T1>(arg1), 10);
        assert_total_penalty_bps(arg3, 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::inventory_critical_penalty_bps<T0, T1>(arg1), 10);
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::set_stale_penalty_bps<T0, T1>(arg1, arg2, arg3);
        let v0 = StalePenaltyEvent{
            pool_id         : 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::pool_id<T0, T1>(arg1),
            bid_penalty_bps : arg2,
            ask_penalty_bps : arg3,
        };
        0x2::event::emit<StalePenaltyEvent>(v0);
    }

    public fun set_tail_penalty_bps<T0, T1>(arg0: &0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::ownable::PoolAdminCap<T0, T1>, arg1: &mut 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::PoolState<T0, T1>, arg2: u64, arg3: u64) {
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::assert_pool_version<T0, T1>(arg1);
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::ownable::assert_pool_admin_cap_matches<T0, T1>(arg0, 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::pool_id<T0, T1>(arg1));
        assert_bps(arg2);
        assert_bps(arg3);
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::set_tail_penalty_bps<T0, T1>(arg1, arg2, arg3);
        let v0 = TailPenaltyEvent{
            pool_id              : 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::pool_id<T0, T1>(arg1),
            bid_tail_penalty_bps : arg2,
            ask_tail_penalty_bps : arg3,
        };
        0x2::event::emit<TailPenaltyEvent>(v0);
    }

    public fun set_time_penalty_config<T0, T1>(arg0: &0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::ownable::PoolAdminCap<T0, T1>, arg1: &mut 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::PoolState<T0, T1>, arg2: u64, arg3: u64) {
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::assert_pool_version<T0, T1>(arg1);
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::ownable::assert_pool_admin_cap_matches<T0, T1>(arg0, 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::pool_id<T0, T1>(arg1));
        set_time_penalty_config_impl<T0, T1>(arg1, arg2, arg3);
    }

    public fun set_time_penalty_config_by_param_cap<T0, T1>(arg0: &0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::ownable::ParamCap<T0, T1>, arg1: &mut 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::PoolState<T0, T1>, arg2: u64, arg3: u64) {
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::assert_pool_version<T0, T1>(arg1);
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::ownable::assert_param_cap_matches<T0, T1>(arg0, 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::pool_id<T0, T1>(arg1));
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::assert_cap_not_revoked<T0, T1>(arg1, 0x2::object::id<0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::ownable::ParamCap<T0, T1>>(arg0));
        set_time_penalty_config_impl<T0, T1>(arg1, arg2, arg3);
    }

    fun set_time_penalty_config_impl<T0, T1>(arg0: &mut 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::PoolState<T0, T1>, arg1: u64, arg2: u64) {
        assert_bps(arg1);
        assert!(arg2 > 0, 15);
        assert_time_penalty_rate(arg1, arg2, 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::stale_pause_gap_ms<T0, T1>(arg0));
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::set_time_penalty_config<T0, T1>(arg0, arg1, arg2);
        let v0 = TimeSlippageEvent{
            pool_id                : 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::pool_id<T0, T1>(arg0),
            time_penalty_bps       : arg1,
            time_penalty_period_ms : arg2,
        };
        0x2::event::emit<TimeSlippageEvent>(v0);
    }

    public fun set_trade_allowed<T0, T1>(arg0: &0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::ownable::PoolAdminCap<T0, T1>, arg1: &mut 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::PoolState<T0, T1>, arg2: bool) {
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::assert_pool_version<T0, T1>(arg1);
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::ownable::assert_pool_admin_cap_matches<T0, T1>(arg0, 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::pool_id<T0, T1>(arg1));
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::set_trade_allowed<T0, T1>(arg1, arg2);
        let v0 = TradeAllowedEvent{
            pool_id       : 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::pool_id<T0, T1>(arg1),
            trade_allowed : arg2,
        };
        0x2::event::emit<TradeAllowedEvent>(v0);
    }

    public fun unrevoke_cap<T0, T1>(arg0: &0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::ownable::PoolAdminCap<T0, T1>, arg1: &mut 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::PoolState<T0, T1>, arg2: 0x2::object::ID) {
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::assert_pool_version<T0, T1>(arg1);
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::ownable::assert_pool_admin_cap_matches<T0, T1>(arg0, 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::pool_id<T0, T1>(arg1));
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::unrevoke_cap_value<T0, T1>(arg1, arg2);
        let v0 = CapUnrevokedEvent{
            pool_id : 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::pool_id<T0, T1>(arg1),
            cap_id  : arg2,
        };
        0x2::event::emit<CapUnrevokedEvent>(v0);
    }

    // decompiled from Move bytecode v7
}

