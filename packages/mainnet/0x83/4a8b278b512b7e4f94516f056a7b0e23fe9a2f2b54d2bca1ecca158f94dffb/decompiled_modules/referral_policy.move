module 0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::referral_policy {
    struct JitterReferralPolicy has drop {
        dummy_field: bool,
    }

    struct ReferralPolicyState has store, key {
        id: 0x2::object::UID,
        project_object_id: 0x2::object::ID,
        project_id: 0x2::object::ID,
        enabled: bool,
        closed: bool,
        closed_at_ms: u64,
        referral_bps: u64,
        settlement_cap: 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::PolicySettlementCap<JitterReferralPolicy>,
    }

    struct LpReferralSourceCap<phantom T0: drop> has drop, store {
        project_id: 0x2::object::ID,
        source_id: 0x2::object::ID,
    }

    struct YtReferralSourceCap<phantom T0: drop> has drop, store {
        project_id: 0x2::object::ID,
        source_id: 0x2::object::ID,
    }

    struct LpReferralRecord has key {
        id: 0x2::object::UID,
        project_id: 0x2::object::ID,
        state_id: 0x2::object::ID,
        source_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        referee: address,
        referrer: address,
        referral_bps: u64,
        lp_amount: u64,
        point_exposure: u64,
        reward_debt: u256,
        pending_points: u64,
        pending_bonus_numerator_remainder: u256,
    }

    struct YtReferralRecord has key {
        id: 0x2::object::UID,
        project_id: 0x2::object::ID,
        state_id: 0x2::object::ID,
        source_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        referee: address,
        referrer: address,
        referral_bps: u64,
        base_amount: u256,
        reward_debt_scaled: u256,
        pending_points: u64,
        pending_bonus_numerator_remainder: u256,
    }

    struct DeferredReferralClaim has key {
        id: 0x2::object::UID,
        owner: address,
        referee: address,
        project_object_id: 0x2::object::ID,
        project_id: 0x2::object::ID,
        state_id: 0x2::object::ID,
        source_id: 0x2::object::ID,
        source_witness: 0x1::type_name::TypeName,
        market_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        record_id: 0x2::object::ID,
        is_lp: bool,
        pending_points: u64,
        pending_bonus_numerator_remainder: u256,
        precision: u256,
    }

    struct ReferralArchivedKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ReferralArchived has copy, drop {
        claim_id: 0x2::object::ID,
        record_id: 0x2::object::ID,
        owner: address,
        pending_points: u64,
        pending_bonus_numerator_remainder: u256,
        precision: u256,
    }

    struct ArchivedReferralClaimed has copy, drop {
        claim_id: 0x2::object::ID,
        record_id: 0x2::object::ID,
        owner: address,
        amount: u64,
        pending_bonus_numerator_remainder: u256,
    }

    struct ReferralPolicyStateCreated has copy, drop {
        state_id: 0x2::object::ID,
        project_object_id: 0x2::object::ID,
        project_id: 0x2::object::ID,
        referral_bps: u64,
    }

    struct ReferralBpsUpdated has copy, drop {
        state_id: 0x2::object::ID,
        project_id: 0x2::object::ID,
        referral_bps: u64,
    }

    struct ReferralEnabledUpdated has copy, drop {
        state_id: 0x2::object::ID,
        project_id: 0x2::object::ID,
        enabled: bool,
    }

    struct ReferralCampaignClosed has copy, drop {
        state_id: 0x2::object::ID,
        project_id: 0x2::object::ID,
        closed_at_ms: u64,
    }

    struct ReferralPolicyApplied has copy, drop {
        state_id: 0x2::object::ID,
        project_id: 0x2::object::ID,
        referee: address,
        referrer: 0x1::option::Option<address>,
        referral_bps: u64,
    }

    struct LpReferralRecordCreated has copy, drop {
        record_id: 0x2::object::ID,
        state_id: 0x2::object::ID,
        project_id: 0x2::object::ID,
        source_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        referee: address,
        referrer: address,
        referral_bps: u64,
        lp_amount: u64,
        point_exposure: u64,
    }

    struct LpReferralRecordSynced has copy, drop {
        record_id: 0x2::object::ID,
        state_id: 0x2::object::ID,
        project_id: 0x2::object::ID,
        source_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        referee: address,
        referrer: address,
        lp_amount_before: u64,
        lp_amount_after: u64,
        point_exposure_before: u64,
        point_exposure_after: u64,
        referral_bps_before: u64,
        referral_bps_after: u64,
        pending_points: u64,
    }

    struct LpReferrerBound has copy, drop {
        record_id: 0x2::object::ID,
        state_id: 0x2::object::ID,
        project_id: 0x2::object::ID,
        source_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        referee: address,
        referrer: address,
        referral_bps: u64,
        acc_point_per_lp: u128,
        forfeited_pending_points: u64,
        forfeited_bonus_numerator_remainder: u256,
    }

    struct LpReferralClaimed has copy, drop {
        record_id: 0x2::object::ID,
        state_id: 0x2::object::ID,
        project_id: 0x2::object::ID,
        source_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        referee: address,
        referrer: address,
        amount: u64,
        pending_after: u64,
    }

    struct LpReferralRecordClosed has copy, drop {
        record_id: 0x2::object::ID,
        state_id: 0x2::object::ID,
        project_id: 0x2::object::ID,
        source_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        referee: address,
        referrer: address,
        forfeited_bonus_numerator_remainder: u256,
    }

    struct YtReferralRecordCreated has copy, drop {
        record_id: 0x2::object::ID,
        state_id: 0x2::object::ID,
        project_id: 0x2::object::ID,
        source_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        referee: address,
        referrer: address,
        referral_bps: u64,
        base_amount: u256,
    }

    struct YtReferralRecordSynced has copy, drop {
        record_id: 0x2::object::ID,
        state_id: 0x2::object::ID,
        project_id: 0x2::object::ID,
        source_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        referee: address,
        referrer: address,
        base_amount_before: u256,
        base_amount_after: u256,
        referral_bps_before: u64,
        referral_bps_after: u64,
        pending_points: u64,
    }

    struct YtReferrerBound has copy, drop {
        record_id: 0x2::object::ID,
        state_id: 0x2::object::ID,
        project_id: 0x2::object::ID,
        source_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        referee: address,
        referrer: address,
        referral_bps: u64,
        acc_point_per_base: u256,
        forfeited_pending_points: u64,
        forfeited_bonus_numerator_remainder: u256,
    }

    struct YtReferralClaimed has copy, drop {
        record_id: 0x2::object::ID,
        state_id: 0x2::object::ID,
        project_id: 0x2::object::ID,
        source_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        referee: address,
        referrer: address,
        amount: u64,
        pending_after: u64,
    }

    struct YtReferralRecordClosed has copy, drop {
        record_id: 0x2::object::ID,
        state_id: 0x2::object::ID,
        project_id: 0x2::object::ID,
        source_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        referee: address,
        referrer: address,
        forfeited_bonus_numerator_remainder: u256,
    }

    public fun enabled(arg0: &ReferralPolicyState) : bool {
        arg0.enabled
    }

    public fun project_id(arg0: &ReferralPolicyState) : 0x2::object::ID {
        arg0.project_id
    }

    public fun apply_lp_bonus_policy(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg2: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::Project, arg3: &ReferralPolicyState, arg4: &LpReferralRecord, arg5: &mut 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::stamp::LiquidlinkStamp) {
        0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::package_version::assert_current(arg0);
        assert!(0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::stamp::is_confirm_only<JitterReferralPolicy>(arg5, 0x2::object::id<ReferralPolicyState>(arg3)), 18);
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::package_version::assert_domain_enabled(arg1, 0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::router_domain());
        assert!(arg3.enabled || arg3.closed, 2);
        assert!(arg3.project_object_id == 0x2::object::id<0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::Project>(arg2), 0);
        assert!(arg3.project_id == 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::project_id(arg2), 0);
        assert!(arg4.project_id == arg3.project_id, 5);
        assert!(arg4.state_id == 0x2::object::id<ReferralPolicyState>(arg3), 5);
        assert!(arg4.referee == 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::stamp::owner(arg5), 5);
        assert!(arg4.position_id == 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::stamp::subject_id(arg5), 5);
        assert!(0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::stamp::op(arg5) == 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::stamp::op_add(), 5);
        let v0 = JitterReferralPolicy{dummy_field: false};
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::stamp::confirm_policy<JitterReferralPolicy>(arg1, arg2, v0, 0x2::object::id<ReferralPolicyState>(arg3), arg5);
        let v1 = ReferralPolicyApplied{
            state_id     : 0x2::object::id<ReferralPolicyState>(arg3),
            project_id   : arg3.project_id,
            referee      : arg4.referee,
            referrer     : 0x1::option::some<address>(arg4.referrer),
            referral_bps : arg4.referral_bps,
        };
        0x2::event::emit<ReferralPolicyApplied>(v1);
    }

    public fun apply_policy(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg2: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::Project, arg3: &ReferralPolicyState, arg4: &0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::bonding_table::ReferralTable, arg5: &mut 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::stamp::LiquidlinkStamp) {
        0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::package_version::assert_current(arg0);
        assert!(!0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::stamp::is_confirm_only<JitterReferralPolicy>(arg5, 0x2::object::id<ReferralPolicyState>(arg3)), 18);
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::package_version::assert_domain_enabled(arg1, 0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::router_domain());
        assert!(arg3.enabled || arg3.closed, 2);
        assert!(arg3.project_object_id == 0x2::object::id<0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::Project>(arg2), 0);
        assert!(arg3.project_id == 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::project_id(arg2), 0);
        let v0 = 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::stamp::owner(arg5);
        let v1 = 0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::bonding_table::try_get_refer(arg4, v0);
        let v2 = 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::stamp::op(arg5);
        if (arg3.closed || v2 == 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::stamp::op_subtract()) {
            let v3 = JitterReferralPolicy{dummy_field: false};
            0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::stamp::confirm_policy<JitterReferralPolicy>(arg1, arg2, v3, 0x2::object::id<ReferralPolicyState>(arg3), arg5);
            let v4 = ReferralPolicyApplied{
                state_id     : 0x2::object::id<ReferralPolicyState>(arg3),
                project_id   : arg3.project_id,
                referee      : v0,
                referrer     : 0x1::option::none<address>(),
                referral_bps : arg3.referral_bps,
            };
            0x2::event::emit<ReferralPolicyApplied>(v4);
        } else if (0x1::option::is_some<address>(&v1) && (arg3.referral_bps > 0 || v2 != 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::stamp::op_add())) {
            let v5 = 0x1::option::destroy_some<address>(v1);
            let v6 = JitterReferralPolicy{dummy_field: false};
            0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::stamp::redirect_bps<JitterReferralPolicy>(arg1, arg2, v6, 0x2::object::id<ReferralPolicyState>(arg3), arg5, v5, arg3.referral_bps);
            let v7 = ReferralPolicyApplied{
                state_id     : 0x2::object::id<ReferralPolicyState>(arg3),
                project_id   : arg3.project_id,
                referee      : v0,
                referrer     : 0x1::option::some<address>(v5),
                referral_bps : arg3.referral_bps,
            };
            0x2::event::emit<ReferralPolicyApplied>(v7);
        } else {
            let v8 = JitterReferralPolicy{dummy_field: false};
            0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::stamp::confirm_policy<JitterReferralPolicy>(arg1, arg2, v8, 0x2::object::id<ReferralPolicyState>(arg3), arg5);
            let v9 = ReferralPolicyApplied{
                state_id     : 0x2::object::id<ReferralPolicyState>(arg3),
                project_id   : arg3.project_id,
                referee      : v0,
                referrer     : 0x1::option::none<address>(),
                referral_bps : arg3.referral_bps,
            };
            0x2::event::emit<ReferralPolicyApplied>(v9);
        };
    }

    public fun apply_yt_bonus_policy(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg2: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::Project, arg3: &ReferralPolicyState, arg4: &YtReferralRecord, arg5: &mut 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::stamp::LiquidlinkStamp) {
        0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::package_version::assert_current(arg0);
        assert!(0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::stamp::is_confirm_only<JitterReferralPolicy>(arg5, 0x2::object::id<ReferralPolicyState>(arg3)), 18);
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::package_version::assert_domain_enabled(arg1, 0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::router_domain());
        assert!(arg3.enabled || arg3.closed, 2);
        assert!(arg3.project_object_id == 0x2::object::id<0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::Project>(arg2), 0);
        assert!(arg3.project_id == 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::project_id(arg2), 0);
        assert!(arg4.project_id == arg3.project_id, 11);
        assert!(arg4.state_id == 0x2::object::id<ReferralPolicyState>(arg3), 11);
        assert!(arg4.referee == 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::stamp::owner(arg5), 11);
        assert!(arg4.source_id == 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::stamp::source_id(arg5), 11);
        assert!(arg4.position_id == 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::stamp::subject_id(arg5), 11);
        assert!(0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::stamp::op(arg5) == 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::stamp::op_add(), 11);
        let v0 = JitterReferralPolicy{dummy_field: false};
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::stamp::confirm_policy<JitterReferralPolicy>(arg1, arg2, v0, 0x2::object::id<ReferralPolicyState>(arg3), arg5);
        let v1 = if (arg4.referrer == @0x0) {
            0x1::option::none<address>()
        } else {
            0x1::option::some<address>(arg4.referrer)
        };
        let v2 = ReferralPolicyApplied{
            state_id     : 0x2::object::id<ReferralPolicyState>(arg3),
            project_id   : arg3.project_id,
            referee      : arg4.referee,
            referrer     : v1,
            referral_bps : arg4.referral_bps,
        };
        0x2::event::emit<ReferralPolicyApplied>(v2);
    }

    public fun archive_lp_referral<T0: drop>(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: T0, arg2: &LpReferralSourceCap<T0>, arg3: &ReferralPolicyState, arg4: &mut LpReferralRecord, arg5: u128, arg6: &mut 0x2::tx_context::TxContext) {
        0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::package_version::assert_current(arg0);
        assert!(arg3.closed, 19);
        assert!(arg2.project_id == arg3.project_id, 0);
        assert!(arg4.project_id == arg3.project_id, 5);
        assert!(arg4.state_id == 0x2::object::id<ReferralPolicyState>(arg3), 5);
        assert!(arg4.source_id == arg2.source_id, 5);
        let v0 = ReferralArchivedKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<ReferralArchivedKey>(&arg4.id, v0)) {
            return
        };
        settle_lp_referral_pending(arg4, arg5);
        archive_referral<T0>(arg3, arg4.referrer, arg4.referee, arg4.source_id, arg4.pool_id, arg4.position_id, 0x2::object::id<LpReferralRecord>(arg4), true, arg4.pending_points, arg4.pending_bonus_numerator_remainder, 10000000000000000, arg6);
        arg4.lp_amount = 0;
        arg4.point_exposure = 0;
        arg4.reward_debt = 0;
        arg4.pending_points = 0;
        arg4.pending_bonus_numerator_remainder = 0;
        arg4.referral_bps = 0;
        let v1 = ReferralArchivedKey{dummy_field: false};
        0x2::dynamic_field::add<ReferralArchivedKey, bool>(&mut arg4.id, v1, true);
    }

    fun archive_referral<T0: drop>(arg0: &ReferralPolicyState, arg1: address, arg2: address, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: 0x2::object::ID, arg6: 0x2::object::ID, arg7: bool, arg8: u64, arg9: u256, arg10: u256, arg11: &mut 0x2::tx_context::TxContext) {
        if (arg8 == 0 && arg9 == 0) {
            return
        };
        assert!(arg1 != @0x0, 21);
        let v0 = DeferredReferralClaim{
            id                                : 0x2::object::new(arg11),
            owner                             : arg1,
            referee                           : arg2,
            project_object_id                 : arg0.project_object_id,
            project_id                        : arg0.project_id,
            state_id                          : 0x2::object::id<ReferralPolicyState>(arg0),
            source_id                         : arg3,
            source_witness                    : 0x1::type_name::with_original_ids<T0>(),
            market_id                         : arg4,
            position_id                       : arg5,
            record_id                         : arg6,
            is_lp                             : arg7,
            pending_points                    : arg8,
            pending_bonus_numerator_remainder : arg9,
            precision                         : arg10,
        };
        let v1 = ReferralArchived{
            claim_id                          : 0x2::object::id<DeferredReferralClaim>(&v0),
            record_id                         : arg6,
            owner                             : arg1,
            pending_points                    : arg8,
            pending_bonus_numerator_remainder : arg9,
            precision                         : arg10,
        };
        0x2::event::emit<ReferralArchived>(v1);
        0x2::transfer::transfer<DeferredReferralClaim>(v0, arg1);
    }

    public fun archive_yt_referral<T0: drop>(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: T0, arg2: &YtReferralSourceCap<T0>, arg3: &ReferralPolicyState, arg4: &mut YtReferralRecord, arg5: u256, arg6: &mut 0x2::tx_context::TxContext) {
        0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::package_version::assert_current(arg0);
        assert!(arg3.closed, 19);
        assert!(arg2.project_id == arg3.project_id, 0);
        assert!(arg4.project_id == arg3.project_id, 11);
        assert!(arg4.state_id == 0x2::object::id<ReferralPolicyState>(arg3), 11);
        assert!(arg4.source_id == arg2.source_id, 11);
        let v0 = ReferralArchivedKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<ReferralArchivedKey>(&arg4.id, v0)) {
            return
        };
        settle_yt_referral_pending(arg4, arg5);
        archive_referral<T0>(arg3, arg4.referrer, arg4.referee, arg4.source_id, arg4.market_id, arg4.position_id, 0x2::object::id<YtReferralRecord>(arg4), false, arg4.pending_points, arg4.pending_bonus_numerator_remainder, 3402823669209384634633746074317682114560000, arg6);
        arg4.base_amount = 0;
        arg4.reward_debt_scaled = 0;
        arg4.pending_points = 0;
        arg4.pending_bonus_numerator_remainder = 0;
        arg4.referral_bps = 0;
        let v1 = ReferralArchivedKey{dummy_field: false};
        0x2::dynamic_field::add<ReferralArchivedKey, bool>(&mut arg4.id, v1, true);
    }

    fun assert_authorized_source<T0: drop>(arg0: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::Project, arg1: T0, arg2: 0x2::object::ID) {
        assert!(0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::enabled(arg0) && 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::auth_source_enabled<T0>(arg0, arg1, arg2), 3);
    }

    fun assert_authorized_source_cap<T0: drop>(arg0: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::Project, arg1: T0, arg2: &LpReferralSourceCap<T0>) {
        assert!(arg2.project_id == 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::project_id(arg0), 3);
        assert_authorized_source<T0>(arg0, arg1, arg2.source_id);
    }

    fun assert_authorized_yt_source_cap<T0: drop>(arg0: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::Project, arg1: T0, arg2: &YtReferralSourceCap<T0>) {
        assert!(arg2.project_id == 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::project_id(arg0), 3);
        assert_authorized_source<T0>(arg0, arg1, arg2.source_id);
    }

    fun assert_project_cap(arg0: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project_cap::ProjectCap, arg1: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::Project) {
        assert!(0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project_cap::get_project_cap_ID(arg0) == 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::project_id(arg1), 0);
    }

    fun assert_record_match(arg0: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::Project, arg1: &ReferralPolicyState, arg2: &LpReferralRecord) {
        assert!(arg2.project_id == 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::project_id(arg0), 5);
        assert!(arg2.state_id == 0x2::object::id<ReferralPolicyState>(arg1), 5);
        assert!(arg1.project_object_id == 0x2::object::id<0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::Project>(arg0), 0);
        assert!(arg1.project_id == 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::project_id(arg0), 0);
    }

    fun assert_state_project(arg0: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project_cap::ProjectCap, arg1: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::Project, arg2: &ReferralPolicyState) {
        assert_project_cap(arg0, arg1);
        assert!(arg2.project_object_id == 0x2::object::id<0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::Project>(arg1), 0);
        assert!(arg2.project_id == 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::project_id(arg1), 0);
    }

    fun assert_valid_referral_bps(arg0: u64) {
        assert!(arg0 <= 10000, 1);
    }

    fun assert_yt_record_match(arg0: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::Project, arg1: &ReferralPolicyState, arg2: &YtReferralRecord) {
        assert!(arg2.project_id == 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::project_id(arg0), 11);
        assert!(arg2.state_id == 0x2::object::id<ReferralPolicyState>(arg1), 11);
        assert!(arg1.project_object_id == 0x2::object::id<0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::Project>(arg0), 0);
        assert!(arg1.project_id == 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::project_id(arg0), 0);
    }

    public fun bind_lp_referrer<T0: drop>(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg2: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::Project, arg3: T0, arg4: &LpReferralSourceCap<T0>, arg5: &ReferralPolicyState, arg6: &0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::bonding_table::ReferralTable, arg7: &mut LpReferralRecord, arg8: u128) {
        assert!(!lp_referral_record_archived(arg7), 22);
        0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::package_version::assert_current(arg0);
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::package_version::assert_domain_enabled(arg1, 0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::router_domain());
        assert!(arg5.enabled, 2);
        assert_record_match(arg2, arg5, arg7);
        assert!(arg7.source_id == arg4.source_id, 5);
        assert_authorized_source_cap<T0>(arg2, arg3, arg4);
        assert!(arg7.referrer == @0x0, 9);
        let v0 = 0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::bonding_table::try_get_refer(arg6, arg7.referee);
        assert!(0x1::option::is_some<address>(&v0), 10);
        let v1 = 0x1::option::destroy_some<address>(v0);
        assert!(v1 != @0x0, 10);
        arg7.pending_points = 0;
        arg7.pending_bonus_numerator_remainder = 0;
        arg7.reward_debt = reward_debt(arg7.point_exposure, arg8);
        arg7.referrer = v1;
        arg7.referral_bps = arg5.referral_bps;
        let v2 = LpReferrerBound{
            record_id                           : 0x2::object::id<LpReferralRecord>(arg7),
            state_id                            : arg7.state_id,
            project_id                          : arg7.project_id,
            source_id                           : arg7.source_id,
            pool_id                             : arg7.pool_id,
            position_id                         : arg7.position_id,
            referee                             : arg7.referee,
            referrer                            : v1,
            referral_bps                        : arg7.referral_bps,
            acc_point_per_lp                    : arg8,
            forfeited_pending_points            : arg7.pending_points,
            forfeited_bonus_numerator_remainder : arg7.pending_bonus_numerator_remainder,
        };
        0x2::event::emit<LpReferrerBound>(v2);
    }

    public fun bind_yt_referrer<T0: drop>(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg2: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::Project, arg3: T0, arg4: &YtReferralSourceCap<T0>, arg5: &ReferralPolicyState, arg6: &0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::bonding_table::ReferralTable, arg7: &mut YtReferralRecord, arg8: u256) {
        assert!(!yt_referral_record_archived(arg7), 22);
        0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::package_version::assert_current(arg0);
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::package_version::assert_domain_enabled(arg1, 0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::router_domain());
        assert!(arg5.enabled, 2);
        assert_yt_record_match(arg2, arg5, arg7);
        assert!(arg7.source_id == arg4.source_id, 11);
        assert_authorized_yt_source_cap<T0>(arg2, arg3, arg4);
        assert!(arg7.referrer == @0x0, 14);
        let v0 = 0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::bonding_table::try_get_refer(arg6, arg7.referee);
        assert!(0x1::option::is_some<address>(&v0), 15);
        let v1 = 0x1::option::destroy_some<address>(v0);
        assert!(v1 != @0x0, 15);
        arg7.pending_points = 0;
        arg7.pending_bonus_numerator_remainder = 0;
        arg7.reward_debt_scaled = yt_reward_debt_scaled(arg7.base_amount, arg8);
        arg7.referrer = v1;
        arg7.referral_bps = arg5.referral_bps;
        let v2 = YtReferrerBound{
            record_id                           : 0x2::object::id<YtReferralRecord>(arg7),
            state_id                            : arg7.state_id,
            project_id                          : arg7.project_id,
            source_id                           : arg7.source_id,
            market_id                           : arg7.market_id,
            position_id                         : arg7.position_id,
            referee                             : arg7.referee,
            referrer                            : v1,
            referral_bps                        : arg7.referral_bps,
            acc_point_per_base                  : arg8,
            forfeited_pending_points            : arg7.pending_points,
            forfeited_bonus_numerator_remainder : arg7.pending_bonus_numerator_remainder,
        };
        0x2::event::emit<YtReferrerBound>(v2);
    }

    fun checked_add_u64(arg0: u64, arg1: u64) : u64 {
        let v0 = (arg0 as u256) + (arg1 as u256);
        assert!(v0 <= 18446744073709551615, 1);
        (v0 as u64)
    }

    public fun claim_archived_referral(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg2: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::Project, arg3: &ReferralPolicyState, arg4: &mut 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::scoreboard::Scoreboard, arg5: &mut DeferredReferralClaim, arg6: &mut 0x2::tx_context::TxContext) {
        0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::package_version::assert_current(arg0);
        0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::assert_target_active<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::package_version::PackageMarker>(arg0, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::package_version::version(), b"market", arg5.market_id, 23);
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::package_version::assert_domain_enabled(arg1, 0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::router_domain());
        assert!(arg3.closed, 19);
        assert!(arg3.project_object_id == 0x2::object::id<0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::Project>(arg2), 0);
        assert!(arg3.project_id == 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::project_id(arg2), 0);
        assert!(arg5.project_object_id == 0x2::object::id<0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::Project>(arg2), 20);
        assert!(arg5.project_id == arg3.project_id, 20);
        assert!(arg5.state_id == 0x2::object::id<ReferralPolicyState>(arg3), 20);
        assert!(arg5.owner == 0x2::tx_context::sender(arg6), 21);
        assert!(0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::enabled(arg2) && 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::auth_source_enabled_by_type(arg2, arg5.source_witness, arg5.source_id), 3);
        let v0 = arg5.pending_points;
        let v1 = JitterReferralPolicy{dummy_field: false};
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::stamp::settle_policy_add<JitterReferralPolicy, ReferralPolicyState>(arg1, arg2, arg3, &arg3.settlement_cap, v1, arg4, v0, 1, arg5.owner, arg5.position_id);
        arg5.pending_points = 0;
        let v2 = ArchivedReferralClaimed{
            claim_id                          : 0x2::object::id<DeferredReferralClaim>(arg5),
            record_id                         : arg5.record_id,
            owner                             : arg5.owner,
            amount                            : v0,
            pending_bonus_numerator_remainder : arg5.pending_bonus_numerator_remainder,
        };
        0x2::event::emit<ArchivedReferralClaimed>(v2);
    }

    public fun claim_lp_referral<T0: drop>(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg2: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::Project, arg3: T0, arg4: &LpReferralSourceCap<T0>, arg5: &ReferralPolicyState, arg6: &mut LpReferralRecord, arg7: &mut 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::scoreboard::Scoreboard, arg8: u128, arg9: u64) {
        assert!(!lp_referral_record_archived(arg6), 22);
        0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::package_version::assert_current(arg0);
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::package_version::assert_domain_enabled(arg1, 0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::router_domain());
        assert!(arg5.enabled || arg5.closed, 2);
        assert_record_match(arg2, arg5, arg6);
        assert!(arg6.source_id == arg4.source_id, 5);
        assert_authorized_source_cap<T0>(arg2, arg3, arg4);
        settle_lp_referral_pending(arg6, arg8);
        let v0 = arg6.pending_points;
        assert!(v0 == 0 || arg6.referrer != @0x0, 5);
        arg6.pending_points = 0;
        if (arg6.referrer != @0x0) {
            let v1 = JitterReferralPolicy{dummy_field: false};
            0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::stamp::settle_policy_add<JitterReferralPolicy, ReferralPolicyState>(arg1, arg2, arg5, &arg5.settlement_cap, v1, arg7, v0, arg9, arg6.referrer, arg6.position_id);
        };
        let v2 = LpReferralClaimed{
            record_id     : 0x2::object::id<LpReferralRecord>(arg6),
            state_id      : arg6.state_id,
            project_id    : arg6.project_id,
            source_id     : arg6.source_id,
            pool_id       : arg6.pool_id,
            position_id   : arg6.position_id,
            referee       : arg6.referee,
            referrer      : arg6.referrer,
            amount        : v0,
            pending_after : arg6.pending_points,
        };
        0x2::event::emit<LpReferralClaimed>(v2);
    }

    public fun claim_yt_referral<T0: drop>(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg2: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::Project, arg3: T0, arg4: &YtReferralSourceCap<T0>, arg5: &ReferralPolicyState, arg6: &mut YtReferralRecord, arg7: &mut 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::scoreboard::Scoreboard, arg8: u256, arg9: u64) {
        assert!(!yt_referral_record_archived(arg6), 22);
        0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::package_version::assert_current(arg0);
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::package_version::assert_domain_enabled(arg1, 0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::router_domain());
        assert!(arg5.enabled || arg5.closed, 2);
        assert_yt_record_match(arg2, arg5, arg6);
        assert!(arg6.source_id == arg4.source_id, 11);
        assert_authorized_yt_source_cap<T0>(arg2, arg3, arg4);
        settle_yt_referral_pending(arg6, arg8);
        let v0 = arg6.pending_points;
        assert!(v0 == 0 || arg6.referrer != @0x0, 11);
        arg6.pending_points = 0;
        if (arg6.referrer != @0x0) {
            let v1 = JitterReferralPolicy{dummy_field: false};
            0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::stamp::settle_policy_add<JitterReferralPolicy, ReferralPolicyState>(arg1, arg2, arg5, &arg5.settlement_cap, v1, arg7, v0, arg9, arg6.referrer, arg6.position_id);
        };
        let v2 = YtReferralClaimed{
            record_id     : 0x2::object::id<YtReferralRecord>(arg6),
            state_id      : arg6.state_id,
            project_id    : arg6.project_id,
            source_id     : arg6.source_id,
            market_id     : arg6.market_id,
            position_id   : arg6.position_id,
            referee       : arg6.referee,
            referrer      : arg6.referrer,
            amount        : v0,
            pending_after : arg6.pending_points,
        };
        0x2::event::emit<YtReferralClaimed>(v2);
    }

    public fun close_campaign(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg2: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project_cap::ProjectCap, arg3: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::Project, arg4: &mut 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::scoreboard::Scoreboard, arg5: &mut ReferralPolicyState, arg6: &0x2::clock::Clock) {
        0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::package_version::assert_current(arg0);
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::package_version::assert_domain_enabled(arg1, 0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::router_domain());
        assert_state_project(arg2, arg3, arg5);
        let v0 = JitterReferralPolicy{dummy_field: false};
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::close_point_policy_scoring<JitterReferralPolicy>(arg1, arg2, arg3, arg4, v0, 0x2::object::id<ReferralPolicyState>(arg5), arg6);
        if (arg5.closed) {
            return
        };
        arg5.enabled = false;
        arg5.closed = true;
        arg5.closed_at_ms = 0x2::clock::timestamp_ms(arg6);
        let v1 = ReferralCampaignClosed{
            state_id     : 0x2::object::id<ReferralPolicyState>(arg5),
            project_id   : arg5.project_id,
            closed_at_ms : arg5.closed_at_ms,
        };
        0x2::event::emit<ReferralCampaignClosed>(v1);
    }

    public fun close_lp_referral_record<T0: drop>(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg2: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::Project, arg3: T0, arg4: &LpReferralSourceCap<T0>, arg5: &ReferralPolicyState, arg6: LpReferralRecord) : u256 {
        assert!(!lp_referral_record_archived(&arg6), 22);
        0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::package_version::assert_current(arg0);
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::package_version::assert_current(arg1);
        assert_record_match(arg2, arg5, &arg6);
        assert!(arg6.source_id == arg4.source_id, 5);
        assert_authorized_source_cap<T0>(arg2, arg3, arg4);
        let v0 = if (arg6.lp_amount == 0) {
            if (arg6.point_exposure == 0) {
                arg6.reward_debt == 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 7);
        assert!(arg6.pending_points == 0, 8);
        let LpReferralRecord {
            id                                : v1,
            project_id                        : v2,
            state_id                          : v3,
            source_id                         : v4,
            pool_id                           : v5,
            position_id                       : v6,
            referee                           : v7,
            referrer                          : v8,
            referral_bps                      : _,
            lp_amount                         : _,
            point_exposure                    : _,
            reward_debt                       : _,
            pending_points                    : _,
            pending_bonus_numerator_remainder : v14,
        } = arg6;
        0x2::object::delete(v1);
        let v15 = LpReferralRecordClosed{
            record_id                           : 0x2::object::id<LpReferralRecord>(&arg6),
            state_id                            : v3,
            project_id                          : v2,
            source_id                           : v4,
            pool_id                             : v5,
            position_id                         : v6,
            referee                             : v7,
            referrer                            : v8,
            forfeited_bonus_numerator_remainder : v14,
        };
        0x2::event::emit<LpReferralRecordClosed>(v15);
        v14
    }

    public fun close_yt_referral_record<T0: drop>(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg2: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::Project, arg3: T0, arg4: &YtReferralSourceCap<T0>, arg5: &ReferralPolicyState, arg6: YtReferralRecord) : u256 {
        assert!(!yt_referral_record_archived(&arg6), 22);
        0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::package_version::assert_current(arg0);
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::package_version::assert_current(arg1);
        assert_yt_record_match(arg2, arg5, &arg6);
        assert!(arg6.source_id == arg4.source_id, 11);
        assert_authorized_yt_source_cap<T0>(arg2, arg3, arg4);
        assert!(arg6.base_amount == 0 && arg6.reward_debt_scaled == 0, 12);
        assert!(arg6.pending_points == 0, 13);
        let YtReferralRecord {
            id                                : v0,
            project_id                        : v1,
            state_id                          : v2,
            source_id                         : v3,
            market_id                         : v4,
            position_id                       : v5,
            referee                           : v6,
            referrer                          : v7,
            referral_bps                      : _,
            base_amount                       : _,
            reward_debt_scaled                : _,
            pending_points                    : _,
            pending_bonus_numerator_remainder : v12,
        } = arg6;
        0x2::object::delete(v0);
        let v13 = YtReferralRecordClosed{
            record_id                           : 0x2::object::id<YtReferralRecord>(&arg6),
            state_id                            : v2,
            project_id                          : v1,
            source_id                           : v3,
            market_id                           : v4,
            position_id                         : v5,
            referee                             : v6,
            referrer                            : v7,
            forfeited_bonus_numerator_remainder : v12,
        };
        0x2::event::emit<YtReferralRecordClosed>(v13);
        v12
    }

    public fun closed(arg0: &ReferralPolicyState) : bool {
        arg0.closed
    }

    public fun closed_at_ms(arg0: &ReferralPolicyState) : u64 {
        arg0.closed_at_ms
    }

    public fun create_lp_referral_record<T0: drop>(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg2: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::Project, arg3: T0, arg4: &LpReferralSourceCap<T0>, arg5: &ReferralPolicyState, arg6: &0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::bonding_table::ReferralTable, arg7: address, arg8: 0x2::object::ID, arg9: 0x2::object::ID, arg10: u64, arg11: u64, arg12: u128, arg13: &mut 0x2::tx_context::TxContext) : LpReferralRecord {
        0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::package_version::assert_current(arg0);
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::package_version::assert_domain_enabled(arg1, 0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::router_domain());
        assert!(arg5.enabled, 2);
        assert!(arg5.project_object_id == 0x2::object::id<0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::Project>(arg2), 0);
        assert!(arg5.project_id == 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::project_id(arg2), 0);
        assert_authorized_source_cap<T0>(arg2, arg3, arg4);
        let v0 = 0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::bonding_table::try_get_refer(arg6, arg7);
        let (v1, v2) = if (0x1::option::is_some<address>(&v0)) {
            (0x1::option::destroy_some<address>(v0), arg5.referral_bps)
        } else {
            (@0x0, 0)
        };
        let v3 = LpReferralRecord{
            id                                : 0x2::object::new(arg13),
            project_id                        : 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::project_id(arg2),
            state_id                          : 0x2::object::id<ReferralPolicyState>(arg5),
            source_id                         : arg4.source_id,
            pool_id                           : arg8,
            position_id                       : arg9,
            referee                           : arg7,
            referrer                          : v1,
            referral_bps                      : v2,
            lp_amount                         : arg10,
            point_exposure                    : arg11,
            reward_debt                       : reward_debt(arg11, arg12),
            pending_points                    : 0,
            pending_bonus_numerator_remainder : 0,
        };
        let v4 = LpReferralRecordCreated{
            record_id      : 0x2::object::id<LpReferralRecord>(&v3),
            state_id       : 0x2::object::id<ReferralPolicyState>(arg5),
            project_id     : 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::project_id(arg2),
            source_id      : arg4.source_id,
            pool_id        : arg8,
            position_id    : arg9,
            referee        : arg7,
            referrer       : v1,
            referral_bps   : v2,
            lp_amount      : arg10,
            point_exposure : arg11,
        };
        0x2::event::emit<LpReferralRecordCreated>(v4);
        v3
    }

    public fun create_lp_referral_source_cap<T0: drop>(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg2: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project_cap::ProjectCap, arg3: &mut 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::Project, arg4: T0, arg5: 0x2::object::ID) : LpReferralSourceCap<T0> {
        0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::package_version::assert_current(arg0);
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::register_auth_source<T0>(arg1, arg2, arg3, arg4, arg5);
        LpReferralSourceCap<T0>{
            project_id : 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::project_id(arg3),
            source_id  : arg5,
        }
    }

    public fun create_state(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg2: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project_cap::ProjectCap, arg3: &mut 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::Project, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : ReferralPolicyState {
        0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::package_version::assert_current(arg0);
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::package_version::assert_domain_enabled(arg1, 0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::router_domain());
        assert_project_cap(arg2, arg3);
        assert_valid_referral_bps(arg4);
        let v0 = 0x2::object::new(arg5);
        let v1 = JitterReferralPolicy{dummy_field: false};
        let v2 = ReferralPolicyState{
            id                : v0,
            project_object_id : 0x2::object::id<0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::Project>(arg3),
            project_id        : 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::project_id(arg3),
            enabled           : true,
            closed            : false,
            closed_at_ms      : 0,
            referral_bps      : arg4,
            settlement_cap    : 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::register_point_policy_with_cap<JitterReferralPolicy>(arg1, arg2, arg3, v1, 0x2::object::uid_to_inner(&v0)),
        };
        let v3 = ReferralPolicyStateCreated{
            state_id          : 0x2::object::id<ReferralPolicyState>(&v2),
            project_object_id : 0x2::object::id<0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::Project>(arg3),
            project_id        : 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::project_id(arg3),
            referral_bps      : arg4,
        };
        0x2::event::emit<ReferralPolicyStateCreated>(v3);
        v2
    }

    public fun create_yt_referral_record<T0: drop>(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg2: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::Project, arg3: T0, arg4: &YtReferralSourceCap<T0>, arg5: &ReferralPolicyState, arg6: &0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::bonding_table::ReferralTable, arg7: address, arg8: 0x2::object::ID, arg9: 0x2::object::ID, arg10: u256, arg11: u256, arg12: &mut 0x2::tx_context::TxContext) : YtReferralRecord {
        0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::package_version::assert_current(arg0);
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::package_version::assert_domain_enabled(arg1, 0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::router_domain());
        assert!(arg5.enabled, 2);
        assert!(arg5.project_object_id == 0x2::object::id<0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::Project>(arg2), 0);
        assert!(arg5.project_id == 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::project_id(arg2), 0);
        assert_authorized_yt_source_cap<T0>(arg2, arg3, arg4);
        let v0 = 0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::bonding_table::try_get_refer(arg6, arg7);
        let (v1, v2) = if (0x1::option::is_some<address>(&v0)) {
            (0x1::option::destroy_some<address>(v0), arg5.referral_bps)
        } else {
            (@0x0, 0)
        };
        let v3 = YtReferralRecord{
            id                                : 0x2::object::new(arg12),
            project_id                        : 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::project_id(arg2),
            state_id                          : 0x2::object::id<ReferralPolicyState>(arg5),
            source_id                         : arg4.source_id,
            market_id                         : arg8,
            position_id                       : arg9,
            referee                           : arg7,
            referrer                          : v1,
            referral_bps                      : v2,
            base_amount                       : arg10,
            reward_debt_scaled                : yt_reward_debt_scaled(arg10, arg11),
            pending_points                    : 0,
            pending_bonus_numerator_remainder : 0,
        };
        let v4 = YtReferralRecordCreated{
            record_id    : 0x2::object::id<YtReferralRecord>(&v3),
            state_id     : 0x2::object::id<ReferralPolicyState>(arg5),
            project_id   : 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::project_id(arg2),
            source_id    : arg4.source_id,
            market_id    : arg8,
            position_id  : arg9,
            referee      : arg7,
            referrer     : v1,
            referral_bps : v2,
            base_amount  : arg10,
        };
        0x2::event::emit<YtReferralRecordCreated>(v4);
        v3
    }

    public fun create_yt_referral_source_cap<T0: drop>(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg2: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project_cap::ProjectCap, arg3: &mut 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::Project, arg4: T0, arg5: 0x2::object::ID) : YtReferralSourceCap<T0> {
        0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::package_version::assert_current(arg0);
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::register_auth_source<T0>(arg1, arg2, arg3, arg4, arg5);
        YtReferralSourceCap<T0>{
            project_id : 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::project_id(arg3),
            source_id  : arg5,
        }
    }

    public fun deferred_referral_claim_is_lp(arg0: &DeferredReferralClaim) : bool {
        arg0.is_lp
    }

    public fun deferred_referral_claim_market_id(arg0: &DeferredReferralClaim) : 0x2::object::ID {
        arg0.market_id
    }

    public fun deferred_referral_claim_owner(arg0: &DeferredReferralClaim) : address {
        arg0.owner
    }

    public fun deferred_referral_claim_pending_bonus_numerator_remainder(arg0: &DeferredReferralClaim) : u256 {
        arg0.pending_bonus_numerator_remainder
    }

    public fun deferred_referral_claim_pending_points(arg0: &DeferredReferralClaim) : u64 {
        arg0.pending_points
    }

    public fun deferred_referral_claim_position_id(arg0: &DeferredReferralClaim) : 0x2::object::ID {
        arg0.position_id
    }

    public fun deferred_referral_claim_precision(arg0: &DeferredReferralClaim) : u256 {
        arg0.precision
    }

    public fun deferred_referral_claim_project_id(arg0: &DeferredReferralClaim) : 0x2::object::ID {
        arg0.project_id
    }

    public fun deferred_referral_claim_project_object_id(arg0: &DeferredReferralClaim) : 0x2::object::ID {
        arg0.project_object_id
    }

    public fun deferred_referral_claim_record_id(arg0: &DeferredReferralClaim) : 0x2::object::ID {
        arg0.record_id
    }

    public fun deferred_referral_claim_referee(arg0: &DeferredReferralClaim) : address {
        arg0.referee
    }

    public fun deferred_referral_claim_source_id(arg0: &DeferredReferralClaim) : 0x2::object::ID {
        arg0.source_id
    }

    public fun deferred_referral_claim_source_witness(arg0: &DeferredReferralClaim) : 0x1::type_name::TypeName {
        arg0.source_witness
    }

    public fun deferred_referral_claim_state_id(arg0: &DeferredReferralClaim) : 0x2::object::ID {
        arg0.state_id
    }

    public fun lp_referral_record_archived(arg0: &LpReferralRecord) : bool {
        let v0 = ReferralArchivedKey{dummy_field: false};
        0x2::dynamic_field::exists_<ReferralArchivedKey>(&arg0.id, v0)
    }

    public fun lp_referral_record_lp_amount(arg0: &LpReferralRecord) : u64 {
        arg0.lp_amount
    }

    public fun lp_referral_record_pending_bonus_numerator_remainder(arg0: &LpReferralRecord) : u256 {
        arg0.pending_bonus_numerator_remainder
    }

    public fun lp_referral_record_pending_points(arg0: &LpReferralRecord) : u64 {
        arg0.pending_points
    }

    public fun lp_referral_record_point_exposure(arg0: &LpReferralRecord) : u64 {
        arg0.point_exposure
    }

    public fun lp_referral_record_pool_id(arg0: &LpReferralRecord) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun lp_referral_record_position_id(arg0: &LpReferralRecord) : 0x2::object::ID {
        arg0.position_id
    }

    public fun lp_referral_record_project_id(arg0: &LpReferralRecord) : 0x2::object::ID {
        arg0.project_id
    }

    public fun lp_referral_record_referee(arg0: &LpReferralRecord) : address {
        arg0.referee
    }

    public fun lp_referral_record_referral_bps(arg0: &LpReferralRecord) : u64 {
        arg0.referral_bps
    }

    public fun lp_referral_record_referrer(arg0: &LpReferralRecord) : address {
        arg0.referrer
    }

    public fun lp_referral_record_source_id(arg0: &LpReferralRecord) : 0x2::object::ID {
        arg0.source_id
    }

    public fun lp_referral_record_state_id(arg0: &LpReferralRecord) : 0x2::object::ID {
        arg0.state_id
    }

    public fun lp_referral_source_cap_project_id<T0: drop>(arg0: &LpReferralSourceCap<T0>) : 0x2::object::ID {
        arg0.project_id
    }

    public fun lp_referral_source_cap_source_id<T0: drop>(arg0: &LpReferralSourceCap<T0>) : 0x2::object::ID {
        arg0.source_id
    }

    fun pending_lp_referral_delta(arg0: &LpReferralRecord, arg1: u128) : (u64, u256) {
        let v0 = reward_debt(arg0.point_exposure, arg1);
        assert!(v0 >= arg0.reward_debt, 6);
        let v1 = (v0 - arg0.reward_debt) * (arg0.referral_bps as u256) + arg0.pending_bonus_numerator_remainder;
        let v2 = v1 / 10000000000000000;
        assert!(v2 <= 18446744073709551615, 1);
        ((v2 as u64), v1 % 10000000000000000)
    }

    public fun pending_lp_referral_points(arg0: &LpReferralRecord, arg1: u128) : u64 {
        let (v0, _) = pending_lp_referral_delta(arg0, arg1);
        v0
    }

    fun pending_yt_referral_delta(arg0: &YtReferralRecord, arg1: u256) : (u64, u256) {
        let v0 = yt_reward_debt_scaled(arg0.base_amount, arg1);
        assert!(v0 >= arg0.reward_debt_scaled, 6);
        let v1 = v0 - arg0.reward_debt_scaled;
        assert!(v1 == 0 || (arg0.referral_bps as u256) <= 115792089237316195423570985008687907853269984665640564039457584007913129639935 / v1, 16);
        let v2 = v1 * (arg0.referral_bps as u256);
        assert!(v2 <= 115792089237316195423570985008687907853269984665640564039457584007913129639935 - arg0.pending_bonus_numerator_remainder, 16);
        let v3 = v2 + arg0.pending_bonus_numerator_remainder;
        let v4 = v3 / 3402823669209384634633746074317682114560000;
        assert!(v4 <= 18446744073709551615, 16);
        ((v4 as u64), v3 % 3402823669209384634633746074317682114560000)
    }

    public fun pending_yt_referral_points(arg0: &YtReferralRecord, arg1: u256) : u64 {
        let (v0, _) = pending_yt_referral_delta(arg0, arg1);
        v0
    }

    public fun project_object_id(arg0: &ReferralPolicyState) : 0x2::object::ID {
        arg0.project_object_id
    }

    public fun referral_bps(arg0: &ReferralPolicyState) : u64 {
        arg0.referral_bps
    }

    public fun register_policy(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg2: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project_cap::ProjectCap, arg3: &mut 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::Project, arg4: &mut ReferralPolicyState) {
        0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::package_version::assert_current(arg0);
        assert_state_project(arg2, arg3, arg4);
        assert!(!arg4.closed, 17);
        let v0 = JitterReferralPolicy{dummy_field: false};
        arg4.settlement_cap = 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::register_point_policy_with_cap<JitterReferralPolicy>(arg1, arg2, arg3, v0, 0x2::object::id<ReferralPolicyState>(arg4));
    }

    fun reward_debt(arg0: u64, arg1: u128) : u256 {
        (arg0 as u256) * (arg1 as u256)
    }

    public fun set_enabled(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg2: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project_cap::ProjectCap, arg3: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::Project, arg4: &mut ReferralPolicyState, arg5: bool) {
        0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::package_version::assert_current(arg0);
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::package_version::assert_domain_enabled(arg1, 0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::router_domain());
        assert_state_project(arg2, arg3, arg4);
        assert!(!arg4.closed, 17);
        arg4.enabled = arg5;
        let v0 = ReferralEnabledUpdated{
            state_id   : 0x2::object::id<ReferralPolicyState>(arg4),
            project_id : arg4.project_id,
            enabled    : arg5,
        };
        0x2::event::emit<ReferralEnabledUpdated>(v0);
    }

    public fun set_referral_bps(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg2: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project_cap::ProjectCap, arg3: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::Project, arg4: &mut ReferralPolicyState, arg5: u64) {
        0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::package_version::assert_current(arg0);
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::package_version::assert_domain_enabled(arg1, 0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::router_domain());
        assert_state_project(arg2, arg3, arg4);
        assert!(!arg4.closed, 17);
        assert_valid_referral_bps(arg5);
        arg4.referral_bps = arg5;
        let v0 = ReferralBpsUpdated{
            state_id     : 0x2::object::id<ReferralPolicyState>(arg4),
            project_id   : arg4.project_id,
            referral_bps : arg5,
        };
        0x2::event::emit<ReferralBpsUpdated>(v0);
    }

    fun settle_lp_referral_pending(arg0: &mut LpReferralRecord, arg1: u128) {
        let (v0, v1) = pending_lp_referral_delta(arg0, arg1);
        arg0.pending_points = checked_add_u64(arg0.pending_points, v0);
        arg0.pending_bonus_numerator_remainder = v1;
        arg0.reward_debt = reward_debt(arg0.point_exposure, arg1);
    }

    fun settle_yt_referral_pending(arg0: &mut YtReferralRecord, arg1: u256) {
        let (v0, v1) = pending_yt_referral_delta(arg0, arg1);
        arg0.pending_points = checked_add_u64(arg0.pending_points, v0);
        arg0.pending_bonus_numerator_remainder = v1;
        arg0.reward_debt_scaled = yt_reward_debt_scaled(arg0.base_amount, arg1);
    }

    public fun share_lp_record(arg0: LpReferralRecord) {
        0x2::transfer::share_object<LpReferralRecord>(arg0);
    }

    public fun share_yt_record(arg0: YtReferralRecord) {
        0x2::transfer::share_object<YtReferralRecord>(arg0);
    }

    public fun sync_lp_referral_record<T0: drop>(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg2: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::Project, arg3: T0, arg4: &LpReferralSourceCap<T0>, arg5: &ReferralPolicyState, arg6: &mut LpReferralRecord, arg7: u64, arg8: u64, arg9: u128) {
        assert!(!lp_referral_record_archived(arg6), 22);
        0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::package_version::assert_current(arg0);
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::package_version::assert_domain_enabled(arg1, 0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::router_domain());
        assert!(arg5.enabled || arg5.closed, 2);
        assert_record_match(arg2, arg5, arg6);
        assert!(arg6.source_id == arg4.source_id, 5);
        assert_authorized_source_cap<T0>(arg2, arg3, arg4);
        let v0 = arg6.lp_amount;
        let v1 = arg6.point_exposure;
        let v2 = arg6.referral_bps;
        if (arg6.referrer == @0x0) {
            arg6.referral_bps = 0;
            arg6.pending_bonus_numerator_remainder = 0;
            arg6.reward_debt = reward_debt(arg6.point_exposure, arg9);
        } else {
            settle_lp_referral_pending(arg6, arg9);
        };
        arg6.lp_amount = arg7;
        arg6.point_exposure = arg8;
        let v3 = if (arg5.closed || arg6.referrer == @0x0) {
            0
        } else {
            arg5.referral_bps
        };
        arg6.referral_bps = v3;
        arg6.reward_debt = reward_debt(arg8, arg9);
        let v4 = LpReferralRecordSynced{
            record_id             : 0x2::object::id<LpReferralRecord>(arg6),
            state_id              : arg6.state_id,
            project_id            : arg6.project_id,
            source_id             : arg6.source_id,
            pool_id               : arg6.pool_id,
            position_id           : arg6.position_id,
            referee               : arg6.referee,
            referrer              : arg6.referrer,
            lp_amount_before      : v0,
            lp_amount_after       : arg7,
            point_exposure_before : v1,
            point_exposure_after  : arg8,
            referral_bps_before   : v2,
            referral_bps_after    : arg6.referral_bps,
            pending_points        : arg6.pending_points,
        };
        0x2::event::emit<LpReferralRecordSynced>(v4);
    }

    public fun sync_yt_referral_record<T0: drop>(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg2: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::Project, arg3: T0, arg4: &YtReferralSourceCap<T0>, arg5: &ReferralPolicyState, arg6: &mut YtReferralRecord, arg7: u256, arg8: u256) {
        assert!(!yt_referral_record_archived(arg6), 22);
        0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::package_version::assert_current(arg0);
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::package_version::assert_domain_enabled(arg1, 0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::router_domain());
        assert!(arg5.enabled || arg5.closed, 2);
        assert_yt_record_match(arg2, arg5, arg6);
        assert!(arg6.source_id == arg4.source_id, 11);
        assert_authorized_yt_source_cap<T0>(arg2, arg3, arg4);
        let v0 = arg6.base_amount;
        let v1 = arg6.referral_bps;
        if (arg6.referrer == @0x0) {
            arg6.referral_bps = 0;
            arg6.pending_bonus_numerator_remainder = 0;
            arg6.reward_debt_scaled = yt_reward_debt_scaled(arg6.base_amount, arg8);
        } else {
            settle_yt_referral_pending(arg6, arg8);
        };
        arg6.base_amount = arg7;
        let v2 = if (arg5.closed || arg6.referrer == @0x0) {
            0
        } else {
            arg5.referral_bps
        };
        arg6.referral_bps = v2;
        arg6.reward_debt_scaled = yt_reward_debt_scaled(arg7, arg8);
        let v3 = YtReferralRecordSynced{
            record_id           : 0x2::object::id<YtReferralRecord>(arg6),
            state_id            : arg6.state_id,
            project_id          : arg6.project_id,
            source_id           : arg6.source_id,
            market_id           : arg6.market_id,
            position_id         : arg6.position_id,
            referee             : arg6.referee,
            referrer            : arg6.referrer,
            base_amount_before  : v0,
            base_amount_after   : arg7,
            referral_bps_before : v1,
            referral_bps_after  : arg6.referral_bps,
            pending_points      : arg6.pending_points,
        };
        0x2::event::emit<YtReferralRecordSynced>(v3);
    }

    public fun unregister_policy(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg2: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project_cap::ProjectCap, arg3: &mut 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::Project, arg4: &mut 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::scoreboard::Scoreboard, arg5: &ReferralPolicyState, arg6: &0x2::clock::Clock) {
        0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::package_version::assert_current(arg0);
        assert_state_project(arg2, arg3, arg5);
        assert!(!arg5.closed, 17);
        let v0 = JitterReferralPolicy{dummy_field: false};
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::unregister_point_policy<JitterReferralPolicy>(arg1, arg2, arg3, arg4, v0, 0x2::object::id<ReferralPolicyState>(arg5), arg6);
    }

    public fun yt_referral_record_archived(arg0: &YtReferralRecord) : bool {
        let v0 = ReferralArchivedKey{dummy_field: false};
        0x2::dynamic_field::exists_<ReferralArchivedKey>(&arg0.id, v0)
    }

    public fun yt_referral_record_base_amount(arg0: &YtReferralRecord) : u256 {
        arg0.base_amount
    }

    public fun yt_referral_record_market_id(arg0: &YtReferralRecord) : 0x2::object::ID {
        arg0.market_id
    }

    public fun yt_referral_record_pending_bonus_numerator_remainder(arg0: &YtReferralRecord) : u256 {
        arg0.pending_bonus_numerator_remainder
    }

    public fun yt_referral_record_pending_points(arg0: &YtReferralRecord) : u64 {
        arg0.pending_points
    }

    public fun yt_referral_record_position_id(arg0: &YtReferralRecord) : 0x2::object::ID {
        arg0.position_id
    }

    public fun yt_referral_record_project_id(arg0: &YtReferralRecord) : 0x2::object::ID {
        arg0.project_id
    }

    public fun yt_referral_record_referee(arg0: &YtReferralRecord) : address {
        arg0.referee
    }

    public fun yt_referral_record_referral_bps(arg0: &YtReferralRecord) : u64 {
        arg0.referral_bps
    }

    public fun yt_referral_record_referrer(arg0: &YtReferralRecord) : address {
        arg0.referrer
    }

    public fun yt_referral_record_source_id(arg0: &YtReferralRecord) : 0x2::object::ID {
        arg0.source_id
    }

    public fun yt_referral_record_state_id(arg0: &YtReferralRecord) : 0x2::object::ID {
        arg0.state_id
    }

    public fun yt_referral_source_cap_project_id<T0: drop>(arg0: &YtReferralSourceCap<T0>) : 0x2::object::ID {
        arg0.project_id
    }

    public fun yt_referral_source_cap_source_id<T0: drop>(arg0: &YtReferralSourceCap<T0>) : 0x2::object::ID {
        arg0.source_id
    }

    fun yt_reward_debt_scaled(arg0: u256, arg1: u256) : u256 {
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        assert!(arg1 <= 115792089237316195423570985008687907853269984665640564039457584007913129639935 / arg0, 16);
        arg0 * arg1
    }

    // decompiled from Move bytecode v7
}

