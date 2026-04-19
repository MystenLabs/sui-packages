module 0x887b36271ccfa0a96b8c4f32b16b0cb1ad2623bc0ae73f842170b5b57843dbd4::admin {
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

    struct PublicTradeLimitEvent has copy, drop {
        pool_id: 0x2::object::ID,
        max_public_trade_usd_notional: u64,
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

    struct FlowConfigEvent has copy, drop {
        pool_id: 0x2::object::ID,
        flow_window_ms: u64,
        flow_warn_notional_usd: u64,
        flow_critical_notional_usd: u64,
        flow_block_notional_usd: u64,
        flow_warn_penalty_bps: u64,
        flow_critical_penalty_bps: u64,
    }

    struct OracleConfigEvent has copy, drop {
        pool_id: 0x2::object::ID,
        base_feed_id_pro: u32,
        quote_feed_id_pro: u32,
        base_max_age_ms: u64,
        quote_max_age_ms: u64,
    }

    struct DeviationConfigEvent has copy, drop {
        pool_id: 0x2::object::ID,
        max_bid_deviation_bps: u64,
        max_ask_deviation_bps: u64,
    }

    fun assert_valid_mode(arg0: u8) {
        let v0 = if (arg0 == 0x887b36271ccfa0a96b8c4f32b16b0cb1ad2623bc0ae73f842170b5b57843dbd4::pool::mode_two_way()) {
            true
        } else if (arg0 == 0x887b36271ccfa0a96b8c4f32b16b0cb1ad2623bc0ae73f842170b5b57843dbd4::pool::mode_bid_only()) {
            true
        } else if (arg0 == 0x887b36271ccfa0a96b8c4f32b16b0cb1ad2623bc0ae73f842170b5b57843dbd4::pool::mode_ask_only()) {
            true
        } else {
            arg0 == 0x887b36271ccfa0a96b8c4f32b16b0cb1ad2623bc0ae73f842170b5b57843dbd4::pool::mode_paused()
        };
        assert!(v0, 2);
    }

    fun assert_valid_notional_thresholds(arg0: &vector<u64>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(arg0)) {
            let v1 = *0x1::vector::borrow<u64>(arg0, v0);
            assert!(v1 > 0, 3);
            if (v0 > 0) {
                assert!(v1 > 0, 4);
            };
            v0 = v0 + 1;
        };
    }

    fun assert_valid_one_way_mode(arg0: u8) {
        assert!(arg0 == 0x887b36271ccfa0a96b8c4f32b16b0cb1ad2623bc0ae73f842170b5b57843dbd4::pool::mode_bid_only() || arg0 == 0x887b36271ccfa0a96b8c4f32b16b0cb1ad2623bc0ae73f842170b5b57843dbd4::pool::mode_ask_only(), 2);
    }

    fun assert_valid_regime(arg0: u8, arg1: u8, arg2: &vector<u64>, arg3: &vector<u64>, arg4: &vector<u64>, arg5: &vector<u64>) {
        assert_valid_mode(arg0);
        assert_valid_one_way_mode(arg1);
        let v0 = 0x1::vector::length<u64>(arg2);
        assert!(v0 > 0 && v0 <= 8, 1);
        assert!(v0 == 0x1::vector::length<u64>(arg3), 3);
        assert!(v0 == 0x1::vector::length<u64>(arg4), 3);
        assert!(v0 == 0x1::vector::length<u64>(arg5), 3);
        assert_valid_notional_thresholds(arg2);
        assert_valid_notional_thresholds(arg3);
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        while (v1 < v0) {
            let v4 = *0x1::vector::borrow<u64>(arg4, v1);
            let v5 = *0x1::vector::borrow<u64>(arg5, v1);
            if (v4 > 0 && v5 > 0) {
                assert!(v5 >= v4, 5);
            };
            if (v1 > 0) {
                assert!(v4 <= v2 || v2 == 0, 6);
                assert!(v5 >= v3 || v3 == 0, 7);
            };
            v1 = v1 + 1;
        };
    }

    public fun create_pool_and_regime<T0, T1>(arg0: &0x887b36271ccfa0a96b8c4f32b16b0cb1ad2623bc0ae73f842170b5b57843dbd4::ownable::AdminCap, arg1: address, arg2: u8, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        0x887b36271ccfa0a96b8c4f32b16b0cb1ad2623bc0ae73f842170b5b57843dbd4::ownable::assert_version(arg0);
        let (v0, v1) = 0x887b36271ccfa0a96b8c4f32b16b0cb1ad2623bc0ae73f842170b5b57843dbd4::pool::create_pool_and_regime<T0, T1>(arg1, arg2, arg3, arg4);
        let v2 = v0;
        let v3 = PoolCreatedEvent{
            pool_id             : 0x887b36271ccfa0a96b8c4f32b16b0cb1ad2623bc0ae73f842170b5b57843dbd4::pool::pool_id<T0, T1>(&v2),
            regime_id           : 0x887b36271ccfa0a96b8c4f32b16b0cb1ad2623bc0ae73f842170b5b57843dbd4::pool::regime_id<T0, T1>(&v2),
            maintainer          : arg1,
            base_coin_decimals  : arg2,
            quote_coin_decimals : arg3,
        };
        0x2::event::emit<PoolCreatedEvent>(v3);
        0x887b36271ccfa0a96b8c4f32b16b0cb1ad2623bc0ae73f842170b5b57843dbd4::pool::share_pool_and_regime<T0, T1>(v2, v1);
    }

    public fun grant_liquidity_operator_cap<T0, T1>(arg0: &0x887b36271ccfa0a96b8c4f32b16b0cb1ad2623bc0ae73f842170b5b57843dbd4::ownable::PoolAdminCap<T0, T1>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x887b36271ccfa0a96b8c4f32b16b0cb1ad2623bc0ae73f842170b5b57843dbd4::ownable::grant_liquidity_operator_cap<T0, T1>(arg1, arg2);
    }

    public fun grant_pool_admin_cap<T0, T1>(arg0: &0x887b36271ccfa0a96b8c4f32b16b0cb1ad2623bc0ae73f842170b5b57843dbd4::ownable::AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x887b36271ccfa0a96b8c4f32b16b0cb1ad2623bc0ae73f842170b5b57843dbd4::ownable::assert_version(arg0);
        0x887b36271ccfa0a96b8c4f32b16b0cb1ad2623bc0ae73f842170b5b57843dbd4::ownable::grant_pool_admin_cap<T0, T1>(arg1, arg2);
    }

    public fun grant_pusher_cap<T0, T1>(arg0: &0x887b36271ccfa0a96b8c4f32b16b0cb1ad2623bc0ae73f842170b5b57843dbd4::ownable::PoolAdminCap<T0, T1>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x887b36271ccfa0a96b8c4f32b16b0cb1ad2623bc0ae73f842170b5b57843dbd4::ownable::grant_pusher_cap<T0, T1>(arg1, arg2);
    }

    public fun migrate_admin_cap(arg0: &mut 0x887b36271ccfa0a96b8c4f32b16b0cb1ad2623bc0ae73f842170b5b57843dbd4::ownable::AdminCap) {
        0x887b36271ccfa0a96b8c4f32b16b0cb1ad2623bc0ae73f842170b5b57843dbd4::ownable::migrate_admin_cap_version(arg0);
    }

    public fun migrate_pool<T0, T1>(arg0: &0x887b36271ccfa0a96b8c4f32b16b0cb1ad2623bc0ae73f842170b5b57843dbd4::ownable::AdminCap, arg1: &mut 0x887b36271ccfa0a96b8c4f32b16b0cb1ad2623bc0ae73f842170b5b57843dbd4::pool::PoolState<T0, T1>) {
        0x887b36271ccfa0a96b8c4f32b16b0cb1ad2623bc0ae73f842170b5b57843dbd4::ownable::assert_version(arg0);
        0x887b36271ccfa0a96b8c4f32b16b0cb1ad2623bc0ae73f842170b5b57843dbd4::pool::migrate_pool_version<T0, T1>(arg1);
    }

    public fun push_regime<T0, T1>(arg0: &0x887b36271ccfa0a96b8c4f32b16b0cb1ad2623bc0ae73f842170b5b57843dbd4::ownable::PusherCap<T0, T1>, arg1: &0x887b36271ccfa0a96b8c4f32b16b0cb1ad2623bc0ae73f842170b5b57843dbd4::pool::PoolState<T0, T1>, arg2: &mut 0x887b36271ccfa0a96b8c4f32b16b0cb1ad2623bc0ae73f842170b5b57843dbd4::pool::RegimeState, arg3: u64, arg4: u8, arg5: u8, arg6: u64, arg7: vector<u64>, arg8: vector<u64>, arg9: vector<u64>, arg10: vector<u64>, arg11: &0x2::tx_context::TxContext) {
        0x887b36271ccfa0a96b8c4f32b16b0cb1ad2623bc0ae73f842170b5b57843dbd4::pool::assert_pool_version<T0, T1>(arg1);
        0x887b36271ccfa0a96b8c4f32b16b0cb1ad2623bc0ae73f842170b5b57843dbd4::pool::assert_matching_regime<T0, T1>(arg1, arg2);
        assert_valid_regime(arg4, arg5, &arg7, &arg8, &arg9, &arg10);
        0x887b36271ccfa0a96b8c4f32b16b0cb1ad2623bc0ae73f842170b5b57843dbd4::pool::replace_regime(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        let v0 = RegimePushEvent{
            pool_id                  : 0x887b36271ccfa0a96b8c4f32b16b0cb1ad2623bc0ae73f842170b5b57843dbd4::pool::pool_id<T0, T1>(arg1),
            regime_version           : 0x887b36271ccfa0a96b8c4f32b16b0cb1ad2623bc0ae73f842170b5b57843dbd4::pool::regime_version(arg2),
            directional_mode         : arg4,
            reference_snapshot_price : arg6,
            bucket_count             : (0x1::vector::length<u64>(&arg7) as u8),
        };
        0x2::event::emit<RegimePushEvent>(v0);
    }

    public fun set_deviation_config<T0, T1>(arg0: &0x887b36271ccfa0a96b8c4f32b16b0cb1ad2623bc0ae73f842170b5b57843dbd4::ownable::PoolAdminCap<T0, T1>, arg1: &mut 0x887b36271ccfa0a96b8c4f32b16b0cb1ad2623bc0ae73f842170b5b57843dbd4::pool::PoolState<T0, T1>, arg2: u64, arg3: u64) {
        0x887b36271ccfa0a96b8c4f32b16b0cb1ad2623bc0ae73f842170b5b57843dbd4::pool::assert_pool_version<T0, T1>(arg1);
        0x887b36271ccfa0a96b8c4f32b16b0cb1ad2623bc0ae73f842170b5b57843dbd4::pool::set_deviation_config<T0, T1>(arg1, arg2, arg3);
        let v0 = DeviationConfigEvent{
            pool_id               : 0x887b36271ccfa0a96b8c4f32b16b0cb1ad2623bc0ae73f842170b5b57843dbd4::pool::pool_id<T0, T1>(arg1),
            max_bid_deviation_bps : arg2,
            max_ask_deviation_bps : arg3,
        };
        0x2::event::emit<DeviationConfigEvent>(v0);
    }

    public fun set_flow_config<T0, T1>(arg0: &0x887b36271ccfa0a96b8c4f32b16b0cb1ad2623bc0ae73f842170b5b57843dbd4::ownable::PoolAdminCap<T0, T1>, arg1: &mut 0x887b36271ccfa0a96b8c4f32b16b0cb1ad2623bc0ae73f842170b5b57843dbd4::pool::PoolState<T0, T1>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64) {
        0x887b36271ccfa0a96b8c4f32b16b0cb1ad2623bc0ae73f842170b5b57843dbd4::pool::assert_pool_version<T0, T1>(arg1);
        0x887b36271ccfa0a96b8c4f32b16b0cb1ad2623bc0ae73f842170b5b57843dbd4::pool::set_flow_config<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        let v0 = FlowConfigEvent{
            pool_id                    : 0x887b36271ccfa0a96b8c4f32b16b0cb1ad2623bc0ae73f842170b5b57843dbd4::pool::pool_id<T0, T1>(arg1),
            flow_window_ms             : arg2,
            flow_warn_notional_usd     : arg3,
            flow_critical_notional_usd : arg4,
            flow_block_notional_usd    : arg5,
            flow_warn_penalty_bps      : arg6,
            flow_critical_penalty_bps  : arg7,
        };
        0x2::event::emit<FlowConfigEvent>(v0);
    }

    public fun set_inventory_config<T0, T1>(arg0: &0x887b36271ccfa0a96b8c4f32b16b0cb1ad2623bc0ae73f842170b5b57843dbd4::ownable::PoolAdminCap<T0, T1>, arg1: &mut 0x887b36271ccfa0a96b8c4f32b16b0cb1ad2623bc0ae73f842170b5b57843dbd4::pool::PoolState<T0, T1>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64) {
        0x887b36271ccfa0a96b8c4f32b16b0cb1ad2623bc0ae73f842170b5b57843dbd4::pool::assert_pool_version<T0, T1>(arg1);
        0x887b36271ccfa0a96b8c4f32b16b0cb1ad2623bc0ae73f842170b5b57843dbd4::pool::set_inventory_config<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        let v0 = InventoryConfigEvent{
            pool_id                         : 0x887b36271ccfa0a96b8c4f32b16b0cb1ad2623bc0ae73f842170b5b57843dbd4::pool::pool_id<T0, T1>(arg1),
            inventory_target_base_ratio_bps : arg2,
            inventory_warn_ratio_bps        : arg3,
            inventory_critical_ratio_bps    : arg4,
            inventory_block_ratio_bps       : arg5,
            inventory_warn_penalty_bps      : arg6,
            inventory_critical_penalty_bps  : arg7,
        };
        0x2::event::emit<InventoryConfigEvent>(v0);
    }

    public fun set_oracle_config<T0, T1>(arg0: &0x887b36271ccfa0a96b8c4f32b16b0cb1ad2623bc0ae73f842170b5b57843dbd4::ownable::PoolAdminCap<T0, T1>, arg1: &mut 0x887b36271ccfa0a96b8c4f32b16b0cb1ad2623bc0ae73f842170b5b57843dbd4::pool::PoolState<T0, T1>, arg2: u32, arg3: u32, arg4: u64, arg5: u64) {
        0x887b36271ccfa0a96b8c4f32b16b0cb1ad2623bc0ae73f842170b5b57843dbd4::pool::assert_pool_version<T0, T1>(arg1);
        0x887b36271ccfa0a96b8c4f32b16b0cb1ad2623bc0ae73f842170b5b57843dbd4::pool::set_oracle_config<T0, T1>(arg1, arg2, arg3, arg4, arg5);
        let v0 = OracleConfigEvent{
            pool_id           : 0x887b36271ccfa0a96b8c4f32b16b0cb1ad2623bc0ae73f842170b5b57843dbd4::pool::pool_id<T0, T1>(arg1),
            base_feed_id_pro  : arg2,
            quote_feed_id_pro : arg3,
            base_max_age_ms   : arg4,
            quote_max_age_ms  : arg5,
        };
        0x2::event::emit<OracleConfigEvent>(v0);
    }

    public fun set_public_trade_limit<T0, T1>(arg0: &0x887b36271ccfa0a96b8c4f32b16b0cb1ad2623bc0ae73f842170b5b57843dbd4::ownable::PoolAdminCap<T0, T1>, arg1: &mut 0x887b36271ccfa0a96b8c4f32b16b0cb1ad2623bc0ae73f842170b5b57843dbd4::pool::PoolState<T0, T1>, arg2: u64) {
        0x887b36271ccfa0a96b8c4f32b16b0cb1ad2623bc0ae73f842170b5b57843dbd4::pool::assert_pool_version<T0, T1>(arg1);
        0x887b36271ccfa0a96b8c4f32b16b0cb1ad2623bc0ae73f842170b5b57843dbd4::pool::set_public_trade_limit<T0, T1>(arg1, arg2);
        let v0 = PublicTradeLimitEvent{
            pool_id                       : 0x887b36271ccfa0a96b8c4f32b16b0cb1ad2623bc0ae73f842170b5b57843dbd4::pool::pool_id<T0, T1>(arg1),
            max_public_trade_usd_notional : arg2,
        };
        0x2::event::emit<PublicTradeLimitEvent>(v0);
    }

    public fun set_stale_config<T0, T1>(arg0: &0x887b36271ccfa0a96b8c4f32b16b0cb1ad2623bc0ae73f842170b5b57843dbd4::ownable::PoolAdminCap<T0, T1>, arg1: &mut 0x887b36271ccfa0a96b8c4f32b16b0cb1ad2623bc0ae73f842170b5b57843dbd4::pool::PoolState<T0, T1>, arg2: u64, arg3: u64, arg4: u64) {
        0x887b36271ccfa0a96b8c4f32b16b0cb1ad2623bc0ae73f842170b5b57843dbd4::pool::assert_pool_version<T0, T1>(arg1);
        0x887b36271ccfa0a96b8c4f32b16b0cb1ad2623bc0ae73f842170b5b57843dbd4::pool::set_stale_config<T0, T1>(arg1, arg2, arg3, arg4);
        let v0 = StaleConfigEvent{
            pool_id        : 0x887b36271ccfa0a96b8c4f32b16b0cb1ad2623bc0ae73f842170b5b57843dbd4::pool::pool_id<T0, T1>(arg1),
            widen_gap_ms   : arg2,
            one_way_gap_ms : arg3,
            pause_gap_ms   : arg4,
        };
        0x2::event::emit<StaleConfigEvent>(v0);
    }

    public fun set_stale_penalty_bps<T0, T1>(arg0: &0x887b36271ccfa0a96b8c4f32b16b0cb1ad2623bc0ae73f842170b5b57843dbd4::ownable::PoolAdminCap<T0, T1>, arg1: &mut 0x887b36271ccfa0a96b8c4f32b16b0cb1ad2623bc0ae73f842170b5b57843dbd4::pool::PoolState<T0, T1>, arg2: u64, arg3: u64) {
        0x887b36271ccfa0a96b8c4f32b16b0cb1ad2623bc0ae73f842170b5b57843dbd4::pool::assert_pool_version<T0, T1>(arg1);
        0x887b36271ccfa0a96b8c4f32b16b0cb1ad2623bc0ae73f842170b5b57843dbd4::pool::set_stale_penalty_bps<T0, T1>(arg1, arg2, arg3);
        let v0 = StalePenaltyEvent{
            pool_id         : 0x887b36271ccfa0a96b8c4f32b16b0cb1ad2623bc0ae73f842170b5b57843dbd4::pool::pool_id<T0, T1>(arg1),
            bid_penalty_bps : arg2,
            ask_penalty_bps : arg3,
        };
        0x2::event::emit<StalePenaltyEvent>(v0);
    }

    public fun set_tail_penalty_bps<T0, T1>(arg0: &0x887b36271ccfa0a96b8c4f32b16b0cb1ad2623bc0ae73f842170b5b57843dbd4::ownable::PoolAdminCap<T0, T1>, arg1: &mut 0x887b36271ccfa0a96b8c4f32b16b0cb1ad2623bc0ae73f842170b5b57843dbd4::pool::PoolState<T0, T1>, arg2: u64, arg3: u64) {
        0x887b36271ccfa0a96b8c4f32b16b0cb1ad2623bc0ae73f842170b5b57843dbd4::pool::assert_pool_version<T0, T1>(arg1);
        0x887b36271ccfa0a96b8c4f32b16b0cb1ad2623bc0ae73f842170b5b57843dbd4::pool::set_tail_penalty_bps<T0, T1>(arg1, arg2, arg3);
        let v0 = TailPenaltyEvent{
            pool_id              : 0x887b36271ccfa0a96b8c4f32b16b0cb1ad2623bc0ae73f842170b5b57843dbd4::pool::pool_id<T0, T1>(arg1),
            bid_tail_penalty_bps : arg2,
            ask_tail_penalty_bps : arg3,
        };
        0x2::event::emit<TailPenaltyEvent>(v0);
    }

    // decompiled from Move bytecode v7
}

