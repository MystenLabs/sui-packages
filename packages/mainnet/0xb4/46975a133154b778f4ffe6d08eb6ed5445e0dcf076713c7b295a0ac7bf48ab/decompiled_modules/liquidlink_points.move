module 0x46c6f7c5176ffe3d6706ed7bee5e31447071f9a5227e29d96179d5e7b5d73ea1::liquidlink_points {
    struct PointConfig has key {
        id: 0x2::object::UID,
        project_object_id: 0x2::object::ID,
        scoreboard_id: 0x2::object::ID,
        yt_multiplier_bps: u64,
        lp_multiplier_bps: u64,
        duration: u64,
        enabled: bool,
        closed: bool,
        closed_at_ms: u64,
        total_yt_amount: u256,
        total_yt_base: u256,
        uncheckpointed_yt: u256,
        config_version: u64,
        yt_config_version: u64,
        lp_config_version: u64,
        yt_referral_source_cap: 0x1::option::Option<0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::YtReferralSourceCap<JitterYtPointSource>>,
    }

    struct LpPointState<phantom T0: drop> has key {
        id: 0x2::object::UID,
        initialized: bool,
        lp_rewarder_uid: 0x2::object::UID,
        pool_rewarder_uid: 0x2::object::UID,
        point_config_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        lp_settlement_cap: 0x1::option::Option<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewarderSettlementCap>,
        pool_settlement_cap: 0x1::option::Option<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewarderSettlementCap>,
        lp_referral_source_cap: 0x1::option::Option<0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::LpReferralSourceCap<JitterLpPointSource>>,
        lp_multiplier_bps: u64,
        acc_point_per_lp: u128,
        attachment_acc_point_per_lp: u128,
        attachment_ms: u64,
        acc_point_remainder: u256,
        point_numerator_remainder: u256,
        point_fraction_remainder_q128: u256,
        last_updated_ms: u64,
        total_lp_points_accrued: u128,
        total_lp_points_saturated: bool,
        last_lp_supply: u64,
        point_config_version: u64,
        reward_attached: bool,
    }

    struct LpConfigVersionKey has copy, drop, store {
        pos0: u64,
    }

    struct LpConfigVersion has copy, drop, store {
        effective_at_ms: u64,
        multiplier_bps: u64,
        duration: u64,
        enabled: bool,
    }

    struct LpHistoryRepairKey has copy, drop, store {
        pos0: u64,
    }

    struct LpHistoryRepair has copy, drop, store {
        from_ms: u64,
        until_ms: u64,
        multiplier_bps: u64,
        duration: u64,
        reason: vector<u8>,
    }

    struct LpHistoryRepairedEvent has copy, drop {
        state_id: 0x2::object::ID,
        config_id: 0x2::object::ID,
        version: u64,
        from_ms: u64,
        until_ms: u64,
        old_multiplier_bps: u64,
        new_multiplier_bps: u64,
        old_duration: u64,
        new_duration: u64,
        reason: vector<u8>,
    }

    struct LpCarryRetiredEvent has copy, drop {
        state_id: 0x2::object::ID,
        acc_point_remainder: u256,
        point_numerator_remainder: u256,
        point_fraction_remainder_q128: u256,
        config_version: u64,
    }

    struct YtConfigVersionKey has copy, drop, store {
        pos0: u64,
    }

    struct YtConfigVersion has copy, drop, store {
        effective_at_ms: u64,
        multiplier_bps: u64,
        duration: u64,
        enabled: bool,
    }

    struct UserKey has copy, drop, store {
        pos0: address,
    }

    struct PositionKey has copy, drop, store {
        pos0: 0x2::object::ID,
    }

    struct ClosedPositionKey has copy, drop, store {
        pos0: 0x2::object::ID,
    }

    struct LpReferralRecordKey has copy, drop, store {
        pos0: 0x2::object::ID,
    }

    struct YtReferralRecordKey has copy, drop, store {
        pos0: 0x2::object::ID,
    }

    struct YtPointWeightKey has copy, drop, store {
        pos0: 0x2::object::ID,
    }

    struct YtMarketAllowedKey has copy, drop, store {
        pos0: 0x2::object::ID,
    }

    struct JitterLpPointSource has drop {
        dummy_field: bool,
    }

    struct JitterPointSource has drop {
        dummy_field: bool,
    }

    struct JitterYtPointSource has drop {
        dummy_field: bool,
    }

    struct LpPointClaimLock has drop {
        _reserved: bool,
    }

    struct YtPointWeight has copy, drop, store {
        multiplier_bps: u64,
    }

    struct UserYtExposure has store {
        yt_base: u256,
    }

    struct YtPositionContribution has store {
        owner: address,
        raw_amount: u256,
        base_amount: u256,
        reward_debt_scaled: u256,
        point_remainder_scaled: u256,
    }

    struct YtMarketExposure has store {
        yt_amount: u256,
        yt_base: u256,
        uncheckpointed_yt: u256,
        attachment_acc: u256,
        attachment_ms: u64,
        acc_point_per_base: u256,
        point_numerator_remainder: u256,
        last_updated_ms: u64,
        expiry_ms: u64,
        point_config_version: u64,
        initialized: bool,
        reward_attached: bool,
        settlement_cap: 0x1::option::Option<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewarderSettlementCap>,
    }

    struct LpLegPointRecord has store {
        owner: address,
        lp_amount: u64,
        reward_debt: u256,
        pending_points: u64,
        pending_point_remainder: u256,
    }

    struct LpReferralRecordMarker has store {
        record_id: 0x2::object::ID,
    }

    struct YtReferralRecordMarker has store {
        record_id: 0x2::object::ID,
    }

    struct PointConfigCreatedEvent has copy, drop {
        config_id: 0x2::object::ID,
        project_object_id: 0x2::object::ID,
        scoreboard_id: 0x2::object::ID,
        owner: address,
        yt_multiplier_bps: u64,
        lp_multiplier_bps: u64,
        duration: u64,
        enabled: bool,
        total_yt_amount: u256,
        total_yt_base: u256,
        config_version: u64,
        yt_config_version: u64,
        lp_config_version: u64,
    }

    struct PointConfigUpdatedEvent has copy, drop {
        config_id: 0x2::object::ID,
        yt_multiplier_bps: u64,
        lp_multiplier_bps: u64,
        duration: u64,
        enabled: bool,
        total_yt_amount: u256,
        total_yt_base: u256,
        config_version: u64,
        yt_config_version: u64,
        lp_config_version: u64,
    }

    struct PointConfigClosedEvent has copy, drop {
        config_id: 0x2::object::ID,
        closed_at_ms: u64,
        yt_config_version: u64,
        lp_config_version: u64,
    }

    struct LpPointStateCreatedEvent has copy, drop {
        state_id: 0x2::object::ID,
        config_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        lp_multiplier_bps: u64,
    }

    struct YtPointWeightConfiguredEvent has copy, drop {
        config_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        multiplier_bps: u64,
    }

    struct YtMarketAllowedEvent has copy, drop {
        config_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
    }

    struct LpPointWeightConfiguredEvent has copy, drop {
        state_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        multiplier_bps: u64,
    }

    struct YtPointsSyncedEvent has copy, drop {
        config_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        owner: address,
        previous_base_amount: u256,
        new_base_amount: u256,
        points_added: u64,
        point_remainder_scaled: u256,
        effective_updated_at_ms: u64,
    }

    struct PointRewardAttachmentUpdatedEvent has copy, drop {
        config_id: 0x2::object::ID,
        scoreboard_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        scope: u8,
        rewarder_id: 0x2::object::ID,
        attached: bool,
    }

    struct LpPointAttachmentBaselineCapturedEvent has copy, drop {
        state_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        attachment_ms: u64,
        attachment_acc_point_per_lp: u128,
    }

    struct LpPointAccumulatorUpdatedEvent has copy, drop {
        state_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        elapsed_ms: u64,
        total_sy: u64,
        circulating_lp_supply: u64,
        points_accrued: u128,
        total_saturated: bool,
        point_numerator_remainder: u256,
        acc_point_remainder: u256,
        acc_point_per_lp: u128,
    }

    struct PointConfigCheckpointedEvent has copy, drop {
        config_id: 0x2::object::ID,
        subject_id: 0x2::object::ID,
        scope: u8,
        from_version: u64,
        to_version: u64,
        current_version: u64,
        checkpointed_until_ms: u64,
        complete: bool,
    }

    struct LpLegPointsSettledEvent has copy, drop {
        state_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        owner: address,
        pending_added: u64,
        pending_total: u64,
        pending_point_remainder: u256,
        lp_amount: u64,
        reward_debt: u256,
    }

    struct LpPointsClaimedEvent has copy, drop {
        state_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        owner: address,
        points: u64,
    }

    struct LpReferralDetachedEvent has copy, drop {
        state_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        record_id: 0x2::object::ID,
        referee: address,
        referrer: address,
        referee_points_claimed: u64,
        referrer_points_claimed: u64,
        forfeited_referee_remainder: u256,
        forfeited_referrer_remainder: u256,
    }

    struct YtReferralDetachedEvent has copy, drop {
        config_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        record_id: 0x2::object::ID,
        referee: address,
        referrer: address,
        referrer_points_claimed: u64,
        forfeited_referee_remainder: u256,
        forfeited_referrer_remainder: u256,
    }

    public fun scoreboard_id(arg0: &PointConfig) : 0x2::object::ID {
        arg0.scoreboard_id
    }

    public fun bind_lp_referrer<T0: drop, T1: drop, T2: drop>(arg0: &PointConfig, arg1: &mut LpPointState<T0>, arg2: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg3: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg4: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::Project, arg5: &0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::ReferralPolicyState, arg6: &0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::bonding_table::ReferralTable, arg7: &mut 0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::LpReferralRecord, arg8: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg9: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition, arg10: &0x2::clock::Clock, arg11: &0x2::tx_context::TxContext) {
        assert_market_active(arg2, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg8));
        assert_lp_state_match<T0, T1, T2>(arg0, arg1, arg8);
        assert_lp_position_match<T0>(arg1, arg9);
        assert_referral_record_match<T0>(arg1, arg7, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg8));
        assert!(0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::lp_referral_record_position_id(arg7) == 0x2::object::id<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition>(arg9), 9210);
        assert!(0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::lp_referral_record_referee(arg7) == 0x2::tx_context::sender(arg11), 9210);
        assert_lp_referral_record_marker<T0>(arg1, 0x2::object::id<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition>(arg9), 0x2::object::id<0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::LpReferralRecord>(arg7));
        update_pool_lp_points<T0, T1, T2>(arg0, arg1, arg8, arg10);
        let v0 = JitterLpPointSource{dummy_field: false};
        0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::sync_lp_referral_record<JitterLpPointSource>(arg2, arg3, arg4, v0, lp_referral_source_cap_ref<T0>(arg1), arg5, arg7, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::lp_amount(arg9), 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::lp_amount(arg9), arg1.acc_point_per_lp);
        let v1 = JitterLpPointSource{dummy_field: false};
        0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::bind_lp_referrer<JitterLpPointSource>(arg2, arg3, arg4, v1, lp_referral_source_cap_ref<T0>(arg1), arg5, arg6, arg7, arg1.acc_point_per_lp);
    }

    public fun bind_yt_referrer<T0: drop, T1: drop, T2: drop>(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg2: &mut PointConfig, arg3: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::Project, arg4: &0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::ReferralPolicyState, arg5: &0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::bonding_table::ReferralTable, arg6: &mut 0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::YtReferralRecord, arg7: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg8: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition, arg9: &0x2::clock::Clock, arg10: &0x2::tx_context::TxContext) {
        assert_market_active(arg0, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg7));
        assert_project_match(arg2, arg3);
        assert_yt_referral_record_match(arg2, arg6, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg7), 0x2::object::id<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition>(arg8));
        assert_yt_referral_record_marker(arg2, 0x2::object::id<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition>(arg8), 0x2::object::id<0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::YtReferralRecord>(arg6));
        assert!(0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::yt_referral_record_referee(arg6) == 0x2::tx_context::sender(arg10), 9210);
        let v0 = update_yt_market_points<T0, T1, T2>(arg2, arg7, arg9);
        sync_yt_referral_from_contribution(arg0, arg1, arg2, arg3, arg4, arg6, 0x2::object::id<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition>(arg8), 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg7));
        let v1 = JitterYtPointSource{dummy_field: false};
        0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::bind_yt_referrer<JitterYtPointSource>(arg0, arg1, arg3, v1, yt_referral_source_cap_ref(arg2), arg4, arg5, arg6, v0);
    }

    public fun closed(arg0: &PointConfig) : bool {
        arg0.closed
    }

    public fun project_object_id(arg0: &PointConfig) : 0x2::object::ID {
        arg0.project_object_id
    }

    fun accrue_lp_interval<T0: drop>(arg0: &mut LpPointState<T0>, arg1: u64, arg2: u64, arg3: &LpConfigVersion, arg4: u64) : u128 {
        let v0 = if (!arg3.enabled) {
            true
        } else if (arg4 == 0) {
            true
        } else if (arg2 == 0) {
            true
        } else {
            arg1 == 0
        };
        if (v0) {
            return 0
        };
        let (v1, v2) = 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::point_math::lp_emission(arg1, arg3.multiplier_bps, arg0.lp_multiplier_bps, arg4, arg3.duration, arg0.point_numerator_remainder);
        arg0.point_numerator_remainder = v2;
        v1
    }

    fun accrue_yt_interval(arg0: &mut YtMarketExposure, arg1: &YtConfigVersion, arg2: u64, arg3: u64) {
        if (!arg1.enabled || arg3 == 0) {
            return
        };
        let (v0, v1) = 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::point_math::yt_emission(arg1.multiplier_bps, arg2, arg3, arg1.duration, arg0.point_numerator_remainder);
        assert!(arg0.acc_point_per_base <= 115792089237316195423570985008687907853269984665640564039457584007913129639935 - v0, 9201);
        arg0.acc_point_per_base = arg0.acc_point_per_base + v0;
        arg0.point_numerator_remainder = v1;
    }

    fun accumulate_lp_points(arg0: u128, arg1: u64, arg2: u256) : (u128, u256) {
        assert!(arg1 > 0, 9202);
        let v0 = (arg0 as u256) * (1000000000000 as u256);
        assert!(v0 <= 115792089237316195423570985008687907853269984665640564039457584007913129639935 - arg2, 9201);
        let v1 = v0 + arg2;
        let v2 = (arg1 as u256);
        let v3 = v1 / v2;
        assert!(v3 <= 340282366920938463463374607431768211455, 9201);
        ((v3 as u128), v1 % v2)
    }

    fun add_initial_lp_config_version(arg0: &mut PointConfig, arg1: u64) {
        let v0 = LpConfigVersionKey{pos0: 0};
        let v1 = LpConfigVersion{
            effective_at_ms : arg1,
            multiplier_bps  : arg0.lp_multiplier_bps,
            duration        : arg0.duration,
            enabled         : arg0.enabled,
        };
        0x2::dynamic_field::add<LpConfigVersionKey, LpConfigVersion>(&mut arg0.id, v0, v1);
    }

    fun add_initial_yt_config_version(arg0: &mut PointConfig, arg1: u64) {
        let v0 = YtConfigVersionKey{pos0: 0};
        let v1 = YtConfigVersion{
            effective_at_ms : arg1,
            multiplier_bps  : arg0.yt_multiplier_bps,
            duration        : arg0.duration,
            enabled         : arg0.enabled,
        };
        0x2::dynamic_field::add<YtConfigVersionKey, YtConfigVersion>(&mut arg0.id, v0, v1);
    }

    fun allow_yt_market(arg0: &mut PointConfig, arg1: 0x2::object::ID) {
        let v0 = YtMarketAllowedKey{pos0: arg1};
        if (0x2::dynamic_field::exists<YtMarketAllowedKey>(&arg0.id, v0)) {
            return
        };
        let v1 = YtMarketExposure{
            yt_amount                 : 0,
            yt_base                   : 0,
            uncheckpointed_yt         : 0,
            attachment_acc            : 0,
            attachment_ms             : 0,
            acc_point_per_base        : 0,
            point_numerator_remainder : 0,
            last_updated_ms           : 0,
            expiry_ms                 : 0,
            point_config_version      : arg0.yt_config_version,
            initialized               : false,
            reward_attached           : false,
            settlement_cap            : 0x1::option::none<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewarderSettlementCap>(),
        };
        0x2::dynamic_field::add<YtMarketAllowedKey, YtMarketExposure>(&mut arg0.id, v0, v1);
        let v2 = YtMarketAllowedEvent{
            config_id : 0x2::object::id<PointConfig>(arg0),
            market_id : arg1,
        };
        0x2::event::emit<YtMarketAllowedEvent>(v2);
    }

    public fun allow_yt_market_by_admin(arg0: &mut PointConfig, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::admin::AdminCap, arg3: 0x2::object::ID) {
        0x46c6f7c5176ffe3d6706ed7bee5e31447071f9a5227e29d96179d5e7b5d73ea1::package_version::assert_current(arg1);
        assert!(!arg0.closed, 9223);
        allow_yt_market(arg0, arg3);
    }

    fun append_lp_config_version(arg0: &mut PointConfig, arg1: u64) {
        assert!(arg1 >= lp_config_version_ref(arg0, arg0.lp_config_version).effective_at_ms, 9203);
        assert!(arg0.lp_config_version < 18446744073709551615, 9201);
        arg0.lp_config_version = arg0.lp_config_version + 1;
        let v0 = LpConfigVersionKey{pos0: arg0.lp_config_version};
        let v1 = LpConfigVersion{
            effective_at_ms : arg1,
            multiplier_bps  : arg0.lp_multiplier_bps,
            duration        : arg0.duration,
            enabled         : arg0.enabled,
        };
        0x2::dynamic_field::add<LpConfigVersionKey, LpConfigVersion>(&mut arg0.id, v0, v1);
    }

    fun append_yt_config_version(arg0: &mut PointConfig, arg1: u64) {
        assert!(arg1 >= yt_config_version_ref(arg0, arg0.yt_config_version).effective_at_ms, 9203);
        assert!(arg0.yt_config_version < 18446744073709551615, 9201);
        arg0.yt_config_version = arg0.yt_config_version + 1;
        let v0 = YtConfigVersionKey{pos0: arg0.yt_config_version};
        let v1 = YtConfigVersion{
            effective_at_ms : arg1,
            multiplier_bps  : arg0.yt_multiplier_bps,
            duration        : arg0.duration,
            enabled         : arg0.enabled,
        };
        0x2::dynamic_field::add<YtConfigVersionKey, YtConfigVersion>(&mut arg0.id, v0, v1);
    }

    fun archive_closed_lp<T0: drop, T1: drop, T2: drop>(arg0: &PointConfig, arg1: &mut LpPointState<T0>, arg2: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition, arg3: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg4: &0x2::clock::Clock, arg5: 0x1::option::Option<0x2::object::ID>, arg6: 0x1::option::Option<0x2::object::ID>, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.initialized, 9217);
        let v0 = 0x2::object::id<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition>(arg2);
        if (lp_position_archived<T0>(arg1, v0)) {
            return
        };
        update_pool_lp_points<T0, T1, T2>(arg0, arg1, arg3, arg4);
        let v1 = PositionKey{pos0: v0};
        let (v2, v3, v4) = if (0x2::dynamic_field::exists<PositionKey>(&arg1.id, v1)) {
            let v5 = 0x2::dynamic_field::remove<PositionKey, LpLegPointRecord>(&mut arg1.id, v1);
            assert!(v5.owner == 0x2::tx_context::sender(arg7) || v5.lp_amount == 0, 9208);
            let (v6, v7) = pending_lp_points_for_record(&v5, arg1.acc_point_per_lp);
            let v8 = (v5.pending_points as u128) + (v6 as u128);
            assert!(v8 <= 18446744073709551615, 9201);
            let LpLegPointRecord {
                owner                   : v9,
                lp_amount               : _,
                reward_debt             : _,
                pending_points          : _,
                pending_point_remainder : _,
            } = v5;
            (v9, (v8 as u64), v7)
        } else {
            let (v14, v15, _) = attachment_lp_record_values<T0>(arg1, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::lp_amount(arg2));
            (0x2::tx_context::sender(arg7), v14, v15)
        };
        0x46c6f7c5176ffe3d6706ed7bee5e31447071f9a5227e29d96179d5e7b5d73ea1::point_claim::archive(0x2::object::id<PointConfig>(arg0), 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg3), 0x2::object::id<LpPointState<T0>>(arg1), v0, v2, 2, v3, v4, (1000000000000 as u256), arg0.closed_at_ms, arg5, arg6, arg7);
        let v17 = ClosedPositionKey{pos0: v0};
        0x2::dynamic_field::add<ClosedPositionKey, bool>(&mut arg1.id, v17, true);
    }

    fun archive_closed_yt<T0: drop, T1: drop, T2: drop>(arg0: &mut PointConfig, arg1: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition, arg2: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg3: &0x2::clock::Clock, arg4: 0x1::option::Option<0x2::object::ID>, arg5: 0x1::option::Option<0x2::object::ID>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition>(arg1);
        if (yt_position_archived(arg0, v0)) {
            return
        };
        assert_yt_checkpoint_owner(arg0, v0, 0x2::tx_context::sender(arg6));
        initialize_yt_contribution<T0, T1, T2>(arg0, arg2, arg1, 0x2::tx_context::sender(arg6));
        let v1 = update_yt_market_points<T0, T1, T2>(arg0, arg2, arg3);
        let v2 = PositionKey{pos0: v0};
        let v3 = 0x2::dynamic_field::borrow<PositionKey, YtPositionContribution>(&arg0.id, v2).owner;
        let v4 = 0x1::u64::min(arg0.closed_at_ms, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::expiry<T0, T1, T2>(arg2));
        let (_, v6) = set_yt_position_contribution(arg0, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg2), v0, v3, 0, 0, v1, v4, 0);
        let v7 = remove_empty_yt_contribution(arg0, v0, v3);
        0x46c6f7c5176ffe3d6706ed7bee5e31447071f9a5227e29d96179d5e7b5d73ea1::point_claim::archive(0x2::object::id<PointConfig>(arg0), 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg2), 0x2::object::id<PointConfig>(arg0), v0, v3, 1, v6, v7, 340282366920938463463374607431768211456, arg0.closed_at_ms, arg4, arg5, arg6);
        let v8 = ClosedPositionKey{pos0: v0};
        0x2::dynamic_field::add<ClosedPositionKey, bool>(&mut arg0.id, v8, true);
    }

    fun assert_current_yt_contribution<T0: drop, T1: drop, T2: drop>(arg0: &mut PointConfig, arg1: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg2: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition, arg3: address, arg4: u256, arg5: &0x2::clock::Clock) : u256 {
        let v0 = 0x2::object::id<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition>(arg2);
        let v1 = if (0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::expiry<T0, T1, T2>(arg1) <= 0x2::clock::timestamp_ms(arg5)) {
            0
        } else {
            (0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::yt_balance(arg2) as u256)
        };
        let v2 = PositionKey{pos0: v0};
        if (!0x2::dynamic_field::exists<PositionKey>(&arg0.id, v2)) {
            assert!(0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::yt_balance(arg2) == 0, 9208);
            let (_, v4) = set_yt_position_contribution(arg0, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg1), v0, arg3, 0, 0, arg4, 0x1::u64::min(0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::expiry<T0, T1, T2>(arg1), 0x2::clock::timestamp_ms(arg5)), 0x1::u64::saturating_sub(0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::expiry<T0, T1, T2>(arg1), 0x2::clock::timestamp_ms(arg5)));
            assert!(v4 == 0, 9208);
            return 0
        };
        let v5 = 0x2::dynamic_field::borrow<PositionKey, YtPositionContribution>(&arg0.id, v2);
        assert!(v5.owner == arg3, 9210);
        assert!(v5.raw_amount == v1, 9208);
        assert!(v5.base_amount == v1, 9208);
        v1
    }

    fun assert_generic_lp_settlement_allowed<T0: drop>(arg0: &LpPointState<T0>, arg1: 0x2::object::ID) {
        let v0 = LpReferralRecordKey{pos0: arg1};
        assert!(!0x2::dynamic_field::exists<LpReferralRecordKey>(&arg0.id, v0), 9213);
    }

    fun assert_generic_yt_settlement_allowed(arg0: &PointConfig, arg1: 0x2::object::ID) {
        let v0 = YtReferralRecordKey{pos0: arg1};
        assert!(!0x2::dynamic_field::exists<YtReferralRecordKey>(&arg0.id, v0), 9213);
    }

    fun assert_lp_position_match<T0: drop>(arg0: &LpPointState<T0>, arg1: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition) {
        assert!(0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::market_state_id(arg1) == arg0.pool_id, 9204);
    }

    fun assert_lp_referral_record_marker<T0: drop>(arg0: &LpPointState<T0>, arg1: 0x2::object::ID, arg2: 0x2::object::ID) {
        let v0 = LpReferralRecordKey{pos0: arg1};
        assert!(0x2::dynamic_field::exists<LpReferralRecordKey>(&arg0.id, v0), 9210);
        assert!(0x2::dynamic_field::borrow<LpReferralRecordKey, LpReferralRecordMarker>(&arg0.id, v0).record_id == arg2, 9210);
    }

    fun assert_lp_reward_topology<T0: drop>(arg0: &LpPointState<T0>) {
        assert!(lp_reward_topology_registered<T0>(arg0), 9212);
    }

    fun assert_lp_state_match<T0: drop, T1: drop, T2: drop>(arg0: &PointConfig, arg1: &LpPointState<T0>, arg2: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>) {
        assert!(arg1.point_config_id == 0x2::object::id<PointConfig>(arg0), 9203);
        assert!(arg1.pool_id == 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg2), 9204);
    }

    fun assert_market_active(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: 0x2::object::ID) {
        0x46c6f7c5176ffe3d6706ed7bee5e31447071f9a5227e29d96179d5e7b5d73ea1::package_version::assert_current(arg0);
        0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::assert_target_active<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::package_version::PackageMarker>(arg0, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::package_version::version(), b"market", arg1, 9225);
    }

    fun assert_no_lp_referral_record<T0: drop>(arg0: &LpPointState<T0>, arg1: 0x2::object::ID) {
        let v0 = LpReferralRecordKey{pos0: arg1};
        assert!(!0x2::dynamic_field::exists<LpReferralRecordKey>(&arg0.id, v0), 9211);
    }

    fun assert_no_yt_referral_record(arg0: &PointConfig, arg1: 0x2::object::ID) {
        let v0 = YtReferralRecordKey{pos0: arg1};
        assert!(!0x2::dynamic_field::exists<YtReferralRecordKey>(&arg0.id, v0), 9211);
    }

    fun assert_project_match(arg0: &PointConfig, arg1: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::Project) {
        assert!(arg0.project_object_id == 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::id(arg1), 9203);
        assert!(arg0.scoreboard_id == 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::scoreboard_id(arg1), 9216);
    }

    fun assert_project_scoreboard_match(arg0: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::Project, arg1: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::scoreboard::Scoreboard) {
        assert!(0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::scoreboard_id(arg0) == 0x2::object::id<0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::scoreboard::Scoreboard>(arg1), 9216);
        assert!(0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::project_id(arg0) == *0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::scoreboard::get_scoreboard_project_ID(arg1), 9216);
    }

    fun assert_referral_close_matches(arg0: &PointConfig, arg1: &0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::ReferralPolicyState) {
        assert!(!0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::closed(arg1) || arg0.closed, 9224);
    }

    fun assert_referral_record_match<T0: drop>(arg0: &LpPointState<T0>, arg1: &0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::LpReferralRecord, arg2: 0x2::object::ID) {
        assert!(0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::lp_referral_record_source_id(arg1) == 0x2::object::id<LpPointState<T0>>(arg0), 9210);
        assert!(0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::lp_referral_record_pool_id(arg1) == arg2, 9210);
    }

    fun assert_scoreboard_match(arg0: &PointConfig, arg1: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::scoreboard::Scoreboard) {
        assert!(arg0.scoreboard_id == 0x2::object::id<0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::scoreboard::Scoreboard>(arg1), 9216);
    }

    fun assert_yt_checkpoint_owner(arg0: &PointConfig, arg1: 0x2::object::ID, arg2: address) {
        let v0 = PositionKey{pos0: arg1};
        if (0x2::dynamic_field::exists<PositionKey>(&arg0.id, v0)) {
            let v1 = 0x2::dynamic_field::borrow<PositionKey, YtPositionContribution>(&arg0.id, v0);
            assert!(v1.owner == arg2 || v1.raw_amount == 0, 9208);
        };
    }

    fun assert_yt_market_allowed(arg0: &PointConfig, arg1: 0x2::object::ID) {
        assert!(yt_market_allowed(arg0, arg1), 9207);
    }

    fun assert_yt_referral_record_marker(arg0: &PointConfig, arg1: 0x2::object::ID, arg2: 0x2::object::ID) {
        let v0 = YtReferralRecordKey{pos0: arg1};
        assert!(0x2::dynamic_field::exists<YtReferralRecordKey>(&arg0.id, v0), 9210);
        assert!(0x2::dynamic_field::borrow<YtReferralRecordKey, YtReferralRecordMarker>(&arg0.id, v0).record_id == arg2, 9210);
    }

    fun assert_yt_referral_record_match(arg0: &PointConfig, arg1: &0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::YtReferralRecord, arg2: 0x2::object::ID, arg3: 0x2::object::ID) {
        assert!(0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::yt_referral_record_source_id(arg1) == 0x2::object::id<PointConfig>(arg0), 9210);
        assert!(0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::yt_referral_record_market_id(arg1) == arg2, 9210);
        assert!(0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::yt_referral_record_position_id(arg1) == arg3, 9210);
    }

    public fun attach_lp_point_rewarders_by_admin<T0: drop, T1: drop, T2: drop>(arg0: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardDistributor, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: &PointConfig, arg3: &mut LpPointState<T0>, arg4: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::scoreboard::Scoreboard, arg5: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg6: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::admin::AdminCap, arg7: &0x2::clock::Clock) {
        assert_market_active(arg1, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg5));
        assert_scoreboard_match(arg2, arg4);
        ensure_market_reward_distributor<T0, T1, T2>(arg5, arg0, arg1, arg6);
        assert_lp_state_match<T0, T1, T2>(arg2, arg3, arg5);
        assert!(!arg3.reward_attached, 9205);
        let v0 = 0x1::option::is_some<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewarderSettlementCap>(&arg3.lp_settlement_cap);
        assert!(v0 == 0x1::option::is_some<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewarderSettlementCap>(&arg3.pool_settlement_cap), 9212);
        let v1 = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg5);
        assert!(!v0, 9205);
        0x1::option::fill<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewarderSettlementCap>(&mut arg3.lp_settlement_cap, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::register_rewarder_with_settlement_cap_by_admin(arg0, arg1, arg6, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::lp_scope(), lp_rewarder_id<T0>(arg3), b"liquidlink", b"liquidlink.lp"));
        0x1::option::fill<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewarderSettlementCap>(&mut arg3.pool_settlement_cap, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::register_rewarder_with_settlement_cap_by_admin(arg0, arg1, arg6, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::pool_scope(), pool_rewarder_id<T0>(arg3), b"liquidlink", b"liquidlink.pool"));
        prepare_lp_attachment<T0>(arg2, arg3, arg7);
        emit_reward_attachment(arg2, v1, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::lp_scope(), lp_rewarder_id<T0>(arg3), true);
        emit_reward_attachment(arg2, v1, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::pool_scope(), pool_rewarder_id<T0>(arg3), true);
    }

    public fun attach_yt_rewarder_by_admin<T0: drop, T1: drop, T2: drop>(arg0: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardDistributor, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: &mut PointConfig, arg3: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::scoreboard::Scoreboard, arg4: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg5: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::admin::AdminCap, arg6: &0x2::clock::Clock) {
        assert_market_active(arg1, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg4));
        assert_scoreboard_match(arg2, arg3);
        ensure_market_reward_distributor<T0, T1, T2>(arg4, arg0, arg1, arg5);
        let v0 = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg4);
        allow_yt_market(arg2, v0);
        prepare_yt_attachment<T0, T1, T2>(arg2, arg4, arg6);
        let v1 = YtMarketAllowedKey{pos0: v0};
        let v2 = 0x2::dynamic_field::borrow_mut<YtMarketAllowedKey, YtMarketExposure>(&mut arg2.id, v1);
        assert!(0x1::option::is_none<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewarderSettlementCap>(&v2.settlement_cap), 9205);
        0x1::option::fill<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewarderSettlementCap>(&mut v2.settlement_cap, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::register_rewarder_with_settlement_cap_by_admin(arg0, arg1, arg5, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::yt_scope(), 0x2::object::id<PointConfig>(arg2), b"liquidlink", b"liquidlink.yt"));
        emit_reward_attachment(arg2, v0, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::yt_scope(), 0x2::object::id<PointConfig>(arg2), true);
    }

    fun attachment_lp_record_values<T0: drop>(arg0: &LpPointState<T0>, arg1: u64) : (u64, u256, u256) {
        assert!(arg0.acc_point_per_lp >= arg0.attachment_acc_point_per_lp, 9201);
        let (v0, v1) = pending_lp_points_from_debt(arg1, arg0.acc_point_per_lp, lp_reward_debt(arg1, arg0.attachment_acc_point_per_lp), 0);
        (v0, v1, lp_reward_debt(arg1, arg0.acc_point_per_lp))
    }

    fun bonus_stamp(arg0: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg1: &0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::ReferralPolicyState, arg2: 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::stamp::LiquidlinkStamp) : 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::stamp::LiquidlinkStamp {
        let v0 = JitterPointSource{dummy_field: false};
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::stamp::require_confirm_only<JitterPointSource, 0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::JitterReferralPolicy>(arg0, v0, &mut arg2, 0x2::object::id<0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::ReferralPolicyState>(arg1));
        arg2
    }

    fun bump_config_version(arg0: &mut PointConfig) {
        assert!(arg0.config_version < 18446744073709551615, 9201);
        arg0.config_version = arg0.config_version + 1;
    }

    fun carry_lp_fraction_to_q128<T0: drop>(arg0: &mut LpPointState<T0>, arg1: u64) {
        if (arg0.point_numerator_remainder == 0) {
            return
        };
        let v0 = 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::point_math::denominator(arg1);
        assert!(arg0.point_numerator_remainder < v0, 9201);
        assert!(arg0.point_numerator_remainder <= 115792089237316195423570985008687907853269984665640564039457584007913129639935 / 340282366920938463463374607431768211456, 9201);
        let v1 = arg0.point_numerator_remainder * 340282366920938463463374607431768211456 / v0;
        assert!(arg0.point_fraction_remainder_q128 <= 115792089237316195423570985008687907853269984665640564039457584007913129639935 - v1, 9201);
        arg0.point_fraction_remainder_q128 = arg0.point_fraction_remainder_q128 + v1;
        arg0.point_numerator_remainder = 0;
    }

    fun checked_add_points(arg0: u64, arg1: u64) : u64 {
        assert!(arg0 <= 18446744073709551615 - arg1, 9201);
        arg0 + arg1
    }

    fun checked_add_pool_points(arg0: u128, arg1: u128) : u128 {
        assert!(arg0 <= 340282366920938463463374607431768211455 - arg1, 9201);
        arg0 + arg1
    }

    public fun checkpoint_closed_lp<T0: drop, T1: drop, T2: drop>(arg0: &PointConfig, arg1: &mut LpPointState<T0>, arg2: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg3: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition, arg4: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert_market_active(arg2, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg4));
        assert!(arg0.closed, 9226);
        assert_lp_state_match<T0, T1, T2>(arg0, arg1, arg4);
        assert_lp_position_match<T0>(arg1, arg3);
        assert_generic_lp_settlement_allowed<T0>(arg1, 0x2::object::id<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition>(arg3));
        archive_closed_lp<T0, T1, T2>(arg0, arg1, arg3, arg4, arg5, 0x1::option::none<0x2::object::ID>(), 0x1::option::none<0x2::object::ID>(), arg6);
        sync_lp_claim_transfer_lock<T0>(arg1, arg2, arg3);
    }

    public fun checkpoint_closed_lp_with_referral<T0: drop, T1: drop, T2: drop>(arg0: &PointConfig, arg1: &mut LpPointState<T0>, arg2: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg3: &0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::ReferralPolicyState, arg4: &mut 0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::LpReferralRecord, arg5: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition, arg6: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert_market_active(arg2, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg6));
        assert!(arg0.closed && 0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::closed(arg3), 9226);
        assert_lp_state_match<T0, T1, T2>(arg0, arg1, arg6);
        assert_lp_position_match<T0>(arg1, arg5);
        assert_referral_record_match<T0>(arg1, arg4, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg6));
        assert!(0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::lp_referral_record_position_id(arg4) == 0x2::object::id<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition>(arg5), 9210);
        if (lp_position_archived<T0>(arg1, 0x2::object::id<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition>(arg5))) {
            return
        };
        assert_lp_referral_record_marker<T0>(arg1, 0x2::object::id<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition>(arg5), 0x2::object::id<0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::LpReferralRecord>(arg4));
        assert!(0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::lp_referral_record_referee(arg4) == 0x2::tx_context::sender(arg8), 9210);
        update_pool_lp_points<T0, T1, T2>(arg0, arg1, arg6, arg7);
        let v0 = JitterLpPointSource{dummy_field: false};
        0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::archive_lp_referral<JitterLpPointSource>(arg2, v0, lp_referral_source_cap_ref<T0>(arg1), arg3, arg4, arg1.acc_point_per_lp, arg8);
        archive_closed_lp<T0, T1, T2>(arg0, arg1, arg5, arg6, arg7, 0x1::option::some<0x2::object::ID>(0x2::object::id<0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::ReferralPolicyState>(arg3)), 0x1::option::some<0x2::object::ID>(0x2::object::id<0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::LpReferralRecord>(arg4)), arg8);
        remove_lp_referral_record_marker<T0>(arg1, 0x2::object::id<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition>(arg5), 0x2::object::id<0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::LpReferralRecord>(arg4));
        let v1 = JitterLpPointSource{dummy_field: false};
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::remove_scoped_transfer_lock<JitterLpPointSource>(arg2, arg5, 0x2::object::id<LpPointState<T0>>(arg1), v1);
        sync_lp_claim_transfer_lock<T0>(arg1, arg2, arg5);
    }

    public fun checkpoint_closed_yt<T0: drop, T1: drop, T2: drop>(arg0: &mut PointConfig, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition, arg3: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_market_active(arg1, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg3));
        assert!(arg0.closed, 9226);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::assert_market_state_match(arg2, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg3));
        assert_generic_yt_settlement_allowed(arg0, 0x2::object::id<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition>(arg2));
        archive_closed_yt<T0, T1, T2>(arg0, arg2, arg3, arg4, 0x1::option::none<0x2::object::ID>(), 0x1::option::none<0x2::object::ID>(), arg5);
    }

    public fun checkpoint_closed_yt_with_referral<T0: drop, T1: drop, T2: drop>(arg0: &mut PointConfig, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: &0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::ReferralPolicyState, arg3: &mut 0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::YtReferralRecord, arg4: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition, arg5: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert_market_active(arg1, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg5));
        assert!(arg0.closed && 0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::closed(arg2), 9226);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::assert_market_state_match(arg4, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg5));
        assert_yt_referral_record_match(arg0, arg3, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg5), 0x2::object::id<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition>(arg4));
        if (yt_position_archived(arg0, 0x2::object::id<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition>(arg4))) {
            return
        };
        assert_yt_referral_record_marker(arg0, 0x2::object::id<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition>(arg4), 0x2::object::id<0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::YtReferralRecord>(arg3));
        assert!(0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::yt_referral_record_referee(arg3) == 0x2::tx_context::sender(arg7), 9210);
        let v0 = update_yt_market_points<T0, T1, T2>(arg0, arg5, arg6);
        let v1 = JitterYtPointSource{dummy_field: false};
        0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::archive_yt_referral<JitterYtPointSource>(arg1, v1, yt_referral_source_cap_ref(arg0), arg2, arg3, v0, arg7);
        archive_closed_yt<T0, T1, T2>(arg0, arg4, arg5, arg6, 0x1::option::some<0x2::object::ID>(0x2::object::id<0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::ReferralPolicyState>(arg2)), 0x1::option::some<0x2::object::ID>(0x2::object::id<0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::YtReferralRecord>(arg3)), arg7);
        remove_yt_referral_record_marker(arg0, 0x2::object::id<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition>(arg4), 0x2::object::id<0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::YtReferralRecord>(arg3));
        let v2 = JitterYtPointSource{dummy_field: false};
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::remove_scoped_transfer_lock<JitterYtPointSource>(arg1, arg4, 0x2::object::id<PointConfig>(arg0), v2);
    }

    public fun checkpoint_lp_config_to_version<T0: drop, T1: drop, T2: drop>(arg0: &PointConfig, arg1: &mut LpPointState<T0>, arg2: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg3: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg4: u64, arg5: &0x2::clock::Clock) {
        assert_market_active(arg2, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg3));
        let v0 = arg0.lp_config_version;
        let (v1, v2) = checkpoint_pool_lp_points_to_version<T0, T1, T2>(arg0, arg1, arg3, arg4, arg5);
        let v3 = PointConfigCheckpointedEvent{
            config_id             : 0x2::object::id<PointConfig>(arg0),
            subject_id            : 0x2::object::id<LpPointState<T0>>(arg1),
            scope                 : 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::lp_scope(),
            from_version          : v1,
            to_version            : arg4,
            current_version       : v0,
            checkpointed_until_ms : v2,
            complete              : arg4 == v0,
        };
        0x2::event::emit<PointConfigCheckpointedEvent>(v3);
    }

    public fun checkpoint_lp_pool<T0: drop, T1: drop, T2: drop>(arg0: &PointConfig, arg1: &mut LpPointState<T0>, arg2: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg3: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg4: &0x2::clock::Clock) {
        assert_market_active(arg2, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg3));
        update_pool_lp_points<T0, T1, T2>(arg0, arg1, arg3, arg4);
    }

    fun checkpoint_pool_lp_points_to_version<T0: drop, T1: drop, T2: drop>(arg0: &PointConfig, arg1: &mut LpPointState<T0>, arg2: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg3: u64, arg4: &0x2::clock::Clock) : (u64, u64) {
        assert_lp_state_match<T0, T1, T2>(arg0, arg1, arg2);
        assert!(arg1.reward_attached, 9217);
        let v0 = arg1.point_config_version;
        assert!(v0 < arg3, 9220);
        assert!(arg3 <= arg0.lp_config_version, 9220);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        let v2 = arg1.last_updated_ms;
        let v3 = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::circulating_lp_supply<T0, T1, T2>(arg2);
        sync_lp_supply<T0>(arg1, v3);
        let v4 = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::total_pool_sy<T0, T1, T2>(arg2);
        let v5 = 0x1::u64::min(v1, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::expiry<T0, T1, T2>(arg2));
        let v6 = v2;
        let v7 = 0;
        while (arg1.point_config_version < arg3) {
            let v8 = *lp_config_version_ref(arg0, arg1.point_config_version);
            let v9 = lp_config_version_ref(arg0, arg1.point_config_version + 1);
            assert!(v9.effective_at_ms <= v1, 9203);
            let v10 = 0x1::u64::min(v5, v9.effective_at_ms);
            let v11 = LpHistoryRepairKey{pos0: arg1.point_config_version};
            if (0x2::dynamic_field::exists<LpHistoryRepairKey>(&arg1.id, v11)) {
                let v12 = 0x2::dynamic_field::borrow<LpHistoryRepairKey, LpHistoryRepair>(&arg1.id, v11);
                assert!(v12.from_ms == v6 && v12.until_ms == v10, 9221);
                v8.multiplier_bps = v12.multiplier_bps;
                v8.duration = v12.duration;
            };
            if (v10 > v6) {
                let v13 = accrue_lp_interval<T0>(arg1, v4, v3, &v8, v10 - v6);
                v7 = checked_add_pool_points(v7, v13);
            };
            if (v8.duration != v9.duration) {
                carry_lp_fraction_to_q128<T0>(arg1, v8.duration);
            };
            arg1.point_config_version = arg1.point_config_version + 1;
            let v14 = 0x1::u64::max(v6, v9.effective_at_ms);
            v6 = 0x1::u64::min(v5, v14);
        };
        let v15 = arg3 == arg0.lp_config_version;
        let v16 = lp_config_version_ref(arg0, arg1.point_config_version);
        if (v15 && v5 > v6) {
            let v17 = accrue_lp_interval<T0>(arg1, v4, v3, v16, v5 - v6);
            v7 = checked_add_pool_points(v7, v17);
            v6 = v5;
        };
        let v18 = if (v15) {
            v1
        } else {
            v6
        };
        finish_pool_lp_checkpoint<T0, T1, T2>(arg1, arg2, v2, v18, v6, v4, v3, v7, v16.duration);
        (v0, arg1.last_updated_ms)
    }

    public fun checkpoint_yt<T0: drop, T1: drop, T2: drop>(arg0: &mut PointConfig, arg1: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::Project, arg2: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg3: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg4: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition, arg5: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) : 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::stamp::LiquidlinkStamp {
        assert_market_active(arg2, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg5));
        assert_generic_yt_settlement_allowed(arg0, 0x2::object::id<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition>(arg4));
        assert_yt_checkpoint_owner(arg0, 0x2::object::id<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition>(arg4), 0x2::tx_context::sender(arg7));
        sync_py_position<T0, T1, T2>(arg3, arg0, arg1, arg4, arg5, arg6, 0x2::tx_context::sender(arg7))
    }

    public fun checkpoint_yt_config_to_version<T0: drop, T1: drop, T2: drop>(arg0: &mut PointConfig, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg3: u64, arg4: &0x2::clock::Clock) {
        assert_market_active(arg1, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg2));
        let v0 = arg0.yt_config_version;
        let (v1, v2) = checkpoint_yt_market_points_to_version<T0, T1, T2>(arg0, arg2, arg3, arg4);
        let v3 = PointConfigCheckpointedEvent{
            config_id             : 0x2::object::id<PointConfig>(arg0),
            subject_id            : 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg2),
            scope                 : 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::yt_scope(),
            from_version          : v1,
            to_version            : arg3,
            current_version       : v0,
            checkpointed_until_ms : v2,
            complete              : arg3 == v0,
        };
        0x2::event::emit<PointConfigCheckpointedEvent>(v3);
    }

    fun checkpoint_yt_market_points_inner(arg0: &mut YtMarketExposure, arg1: &vector<YtConfigVersion>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64) {
        assert!(arg0.initialized, 9203);
        assert!(arg0.expiry_ms == arg5, 9203);
        assert!(arg0.point_config_version < arg3, 9220);
        assert!(arg3 <= arg4, 9220);
        assert!(0x1::vector::length<YtConfigVersion>(arg1) == arg3 - arg0.point_config_version + 1, 9203);
        let v0 = arg0.last_updated_ms;
        let v1 = 0;
        while (arg0.point_config_version < arg3) {
            let v2 = 0x1::vector::borrow<YtConfigVersion>(arg1, v1);
            let v3 = 0x1::vector::borrow<YtConfigVersion>(arg1, v1 + 1);
            assert!(v3.effective_at_ms <= arg7, 9203);
            let v4 = 0x1::u64::min(arg6, v3.effective_at_ms);
            if (v4 > v0) {
                accrue_yt_interval(arg0, v2, arg2, v4 - v0);
            };
            if (v2.duration != v3.duration) {
                arg0.point_numerator_remainder = 0;
            };
            arg0.point_config_version = arg0.point_config_version + 1;
            v1 = v1 + 1;
            let v5 = 0x1::u64::max(v0, v3.effective_at_ms);
            v0 = 0x1::u64::min(arg6, v5);
        };
        if (arg3 == arg4) {
            let v6 = 0x1::vector::borrow<YtConfigVersion>(arg1, v1);
            if (arg6 > v0) {
                accrue_yt_interval(arg0, v6, arg2, arg6 - v0);
            };
            v0 = arg6;
        };
        arg0.last_updated_ms = v0;
    }

    fun checkpoint_yt_market_points_to_version<T0: drop, T1: drop, T2: drop>(arg0: &mut PointConfig, arg1: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg2: u64, arg3: &0x2::clock::Clock) : (u64, u64) {
        let v0 = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg1);
        let v1 = YtMarketAllowedKey{pos0: v0};
        assert_yt_market_allowed(arg0, v0);
        let v2 = 0x2::clock::timestamp_ms(arg3);
        let v3 = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::expiry<T0, T1, T2>(arg1);
        let v4 = 0x2::dynamic_field::borrow<YtMarketAllowedKey, YtMarketExposure>(&arg0.id, v1);
        let v5 = v4.point_config_version;
        assert!(v4.initialized, 9203);
        assert!(v4.reward_attached, 9217);
        assert!(v5 < arg2, 9220);
        assert!(arg2 <= arg0.yt_config_version, 9220);
        let v6 = 0x1::vector::empty<YtConfigVersion>();
        loop {
            0x1::vector::push_back<YtConfigVersion>(&mut v6, *yt_config_version_ref(arg0, v5));
            if (v5 == arg2) {
                break
            };
            v5 = v5 + 1;
        };
        let v7 = 0x2::dynamic_field::borrow_mut<YtMarketAllowedKey, YtMarketExposure>(&mut arg0.id, v1);
        checkpoint_yt_market_points_inner(v7, &v6, yt_market_multiplier_bps(arg0, v0), arg2, arg0.yt_config_version, v3, 0x1::u64::min(v2, v3), v2);
        (v5, v7.last_updated_ms)
    }

    public fun claim_closed_points(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg2: &PointConfig, arg3: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::Project, arg4: 0x46c6f7c5176ffe3d6706ed7bee5e31447071f9a5227e29d96179d5e7b5d73ea1::point_claim::PointClaim, arg5: &0x2::tx_context::TxContext) : 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::stamp::LiquidlinkStamp {
        assert_market_active(arg0, 0x46c6f7c5176ffe3d6706ed7bee5e31447071f9a5227e29d96179d5e7b5d73ea1::point_claim::market_id(&arg4));
        assert!(arg2.closed, 9226);
        assert!(0x46c6f7c5176ffe3d6706ed7bee5e31447071f9a5227e29d96179d5e7b5d73ea1::point_claim::config_id(&arg4) == 0x2::object::id<PointConfig>(arg2), 9203);
        assert!(0x46c6f7c5176ffe3d6706ed7bee5e31447071f9a5227e29d96179d5e7b5d73ea1::point_claim::closed_at_ms(&arg4) == arg2.closed_at_ms, 9203);
        assert_project_match(arg2, arg3);
        let v0 = 0x46c6f7c5176ffe3d6706ed7bee5e31447071f9a5227e29d96179d5e7b5d73ea1::point_claim::referral_state_id(&arg4);
        let v1 = new_point_stamp(arg1, arg2, arg3, 0x46c6f7c5176ffe3d6706ed7bee5e31447071f9a5227e29d96179d5e7b5d73ea1::point_claim::owner(&arg4), 0x46c6f7c5176ffe3d6706ed7bee5e31447071f9a5227e29d96179d5e7b5d73ea1::point_claim::position_id(&arg4), 0x46c6f7c5176ffe3d6706ed7bee5e31447071f9a5227e29d96179d5e7b5d73ea1::point_claim::take(arg4, arg5));
        if (0x1::option::is_some<0x2::object::ID>(&v0)) {
            let v2 = JitterPointSource{dummy_field: false};
            0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::stamp::require_confirm_only<JitterPointSource, 0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::JitterReferralPolicy>(arg1, v2, &mut v1, *0x1::option::borrow<0x2::object::ID>(&v0));
        };
        v1
    }

    public fun claim_lp_points<T0: drop, T1: drop, T2: drop>(arg0: &PointConfig, arg1: &mut LpPointState<T0>, arg2: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::Project, arg3: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg4: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg5: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg6: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) : (u64, 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::stamp::LiquidlinkStamp) {
        assert_market_active(arg3, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg5));
        assert_project_match(arg0, arg2);
        assert_generic_lp_settlement_allowed<T0>(arg1, 0x2::object::id<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition>(arg6));
        update_pool_lp_points<T0, T1, T2>(arg0, arg1, arg5, arg7);
        let (_, v1) = settle_lp_position<T0>(arg1, arg6, 0x2::tx_context::sender(arg8));
        assert!(v1 == 0, 9208);
        let v2 = take_lp_points<T0>(arg1, 0x2::object::id<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition>(arg6), 0x2::tx_context::sender(arg8));
        sync_lp_claim_transfer_lock<T0>(arg1, arg3, arg6);
        (v2, new_lp_point_stamp<T0>(arg4, arg0, arg2, 0x2::tx_context::sender(arg8), 0x2::object::id<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition>(arg6), v2, arg1, true))
    }

    public fun claim_lp_points_with_referral_points<T0: drop, T1: drop, T2: drop>(arg0: &PointConfig, arg1: &mut LpPointState<T0>, arg2: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg3: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg4: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::Project, arg5: &0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::ReferralPolicyState, arg6: &mut 0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::LpReferralRecord, arg7: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg8: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition, arg9: &0x2::clock::Clock, arg10: &0x2::tx_context::TxContext) : (u64, 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::stamp::LiquidlinkStamp) {
        assert_market_active(arg2, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg7));
        update_pool_lp_points<T0, T1, T2>(arg0, arg1, arg7, arg9);
        let (_, v1) = settle_lp_position_with_referral<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg8, 0x2::tx_context::sender(arg10));
        assert!(v1 == 0, 9208);
        let v2 = take_lp_points<T0>(arg1, 0x2::object::id<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition>(arg8), 0x2::tx_context::sender(arg10));
        sync_lp_claim_transfer_lock<T0>(arg1, arg2, arg8);
        (v2, bonus_stamp(arg3, arg5, new_lp_point_stamp<T0>(arg3, arg0, arg4, 0x2::tx_context::sender(arg10), 0x2::object::id<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition>(arg8), v2, arg1, true)))
    }

    public fun claim_lp_referral_points_with_points<T0: drop, T1: drop, T2: drop>(arg0: &PointConfig, arg1: &mut LpPointState<T0>, arg2: &mut 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::scoreboard::Scoreboard, arg3: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg4: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg5: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::Project, arg6: &0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::ReferralPolicyState, arg7: &mut 0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::LpReferralRecord, arg8: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg9: &0x2::clock::Clock) {
        assert_market_active(arg3, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg8));
        assert_scoreboard_match(arg0, arg2);
        assert_project_match(arg0, arg5);
        assert_lp_state_match<T0, T1, T2>(arg0, arg1, arg8);
        assert_referral_close_matches(arg0, arg6);
        assert_referral_record_match<T0>(arg1, arg7, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg8));
        assert_lp_referral_record_marker<T0>(arg1, 0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::lp_referral_record_position_id(arg7), 0x2::object::id<0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::LpReferralRecord>(arg7));
        update_pool_lp_points<T0, T1, T2>(arg0, arg1, arg8, arg9);
        let v0 = JitterLpPointSource{dummy_field: false};
        0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::claim_lp_referral<JitterLpPointSource>(arg3, arg4, arg5, v0, lp_referral_source_cap_ref<T0>(arg1), arg6, arg7, arg2, arg1.acc_point_per_lp, arg0.duration);
    }

    public fun claim_yt_referral_points_with_points<T0: drop, T1: drop, T2: drop>(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg2: &mut PointConfig, arg3: &mut 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::scoreboard::Scoreboard, arg4: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::Project, arg5: &0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::ReferralPolicyState, arg6: &mut 0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::YtReferralRecord, arg7: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg8: &0x2::clock::Clock) {
        assert_market_active(arg0, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg7));
        assert_scoreboard_match(arg2, arg3);
        assert_project_match(arg2, arg4);
        let v0 = 0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::yt_referral_record_position_id(arg6);
        assert_yt_referral_record_match(arg2, arg6, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg7), v0);
        assert_yt_referral_record_marker(arg2, v0, 0x2::object::id<0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::YtReferralRecord>(arg6));
        let v1 = update_yt_market_points<T0, T1, T2>(arg2, arg7, arg8);
        sync_yt_referral_from_contribution(arg0, arg1, arg2, arg4, arg5, arg6, v0, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg7));
        let v2 = JitterYtPointSource{dummy_field: false};
        0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::claim_yt_referral<JitterYtPointSource>(arg0, arg1, arg4, v2, yt_referral_source_cap_ref(arg2), arg5, arg6, arg3, v1, arg2.duration);
    }

    public fun close_by_admin(arg0: &mut PointConfig, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::admin::AdminCap, arg3: &0x2::clock::Clock) {
        0x46c6f7c5176ffe3d6706ed7bee5e31447071f9a5227e29d96179d5e7b5d73ea1::package_version::assert_current(arg1);
        if (arg0.closed) {
            return
        };
        let v0 = 0x2::clock::timestamp_ms(arg3);
        set_enabled(arg0, false, v0);
        arg0.closed = true;
        arg0.closed_at_ms = v0;
        let v1 = PointConfigClosedEvent{
            config_id         : 0x2::object::id<PointConfig>(arg0),
            closed_at_ms      : v0,
            yt_config_version : arg0.yt_config_version,
            lp_config_version : arg0.lp_config_version,
        };
        0x2::event::emit<PointConfigClosedEvent>(v1);
    }

    public fun close_referral_campaign_by_admin(arg0: &mut PointConfig, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::admin::AdminCap, arg3: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg4: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project_cap::ProjectCap, arg5: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::Project, arg6: &mut 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::scoreboard::Scoreboard, arg7: &mut 0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::ReferralPolicyState, arg8: &0x2::clock::Clock) {
        assert_project_scoreboard_match(arg5, arg6);
        assert!(arg0.project_object_id == 0x2::object::id<0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::Project>(arg5), 9203);
        assert!(arg0.scoreboard_id == 0x2::object::id<0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::scoreboard::Scoreboard>(arg6), 9203);
        assert!(0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::project_object_id(arg7) == 0x2::object::id<0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::Project>(arg5), 9203);
        close_by_admin(arg0, arg1, arg2, arg8);
        0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::close_campaign(arg1, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public fun closed_at_ms(arg0: &PointConfig) : u64 {
        arg0.closed_at_ms
    }

    public fun config_version(arg0: &PointConfig) : u64 {
        arg0.config_version
    }

    fun create_and_share(arg0: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg1: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project_cap::ProjectCap, arg2: &mut 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::Project, arg3: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::scoreboard::Scoreboard, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = new_point_config(0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::id(arg2), 0x2::object::id<0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::scoreboard::Scoreboard>(arg3), arg4, arg5, arg6, true, arg7);
        let v1 = 0x2::object::id<PointConfig>(&v0);
        let v2 = JitterPointSource{dummy_field: false};
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::register_auth_source<JitterPointSource>(arg0, arg1, arg2, v2, v1);
        let v3 = PointConfigCreatedEvent{
            config_id         : v1,
            project_object_id : 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::id(arg2),
            scoreboard_id     : 0x2::object::id<0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::scoreboard::Scoreboard>(arg3),
            owner             : 0x2::tx_context::sender(arg7),
            yt_multiplier_bps : arg4,
            lp_multiplier_bps : arg5,
            duration          : arg6,
            enabled           : true,
            total_yt_amount   : v0.total_yt_amount,
            total_yt_base     : v0.total_yt_base,
            config_version    : v0.config_version,
            yt_config_version : v0.yt_config_version,
            lp_config_version : v0.lp_config_version,
        };
        0x2::event::emit<PointConfigCreatedEvent>(v3);
        0x2::transfer::share_object<PointConfig>(v0);
    }

    public fun create_and_share_by_admin(arg0: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg1: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project_cap::ProjectCap, arg2: &mut 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::Project, arg3: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::scoreboard::Scoreboard, arg4: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg5: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::admin::AdminCap, arg6: u64, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        0x46c6f7c5176ffe3d6706ed7bee5e31447071f9a5227e29d96179d5e7b5d73ea1::package_version::assert_current(arg4);
        assert_project_scoreboard_match(arg2, arg3);
        create_and_share(arg0, arg1, arg2, arg3, arg6, arg7, arg8, arg9);
    }

    public fun create_and_share_default_by_admin(arg0: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg1: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project_cap::ProjectCap, arg2: &mut 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::Project, arg3: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::scoreboard::Scoreboard, arg4: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg5: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::admin::AdminCap, arg6: &mut 0x2::tx_context::TxContext) {
        0x46c6f7c5176ffe3d6706ed7bee5e31447071f9a5227e29d96179d5e7b5d73ea1::package_version::assert_current(arg4);
        assert_project_scoreboard_match(arg2, arg3);
        create_and_share(arg0, arg1, arg2, arg3, 10000, 10000, 86400000, arg6);
    }

    fun create_and_share_lp_point_state<T0: drop, T1: drop, T2: drop>(arg0: &PointConfig, arg1: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = LpPointState<T0>{
            id                            : 0x2::object::new(arg3),
            initialized                   : false,
            lp_rewarder_uid               : 0x2::object::new(arg3),
            pool_rewarder_uid             : 0x2::object::new(arg3),
            point_config_id               : 0x2::object::id<PointConfig>(arg0),
            pool_id                       : 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg1),
            lp_settlement_cap             : 0x1::option::none<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewarderSettlementCap>(),
            pool_settlement_cap           : 0x1::option::none<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewarderSettlementCap>(),
            lp_referral_source_cap        : 0x1::option::none<0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::LpReferralSourceCap<JitterLpPointSource>>(),
            lp_multiplier_bps             : 10000,
            acc_point_per_lp              : 0,
            attachment_acc_point_per_lp   : 0,
            attachment_ms                 : 0,
            acc_point_remainder           : 0,
            point_numerator_remainder     : 0,
            point_fraction_remainder_q128 : 0,
            last_updated_ms               : 0x2::clock::timestamp_ms(arg2),
            total_lp_points_accrued       : 0,
            total_lp_points_saturated     : false,
            last_lp_supply                : 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::circulating_lp_supply<T0, T1, T2>(arg1),
            point_config_version          : arg0.lp_config_version,
            reward_attached               : false,
        };
        let v1 = LpPointStateCreatedEvent{
            state_id          : 0x2::object::id<LpPointState<T0>>(&v0),
            config_id         : 0x2::object::id<PointConfig>(arg0),
            pool_id           : 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg1),
            lp_multiplier_bps : 10000,
        };
        0x2::event::emit<LpPointStateCreatedEvent>(v1);
        0x2::transfer::share_object<LpPointState<T0>>(v0);
    }

    public fun create_lp_point_state_by_admin<T0: drop, T1: drop, T2: drop>(arg0: &PointConfig, arg1: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg2: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg3: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::admin::AdminCap, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_market_active(arg2, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg1));
        assert!(!arg0.closed, 9223);
        create_and_share_lp_point_state<T0, T1, T2>(arg0, arg1, arg4, arg5);
    }

    public fun create_lp_referral_record_with_points<T0: drop, T1: drop, T2: drop>(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg2: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::Project, arg3: &0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::ReferralPolicyState, arg4: &0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::bonding_table::ReferralTable, arg5: &PointConfig, arg6: &mut LpPointState<T0>, arg7: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg8: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::LpReferralRecord {
        assert_market_active(arg0, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg7));
        assert!(arg6.reward_attached, 9217);
        assert_lp_state_match<T0, T1, T2>(arg5, arg6, arg7);
        assert_lp_position_match<T0>(arg6, arg8);
        assert_no_lp_referral_record<T0>(arg6, 0x2::object::id<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition>(arg8));
        update_pool_lp_points<T0, T1, T2>(arg5, arg6, arg7, arg9);
        let v0 = JitterLpPointSource{dummy_field: false};
        let v1 = 0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::create_lp_referral_record<JitterLpPointSource>(arg0, arg1, arg2, v0, lp_referral_source_cap_ref<T0>(arg6), arg3, arg4, 0x2::tx_context::sender(arg10), 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg7), 0x2::object::id<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition>(arg8), 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::lp_amount(arg8), 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::lp_amount(arg8), arg6.acc_point_per_lp, arg10);
        mark_lp_referral_record<T0>(arg6, 0x2::object::id<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition>(arg8), 0x2::object::id<0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::LpReferralRecord>(&v1));
        let v2 = JitterLpPointSource{dummy_field: false};
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::add_scoped_transfer_lock<JitterLpPointSource>(arg0, arg8, 0x2::object::id<LpPointState<T0>>(arg6), v2);
        v1
    }

    public fun create_yt_referral_record_with_points<T0: drop, T1: drop, T2: drop>(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg2: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::Project, arg3: &0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::ReferralPolicyState, arg4: &0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::bonding_table::ReferralTable, arg5: &mut PointConfig, arg6: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg7: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::YtReferralRecord {
        assert_market_active(arg0, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg6));
        assert!(yt_reward_attached(arg5, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg6)), 9217);
        assert_project_match(arg5, arg2);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::assert_market_state_match(arg7, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg6));
        assert_no_yt_referral_record(arg5, 0x2::object::id<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition>(arg7));
        let v0 = update_yt_market_points<T0, T1, T2>(arg5, arg6, arg8);
        let v1 = assert_current_yt_contribution<T0, T1, T2>(arg5, arg6, arg7, 0x2::tx_context::sender(arg9), v0, arg8);
        let v2 = JitterYtPointSource{dummy_field: false};
        let v3 = 0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::create_yt_referral_record<JitterYtPointSource>(arg0, arg1, arg2, v2, yt_referral_source_cap_ref(arg5), arg3, arg4, 0x2::tx_context::sender(arg9), 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg6), 0x2::object::id<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition>(arg7), v1, v0, arg9);
        mark_yt_referral_record(arg5, 0x2::object::id<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition>(arg7), 0x2::object::id<0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::YtReferralRecord>(&v3));
        let v4 = JitterYtPointSource{dummy_field: false};
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::add_scoped_transfer_lock<JitterYtPointSource>(arg0, arg7, 0x2::object::id<PointConfig>(arg5), v4);
        v3
    }

    public fun destroy_empty_claim(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg2: 0x46c6f7c5176ffe3d6706ed7bee5e31447071f9a5227e29d96179d5e7b5d73ea1::point_claim::PointClaim, arg3: &0x2::tx_context::TxContext) {
        assert_market_active(arg0, 0x46c6f7c5176ffe3d6706ed7bee5e31447071f9a5227e29d96179d5e7b5d73ea1::point_claim::market_id(&arg2));
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::package_version::assert_domain_enabled(arg1, 0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::scoreboard_domain());
        0x46c6f7c5176ffe3d6706ed7bee5e31447071f9a5227e29d96179d5e7b5d73ea1::point_claim::destroy_empty(arg2, arg3);
    }

    public fun detach_lp_point_rewarders_by_admin<T0: drop, T1: drop, T2: drop>(arg0: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardDistributor, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: &PointConfig, arg3: &mut LpPointState<T0>, arg4: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::scoreboard::Scoreboard, arg5: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg6: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::admin::AdminCap, arg7: &0x2::clock::Clock) {
        assert_market_active(arg1, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg5));
        assert_scoreboard_match(arg2, arg4);
        assert_lp_state_match<T0, T1, T2>(arg2, arg3, arg5);
        assert!(arg3.reward_attached, 9217);
        update_pool_lp_points<T0, T1, T2>(arg2, arg3, arg5, arg7);
        let v0 = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg5);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::unregister_rewarder_by_admin(arg0, arg1, arg6, 0x1::option::borrow<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewarderSettlementCap>(&arg3.pool_settlement_cap));
        arg3.reward_attached = false;
        emit_reward_attachment(arg2, v0, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::lp_scope(), lp_rewarder_id<T0>(arg3), false);
        emit_reward_attachment(arg2, v0, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::pool_scope(), pool_rewarder_id<T0>(arg3), false);
    }

    public fun detach_lp_referral_record_with_points<T0: drop, T1: drop, T2: drop>(arg0: &PointConfig, arg1: &mut LpPointState<T0>, arg2: &mut 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::scoreboard::Scoreboard, arg3: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg4: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg5: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::Project, arg6: &0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::ReferralPolicyState, arg7: 0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::LpReferralRecord, arg8: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg9: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition, arg10: &0x2::clock::Clock, arg11: &0x2::tx_context::TxContext) {
        assert_market_active(arg3, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg8));
        assert_project_match(arg0, arg5);
        assert_lp_state_match<T0, T1, T2>(arg0, arg1, arg8);
        assert_lp_position_match<T0>(arg1, arg9);
        assert!(0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::lp_amount(arg9) == 0, 9214);
        assert_referral_record_match<T0>(arg1, &arg7, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg8));
        let v0 = 0x2::object::id<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition>(arg9);
        let v1 = 0x2::object::id<0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::LpReferralRecord>(&arg7);
        let v2 = 0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::lp_referral_record_referee(&arg7);
        assert!(v2 == 0x2::tx_context::sender(arg11), 9210);
        assert!(0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::lp_referral_record_position_id(&arg7) == v0, 9210);
        assert_lp_referral_record_marker<T0>(arg1, v0, v1);
        update_pool_lp_points<T0, T1, T2>(arg0, arg1, arg8, arg10);
        let v3 = &mut arg7;
        let (_, v5) = settle_lp_position_with_referral<T0>(arg0, arg1, arg3, arg4, arg5, arg6, v3, arg9, v2);
        assert!(v5 == 0, 9208);
        assert!(lp_pending_points<T0>(arg1, v0) == 0, 9215);
        let v6 = JitterLpPointSource{dummy_field: false};
        0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::claim_lp_referral<JitterLpPointSource>(arg3, arg4, arg5, v6, lp_referral_source_cap_ref<T0>(arg1), arg6, &mut arg7, arg2, arg1.acc_point_per_lp, arg0.duration);
        let v7 = remove_empty_lp_point_record<T0>(arg1, v0, v2);
        remove_lp_referral_record_marker<T0>(arg1, v0, v1);
        let v8 = JitterLpPointSource{dummy_field: false};
        let v9 = JitterLpPointSource{dummy_field: false};
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::remove_scoped_transfer_lock<JitterLpPointSource>(arg3, arg9, 0x2::object::id<LpPointState<T0>>(arg1), v9);
        sync_lp_claim_transfer_lock<T0>(arg1, arg3, arg9);
        let v10 = LpReferralDetachedEvent{
            state_id                     : 0x2::object::id<LpPointState<T0>>(arg1),
            position_id                  : v0,
            record_id                    : v1,
            referee                      : v2,
            referrer                     : 0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::lp_referral_record_referrer(&arg7),
            referee_points_claimed       : 0,
            referrer_points_claimed      : 0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::lp_referral_record_pending_points(&arg7),
            forfeited_referee_remainder  : v7,
            forfeited_referrer_remainder : 0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::close_lp_referral_record<JitterLpPointSource>(arg3, arg4, arg5, v8, lp_referral_source_cap_ref<T0>(arg1), arg6, arg7),
        };
        0x2::event::emit<LpReferralDetachedEvent>(v10);
    }

    public fun detach_yt_referral_record_with_points<T0: drop, T1: drop, T2: drop>(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg2: &mut PointConfig, arg3: &mut 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::scoreboard::Scoreboard, arg4: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::Project, arg5: &0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::ReferralPolicyState, arg6: 0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::YtReferralRecord, arg7: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg8: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition, arg9: &0x2::clock::Clock, arg10: &0x2::tx_context::TxContext) {
        assert_market_active(arg0, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg7));
        assert_scoreboard_match(arg2, arg3);
        assert_project_match(arg2, arg4);
        assert!(0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::yt_balance(arg8) == 0, 9209);
        let v0 = 0x2::object::id<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition>(arg8);
        let v1 = 0x2::object::id<0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::YtReferralRecord>(&arg6);
        let v2 = 0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::yt_referral_record_referee(&arg6);
        assert!(v2 == 0x2::tx_context::sender(arg10), 9210);
        assert_yt_referral_record_match(arg2, &arg6, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg7), v0);
        assert_yt_referral_record_marker(arg2, v0, v1);
        let v3 = update_yt_market_points<T0, T1, T2>(arg2, arg7, arg9);
        let v4 = &mut arg6;
        sync_yt_referral_from_contribution(arg0, arg1, arg2, arg4, arg5, v4, v0, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg7));
        assert!(0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::yt_referral_record_base_amount(&arg6) == 0, 9215);
        let v5 = JitterYtPointSource{dummy_field: false};
        0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::claim_yt_referral<JitterYtPointSource>(arg0, arg1, arg4, v5, yt_referral_source_cap_ref(arg2), arg5, &mut arg6, arg3, v3, arg2.duration);
        let v6 = remove_empty_yt_contribution(arg2, v0, v2);
        remove_yt_referral_record_marker(arg2, v0, v1);
        let v7 = JitterYtPointSource{dummy_field: false};
        let v8 = JitterYtPointSource{dummy_field: false};
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::remove_scoped_transfer_lock<JitterYtPointSource>(arg0, arg8, 0x2::object::id<PointConfig>(arg2), v8);
        let v9 = YtReferralDetachedEvent{
            config_id                    : 0x2::object::id<PointConfig>(arg2),
            market_id                    : 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg7),
            position_id                  : v0,
            record_id                    : v1,
            referee                      : v2,
            referrer                     : 0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::yt_referral_record_referrer(&arg6),
            referrer_points_claimed      : 0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::yt_referral_record_pending_points(&arg6),
            forfeited_referee_remainder  : v6,
            forfeited_referrer_remainder : 0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::close_yt_referral_record<JitterYtPointSource>(arg0, arg1, arg4, v7, yt_referral_source_cap_ref(arg2), arg5, arg6),
        };
        0x2::event::emit<YtReferralDetachedEvent>(v9);
    }

    public fun detach_yt_rewarder_by_admin<T0: drop, T1: drop, T2: drop>(arg0: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardDistributor, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: &mut PointConfig, arg3: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::scoreboard::Scoreboard, arg4: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg5: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::admin::AdminCap, arg6: &0x2::clock::Clock) {
        assert_market_active(arg1, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg4));
        assert_scoreboard_match(arg2, arg3);
        let v0 = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg4);
        assert!(yt_reward_attached(arg2, v0), 9217);
        update_yt_market_points<T0, T1, T2>(arg2, arg4, arg6);
        set_yt_reward_attached(arg2, v0, false);
        assert!(0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::reward_distributor_id<T0, T1, T2>(arg4) == 0x2::object::id<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardDistributor>(arg0), 9218);
        emit_reward_attachment(arg2, v0, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::yt_scope(), 0x2::object::id<PointConfig>(arg2), false);
    }

    public fun duration(arg0: &PointConfig) : u64 {
        arg0.duration
    }

    fun emit_config_updated(arg0: &PointConfig) {
        let v0 = PointConfigUpdatedEvent{
            config_id         : 0x2::object::id<PointConfig>(arg0),
            yt_multiplier_bps : arg0.yt_multiplier_bps,
            lp_multiplier_bps : arg0.lp_multiplier_bps,
            duration          : arg0.duration,
            enabled           : arg0.enabled,
            total_yt_amount   : arg0.total_yt_amount,
            total_yt_base     : arg0.total_yt_base,
            config_version    : arg0.config_version,
            yt_config_version : arg0.yt_config_version,
            lp_config_version : arg0.lp_config_version,
        };
        0x2::event::emit<PointConfigUpdatedEvent>(v0);
    }

    fun emit_reward_attachment(arg0: &PointConfig, arg1: 0x2::object::ID, arg2: u8, arg3: 0x2::object::ID, arg4: bool) {
        let v0 = PointRewardAttachmentUpdatedEvent{
            config_id     : 0x2::object::id<PointConfig>(arg0),
            scoreboard_id : arg0.scoreboard_id,
            market_id     : arg1,
            scope         : arg2,
            rewarder_id   : arg3,
            attached      : arg4,
        };
        0x2::event::emit<PointRewardAttachmentUpdatedEvent>(v0);
    }

    public fun enabled(arg0: &PointConfig) : bool {
        arg0.enabled
    }

    fun ensure_market_reward_distributor<T0: drop, T1: drop, T2: drop>(arg0: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg1: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardDistributor, arg2: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg3: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::admin::AdminCap) {
        assert!(0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::reward_distributor_required<T0, T1, T2>(arg0), 9218);
        assert!(0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::reward_distributor_id<T0, T1, T2>(arg0) == 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::id(arg1), 9218);
        assert!(0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::market_state_id(arg1) == 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg0), 9218);
    }

    fun ensure_market_yt_exposure(arg0: &mut PointConfig, arg1: 0x2::object::ID) {
        allow_yt_market(arg0, arg1);
    }

    fun ensure_user_yt_exposure(arg0: &mut PointConfig, arg1: address) {
        let v0 = UserKey{pos0: arg1};
        if (!0x2::dynamic_field::exists<UserKey>(&arg0.id, v0)) {
            let v1 = UserYtExposure{yt_base: 0};
            0x2::dynamic_field::add<UserKey, UserYtExposure>(&mut arg0.id, v0, v1);
        };
    }

    fun finish_pool_lp_checkpoint<T0: drop, T1: drop, T2: drop>(arg0: &mut LpPointState<T0>, arg1: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u128, arg8: u64) {
        if (arg6 > 0) {
            let v0 = take_cross_denominator_fraction<T0>(arg0, arg8);
            arg7 = checked_add_pool_points(arg7, v0);
        };
        arg0.last_updated_ms = arg3;
        if (arg7 == 0) {
            return
        };
        let (v1, v2) = accumulate_lp_points(arg7, arg6, arg0.acc_point_remainder);
        assert!(arg0.acc_point_per_lp <= 340282366920938463463374607431768211455 - v1, 9201);
        arg0.acc_point_per_lp = arg0.acc_point_per_lp + v1;
        arg0.acc_point_remainder = v2;
        let (v3, v4) = 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::point_math::add_telemetry(arg0.total_lp_points_accrued, arg7);
        arg0.total_lp_points_accrued = v3;
        let v5 = arg0.total_lp_points_saturated || v4;
        arg0.total_lp_points_saturated = v5;
        let v6 = if (arg4 > arg2) {
            arg4 - arg2
        } else {
            0
        };
        let v7 = LpPointAccumulatorUpdatedEvent{
            state_id                  : 0x2::object::id<LpPointState<T0>>(arg0),
            pool_id                   : 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg1),
            elapsed_ms                : v6,
            total_sy                  : arg5,
            circulating_lp_supply     : arg6,
            points_accrued            : arg7,
            total_saturated           : arg0.total_lp_points_saturated,
            point_numerator_remainder : arg0.point_numerator_remainder,
            acc_point_remainder       : v2,
            acc_point_per_lp          : arg0.acc_point_per_lp,
        };
        0x2::event::emit<LpPointAccumulatorUpdatedEvent>(v7);
    }

    fun initialize_yt_contribution<T0: drop, T1: drop, T2: drop>(arg0: &mut PointConfig, arg1: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg2: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition, arg3: address) {
        assert!(!yt_position_archived(arg0, 0x2::object::id<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition>(arg2)), 9227);
        let v0 = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg1);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::assert_market_state_match(arg2, v0);
        assert!(yt_reward_initialized(arg0, v0), 9217);
        let v1 = PositionKey{pos0: 0x2::object::id<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition>(arg2)};
        if (0x2::dynamic_field::exists<PositionKey>(&arg0.id, v1)) {
            return
        };
        let v2 = (0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::yt_balance(arg2) as u256);
        let v3 = YtMarketAllowedKey{pos0: v0};
        let v4 = 0x2::dynamic_field::borrow_mut<YtMarketAllowedKey, YtMarketExposure>(&mut arg0.id, v3);
        assert!(v2 <= v4.uncheckpointed_yt, 9208);
        v4.uncheckpointed_yt = v4.uncheckpointed_yt - v2;
        arg0.uncheckpointed_yt = arg0.uncheckpointed_yt - v2;
        mutate_user_yt_exposure(arg0, arg3, 0, v2);
        mutate_market_yt_exposure(arg0, v0, 0, 0, v2, v2);
        arg0.total_yt_amount = arg0.total_yt_amount + v2;
        arg0.total_yt_base = arg0.total_yt_base + v2;
        let v5 = YtPositionContribution{
            owner                  : arg3,
            raw_amount             : v2,
            base_amount            : v2,
            reward_debt_scaled     : yt_reward_debt_scaled(v2, v4.attachment_acc),
            point_remainder_scaled : 0,
        };
        0x2::dynamic_field::add<PositionKey, YtPositionContribution>(&mut arg0.id, v1, v5);
    }

    fun initialize_zero_lp_position_record<T0: drop>(arg0: &mut LpPointState<T0>, arg1: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition, arg2: address) {
        assert!(!lp_position_archived<T0>(arg0, 0x2::object::id<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition>(arg1)), 9227);
        assert!(arg0.initialized, 9217);
        assert!(0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::lp_amount(arg1) == 0, 9208);
        let v0 = 0x2::object::id<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition>(arg1);
        let v1 = PositionKey{pos0: v0};
        if (0x2::dynamic_field::exists<PositionKey>(&arg0.id, v1)) {
            let v2 = 0x2::dynamic_field::borrow_mut<PositionKey, LpLegPointRecord>(&mut arg0.id, v1);
            let v3 = if (v2.lp_amount == 0) {
                if (v2.reward_debt == 0) {
                    if (v2.pending_points == 0) {
                        v2.pending_point_remainder == 0
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            };
            assert!(v3, 9208);
            v2.owner = arg2;
            let v4 = LpLegPointsSettledEvent{
                state_id                : 0x2::object::id<LpPointState<T0>>(arg0),
                position_id             : v0,
                owner                   : arg2,
                pending_added           : 0,
                pending_total           : 0,
                pending_point_remainder : 0,
                lp_amount               : 0,
                reward_debt             : 0,
            };
            0x2::event::emit<LpLegPointsSettledEvent>(v4);
            return
        };
        let v5 = LpLegPointRecord{
            owner                   : arg2,
            lp_amount               : 0,
            reward_debt             : 0,
            pending_points          : 0,
            pending_point_remainder : 0,
        };
        0x2::dynamic_field::add<PositionKey, LpLegPointRecord>(&mut arg0.id, v1, v5);
        let v6 = LpLegPointsSettledEvent{
            state_id                : 0x2::object::id<LpPointState<T0>>(arg0),
            position_id             : v0,
            owner                   : arg2,
            pending_added           : 0,
            pending_total           : 0,
            pending_point_remainder : 0,
            lp_amount               : 0,
            reward_debt             : 0,
        };
        0x2::event::emit<LpLegPointsSettledEvent>(v6);
    }

    public fun lp_acc_point_per_lp<T0: drop>(arg0: &LpPointState<T0>) : u128 {
        arg0.acc_point_per_lp
    }

    public fun lp_acc_point_remainder<T0: drop>(arg0: &LpPointState<T0>) : u256 {
        arg0.acc_point_remainder
    }

    public fun lp_config_version(arg0: &PointConfig) : u64 {
        arg0.lp_config_version
    }

    fun lp_config_version_ref(arg0: &PointConfig, arg1: u64) : &LpConfigVersion {
        let v0 = LpConfigVersionKey{pos0: arg1};
        0x2::dynamic_field::borrow<LpConfigVersionKey, LpConfigVersion>(&arg0.id, v0)
    }

    public fun lp_last_updated_ms<T0: drop>(arg0: &LpPointState<T0>) : u64 {
        arg0.last_updated_ms
    }

    public fun lp_multiplier_bps(arg0: &PointConfig) : u64 {
        arg0.lp_multiplier_bps
    }

    public fun lp_pending_point_remainder<T0: drop>(arg0: &LpPointState<T0>, arg1: 0x2::object::ID) : u256 {
        let v0 = PositionKey{pos0: arg1};
        if (!0x2::dynamic_field::exists<PositionKey>(&arg0.id, v0)) {
            return 0
        };
        0x2::dynamic_field::borrow<PositionKey, LpLegPointRecord>(&arg0.id, v0).pending_point_remainder
    }

    public fun lp_pending_points<T0: drop>(arg0: &LpPointState<T0>, arg1: 0x2::object::ID) : u64 {
        let v0 = PositionKey{pos0: arg1};
        if (!0x2::dynamic_field::exists<PositionKey>(&arg0.id, v0)) {
            return 0
        };
        0x2::dynamic_field::borrow<PositionKey, LpLegPointRecord>(&arg0.id, v0).pending_points
    }

    public fun lp_point_config_version<T0: drop>(arg0: &LpPointState<T0>) : u64 {
        arg0.point_config_version
    }

    public fun lp_point_fraction_remainder_q128<T0: drop>(arg0: &LpPointState<T0>) : u256 {
        arg0.point_fraction_remainder_q128
    }

    public fun lp_position_archived<T0: drop>(arg0: &LpPointState<T0>, arg1: 0x2::object::ID) : bool {
        let v0 = ClosedPositionKey{pos0: arg1};
        0x2::dynamic_field::exists<ClosedPositionKey>(&arg0.id, v0)
    }

    fun lp_referral_source_cap_ref<T0: drop>(arg0: &LpPointState<T0>) : &0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::LpReferralSourceCap<JitterLpPointSource> {
        assert!(0x1::option::is_some<0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::LpReferralSourceCap<JitterLpPointSource>>(&arg0.lp_referral_source_cap), 9206);
        0x1::option::borrow<0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::LpReferralSourceCap<JitterLpPointSource>>(&arg0.lp_referral_source_cap)
    }

    public fun lp_reward_attached<T0: drop>(arg0: &LpPointState<T0>) : bool {
        arg0.reward_attached
    }

    fun lp_reward_debt(arg0: u64, arg1: u128) : u256 {
        (arg0 as u256) * (arg1 as u256)
    }

    public fun lp_reward_topology_registered<T0: drop>(arg0: &LpPointState<T0>) : bool {
        0x1::option::is_some<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewarderSettlementCap>(&arg0.lp_settlement_cap) && (!arg0.reward_attached || 0x1::option::is_some<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewarderSettlementCap>(&arg0.pool_settlement_cap))
    }

    public fun lp_rewarder_id<T0: drop>(arg0: &LpPointState<T0>) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.lp_rewarder_uid)
    }

    public fun lp_state_multiplier_bps<T0: drop>(arg0: &LpPointState<T0>) : u64 {
        arg0.lp_multiplier_bps
    }

    fun mark_lp_referral_record<T0: drop>(arg0: &mut LpPointState<T0>, arg1: 0x2::object::ID, arg2: 0x2::object::ID) {
        let v0 = LpReferralRecordKey{pos0: arg1};
        let v1 = LpReferralRecordMarker{record_id: arg2};
        0x2::dynamic_field::add<LpReferralRecordKey, LpReferralRecordMarker>(&mut arg0.id, v0, v1);
    }

    fun mark_yt_referral_record(arg0: &mut PointConfig, arg1: 0x2::object::ID, arg2: 0x2::object::ID) {
        assert_no_yt_referral_record(arg0, arg1);
        let v0 = YtReferralRecordKey{pos0: arg1};
        let v1 = YtReferralRecordMarker{record_id: arg2};
        0x2::dynamic_field::add<YtReferralRecordKey, YtReferralRecordMarker>(&mut arg0.id, v0, v1);
    }

    fun mutate_market_yt_exposure(arg0: &mut PointConfig, arg1: 0x2::object::ID, arg2: u256, arg3: u256, arg4: u256, arg5: u256) {
        ensure_market_yt_exposure(arg0, arg1);
        let v0 = YtMarketAllowedKey{pos0: arg1};
        let v1 = 0x2::dynamic_field::borrow_mut<YtMarketAllowedKey, YtMarketExposure>(&mut arg0.id, v0);
        assert!(v1.yt_amount >= arg2, 9202);
        assert!(v1.yt_base >= arg3, 9202);
        v1.yt_amount = v1.yt_amount - arg2 + arg4;
        v1.yt_base = v1.yt_base - arg3 + arg5;
    }

    fun mutate_user_yt_exposure(arg0: &mut PointConfig, arg1: address, arg2: u256, arg3: u256) {
        ensure_user_yt_exposure(arg0, arg1);
        let v0 = UserKey{pos0: arg1};
        let v1 = 0x2::dynamic_field::borrow_mut<UserKey, UserYtExposure>(&mut arg0.id, v0);
        assert!(v1.yt_base >= arg2, 9202);
        v1.yt_base = v1.yt_base - arg2 + arg3;
    }

    fun new_lp_point_stamp<T0: drop>(arg0: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg1: &PointConfig, arg2: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::Project, arg3: address, arg4: 0x2::object::ID, arg5: u64, arg6: &mut LpPointState<T0>, arg7: bool) : 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::stamp::LiquidlinkStamp {
        let v0 = new_point_stamp(arg0, arg1, arg2, arg3, arg4, arg5);
        let v1 = JitterPointSource{dummy_field: false};
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::stamp::mark_accrual<JitterPointSource>(v1, &mut v0, &mut arg6.id, arg7);
        v0
    }

    fun new_point_config(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) : PointConfig {
        assert!(arg4 > 0, 9200);
        let v0 = PointConfig{
            id                     : 0x2::object::new(arg6),
            project_object_id      : arg0,
            scoreboard_id          : arg1,
            yt_multiplier_bps      : arg2,
            lp_multiplier_bps      : arg3,
            duration               : arg4,
            enabled                : arg5,
            closed                 : false,
            closed_at_ms           : 0,
            total_yt_amount        : 0,
            total_yt_base          : 0,
            uncheckpointed_yt      : 0,
            config_version         : 0,
            yt_config_version      : 0,
            lp_config_version      : 0,
            yt_referral_source_cap : 0x1::option::none<0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::YtReferralSourceCap<JitterYtPointSource>>(),
        };
        let v1 = &mut v0;
        add_initial_yt_config_version(v1, 0);
        let v2 = &mut v0;
        add_initial_lp_config_version(v2, 0);
        v0
    }

    fun new_point_stamp(arg0: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg1: &PointConfig, arg2: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::Project, arg3: address, arg4: 0x2::object::ID, arg5: u64) : 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::stamp::LiquidlinkStamp {
        assert_project_match(arg1, arg2);
        let v0 = JitterPointSource{dummy_field: false};
        let v1 = 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::stamp::begin_add<JitterPointSource>(arg0, arg2, v0, 0x2::object::id<PointConfig>(arg1), arg3, arg4, arg5, arg1.duration);
        let v2 = JitterPointSource{dummy_field: false};
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::stamp::mark_historical<JitterPointSource>(v2, &mut v1);
        v1
    }

    fun pending_lp_points_for_record(arg0: &LpLegPointRecord, arg1: u128) : (u64, u256) {
        pending_lp_points_from_debt(arg0.lp_amount, arg1, arg0.reward_debt, arg0.pending_point_remainder)
    }

    fun pending_lp_points_from_debt(arg0: u64, arg1: u128, arg2: u256, arg3: u256) : (u64, u256) {
        let v0 = lp_reward_debt(arg0, arg1);
        if (v0 <= arg2) {
            return (0, arg3)
        };
        let v1 = v0 - arg2;
        assert!(v1 <= 115792089237316195423570985008687907853269984665640564039457584007913129639935 - arg3, 9201);
        let v2 = v1 + arg3;
        let v3 = v2 / (1000000000000 as u256);
        assert!(v3 <= (18446744073709551615 as u256), 9201);
        ((v3 as u64), v2 % (1000000000000 as u256))
    }

    public fun pool_rewarder_id<T0: drop>(arg0: &LpPointState<T0>) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.pool_rewarder_uid)
    }

    fun prepare_lp_attachment<T0: drop>(arg0: &PointConfig, arg1: &mut LpPointState<T0>, arg2: &0x2::clock::Clock) {
        assert!(!arg0.closed, 9223);
        assert!(!arg1.reward_attached, 9205);
        if (arg1.point_config_version < arg0.lp_config_version) {
            let v0 = lp_config_version_ref(arg0, arg1.point_config_version).duration;
            carry_lp_fraction_to_q128<T0>(arg1, v0);
            arg1.point_config_version = arg0.lp_config_version;
        };
        let v1 = 0x2::clock::timestamp_ms(arg2);
        arg1.attachment_acc_point_per_lp = arg1.acc_point_per_lp;
        arg1.attachment_ms = v1;
        arg1.last_updated_ms = v1;
        arg1.reward_attached = true;
        arg1.initialized = true;
        let v2 = LpPointAttachmentBaselineCapturedEvent{
            state_id                    : 0x2::object::id<LpPointState<T0>>(arg1),
            pool_id                     : arg1.pool_id,
            attachment_ms               : v1,
            attachment_acc_point_per_lp : arg1.attachment_acc_point_per_lp,
        };
        0x2::event::emit<LpPointAttachmentBaselineCapturedEvent>(v2);
    }

    fun prepare_yt_attachment<T0: drop, T1: drop, T2: drop>(arg0: &mut PointConfig, arg1: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg2: &0x2::clock::Clock) {
        assert!(!arg0.closed, 9223);
        let v0 = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg1);
        let v1 = (0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::yt_supply<T0, T1, T2>(arg1) as u256);
        let (v2, _) = 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::point_math::yt_emission(arg0.yt_multiplier_bps, yt_market_multiplier_bps(arg0, v0), 0x1::u64::saturating_sub(0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::expiry<T0, T1, T2>(arg1), 0x2::clock::timestamp_ms(arg2)), arg0.duration, 0);
        0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::point_math::assert_yt_capacity(v1, 0, v2, 0);
        let v4 = YtMarketAllowedKey{pos0: v0};
        let v5 = 0x2::dynamic_field::borrow_mut<YtMarketAllowedKey, YtMarketExposure>(&mut arg0.id, v4);
        assert!(!v5.reward_attached, 9205);
        assert!(!v5.initialized, 9205);
        assert!(v5.yt_amount == 0 && v5.yt_base == 0, 9208);
        v5.expiry_ms = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::expiry<T0, T1, T2>(arg1);
        v5.point_config_version = arg0.yt_config_version;
        v5.initialized = true;
        v5.last_updated_ms = 0x1::u64::min(0x2::clock::timestamp_ms(arg2), v5.expiry_ms);
        v5.attachment_ms = v5.last_updated_ms;
        v5.attachment_acc = v5.acc_point_per_base;
        v5.uncheckpointed_yt = v1;
        v5.reward_attached = true;
        arg0.uncheckpointed_yt = arg0.uncheckpointed_yt + v1;
    }

    public fun register_lp_referral_source_by_project_cap<T0: drop>(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg2: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project_cap::ProjectCap, arg3: &mut 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::Project, arg4: &PointConfig, arg5: &mut LpPointState<T0>) {
        0x46c6f7c5176ffe3d6706ed7bee5e31447071f9a5227e29d96179d5e7b5d73ea1::package_version::assert_current(arg0);
        assert!(arg5.point_config_id == 0x2::object::id<PointConfig>(arg4), 9203);
        assert_project_match(arg4, arg3);
        assert!(0x1::option::is_none<0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::LpReferralSourceCap<JitterLpPointSource>>(&arg5.lp_referral_source_cap), 9205);
        let v0 = JitterLpPointSource{dummy_field: false};
        0x1::option::fill<0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::LpReferralSourceCap<JitterLpPointSource>>(&mut arg5.lp_referral_source_cap, 0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::create_lp_referral_source_cap<JitterLpPointSource>(arg0, arg1, arg2, arg3, v0, 0x2::object::id<LpPointState<T0>>(arg5)));
    }

    public fun register_yt_referral_source_by_project_cap(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg2: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project_cap::ProjectCap, arg3: &mut 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::Project, arg4: &mut PointConfig) {
        0x46c6f7c5176ffe3d6706ed7bee5e31447071f9a5227e29d96179d5e7b5d73ea1::package_version::assert_current(arg0);
        assert!(!arg4.closed, 9223);
        assert_project_match(arg4, arg3);
        assert!(0x1::option::is_none<0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::YtReferralSourceCap<JitterYtPointSource>>(&arg4.yt_referral_source_cap), 9205);
        let v0 = JitterYtPointSource{dummy_field: false};
        0x1::option::fill<0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::YtReferralSourceCap<JitterYtPointSource>>(&mut arg4.yt_referral_source_cap, 0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::create_yt_referral_source_cap<JitterYtPointSource>(arg0, arg1, arg2, arg3, v0, 0x2::object::id<PointConfig>(arg4)));
    }

    fun remove_empty_lp_point_record<T0: drop>(arg0: &mut LpPointState<T0>, arg1: 0x2::object::ID, arg2: address) : u256 {
        let v0 = PositionKey{pos0: arg1};
        let LpLegPointRecord {
            owner                   : v1,
            lp_amount               : v2,
            reward_debt             : v3,
            pending_points          : v4,
            pending_point_remainder : v5,
        } = 0x2::dynamic_field::remove<PositionKey, LpLegPointRecord>(&mut arg0.id, v0);
        assert!(v1 == arg2, 9210);
        let v6 = if (v2 == 0) {
            if (v3 == 0) {
                v4 == 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v6, 9215);
        v5
    }

    fun remove_empty_yt_contribution(arg0: &mut PointConfig, arg1: 0x2::object::ID, arg2: address) : u256 {
        let v0 = PositionKey{pos0: arg1};
        let YtPositionContribution {
            owner                  : v1,
            raw_amount             : v2,
            base_amount            : v3,
            reward_debt_scaled     : v4,
            point_remainder_scaled : v5,
        } = 0x2::dynamic_field::remove<PositionKey, YtPositionContribution>(&mut arg0.id, v0);
        assert!(v1 == arg2, 9210);
        let v6 = if (v2 == 0) {
            if (v3 == 0) {
                v4 == 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v6, 9215);
        v5
    }

    fun remove_lp_referral_record_marker<T0: drop>(arg0: &mut LpPointState<T0>, arg1: 0x2::object::ID, arg2: 0x2::object::ID) {
        let v0 = LpReferralRecordKey{pos0: arg1};
        let LpReferralRecordMarker { record_id: v1 } = 0x2::dynamic_field::remove<LpReferralRecordKey, LpReferralRecordMarker>(&mut arg0.id, v0);
        assert!(v1 == arg2, 9210);
    }

    fun remove_yt_referral_record_marker(arg0: &mut PointConfig, arg1: 0x2::object::ID, arg2: 0x2::object::ID) {
        assert_yt_referral_record_marker(arg0, arg1, arg2);
        let v0 = YtReferralRecordKey{pos0: arg1};
        let YtReferralRecordMarker { record_id: v1 } = 0x2::dynamic_field::remove<YtReferralRecordKey, YtReferralRecordMarker>(&mut arg0.id, v0);
        assert!(v1 == arg2, 9210);
    }

    public fun repair_lp_history<T0: drop, T1: drop, T2: drop>(arg0: &PointConfig, arg1: &mut LpPointState<T0>, arg2: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg3: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg4: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::admin::AdminCap, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: vector<u8>, arg11: &0x2::clock::Clock) {
        assert_market_active(arg3, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg2));
        assert_lp_state_match<T0, T1, T2>(arg0, arg1, arg2);
        assert!(arg1.reward_attached, 9217);
        let v0 = if (arg0.lp_config_version == arg5) {
            if (arg1.point_config_version == arg6) {
                arg1.last_updated_ms == arg7
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 9221);
        assert!(arg6 < arg5, 9222);
        assert!(arg9 > 0, 9200);
        assert!(!0x1::vector::is_empty<u8>(&arg10) && 0x1::vector::length<u8>(&arg10) <= 512, 9222);
        let v1 = lp_config_version_ref(arg0, arg6);
        let v2 = lp_config_version_ref(arg0, arg6 + 1);
        assert!(v2.effective_at_ms <= 0x2::clock::timestamp_ms(arg11), 9222);
        let v3 = 0x1::u64::min(v2.effective_at_ms, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::expiry<T0, T1, T2>(arg2));
        assert!(v3 > arg7, 9222);
        if (arg9 != v1.duration) {
            carry_lp_fraction_to_q128<T0>(arg1, v1.duration);
        };
        let v4 = LpHistoryRepairKey{pos0: arg6};
        let v5 = LpHistoryRepair{
            from_ms        : arg7,
            until_ms       : v3,
            multiplier_bps : arg8,
            duration       : arg9,
            reason         : arg10,
        };
        0x2::dynamic_field::add<LpHistoryRepairKey, LpHistoryRepair>(&mut arg1.id, v4, v5);
        let (_, _) = checkpoint_pool_lp_points_to_version<T0, T1, T2>(arg0, arg1, arg2, arg6 + 1, arg11);
        let v8 = LpHistoryRepairedEvent{
            state_id           : 0x2::object::id<LpPointState<T0>>(arg1),
            config_id          : 0x2::object::id<PointConfig>(arg0),
            version            : arg6,
            from_ms            : arg7,
            until_ms           : v3,
            old_multiplier_bps : v1.multiplier_bps,
            new_multiplier_bps : arg8,
            old_duration       : v1.duration,
            new_duration       : arg9,
            reason             : arg10,
        };
        0x2::event::emit<LpHistoryRepairedEvent>(v8);
    }

    public fun repair_multipliers_by_admin(arg0: &mut PointConfig, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::admin::AdminCap, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock) {
        0x46c6f7c5176ffe3d6706ed7bee5e31447071f9a5227e29d96179d5e7b5d73ea1::package_version::assert_current(arg1);
        assert!(!arg0.closed, 9223);
        assert!(arg5 > 0, 9200);
        let v0 = if (arg0.yt_multiplier_bps != arg3) {
            true
        } else {
            arg0.duration != arg5
        };
        let v1 = if (arg0.lp_multiplier_bps != arg4) {
            true
        } else {
            arg0.duration != arg5
        };
        if (v0) {
            assert!(arg0.total_yt_amount == 0, 9209);
        };
        arg0.yt_multiplier_bps = arg3;
        arg0.lp_multiplier_bps = arg4;
        arg0.duration = arg5;
        bump_config_version(arg0);
        if (v0) {
            append_yt_config_version(arg0, 0x2::clock::timestamp_ms(arg6));
        };
        if (v1) {
            append_lp_config_version(arg0, 0x2::clock::timestamp_ms(arg6));
        };
        emit_config_updated(arg0);
    }

    fun retire_lp_carry<T0: drop>(arg0: &mut LpPointState<T0>) {
        let v0 = if (arg0.acc_point_remainder == 0) {
            if (arg0.point_numerator_remainder == 0) {
                arg0.point_fraction_remainder_q128 == 0
            } else {
                false
            }
        } else {
            false
        };
        if (v0) {
            return
        };
        let v1 = LpCarryRetiredEvent{
            state_id                      : 0x2::object::id<LpPointState<T0>>(arg0),
            acc_point_remainder           : arg0.acc_point_remainder,
            point_numerator_remainder     : arg0.point_numerator_remainder,
            point_fraction_remainder_q128 : arg0.point_fraction_remainder_q128,
            config_version                : arg0.point_config_version,
        };
        0x2::event::emit<LpCarryRetiredEvent>(v1);
        arg0.acc_point_remainder = 0;
        arg0.point_numerator_remainder = 0;
        arg0.point_fraction_remainder_q128 = 0;
    }

    fun set_enabled(arg0: &mut PointConfig, arg1: bool, arg2: u64) {
        assert!(!arg0.closed, 9223);
        if (arg0.enabled == arg1) {
            return
        };
        arg0.enabled = arg1;
        bump_config_version(arg0);
        append_yt_config_version(arg0, arg2);
        append_lp_config_version(arg0, arg2);
        emit_config_updated(arg0);
    }

    public fun set_enabled_by_acl(arg0: &mut PointConfig, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: &0x413f0b727ca3a6fded067960c364d337ad57e284c96f3b21a922455627ca332b::acl::ACL, arg3: bool, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0x46c6f7c5176ffe3d6706ed7bee5e31447071f9a5227e29d96179d5e7b5d73ea1::package_version::assert_current(arg1);
        0x413f0b727ca3a6fded067960c364d337ad57e284c96f3b21a922455627ca332b::acl::assert_has_role(arg2, arg1, 0x2::tx_context::sender(arg5), 0x1::string::utf8(b"points.pause"));
        set_enabled(arg0, arg3, 0x2::clock::timestamp_ms(arg4));
    }

    public fun set_enabled_by_admin(arg0: &mut PointConfig, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::admin::AdminCap, arg3: bool, arg4: &0x2::clock::Clock) {
        0x46c6f7c5176ffe3d6706ed7bee5e31447071f9a5227e29d96179d5e7b5d73ea1::package_version::assert_current(arg1);
        set_enabled(arg0, arg3, 0x2::clock::timestamp_ms(arg4));
    }

    fun set_lp_state_multiplier<T0: drop>(arg0: &mut LpPointState<T0>, arg1: u64) {
        arg0.lp_multiplier_bps = arg1;
        let v0 = LpPointWeightConfiguredEvent{
            state_id       : 0x2::object::id<LpPointState<T0>>(arg0),
            pool_id        : arg0.pool_id,
            multiplier_bps : arg1,
        };
        0x2::event::emit<LpPointWeightConfiguredEvent>(v0);
    }

    public fun set_lp_state_multiplier_by_admin<T0: drop, T1: drop, T2: drop>(arg0: &PointConfig, arg1: &mut LpPointState<T0>, arg2: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg3: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg4: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::admin::AdminCap, arg5: u64, arg6: &0x2::clock::Clock) {
        assert_market_active(arg3, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg2));
        assert!(!arg0.closed, 9223);
        update_pool_lp_points<T0, T1, T2>(arg0, arg1, arg2, arg6);
        set_lp_state_multiplier<T0>(arg1, arg5);
    }

    fun set_multipliers(arg0: &mut PointConfig, arg1: u64, arg2: u64, arg3: u64, arg4: u64) {
        assert!(!arg0.closed, 9223);
        assert!(arg3 > 0, 9200);
        if (arg1 != arg0.yt_multiplier_bps || arg3 != arg0.duration) {
            assert!(arg0.total_yt_amount == 0 && arg0.uncheckpointed_yt == 0, 9209);
        };
        let v0 = if (arg0.yt_multiplier_bps != arg1) {
            true
        } else {
            arg0.duration != arg3
        };
        let v1 = if (arg0.lp_multiplier_bps != arg2) {
            true
        } else {
            arg0.duration != arg3
        };
        arg0.yt_multiplier_bps = arg1;
        arg0.lp_multiplier_bps = arg2;
        arg0.duration = arg3;
        bump_config_version(arg0);
        if (v0) {
            append_yt_config_version(arg0, arg4);
        };
        if (v1) {
            append_lp_config_version(arg0, arg4);
        };
        emit_config_updated(arg0);
    }

    public fun set_multipliers_by_admin(arg0: &mut PointConfig, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::admin::AdminCap, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock) {
        0x46c6f7c5176ffe3d6706ed7bee5e31447071f9a5227e29d96179d5e7b5d73ea1::package_version::assert_current(arg1);
        set_multipliers(arg0, arg3, arg4, arg5, 0x2::clock::timestamp_ms(arg6));
    }

    fun set_yt_market_multiplier(arg0: &mut PointConfig, arg1: 0x2::object::ID, arg2: u64) {
        assert!(!arg0.closed, 9223);
        allow_yt_market(arg0, arg1);
        if (arg2 != yt_market_multiplier_bps(arg0, arg1)) {
            assert!(yt_market_amount(arg0, arg1) == 0, 9209);
            let v0 = YtMarketAllowedKey{pos0: arg1};
            assert!(0x2::dynamic_field::borrow<YtMarketAllowedKey, YtMarketExposure>(&arg0.id, v0).uncheckpointed_yt == 0, 9209);
        };
        let v1 = YtPointWeightKey{pos0: arg1};
        let v2 = YtPointWeight{multiplier_bps: arg2};
        if (0x2::dynamic_field::exists<YtPointWeightKey>(&arg0.id, v1)) {
            *0x2::dynamic_field::borrow_mut<YtPointWeightKey, YtPointWeight>(&mut arg0.id, v1) = v2;
        } else {
            0x2::dynamic_field::add<YtPointWeightKey, YtPointWeight>(&mut arg0.id, v1, v2);
        };
        let v3 = YtPointWeightConfiguredEvent{
            config_id      : 0x2::object::id<PointConfig>(arg0),
            market_id      : arg1,
            multiplier_bps : arg2,
        };
        0x2::event::emit<YtPointWeightConfiguredEvent>(v3);
    }

    public fun set_yt_market_multiplier_by_admin(arg0: &mut PointConfig, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::admin::AdminCap, arg3: 0x2::object::ID, arg4: u64) {
        0x46c6f7c5176ffe3d6706ed7bee5e31447071f9a5227e29d96179d5e7b5d73ea1::package_version::assert_current(arg1);
        set_yt_market_multiplier(arg0, arg3, arg4);
    }

    fun set_yt_position_contribution(arg0: &mut PointConfig, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: address, arg4: u256, arg5: u256, arg6: u256, arg7: u64, arg8: u64) : (address, u64) {
        let v0 = PositionKey{pos0: arg2};
        let v1 = arg3;
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        let v5 = 0;
        if (!0x2::dynamic_field::exists<PositionKey>(&arg0.id, v0)) {
            let v6 = YtPositionContribution{
                owner                  : arg3,
                raw_amount             : 0,
                base_amount            : 0,
                reward_debt_scaled     : 0,
                point_remainder_scaled : 0,
            };
            0x2::dynamic_field::add<PositionKey, YtPositionContribution>(&mut arg0.id, v0, v6);
        } else {
            let v7 = 0x2::dynamic_field::borrow<PositionKey, YtPositionContribution>(&arg0.id, v0);
            v1 = v7.owner;
            v2 = v7.raw_amount;
            v3 = v7.base_amount;
            let (v8, v9) = settle_yt_contribution(v7, arg6);
            v4 = v8;
            v5 = v9;
        };
        if (arg5 > v3) {
            let v10 = YtMarketAllowedKey{pos0: arg1};
            let (v11, _) = 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::point_math::yt_emission(arg0.yt_multiplier_bps, yt_market_multiplier_bps(arg0, arg1), arg8, arg0.duration, 0x2::dynamic_field::borrow<YtMarketAllowedKey, YtMarketExposure>(&arg0.id, v10).point_numerator_remainder);
            let v13 = if (v1 == arg3) {
                v5
            } else {
                0
            };
            0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::point_math::assert_yt_capacity(arg5, arg6, v11, v13);
        };
        if (v3 != 0) {
            mutate_user_yt_exposure(arg0, v1, v3, 0);
        };
        if (v2 != 0 || v3 != 0) {
            mutate_market_yt_exposure(arg0, arg1, v2, v3, 0, 0);
        };
        if (arg5 != 0) {
            mutate_user_yt_exposure(arg0, arg3, 0, arg5);
        };
        if (arg4 != 0 || arg5 != 0) {
            mutate_market_yt_exposure(arg0, arg1, 0, 0, arg4, arg5);
        } else {
            ensure_user_yt_exposure(arg0, arg3);
            ensure_market_yt_exposure(arg0, arg1);
        };
        arg0.total_yt_amount = arg0.total_yt_amount - v2 + arg4;
        arg0.total_yt_base = arg0.total_yt_base - v3 + arg5;
        let v14 = 0x2::dynamic_field::borrow_mut<PositionKey, YtPositionContribution>(&mut arg0.id, v0);
        v14.owner = arg3;
        v14.raw_amount = arg4;
        v14.base_amount = arg5;
        v14.reward_debt_scaled = yt_reward_debt_scaled(arg5, arg6);
        let v15 = if (v1 == arg3) {
            v5
        } else {
            0
        };
        v14.point_remainder_scaled = v15;
        let v16 = YtPointsSyncedEvent{
            config_id               : 0x2::object::id<PointConfig>(arg0),
            position_id             : arg2,
            owner                   : arg3,
            previous_base_amount    : v3,
            new_base_amount         : arg5,
            points_added            : v4,
            point_remainder_scaled  : v14.point_remainder_scaled,
            effective_updated_at_ms : arg7,
        };
        0x2::event::emit<YtPointsSyncedEvent>(v16);
        (v1, v4)
    }

    fun set_yt_reward_attached(arg0: &mut PointConfig, arg1: 0x2::object::ID, arg2: bool) {
        let v0 = YtMarketAllowedKey{pos0: arg1};
        0x2::dynamic_field::borrow_mut<YtMarketAllowedKey, YtMarketExposure>(&mut arg0.id, v0).reward_attached = arg2;
    }

    public fun settle_closed_lp<T0: drop, T1: drop, T2: drop>(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: &PointConfig, arg2: &mut LpPointState<T0>, arg3: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardDistributor, arg4: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardOperation, arg5: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition, arg6: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert_market_active(arg0, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg6));
        checkpoint_closed_lp<T0, T1, T2>(arg1, arg2, arg0, arg5, arg6, arg7, arg8);
        settle_closed_operation(arg0, arg3, arg4, settlement_cap_ref(&arg2.lp_settlement_cap), arg5, false, arg8);
    }

    public fun settle_closed_lp_with_referral<T0: drop, T1: drop, T2: drop>(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: &PointConfig, arg2: &mut LpPointState<T0>, arg3: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardDistributor, arg4: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardOperation, arg5: &0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::ReferralPolicyState, arg6: &mut 0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::LpReferralRecord, arg7: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition, arg8: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert_market_active(arg0, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg8));
        checkpoint_closed_lp_with_referral<T0, T1, T2>(arg1, arg2, arg0, arg5, arg6, arg7, arg8, arg9, arg10);
        settle_closed_operation(arg0, arg3, arg4, settlement_cap_ref(&arg2.lp_settlement_cap), arg7, false, arg10);
    }

    fun settle_closed_operation(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardDistributor, arg2: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardOperation, arg3: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewarderSettlementCap, arg4: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition, arg5: bool, arg6: &0x2::tx_context::TxContext) {
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::assert_subject(arg2, 0x2::object::id<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition>(arg4));
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::assert_owner(arg2, 0x2::tx_context::sender(arg6));
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::assert_operation_market_matches(arg2, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::market_state_id(arg4));
        let v0 = if (arg5) {
            0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::yt_balance(arg4)
        } else {
            0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::lp_amount(arg4)
        };
        assert!(0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::previous_exposure(arg2) == v0, 9208);
        let v1 = if (arg5) {
            0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::yt_reward_guard(arg4)
        } else {
            0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::lp_reward_guard(arg4)
        };
        assert!(0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::operation_guard(arg2) == v1, 9208);
        if (0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::operation_is_transfer(arg2)) {
            0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::settle_transfer_rewarder_with_cap(arg1, arg0, arg2, arg3, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::operation_next_owner(arg2));
        } else {
            0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::settle_rewarder_with_cap(arg1, arg0, arg2, arg3);
        };
    }

    public fun settle_closed_yt<T0: drop, T1: drop, T2: drop>(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: &mut PointConfig, arg2: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardDistributor, arg3: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardOperation, arg4: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition, arg5: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert_market_active(arg0, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg5));
        checkpoint_closed_yt<T0, T1, T2>(arg1, arg0, arg4, arg5, arg6, arg7);
        settle_closed_operation(arg0, arg2, arg3, yt_settlement_cap_ref(arg1, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg5)), arg4, true, arg7);
    }

    public fun settle_closed_yt_with_referral<T0: drop, T1: drop, T2: drop>(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: &mut PointConfig, arg2: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardDistributor, arg3: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardOperation, arg4: &0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::ReferralPolicyState, arg5: &mut 0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::YtReferralRecord, arg6: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition, arg7: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert_market_active(arg0, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg7));
        checkpoint_closed_yt_with_referral<T0, T1, T2>(arg1, arg0, arg4, arg5, arg6, arg7, arg8, arg9);
        settle_closed_operation(arg0, arg2, arg3, yt_settlement_cap_ref(arg1, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg7)), arg6, true, arg9);
    }

    fun settle_lp_position<T0: drop>(arg0: &mut LpPointState<T0>, arg1: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition, arg2: address) : (address, u64) {
        assert!(arg0.initialized, 9217);
        let v0 = PositionKey{pos0: 0x2::object::id<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition>(arg1)};
        if (0x2::dynamic_field::exists<PositionKey>(&arg0.id, v0)) {
            let v1 = 0x2::dynamic_field::borrow<PositionKey, LpLegPointRecord>(&arg0.id, v0);
            assert!(v1.owner == arg2 || v1.lp_amount == 0, 9208);
        };
        settle_lp_position_for_owner<T0>(arg0, arg1, arg2)
    }

    fun settle_lp_position_for_owner<T0: drop>(arg0: &mut LpPointState<T0>, arg1: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition, arg2: address) : (address, u64) {
        assert!(!lp_position_archived<T0>(arg0, 0x2::object::id<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition>(arg1)), 9227);
        assert!(arg0.initialized, 9217);
        assert_lp_position_match<T0>(arg0, arg1);
        let v0 = 0x2::object::id<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition>(arg1);
        let v1 = PositionKey{pos0: v0};
        let v2 = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::lp_amount(arg1);
        if (!0x2::dynamic_field::exists<PositionKey>(&arg0.id, v1)) {
            let (v3, v4, v5) = attachment_lp_record_values<T0>(arg0, v2);
            let v6 = LpLegPointRecord{
                owner                   : arg2,
                lp_amount               : v2,
                reward_debt             : v5,
                pending_points          : v3,
                pending_point_remainder : v4,
            };
            0x2::dynamic_field::add<PositionKey, LpLegPointRecord>(&mut arg0.id, v1, v6);
            let v7 = LpLegPointsSettledEvent{
                state_id                : 0x2::object::id<LpPointState<T0>>(arg0),
                position_id             : v0,
                owner                   : arg2,
                pending_added           : v3,
                pending_total           : v3,
                pending_point_remainder : v4,
                lp_amount               : v2,
                reward_debt             : v5,
            };
            0x2::event::emit<LpLegPointsSettledEvent>(v7);
            return (arg2, 0)
        };
        let v8 = false;
        let v9 = @0x0;
        let v10 = 0;
        let v11 = 0x2::dynamic_field::borrow<PositionKey, LpLegPointRecord>(&arg0.id, v1);
        if (v11.lp_amount != v2 || v11.lp_amount > 0 && v11.owner != arg2) {
            retire_lp_carry<T0>(arg0);
        };
        let v12 = 0x2::dynamic_field::borrow_mut<PositionKey, LpLegPointRecord>(&mut arg0.id, v1);
        let (v13, v14) = pending_lp_points_for_record(v12, arg0.acc_point_per_lp);
        let v15 = checked_add_points(v12.pending_points, v13);
        let v16 = v15;
        if (v12.owner != arg2) {
            v8 = true;
            v9 = v12.owner;
            v10 = v15;
            v12.owner = arg2;
            v12.pending_points = 0;
            v12.pending_point_remainder = 0;
            v16 = 0;
        } else {
            v12.pending_points = v15;
            v12.pending_point_remainder = v14;
        };
        v12.lp_amount = v2;
        v12.reward_debt = lp_reward_debt(v2, arg0.acc_point_per_lp);
        let v17 = LpLegPointsSettledEvent{
            state_id                : 0x2::object::id<LpPointState<T0>>(arg0),
            position_id             : v0,
            owner                   : arg2,
            pending_added           : v13,
            pending_total           : v16,
            pending_point_remainder : v12.pending_point_remainder,
            lp_amount               : v2,
            reward_debt             : v12.reward_debt,
        };
        0x2::event::emit<LpLegPointsSettledEvent>(v17);
        if (!v8) {
            (arg2, 0)
        } else {
            (v9, v10)
        }
    }

    fun settle_lp_position_transfer<T0: drop>(arg0: &mut LpPointState<T0>, arg1: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition, arg2: address, arg3: address) : (address, u64) {
        assert!(arg0.initialized, 9217);
        assert_lp_position_match<T0>(arg0, arg1);
        let v0 = 0x2::object::id<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition>(arg1);
        let v1 = PositionKey{pos0: v0};
        if (0x2::dynamic_field::exists<PositionKey>(&arg0.id, v1)) {
            let v2 = 0x2::dynamic_field::borrow<PositionKey, LpLegPointRecord>(&arg0.id, v1);
            assert!(v2.owner == arg2 || v2.lp_amount == 0 && v2.pending_points == 0, 9208);
            return settle_lp_position_for_owner<T0>(arg0, arg1, arg3)
        };
        let v3 = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::lp_amount(arg1);
        let (v4, _, v6) = attachment_lp_record_values<T0>(arg0, v3);
        if (v3 > 0 && arg2 != arg3) {
            retire_lp_carry<T0>(arg0);
        };
        let v7 = LpLegPointRecord{
            owner                   : arg3,
            lp_amount               : v3,
            reward_debt             : v6,
            pending_points          : 0,
            pending_point_remainder : 0,
        };
        0x2::dynamic_field::add<PositionKey, LpLegPointRecord>(&mut arg0.id, v1, v7);
        let v8 = LpLegPointsSettledEvent{
            state_id                : 0x2::object::id<LpPointState<T0>>(arg0),
            position_id             : v0,
            owner                   : arg3,
            pending_added           : v4,
            pending_total           : 0,
            pending_point_remainder : 0,
            lp_amount               : v3,
            reward_debt             : v6,
        };
        0x2::event::emit<LpLegPointsSettledEvent>(v8);
        (arg2, v4)
    }

    fun settle_lp_position_with_referral<T0: drop>(arg0: &PointConfig, arg1: &mut LpPointState<T0>, arg2: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg3: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg4: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::Project, arg5: &0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::ReferralPolicyState, arg6: &mut 0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::LpReferralRecord, arg7: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition, arg8: address) : (address, u64) {
        assert_referral_close_matches(arg0, arg5);
        assert_project_match(arg0, arg4);
        assert_lp_position_match<T0>(arg1, arg7);
        assert_referral_record_match<T0>(arg1, arg6, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::market_state_id(arg7));
        assert!(0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::lp_referral_record_position_id(arg6) == 0x2::object::id<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition>(arg7), 9210);
        assert!(0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::lp_referral_record_referee(arg6) == arg8, 9210);
        assert_lp_referral_record_marker<T0>(arg1, 0x2::object::id<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition>(arg7), 0x2::object::id<0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::LpReferralRecord>(arg6));
        let (v0, v1) = settle_lp_position<T0>(arg1, arg7, arg8);
        let v2 = JitterLpPointSource{dummy_field: false};
        0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::sync_lp_referral_record<JitterLpPointSource>(arg2, arg3, arg4, v2, lp_referral_source_cap_ref<T0>(arg1), arg5, arg6, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::lp_amount(arg7), 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::lp_amount(arg7), arg1.acc_point_per_lp);
        (v0, v1)
    }

    public fun settle_lp_position_with_referral_points<T0: drop, T1: drop, T2: drop>(arg0: &PointConfig, arg1: &mut LpPointState<T0>, arg2: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg3: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg4: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::Project, arg5: &0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::ReferralPolicyState, arg6: &mut 0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::LpReferralRecord, arg7: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg8: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition, arg9: &0x2::clock::Clock, arg10: &0x2::tx_context::TxContext) : 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::stamp::LiquidlinkStamp {
        assert_market_active(arg2, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg7));
        update_pool_lp_points<T0, T1, T2>(arg0, arg1, arg7, arg9);
        let (v0, v1) = settle_lp_position_with_referral<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg8, 0x2::tx_context::sender(arg10));
        bonus_stamp(arg3, arg5, new_lp_point_stamp<T0>(arg3, arg0, arg4, v0, 0x2::object::id<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition>(arg8), v1, arg1, false))
    }

    public fun settle_lp_reward_operation<T0: drop, T1: drop, T2: drop>(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg2: &PointConfig, arg3: &mut LpPointState<T0>, arg4: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::Project, arg5: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardDistributor, arg6: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardOperation, arg7: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg8: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition, arg9: &0x2::clock::Clock, arg10: &0x2::tx_context::TxContext) : 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::stamp::LiquidlinkStamp {
        assert_market_active(arg0, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg7));
        assert!(!arg2.closed, 9223);
        assert_project_match(arg2, arg4);
        assert_lp_reward_topology<T0>(arg3);
        assert_lp_state_match<T0, T1, T2>(arg2, arg3, arg7);
        let v0 = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::pool_id(arg8) == 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::none_id() && 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::lp_amount(arg8) == 0;
        if (v0) {
            assert!(0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::market_state_id(arg8) == 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg7), 9204);
        } else {
            assert_lp_position_match<T0>(arg3, arg8);
        };
        assert_generic_lp_settlement_allowed<T0>(arg3, 0x2::object::id<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition>(arg8));
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::assert_subject(arg6, 0x2::object::id<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition>(arg8));
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::assert_owner(arg6, 0x2::tx_context::sender(arg10));
        let v1 = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::operation_is_transfer(arg6);
        let v2 = if (v1) {
            let v3 = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::operation_next_owner(arg6);
            0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::settle_transfer_rewarder_with_cap(arg5, arg0, arg6, settlement_cap_ref(&arg3.lp_settlement_cap), v3);
            v3
        } else {
            0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::settle_rewarder_with_cap(arg5, arg0, arg6, settlement_cap_ref(&arg3.lp_settlement_cap));
            0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::operation_owner(arg6)
        };
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::assert_operation_market_matches(arg6, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg7));
        assert!(0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::previous_exposure(arg6) == 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::lp_amount(arg8), 9208);
        assert!(0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::operation_guard(arg6) == 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::lp_reward_guard(arg8), 9208);
        update_pool_lp_points<T0, T1, T2>(arg2, arg3, arg7, arg9);
        let (v4, v5) = if (v0) {
            initialize_zero_lp_position_record<T0>(arg3, arg8, v2);
            (v2, 0)
        } else if (v1) {
            settle_lp_position_transfer<T0>(arg3, arg8, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::operation_owner(arg6), v2)
        } else {
            settle_lp_position<T0>(arg3, arg8, v2)
        };
        sync_lp_claim_transfer_lock<T0>(arg3, arg0, arg8);
        new_lp_point_stamp<T0>(arg1, arg2, arg4, v4, 0x2::object::id<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition>(arg8), v5, arg3, false)
    }

    public fun settle_lp_reward_operation_with_referral<T0: drop, T1: drop, T2: drop>(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg2: &PointConfig, arg3: &mut LpPointState<T0>, arg4: &mut 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::scoreboard::Scoreboard, arg5: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardDistributor, arg6: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardOperation, arg7: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::Project, arg8: &0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::ReferralPolicyState, arg9: &mut 0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::LpReferralRecord, arg10: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg11: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition, arg12: &0x2::clock::Clock, arg13: &0x2::tx_context::TxContext) : 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::stamp::LiquidlinkStamp {
        assert_market_active(arg0, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg10));
        assert!(!arg2.closed, 9223);
        assert_scoreboard_match(arg2, arg4);
        assert_project_match(arg2, arg7);
        assert_lp_reward_topology<T0>(arg3);
        assert_lp_state_match<T0, T1, T2>(arg2, arg3, arg10);
        assert_lp_position_match<T0>(arg3, arg11);
        assert_referral_record_match<T0>(arg3, arg9, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg10));
        assert_lp_referral_record_marker<T0>(arg3, 0x2::object::id<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition>(arg11), 0x2::object::id<0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::LpReferralRecord>(arg9));
        assert!(0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::lp_referral_record_position_id(arg9) == 0x2::object::id<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition>(arg11), 9210);
        assert!(0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::lp_referral_record_referee(arg9) == 0x2::tx_context::sender(arg13), 9210);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::assert_mutation_operation(arg6);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::assert_subject(arg6, 0x2::object::id<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition>(arg11));
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::assert_owner(arg6, 0x2::tx_context::sender(arg13));
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::assert_operation_market_matches(arg6, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg10));
        assert!(0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::previous_exposure(arg6) == 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::lp_amount(arg11), 9208);
        assert!(0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::operation_guard(arg6) == 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::lp_reward_guard(arg11), 9208);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::settle_rewarder_with_cap(arg5, arg0, arg6, settlement_cap_ref(&arg3.lp_settlement_cap));
        update_pool_lp_points<T0, T1, T2>(arg2, arg3, arg10, arg12);
        let (v0, v1) = settle_lp_position_with_referral<T0>(arg2, arg3, arg0, arg1, arg7, arg8, arg9, arg11, 0x2::tx_context::sender(arg13));
        bonus_stamp(arg1, arg8, new_lp_point_stamp<T0>(arg1, arg2, arg7, v0, 0x2::object::id<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition>(arg11), v1, arg3, false))
    }

    public fun settle_pool_reward_operation<T0: drop, T1: drop, T2: drop>(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: &PointConfig, arg2: &mut LpPointState<T0>, arg3: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardDistributor, arg4: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardOperation, arg5: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg6: &0x2::clock::Clock) {
        assert_market_active(arg0, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg5));
        assert_lp_reward_topology<T0>(arg2);
        assert_lp_state_match<T0, T1, T2>(arg1, arg2, arg5);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::assert_subject(arg4, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg5));
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::settle_rewarder_with_cap(arg3, arg0, arg4, settlement_cap_ref(&arg2.pool_settlement_cap));
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::assert_operation_market_matches(arg4, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg5));
        assert!(0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::previous_exposure(arg4) == 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::total_pool_sy<T0, T1, T2>(arg5), 9208);
        assert!(0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::operation_guard(arg4) == 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::pool_reward_guard<T0, T1, T2>(arg5), 9208);
        update_pool_lp_points<T0, T1, T2>(arg1, arg2, arg5, arg6);
    }

    fun settle_yt_contribution(arg0: &YtPositionContribution, arg1: u256) : (u64, u256) {
        let v0 = yt_reward_debt_scaled(arg0.base_amount, arg1);
        assert!(v0 >= arg0.reward_debt_scaled, 9201);
        let v1 = v0 - arg0.reward_debt_scaled;
        assert!(v1 <= 115792089237316195423570985008687907853269984665640564039457584007913129639935 - arg0.point_remainder_scaled, 9201);
        let v2 = v1 + arg0.point_remainder_scaled;
        let v3 = v2 / 340282366920938463463374607431768211456;
        assert!(v3 <= (18446744073709551615 as u256), 9201);
        ((v3 as u64), v2 % 340282366920938463463374607431768211456)
    }

    public fun settle_yt_reward_operation<T0: drop, T1: drop, T2: drop>(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg2: &mut PointConfig, arg3: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::Project, arg4: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardDistributor, arg5: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardOperation, arg6: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition, arg7: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg8: &0x2::clock::Clock, arg9: &0x2::tx_context::TxContext) : 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::stamp::LiquidlinkStamp {
        assert_market_active(arg0, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg7));
        assert!(!arg2.closed, 9223);
        assert_project_match(arg2, arg3);
        assert!(yt_reward_initialized(arg2, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg7)), 9217);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::assert_market_state_match(arg6, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg7));
        assert!(0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::market_state_id(arg6) == 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg7), 9203);
        assert_generic_yt_settlement_allowed(arg2, 0x2::object::id<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition>(arg6));
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::assert_subject(arg5, 0x2::object::id<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition>(arg6));
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::assert_owner(arg5, 0x2::tx_context::sender(arg9));
        assert_yt_checkpoint_owner(arg2, 0x2::object::id<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition>(arg6), 0x2::tx_context::sender(arg9));
        let v0 = if (0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::operation_is_transfer(arg5)) {
            let v1 = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::operation_next_owner(arg5);
            0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::settle_transfer_rewarder_with_cap(arg4, arg0, arg5, yt_settlement_cap_ref(arg2, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg7)), v1);
            v1
        } else {
            0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::settle_rewarder_with_cap(arg4, arg0, arg5, yt_settlement_cap_ref(arg2, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg7)));
            0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::operation_owner(arg5)
        };
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::assert_operation_market_matches(arg5, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg7));
        assert!(0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::previous_exposure(arg5) == 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::yt_balance(arg6), 9208);
        assert!(0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::operation_guard(arg5) == 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::yt_reward_guard(arg6), 9208);
        initialize_yt_contribution<T0, T1, T2>(arg2, arg7, arg6, 0x2::tx_context::sender(arg9));
        sync_py_position<T0, T1, T2>(arg1, arg2, arg3, arg6, arg7, arg8, v0)
    }

    public fun settle_yt_reward_operation_with_referral<T0: drop, T1: drop, T2: drop>(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg2: &mut PointConfig, arg3: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::Project, arg4: &0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::ReferralPolicyState, arg5: &mut 0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::YtReferralRecord, arg6: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardDistributor, arg7: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardOperation, arg8: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition, arg9: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg10: &0x2::clock::Clock, arg11: &0x2::tx_context::TxContext) : 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::stamp::LiquidlinkStamp {
        assert_market_active(arg0, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg9));
        assert!(!arg2.closed, 9223);
        assert_project_match(arg2, arg3);
        assert!(yt_reward_initialized(arg2, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg9)), 9217);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::assert_market_state_match(arg8, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg9));
        assert!(0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::market_state_id(arg8) == 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg9), 9203);
        assert_yt_referral_record_match(arg2, arg5, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg9), 0x2::object::id<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition>(arg8));
        assert_yt_referral_record_marker(arg2, 0x2::object::id<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition>(arg8), 0x2::object::id<0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::YtReferralRecord>(arg5));
        assert!(0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::yt_referral_record_referee(arg5) == 0x2::tx_context::sender(arg11), 9210);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::assert_mutation_operation(arg7);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::assert_subject(arg7, 0x2::object::id<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition>(arg8));
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::assert_owner(arg7, 0x2::tx_context::sender(arg11));
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::assert_operation_market_matches(arg7, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg9));
        assert!(0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::previous_exposure(arg7) == 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::yt_balance(arg8), 9208);
        assert!(0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::operation_guard(arg7) == 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::yt_reward_guard(arg8), 9208);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::settle_rewarder_with_cap(arg6, arg0, arg7, yt_settlement_cap_ref(arg2, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg9)));
        let v0 = sync_py_position<T0, T1, T2>(arg1, arg2, arg3, arg8, arg9, arg10, 0x2::tx_context::sender(arg11));
        sync_yt_referral_from_contribution(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::object::id<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition>(arg8), 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg9));
        bonus_stamp(arg1, arg4, v0)
    }

    fun settlement_cap_ref(arg0: &0x1::option::Option<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewarderSettlementCap>) : &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewarderSettlementCap {
        assert!(0x1::option::is_some<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewarderSettlementCap>(arg0), 9206);
        0x1::option::borrow<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewarderSettlementCap>(arg0)
    }

    fun sync_lp_claim_transfer_lock<T0: drop>(arg0: &LpPointState<T0>, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition) {
        let v0 = PositionKey{pos0: 0x2::object::id<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition>(arg2)};
        let v1 = if (0x2::dynamic_field::exists<PositionKey>(&arg0.id, v0)) {
            let v2 = 0x2::dynamic_field::borrow<PositionKey, LpLegPointRecord>(&arg0.id, v0);
            v2.lp_amount == 0 && v2.pending_points > 0
        } else {
            false
        };
        let v3 = 0x2::object::id<LpPointState<T0>>(arg0);
        let v4 = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::has_scoped_transfer_lock<LpPointClaimLock>(arg2, v3);
        if (v1 && !v4) {
            let v5 = LpPointClaimLock{_reserved: true};
            0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::add_scoped_transfer_lock<LpPointClaimLock>(arg1, arg2, v3, v5);
        } else if (!v1 && v4) {
            let v6 = LpPointClaimLock{_reserved: true};
            0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::remove_scoped_transfer_lock<LpPointClaimLock>(arg1, arg2, v3, v6);
        };
    }

    fun sync_lp_supply<T0: drop>(arg0: &mut LpPointState<T0>, arg1: u64) {
        if (arg0.last_lp_supply != arg1) {
            retire_lp_carry<T0>(arg0);
            arg0.last_lp_supply = arg1;
        };
    }

    fun sync_py_position<T0: drop, T1: drop, T2: drop>(arg0: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg1: &mut PointConfig, arg2: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::Project, arg3: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition, arg4: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg5: &0x2::clock::Clock, arg6: address) : 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::stamp::LiquidlinkStamp {
        assert_project_match(arg1, arg2);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::assert_market_state_match(arg3, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg4));
        assert!(0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::market_state_id(arg3) == 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg4), 9203);
        let v0 = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::market_state_id(arg3);
        assert_yt_market_allowed(arg1, v0);
        initialize_yt_contribution<T0, T1, T2>(arg1, arg4, arg3, arg6);
        let v1 = update_yt_market_points<T0, T1, T2>(arg1, arg4, arg5);
        let v2 = if (0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::expiry<T0, T1, T2>(arg4) <= 0x2::clock::timestamp_ms(arg5)) {
            0
        } else {
            (0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::yt_balance(arg3) as u256)
        };
        let (v3, v4) = set_yt_position_contribution(arg1, v0, 0x2::object::id<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition>(arg3), arg6, v2, v2, v1, 0x1::u64::min(0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::expiry<T0, T1, T2>(arg4), 0x2::clock::timestamp_ms(arg5)), 0x1::u64::saturating_sub(0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::expiry<T0, T1, T2>(arg4), 0x2::clock::timestamp_ms(arg5)));
        let v5 = new_point_stamp(arg0, arg1, arg2, v3, 0x2::object::id<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition>(arg3), v4);
        let v6 = JitterPointSource{dummy_field: false};
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::stamp::mark_accrual<JitterPointSource>(v6, &mut v5, &mut arg1.id, true);
        v5
    }

    public fun sync_py_position_with_referral_points<T0: drop, T1: drop, T2: drop>(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg2: &mut PointConfig, arg3: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::Project, arg4: &0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::ReferralPolicyState, arg5: &mut 0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::YtReferralRecord, arg6: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition, arg7: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg8: &0x2::clock::Clock, arg9: &0x2::tx_context::TxContext) : 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::stamp::LiquidlinkStamp {
        assert_market_active(arg0, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg7));
        assert_yt_referral_record_match(arg2, arg5, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg7), 0x2::object::id<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition>(arg6));
        assert_yt_referral_record_marker(arg2, 0x2::object::id<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition>(arg6), 0x2::object::id<0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::YtReferralRecord>(arg5));
        assert!(0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::yt_referral_record_referee(arg5) == 0x2::tx_context::sender(arg9), 9210);
        let v0 = sync_py_position<T0, T1, T2>(arg1, arg2, arg3, arg6, arg7, arg8, 0x2::tx_context::sender(arg9));
        sync_yt_referral_from_contribution(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::object::id<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position::JitterPosition>(arg6), 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg7));
        bonus_stamp(arg1, arg4, v0)
    }

    fun sync_yt_referral_from_contribution(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg2: &PointConfig, arg3: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::Project, arg4: &0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::ReferralPolicyState, arg5: &mut 0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::YtReferralRecord, arg6: 0x2::object::ID, arg7: 0x2::object::ID) {
        assert_referral_close_matches(arg2, arg4);
        assert_yt_referral_record_match(arg2, arg5, arg7, arg6);
        let v0 = PositionKey{pos0: arg6};
        let v1 = 0x2::dynamic_field::borrow<PositionKey, YtPositionContribution>(&arg2.id, v0);
        assert!(v1.owner == 0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::yt_referral_record_referee(arg5), 9210);
        let v2 = JitterYtPointSource{dummy_field: false};
        0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::sync_yt_referral_record<JitterYtPointSource>(arg0, arg1, arg3, v2, yt_referral_source_cap_ref(arg2), arg4, arg5, v1.base_amount, yt_market_acc_point_per_base(arg2, arg7));
    }

    fun take_cross_denominator_fraction<T0: drop>(arg0: &mut LpPointState<T0>, arg1: u64) : u128 {
        if (arg0.point_fraction_remainder_q128 == 0 || arg0.point_numerator_remainder == 0) {
            return take_whole_q128_points<T0>(arg0)
        };
        let v0 = 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::point_math::denominator(arg1);
        assert!(arg0.point_numerator_remainder < v0, 9201);
        assert!(arg0.point_numerator_remainder <= 115792089237316195423570985008687907853269984665640564039457584007913129639935 / 340282366920938463463374607431768211456, 9201);
        let v1 = arg0.point_numerator_remainder * 340282366920938463463374607431768211456 / v0;
        assert!(arg0.point_fraction_remainder_q128 <= 115792089237316195423570985008687907853269984665640564039457584007913129639935 - v1, 9201);
        let v2 = arg0.point_fraction_remainder_q128 + v1;
        if (v2 < 340282366920938463463374607431768211456) {
            return 0
        };
        arg0.point_fraction_remainder_q128 = v2 % 340282366920938463463374607431768211456;
        arg0.point_numerator_remainder = 0;
        ((v2 / 340282366920938463463374607431768211456) as u128)
    }

    fun take_lp_points<T0: drop>(arg0: &mut LpPointState<T0>, arg1: 0x2::object::ID, arg2: address) : u64 {
        let v0 = PositionKey{pos0: arg1};
        if (!0x2::dynamic_field::exists<PositionKey>(&arg0.id, v0)) {
            return 0
        };
        let v1 = 0x2::dynamic_field::borrow_mut<PositionKey, LpLegPointRecord>(&mut arg0.id, v0);
        let v2 = v1.pending_points;
        v1.pending_points = 0;
        let v3 = LpPointsClaimedEvent{
            state_id    : 0x2::object::id<LpPointState<T0>>(arg0),
            position_id : arg1,
            owner       : arg2,
            points      : v2,
        };
        0x2::event::emit<LpPointsClaimedEvent>(v3);
        v2
    }

    fun take_whole_q128_points<T0: drop>(arg0: &mut LpPointState<T0>) : u128 {
        arg0.point_fraction_remainder_q128 = arg0.point_fraction_remainder_q128 % 340282366920938463463374607431768211456;
        ((arg0.point_fraction_remainder_q128 / 340282366920938463463374607431768211456) as u128)
    }

    public fun total_lp_points_accrued<T0: drop>(arg0: &LpPointState<T0>) : u128 {
        arg0.total_lp_points_accrued
    }

    public fun total_lp_points_saturated<T0: drop>(arg0: &LpPointState<T0>) : bool {
        arg0.total_lp_points_saturated
    }

    public fun total_yt_amount(arg0: &PointConfig) : u256 {
        arg0.total_yt_amount
    }

    public fun total_yt_base(arg0: &PointConfig) : u256 {
        arg0.total_yt_base
    }

    public fun uncheckpointed_yt(arg0: &PointConfig) : u256 {
        arg0.uncheckpointed_yt
    }

    fun update_pool_lp_points<T0: drop, T1: drop, T2: drop>(arg0: &PointConfig, arg1: &mut LpPointState<T0>, arg2: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg3: &0x2::clock::Clock) {
        assert_lp_state_match<T0, T1, T2>(arg0, arg1, arg2);
        if (!arg1.reward_attached) {
            return
        };
        assert!(arg1.point_config_version == arg0.lp_config_version, 9219);
        sync_lp_supply<T0>(arg1, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::circulating_lp_supply<T0, T1, T2>(arg2));
        let v0 = 0x2::clock::timestamp_ms(arg3);
        if (v0 <= arg1.last_updated_ms) {
            return
        };
        let v1 = arg1.last_updated_ms;
        let v2 = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::circulating_lp_supply<T0, T1, T2>(arg2);
        let v3 = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::total_pool_sy<T0, T1, T2>(arg2);
        let v4 = 0x1::u64::min(v0, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::expiry<T0, T1, T2>(arg2));
        let v5 = lp_config_version_ref(arg0, arg1.point_config_version);
        let v6 = if (v4 > v1) {
            accrue_lp_interval<T0>(arg1, v3, v2, v5, v4 - v1)
        } else {
            0
        };
        finish_pool_lp_checkpoint<T0, T1, T2>(arg1, arg2, v1, v0, v4, v3, v2, v6, v5.duration);
    }

    fun update_yt_market_points<T0: drop, T1: drop, T2: drop>(arg0: &mut PointConfig, arg1: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg2: &0x2::clock::Clock) : u256 {
        let v0 = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg1);
        let v1 = YtMarketAllowedKey{pos0: v0};
        let v2 = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::expiry<T0, T1, T2>(arg1);
        let v3 = 0x1::u64::min(0x2::clock::timestamp_ms(arg2), v2);
        let v4 = 0x2::dynamic_field::borrow<YtMarketAllowedKey, YtMarketExposure>(&arg0.id, v1);
        assert!(v4.initialized, 9217);
        if (!v4.reward_attached) {
            return v4.acc_point_per_base
        };
        assert!(v4.point_config_version == arg0.yt_config_version, 9219);
        let v5 = *yt_config_version_ref(arg0, arg0.yt_config_version);
        let v6 = 0x2::dynamic_field::borrow_mut<YtMarketAllowedKey, YtMarketExposure>(&mut arg0.id, v1);
        assert!(v6.expiry_ms == v2, 9203);
        if (v3 > v6.last_updated_ms) {
            let v7 = v3 - v6.last_updated_ms;
            accrue_yt_interval(v6, &v5, yt_market_multiplier_bps(arg0, v0), v7);
        };
        v6.last_updated_ms = v3;
        v6.acc_point_per_base
    }

    public fun user_yt_base(arg0: &PointConfig, arg1: address) : u256 {
        let v0 = UserKey{pos0: arg1};
        if (!0x2::dynamic_field::exists<UserKey>(&arg0.id, v0)) {
            return 0
        };
        0x2::dynamic_field::borrow<UserKey, UserYtExposure>(&arg0.id, v0).yt_base
    }

    public fun yt_config_version(arg0: &PointConfig) : u64 {
        arg0.yt_config_version
    }

    fun yt_config_version_ref(arg0: &PointConfig, arg1: u64) : &YtConfigVersion {
        let v0 = YtConfigVersionKey{pos0: arg1};
        0x2::dynamic_field::borrow<YtConfigVersionKey, YtConfigVersion>(&arg0.id, v0)
    }

    public fun yt_market_acc_point_per_base(arg0: &PointConfig, arg1: 0x2::object::ID) : u256 {
        let v0 = YtMarketAllowedKey{pos0: arg1};
        if (!0x2::dynamic_field::exists<YtMarketAllowedKey>(&arg0.id, v0)) {
            return 0
        };
        0x2::dynamic_field::borrow<YtMarketAllowedKey, YtMarketExposure>(&arg0.id, v0).acc_point_per_base
    }

    public fun yt_market_allowed(arg0: &PointConfig, arg1: 0x2::object::ID) : bool {
        let v0 = YtMarketAllowedKey{pos0: arg1};
        0x2::dynamic_field::exists<YtMarketAllowedKey>(&arg0.id, v0)
    }

    public fun yt_market_amount(arg0: &PointConfig, arg1: 0x2::object::ID) : u256 {
        let v0 = YtMarketAllowedKey{pos0: arg1};
        if (!0x2::dynamic_field::exists<YtMarketAllowedKey>(&arg0.id, v0)) {
            return 0
        };
        0x2::dynamic_field::borrow<YtMarketAllowedKey, YtMarketExposure>(&arg0.id, v0).yt_amount
    }

    public fun yt_market_base(arg0: &PointConfig, arg1: 0x2::object::ID) : u256 {
        let v0 = YtMarketAllowedKey{pos0: arg1};
        if (!0x2::dynamic_field::exists<YtMarketAllowedKey>(&arg0.id, v0)) {
            return 0
        };
        0x2::dynamic_field::borrow<YtMarketAllowedKey, YtMarketExposure>(&arg0.id, v0).yt_base
    }

    public fun yt_market_last_updated_ms(arg0: &PointConfig, arg1: 0x2::object::ID) : u64 {
        let v0 = YtMarketAllowedKey{pos0: arg1};
        if (!0x2::dynamic_field::exists<YtMarketAllowedKey>(&arg0.id, v0)) {
            return 0
        };
        0x2::dynamic_field::borrow<YtMarketAllowedKey, YtMarketExposure>(&arg0.id, v0).last_updated_ms
    }

    public fun yt_market_multiplier_bps(arg0: &PointConfig, arg1: 0x2::object::ID) : u64 {
        let v0 = YtPointWeightKey{pos0: arg1};
        if (!0x2::dynamic_field::exists<YtPointWeightKey>(&arg0.id, v0)) {
            return 10000
        };
        0x2::dynamic_field::borrow<YtPointWeightKey, YtPointWeight>(&arg0.id, v0).multiplier_bps
    }

    public fun yt_market_point_config_version(arg0: &PointConfig, arg1: 0x2::object::ID) : u64 {
        assert_yt_market_allowed(arg0, arg1);
        let v0 = YtMarketAllowedKey{pos0: arg1};
        0x2::dynamic_field::borrow<YtMarketAllowedKey, YtMarketExposure>(&arg0.id, v0).point_config_version
    }

    public fun yt_multiplier_bps(arg0: &PointConfig) : u64 {
        arg0.yt_multiplier_bps
    }

    public fun yt_position_amount(arg0: &PointConfig, arg1: 0x2::object::ID) : u256 {
        let v0 = PositionKey{pos0: arg1};
        if (!0x2::dynamic_field::exists<PositionKey>(&arg0.id, v0)) {
            return 0
        };
        0x2::dynamic_field::borrow<PositionKey, YtPositionContribution>(&arg0.id, v0).raw_amount
    }

    public fun yt_position_archived(arg0: &PointConfig, arg1: 0x2::object::ID) : bool {
        let v0 = ClosedPositionKey{pos0: arg1};
        0x2::dynamic_field::exists<ClosedPositionKey>(&arg0.id, v0)
    }

    public fun yt_position_base(arg0: &PointConfig, arg1: 0x2::object::ID) : u256 {
        let v0 = PositionKey{pos0: arg1};
        if (!0x2::dynamic_field::exists<PositionKey>(&arg0.id, v0)) {
            return 0
        };
        0x2::dynamic_field::borrow<PositionKey, YtPositionContribution>(&arg0.id, v0).base_amount
    }

    public fun yt_position_point_remainder(arg0: &PointConfig, arg1: 0x2::object::ID) : u256 {
        let v0 = PositionKey{pos0: arg1};
        if (!0x2::dynamic_field::exists<PositionKey>(&arg0.id, v0)) {
            return 0
        };
        0x2::dynamic_field::borrow<PositionKey, YtPositionContribution>(&arg0.id, v0).point_remainder_scaled
    }

    fun yt_referral_source_cap_ref(arg0: &PointConfig) : &0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::YtReferralSourceCap<JitterYtPointSource> {
        assert!(0x1::option::is_some<0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::YtReferralSourceCap<JitterYtPointSource>>(&arg0.yt_referral_source_cap), 9206);
        0x1::option::borrow<0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy::YtReferralSourceCap<JitterYtPointSource>>(&arg0.yt_referral_source_cap)
    }

    public fun yt_reward_attached(arg0: &PointConfig, arg1: 0x2::object::ID) : bool {
        let v0 = YtMarketAllowedKey{pos0: arg1};
        if (!0x2::dynamic_field::exists<YtMarketAllowedKey>(&arg0.id, v0)) {
            return false
        };
        0x2::dynamic_field::borrow<YtMarketAllowedKey, YtMarketExposure>(&arg0.id, v0).reward_attached
    }

    fun yt_reward_debt_scaled(arg0: u256, arg1: u256) : u256 {
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        assert!(arg1 <= 115792089237316195423570985008687907853269984665640564039457584007913129639935 / arg0, 9201);
        arg0 * arg1
    }

    public fun yt_reward_initialized(arg0: &PointConfig, arg1: 0x2::object::ID) : bool {
        let v0 = YtMarketAllowedKey{pos0: arg1};
        if (!0x2::dynamic_field::exists<YtMarketAllowedKey>(&arg0.id, v0)) {
            return false
        };
        0x2::dynamic_field::borrow<YtMarketAllowedKey, YtMarketExposure>(&arg0.id, v0).initialized
    }

    fun yt_settlement_cap_ref(arg0: &PointConfig, arg1: 0x2::object::ID) : &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewarderSettlementCap {
        let v0 = YtMarketAllowedKey{pos0: arg1};
        settlement_cap_ref(&0x2::dynamic_field::borrow<YtMarketAllowedKey, YtMarketExposure>(&arg0.id, v0).settlement_cap)
    }

    // decompiled from Move bytecode v7
}

