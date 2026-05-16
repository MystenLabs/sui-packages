module 0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::dispute_quorum {
    struct DisputeQuorumConfig has key {
        id: 0x2::object::UID,
        min_reviewer_level: u8,
        min_reviewer_confidence: u64,
        min_reviewer_score: u64,
        default_required_reviewer_votes: u64,
        min_required_reviewer_votes: u64,
        max_required_reviewer_votes: u64,
        default_reviewer_accept_window_ms: u64,
        default_vote_commit_window_ms: u64,
        default_vote_reveal_window_ms: u64,
        default_vote_challenge_window_ms: u64,
        default_max_replacement_rounds: u64,
        default_case_hard_timeout_ms: u64,
        fallback_after_ms: u64,
        platform_fallback_sink: address,
        min_dispute_bond_per_side_sui: u64,
        max_dispute_bond_per_side_sui: u64,
        target_reviewer_payout_bps: u64,
        target_platform_fallback_payout_bps: u64,
        reviewer_noshow_slash_bps: u64,
        reviewer_invalid_reveal_slash_bps: u64,
        reviewer_overturn_slash_bps: u64,
        reviewer_min_stake_sui: u64,
        max_active_cases_per_reviewer: u64,
    }

    struct ReviewerRegistry has key {
        id: 0x2::object::UID,
        reviewer_count: u64,
        bootstrap_approved_reviewers: vector<address>,
    }

    struct ReviewerEntry has key {
        id: 0x2::object::UID,
        owner: address,
        active: bool,
        transport_type: u8,
        transport_pubkey: vector<u8>,
        min_case_reward_sui: u64,
        joined_at_ms: u64,
        updated_at_ms: u64,
        stake_locked: 0x2::balance::Balance<0x2::sui::SUI>,
        performance_score: u64,
        decisions_total: u64,
        decisions_majority: u64,
        decisions_overturned: u64,
        commit_reveal_failures: u64,
        noshow_count: u64,
    }

    struct OrderDisputeBond has key {
        id: 0x2::object::UID,
        order_id: 0x1::string::String,
        buyer: address,
        seller: address,
        buyer_bond_paid: bool,
        seller_bond_paid: bool,
        buyer_locked: 0x2::balance::Balance<0x2::sui::SUI>,
        seller_locked: 0x2::balance::Balance<0x2::sui::SUI>,
        required_reviewer_votes: u64,
        required_reviewer_votes_floor: u64,
        reviewer_accept_window_ms: u64,
        vote_commit_window_ms: u64,
        vote_reveal_window_ms: u64,
        vote_challenge_window_ms: u64,
        max_replacement_rounds: u64,
        case_hard_timeout_ms: u64,
        fallback_after_ms: u64,
        state: u8,
        has_active_case: bool,
    }

    struct OrderDisputeBondTyped<phantom T0> has key {
        id: 0x2::object::UID,
        order_id: 0x1::string::String,
        buyer: address,
        seller: address,
        buyer_bond_paid: bool,
        seller_bond_paid: bool,
        buyer_locked: 0x2::balance::Balance<T0>,
        seller_locked: 0x2::balance::Balance<T0>,
        required_reviewer_votes: u64,
        required_reviewer_votes_floor: u64,
        reviewer_accept_window_ms: u64,
        vote_commit_window_ms: u64,
        vote_reveal_window_ms: u64,
        vote_challenge_window_ms: u64,
        max_replacement_rounds: u64,
        case_hard_timeout_ms: u64,
        fallback_after_ms: u64,
        state: u8,
        has_active_case: bool,
    }

    struct MilestoneDisputeCase has key {
        id: 0x2::object::UID,
        order_id: 0x1::string::String,
        milestone_id: 0x1::string::String,
        escrow_id: address,
        buyer: address,
        seller: address,
        bond_object_id: address,
        accept_deadline_ms: u64,
        commit_deadline_ms: u64,
        reveal_deadline_ms: u64,
        challenge_deadline_ms: u64,
        hard_timeout_ms: u64,
        fallback_eligible_at_ms: u64,
        required_reviewer_votes: u64,
        required_reviewer_votes_floor: u64,
        assignment_round: u64,
        max_replacement_rounds: u64,
        timing_windows_ms: vector<u64>,
        assigned_reviewers: vector<address>,
        invited_reviewers: vector<address>,
        blocked_reviewers: vector<address>,
        committers: vector<address>,
        committed_hashes: vector<vector<u8>>,
        revealed_reviewers: vector<address>,
        revealed_votes: vector<u8>,
        votes_yes: u64,
        votes_no: u64,
        state: u8,
        resolved_path: u8,
        settlement_path: u8,
        closed_at_ms: u64,
    }

    struct ReviewerCaseCountKey has copy, drop, store {
        owner: address,
    }

    struct ReviewerRegisteredKey has copy, drop, store {
        owner: address,
    }

    struct ReviewerLastActivityKey has copy, drop, store {
        owner: address,
    }

    struct ReviewerForceDeregisteredKey has copy, drop, store {
        owner: address,
    }

    struct ReviewerPendingBlockedPenaltyCountKey has copy, drop, store {
        owner: address,
    }

    struct PendingReviewerOutcomeKey has copy, drop, store {
        owner: address,
    }

    struct MetricsClaimedKey has copy, drop, store {
        case_id: address,
        reviewer: address,
    }

    struct BlockedReviewerStatusKey has copy, drop, store {
        reviewer: address,
    }

    struct EscrowDisputeBindingKey has copy, drop, store {
        escrow_id: address,
    }

    struct PendingDisputeQuorumTimingUpdateKey has copy, drop, store {
        dummy_field: bool,
    }

    struct PendingDisputeQuorumEconomicsUpdateKey has copy, drop, store {
        dummy_field: bool,
    }

    struct PendingDisputeQuorumReviewerThresholdUpdateKey has copy, drop, store {
        dummy_field: bool,
    }

    struct DisputeBondAssetLaneKey has copy, drop, store {
        asset_type_bytes: vector<u8>,
    }

    struct EscrowDisputeBinding has drop, store {
        bond_object_id: address,
        dispute_case_id: address,
        settlement_path: u8,
        finalized: bool,
    }

    struct PendingReviewerSlash has copy, drop, store {
        bps: u64,
        sink: address,
    }

    struct PendingReviewerOutcome has drop, store {
        decisions_total: u64,
        decisions_majority: u64,
        decisions_overturned: u64,
        commit_reveal_failures: u64,
        noshow_count: u64,
        pending_slashes: vector<PendingReviewerSlash>,
    }

    struct PendingDisputeQuorumTimingUpdate has drop, store {
        default_reviewer_accept_window_ms: u64,
        default_vote_commit_window_ms: u64,
        default_vote_reveal_window_ms: u64,
        default_vote_challenge_window_ms: u64,
        default_max_replacement_rounds: u64,
        default_case_hard_timeout_ms: u64,
        fallback_after_ms: u64,
        effective_at_ms: u64,
        treasury_approved: bool,
    }

    struct PendingDisputeQuorumEconomicsUpdate has drop, store {
        min_dispute_bond_per_side_sui: u64,
        max_dispute_bond_per_side_sui: u64,
        target_reviewer_payout_bps: u64,
        target_platform_fallback_payout_bps: u64,
        reviewer_noshow_slash_bps: u64,
        reviewer_invalid_reveal_slash_bps: u64,
        reviewer_overturn_slash_bps: u64,
        reviewer_min_stake_sui: u64,
        max_active_cases_per_reviewer: u64,
        platform_fallback_sink: address,
        effective_at_ms: u64,
        treasury_approved: bool,
    }

    struct PendingDisputeQuorumReviewerThresholdUpdate has drop, store {
        min_reviewer_level: u8,
        min_reviewer_confidence: u64,
        min_reviewer_score: u64,
        effective_at_ms: u64,
        treasury_approved: bool,
    }

    struct DisputeBondAssetLaneConfig has drop, store {
        enabled: bool,
        require_order_currency_match: bool,
        invite_only_reviewers: bool,
        require_exact_min: bool,
        min_amount: u64,
        max_amount: u64,
    }

    struct DisputeQuorumConfigInitialized has copy, drop {
        config_id: address,
    }

    struct ReviewerRegistryInitialized has copy, drop {
        registry_id: address,
    }

    struct DisputeQuorumEconomicsUpdateQueued has copy, drop {
        config_id: address,
        actor: address,
        effective_at_ms: u64,
    }

    struct DisputeQuorumEconomicsUpdateApproved has copy, drop {
        config_id: address,
        actor: address,
    }

    struct DisputeQuorumEconomicsUpdateCanceled has copy, drop {
        config_id: address,
        actor: address,
        pending_effective_at_ms: u64,
    }

    struct DisputeQuorumEconomicsUpdated has copy, drop {
        config_id: address,
        actor: address,
        applied_at_ms: u64,
    }

    struct DisputeQuorumReviewerThresholdUpdateQueued has copy, drop {
        config_id: address,
        actor: address,
        effective_at_ms: u64,
    }

    struct DisputeQuorumReviewerThresholdUpdateApproved has copy, drop {
        config_id: address,
        actor: address,
    }

    struct DisputeQuorumReviewerThresholdUpdateCanceled has copy, drop {
        config_id: address,
        actor: address,
        pending_effective_at_ms: u64,
    }

    struct DisputeQuorumReviewerThresholdUpdated has copy, drop {
        config_id: address,
        actor: address,
        applied_at_ms: u64,
    }

    struct ReviewerBootstrapAllowlistChanged has copy, drop {
        registry_id: address,
        actor: address,
        approved_count: u64,
    }

    struct DisputeBondAssetLaneConfigChanged has copy, drop {
        config_id: address,
        actor: address,
        asset_type_bytes: vector<u8>,
        flags: u8,
        min_amount: u64,
        max_amount: u64,
    }

    struct DisputeQuorumTimingUpdateQueued has copy, drop {
        config_id: address,
        actor: address,
        effective_at_ms: u64,
    }

    struct DisputeQuorumTimingUpdateApproved has copy, drop {
        config_id: address,
        actor: address,
    }

    struct DisputeQuorumTimingUpdateCanceled has copy, drop {
        config_id: address,
        actor: address,
        pending_effective_at_ms: u64,
    }

    struct DisputeQuorumTimingUpdated has copy, drop {
        config_id: address,
        actor: address,
        applied_at_ms: u64,
    }

    struct ReviewerRegistered has copy, drop {
        reviewer_entry_id: address,
        owner: address,
        stake_locked: u64,
    }

    struct ReviewerUpdated has copy, drop {
        reviewer_entry_id: address,
        owner: address,
        active: bool,
    }

    struct ReviewerDeregistered has copy, drop {
        reviewer_entry_id: address,
        owner: address,
    }

    struct ReviewerForceDeregistered has copy, drop {
        owner: address,
    }

    struct OrderDisputeBondCreated has copy, drop {
        bond_id: address,
        order_id: 0x1::string::String,
        buyer: address,
        seller: address,
        required_reviewer_votes: u64,
        required_reviewer_votes_floor: u64,
    }

    struct OrderDisputeBondFunded has copy, drop {
        bond_id: address,
        funder: address,
        amount: u64,
        buyer_paid: bool,
        seller_paid: bool,
        state: u8,
    }

    struct OrderDisputeBondCanceled has copy, drop {
        bond_id: address,
        buyer_refund: u64,
        seller_refund: u64,
    }

    struct OrderDisputeBondReleased has copy, drop {
        bond_id: address,
        buyer_refund: u64,
        seller_refund: u64,
    }

    struct MilestoneDisputeOpened has copy, drop {
        dispute_case_id: address,
        bond_id: address,
        escrow_id: address,
        order_id: 0x1::string::String,
        milestone_id: 0x1::string::String,
    }

    struct ReviewerInvited has copy, drop {
        dispute_case_id: address,
        reviewer: address,
        assignment_round: u64,
    }

    struct ReplacementRoundStarted has copy, drop {
        dispute_case_id: address,
        assignment_round: u64,
        required_reviewer_votes: u64,
    }

    struct ReviewerAccepted has copy, drop {
        dispute_case_id: address,
        reviewer: address,
        accepted_count: u64,
    }

    struct ReviewVoteCommitted has copy, drop {
        dispute_case_id: address,
        reviewer: address,
    }

    struct ReviewVoteRevealed has copy, drop {
        dispute_case_id: address,
        reviewer: address,
        vote: u8,
    }

    struct DisputeQuorumResolved has copy, drop {
        dispute_case_id: address,
        bond_id: address,
        resolved_path: u8,
        settlement_path: u8,
        votes_yes: u64,
        votes_no: u64,
        winner_vote: u8,
        winner_count: u64,
        reviewer_payout_total: u64,
        closed_at_ms: u64,
    }

    struct DisputeFallbackResolved has copy, drop {
        dispute_case_id: address,
        bond_id: address,
        settlement_path: u8,
        platform_payout: u64,
        buyer_refund: u64,
        seller_refund: u64,
        closed_at_ms: u64,
    }

    fun accept_dispute_case_core(arg0: &mut MilestoneDisputeCase, arg1: &mut ReviewerRegistry, arg2: &mut ReviewerEntry, arg3: &DisputeQuorumConfig, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        apply_pending_reviewer_outcomes(arg1, arg2, arg5);
        assert!(arg0.state == 0, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_invalid_state());
        assert!(v1 <= arg0.accept_deadline_ms, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_invalid_state());
        assert!(v0 == arg2.owner, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_not_authorized());
        assert!(arg2.active, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_reviewer_not_active());
        assert!(reviewer_meets_stake_threshold(arg2, arg3), 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_insufficient_stake());
        assert!(v0 != arg0.buyer && v0 != arg0.seller, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_reviewer_not_eligible());
        assert!(!contains_address(&arg0.assigned_reviewers, v0), 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_already_assigned());
        assert!(!contains_address(&arg0.blocked_reviewers, v0), 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_reviewer_not_eligible());
        if (0x1::vector::length<address>(&arg0.invited_reviewers) > 0) {
            assert!(contains_address(&arg0.invited_reviewers, v0), 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_not_invited());
        } else if (0x1::vector::length<address>(&arg1.bootstrap_approved_reviewers) > 0) {
            assert!(contains_address(&arg1.bootstrap_approved_reviewers, v0), 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_reviewer_not_eligible());
        };
        increment_active_case_count(arg1, v0, arg3);
        0x1::vector::push_back<address>(&mut arg0.assigned_reviewers, v0);
        let v2 = 0x1::vector::length<address>(&arg0.assigned_reviewers);
        if (v2 >= arg0.required_reviewer_votes) {
            arg0.state = 1;
            arg0.commit_deadline_ms = v1 + timing_window(arg0, 1);
            arg0.reveal_deadline_ms = arg0.commit_deadline_ms + timing_window(arg0, 2);
            arg0.challenge_deadline_ms = 0;
        };
        arg2.updated_at_ms = v1;
        set_reviewer_last_activity(arg1, v0, v1);
        let v3 = ReviewerAccepted{
            dispute_case_id : case_id(arg0),
            reviewer        : v0,
            accepted_count  : v2,
        };
        0x2::event::emit<ReviewerAccepted>(v3);
    }

    public fun accept_dispute_case_with_reputation_cfg(arg0: &mut MilestoneDisputeCase, arg1: &mut ReviewerRegistry, arg2: &mut ReviewerEntry, arg3: &DisputeQuorumConfig, arg4: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::reputation::ReputationFeeConfig, arg5: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::reputation::ReputationProfile, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        assert!(0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::reputation::owner(arg5) == v0, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_not_authorized());
        assert!(shared_participant_state_passes_reviewer_thresholds(arg3, arg4, v0), 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_reviewer_not_eligible());
        accept_dispute_case_core(arg0, arg1, arg2, arg3, arg6, arg7);
    }

    fun add_revealed_reviewer_outcome(arg0: &mut PendingReviewerOutcome, arg1: &MilestoneDisputeCase, arg2: u8, arg3: &DisputeQuorumConfig) {
        arg0.decisions_total = 1;
        if (arg1.state == 3) {
            if (arg2 == winner_vote(arg1)) {
                arg0.decisions_majority = 1;
            } else {
                arg0.decisions_overturned = 1;
                push_pending_reviewer_slash(arg0, arg3.reviewer_overturn_slash_bps, arg3.platform_fallback_sink);
            };
        };
    }

    public fun apply_dispute_quorum_economics_update(arg0: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::AdminCap, arg1: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::GovernanceConfig, arg2: &mut DisputeQuorumConfig, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::assert_incident_not_frozen(arg1);
        assert!(0x2::dynamic_field::exists_<PendingDisputeQuorumEconomicsUpdateKey>(&arg2.id, economics_update_key()), 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_no_pending_economics_update());
        let v0 = 0x2::dynamic_field::borrow<PendingDisputeQuorumEconomicsUpdateKey, PendingDisputeQuorumEconomicsUpdate>(&arg2.id, economics_update_key());
        assert!(v0.treasury_approved, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_economics_update_not_approved());
        let v1 = 0x2::clock::timestamp_ms(arg3);
        assert!(v1 >= v0.effective_at_ms, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_economics_update_timelock_not_elapsed());
        let PendingDisputeQuorumEconomicsUpdate {
            min_dispute_bond_per_side_sui       : v2,
            max_dispute_bond_per_side_sui       : v3,
            target_reviewer_payout_bps          : v4,
            target_platform_fallback_payout_bps : v5,
            reviewer_noshow_slash_bps           : v6,
            reviewer_invalid_reveal_slash_bps   : v7,
            reviewer_overturn_slash_bps         : v8,
            reviewer_min_stake_sui              : v9,
            max_active_cases_per_reviewer       : v10,
            platform_fallback_sink              : v11,
            effective_at_ms                     : _,
            treasury_approved                   : _,
        } = 0x2::dynamic_field::remove<PendingDisputeQuorumEconomicsUpdateKey, PendingDisputeQuorumEconomicsUpdate>(&mut arg2.id, economics_update_key());
        arg2.min_dispute_bond_per_side_sui = v2;
        arg2.max_dispute_bond_per_side_sui = v3;
        arg2.target_reviewer_payout_bps = v4;
        arg2.target_platform_fallback_payout_bps = v5;
        arg2.reviewer_noshow_slash_bps = v6;
        arg2.reviewer_invalid_reveal_slash_bps = v7;
        arg2.reviewer_overturn_slash_bps = v8;
        arg2.reviewer_min_stake_sui = v9;
        arg2.max_active_cases_per_reviewer = v10;
        arg2.platform_fallback_sink = v11;
        let v14 = 0x2::object::id<DisputeQuorumConfig>(arg2);
        let v15 = DisputeQuorumEconomicsUpdated{
            config_id     : 0x2::object::id_to_address(&v14),
            actor         : 0x2::tx_context::sender(arg4),
            applied_at_ms : v1,
        };
        0x2::event::emit<DisputeQuorumEconomicsUpdated>(v15);
    }

    public fun apply_dispute_quorum_reviewer_threshold_update(arg0: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::AdminCap, arg1: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::GovernanceConfig, arg2: &mut DisputeQuorumConfig, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::assert_incident_not_frozen(arg1);
        let v0 = reviewer_threshold_update_key();
        assert!(0x2::dynamic_field::exists_<PendingDisputeQuorumReviewerThresholdUpdateKey>(&arg2.id, v0), 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_no_pending_reviewer_threshold_update());
        let v1 = 0x2::dynamic_field::borrow<PendingDisputeQuorumReviewerThresholdUpdateKey, PendingDisputeQuorumReviewerThresholdUpdate>(&arg2.id, v0);
        assert!(v1.treasury_approved, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_reviewer_threshold_update_not_approved());
        let v2 = 0x2::clock::timestamp_ms(arg3);
        assert!(v2 >= v1.effective_at_ms, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_reviewer_threshold_update_timelock_not_elapsed());
        let PendingDisputeQuorumReviewerThresholdUpdate {
            min_reviewer_level      : v3,
            min_reviewer_confidence : v4,
            min_reviewer_score      : v5,
            effective_at_ms         : _,
            treasury_approved       : _,
        } = 0x2::dynamic_field::remove<PendingDisputeQuorumReviewerThresholdUpdateKey, PendingDisputeQuorumReviewerThresholdUpdate>(&mut arg2.id, v0);
        arg2.min_reviewer_level = v3;
        arg2.min_reviewer_confidence = v4;
        arg2.min_reviewer_score = v5;
        let v8 = 0x2::object::id<DisputeQuorumConfig>(arg2);
        let v9 = DisputeQuorumReviewerThresholdUpdated{
            config_id     : 0x2::object::id_to_address(&v8),
            actor         : 0x2::tx_context::sender(arg4),
            applied_at_ms : v2,
        };
        0x2::event::emit<DisputeQuorumReviewerThresholdUpdated>(v9);
    }

    public fun apply_dispute_quorum_timing_update(arg0: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::AdminCap, arg1: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::GovernanceConfig, arg2: &mut DisputeQuorumConfig, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::assert_incident_not_frozen(arg1);
        let v0 = timing_update_key();
        assert!(0x2::dynamic_field::exists_<PendingDisputeQuorumTimingUpdateKey>(&arg2.id, v0), 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_no_pending_timing_update());
        let v1 = 0x2::dynamic_field::borrow<PendingDisputeQuorumTimingUpdateKey, PendingDisputeQuorumTimingUpdate>(&arg2.id, v0);
        assert!(v1.treasury_approved, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_timing_update_not_approved());
        let v2 = 0x2::clock::timestamp_ms(arg3);
        assert!(v2 >= v1.effective_at_ms, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_timing_update_timelock_not_elapsed());
        let PendingDisputeQuorumTimingUpdate {
            default_reviewer_accept_window_ms : v3,
            default_vote_commit_window_ms     : v4,
            default_vote_reveal_window_ms     : v5,
            default_vote_challenge_window_ms  : v6,
            default_max_replacement_rounds    : v7,
            default_case_hard_timeout_ms      : v8,
            fallback_after_ms                 : v9,
            effective_at_ms                   : _,
            treasury_approved                 : _,
        } = 0x2::dynamic_field::remove<PendingDisputeQuorumTimingUpdateKey, PendingDisputeQuorumTimingUpdate>(&mut arg2.id, v0);
        arg2.default_reviewer_accept_window_ms = v3;
        arg2.default_vote_commit_window_ms = v4;
        arg2.default_vote_reveal_window_ms = v5;
        arg2.default_vote_challenge_window_ms = v6;
        arg2.default_max_replacement_rounds = v7;
        arg2.default_case_hard_timeout_ms = v8;
        arg2.fallback_after_ms = v9;
        let v12 = 0x2::object::id<DisputeQuorumConfig>(arg2);
        let v13 = DisputeQuorumTimingUpdated{
            config_id     : 0x2::object::id_to_address(&v12),
            actor         : 0x2::tx_context::sender(arg4),
            applied_at_ms : v2,
        };
        0x2::event::emit<DisputeQuorumTimingUpdated>(v13);
    }

    fun apply_pending_reviewer_outcomes(arg0: &mut ReviewerRegistry, arg1: &mut ReviewerEntry, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = PendingReviewerOutcomeKey{owner: arg1.owner};
        if (!0x2::dynamic_field::exists_<PendingReviewerOutcomeKey>(&arg0.id, v0)) {
            return
        };
        let v1 = 0x2::dynamic_field::remove<PendingReviewerOutcomeKey, PendingReviewerOutcome>(&mut arg0.id, v0);
        arg1.decisions_total = arg1.decisions_total + v1.decisions_total;
        arg1.decisions_majority = arg1.decisions_majority + v1.decisions_majority;
        arg1.decisions_overturned = arg1.decisions_overturned + v1.decisions_overturned;
        arg1.commit_reveal_failures = arg1.commit_reveal_failures + v1.commit_reveal_failures;
        arg1.noshow_count = arg1.noshow_count + v1.noshow_count;
        while (0x1::vector::length<PendingReviewerSlash>(&v1.pending_slashes) > 0) {
            let v2 = 0x1::vector::pop_back<PendingReviewerSlash>(&mut v1.pending_slashes);
            apply_reviewer_slash(arg1, v2.bps, v2.sink, arg2);
        };
        arg1.performance_score = recompute_reviewer_performance_score(arg1);
    }

    fun apply_reviewer_slash(arg0: &mut ReviewerEntry, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = (((0x2::balance::value<0x2::sui::SUI>(&arg0.stake_locked) as u128) * (arg1 as u128) / (10000 as u128)) as u64);
        if (v0 == 0) {
            return 0
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.stake_locked, v0), arg3), arg2);
        v0
    }

    public fun approve_pending_dispute_quorum_economics_update(arg0: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::TreasuryCap, arg1: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::GovernanceConfig, arg2: &mut DisputeQuorumConfig, arg3: &mut 0x2::tx_context::TxContext) {
        0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::assert_incident_not_frozen(arg1);
        assert!(0x2::dynamic_field::exists_<PendingDisputeQuorumEconomicsUpdateKey>(&arg2.id, economics_update_key()), 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_no_pending_economics_update());
        0x2::dynamic_field::borrow_mut<PendingDisputeQuorumEconomicsUpdateKey, PendingDisputeQuorumEconomicsUpdate>(&mut arg2.id, economics_update_key()).treasury_approved = true;
        let v0 = 0x2::object::id<DisputeQuorumConfig>(arg2);
        let v1 = DisputeQuorumEconomicsUpdateApproved{
            config_id : 0x2::object::id_to_address(&v0),
            actor     : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<DisputeQuorumEconomicsUpdateApproved>(v1);
    }

    public fun approve_pending_dispute_quorum_reviewer_threshold_update(arg0: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::TreasuryCap, arg1: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::GovernanceConfig, arg2: &mut DisputeQuorumConfig, arg3: &mut 0x2::tx_context::TxContext) {
        0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::assert_incident_not_frozen(arg1);
        let v0 = reviewer_threshold_update_key();
        assert!(0x2::dynamic_field::exists_<PendingDisputeQuorumReviewerThresholdUpdateKey>(&arg2.id, v0), 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_no_pending_reviewer_threshold_update());
        0x2::dynamic_field::borrow_mut<PendingDisputeQuorumReviewerThresholdUpdateKey, PendingDisputeQuorumReviewerThresholdUpdate>(&mut arg2.id, v0).treasury_approved = true;
        let v1 = 0x2::object::id<DisputeQuorumConfig>(arg2);
        let v2 = DisputeQuorumReviewerThresholdUpdateApproved{
            config_id : 0x2::object::id_to_address(&v1),
            actor     : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<DisputeQuorumReviewerThresholdUpdateApproved>(v2);
    }

    public fun approve_pending_dispute_quorum_timing_update(arg0: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::TreasuryCap, arg1: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::GovernanceConfig, arg2: &mut DisputeQuorumConfig, arg3: &mut 0x2::tx_context::TxContext) {
        0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::assert_incident_not_frozen(arg1);
        let v0 = timing_update_key();
        assert!(0x2::dynamic_field::exists_<PendingDisputeQuorumTimingUpdateKey>(&arg2.id, v0), 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_no_pending_timing_update());
        0x2::dynamic_field::borrow_mut<PendingDisputeQuorumTimingUpdateKey, PendingDisputeQuorumTimingUpdate>(&mut arg2.id, v0).treasury_approved = true;
        let v1 = 0x2::object::id<DisputeQuorumConfig>(arg2);
        let v2 = DisputeQuorumTimingUpdateApproved{
            config_id : 0x2::object::id_to_address(&v1),
            actor     : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<DisputeQuorumTimingUpdateApproved>(v2);
    }

    fun assert_invited_reviewers_not_blocked(arg0: &MilestoneDisputeCase, arg1: &vector<address>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(arg1)) {
            assert!(!contains_address(&arg0.blocked_reviewers, *0x1::vector::borrow<address>(arg1, v0)), 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_reviewer_not_eligible());
            v0 = v0 + 1;
        };
    }

    public(friend) fun assert_no_escrow_dispute_binding(arg0: &DisputeQuorumConfig, arg1: address) {
        let v0 = EscrowDisputeBindingKey{escrow_id: arg1};
        assert!(!0x2::dynamic_field::exists_<EscrowDisputeBindingKey>(&arg0.id, v0), 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_invalid_state());
    }

    fun assert_non_empty_with_max(arg0: &0x1::string::String, arg1: u64) {
        let v0 = 0x1::string::length(arg0);
        assert!(v0 > 0 && v0 <= arg1, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_invalid_input());
    }

    fun assert_quorum_finalize_time_ready(arg0: &MilestoneDisputeCase, arg1: u64) {
        assert!(arg1 >= arg0.reveal_deadline_ms, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_not_finalizable());
        if (arg0.challenge_deadline_ms > 0) {
            assert!(arg1 >= arg0.challenge_deadline_ms, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_challenge_window_closed());
        };
    }

    fun assert_transport_pubkey(arg0: &vector<u8>) {
        let v0 = 0x1::vector::length<u8>(arg0);
        assert!(v0 >= 16 && v0 <= 256, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_invalid_input());
    }

    fun assert_typed_dispute_bond_lane_amount<T0>(arg0: &DisputeQuorumConfig, arg1: u64) {
        let v0 = borrow_dispute_bond_asset_lane_config<T0>(arg0);
        assert!(v0.enabled, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_invalid_policy());
        assert!(arg1 >= v0.min_amount && arg1 <= v0.max_amount, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_invalid_policy());
        if (v0.require_exact_min) {
            assert!(arg1 == v0.min_amount, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_invalid_policy());
        };
    }

    fun assert_unique_reviewer_list(arg0: &vector<address>, arg1: address, arg2: address) {
        let v0 = 0x1::vector::length<address>(arg0);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = *0x1::vector::borrow<address>(arg0, v1);
            assert!(v2 != @0x0, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_invalid_input());
            assert!(v2 != arg1 && v2 != arg2, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_invalid_input());
            let v3 = v1 + 1;
            while (v3 < v0) {
                assert!(*0x1::vector::borrow<address>(arg0, v3) != v2, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_invalid_input());
                v3 = v3 + 1;
            };
            v1 = v1 + 1;
        };
    }

    fun assert_valid_economics(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: address) {
        assert!(arg0 >= 10000000, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_invalid_policy());
        assert!(arg0 <= arg1, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_invalid_policy());
        assert!(arg2 <= 10000, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_invalid_policy());
        assert!(arg3 <= 10000, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_invalid_policy());
        assert!(arg2 + arg3 <= 10000, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_invalid_policy());
        assert!(arg4 <= 10000, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_invalid_policy());
        assert!(arg5 <= 10000, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_invalid_policy());
        assert!(arg6 <= 10000, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_invalid_policy());
        assert!(arg7 >= 100000000, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_invalid_policy());
        assert!(arg8 > 0, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_invalid_policy());
        assert!(arg9 != @0x0, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_invalid_config());
    }

    fun assert_valid_funding_policy(arg0: u8) {
        assert!(arg0 == 0, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_invalid_policy());
    }

    fun assert_valid_required_votes(arg0: u64, arg1: u64, arg2: &DisputeQuorumConfig) {
        assert!(arg0 >= arg2.min_required_reviewer_votes, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_vote_below_min());
        assert!(arg0 <= arg2.max_required_reviewer_votes, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_vote_above_max());
        assert!(arg0 % 2 == 1, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_vote_not_odd());
        assert!(arg1 > 0 && arg1 <= arg0, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_vote_floor_invalid());
        assert!(arg1 >= arg2.min_required_reviewer_votes, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_vote_floor_invalid());
        assert!(arg1 % 2 == 1, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_vote_not_odd());
    }

    fun assert_valid_reviewer_threshold_fields(arg0: u8, arg1: u64, arg2: u64) {
        assert!(arg0 <= 4, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_invalid_config());
        assert!(arg1 <= 100, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_invalid_config());
        assert!(arg2 <= 100, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_invalid_config());
    }

    fun assert_valid_settlement_path(arg0: u8) {
        let v0 = if (arg0 == 0) {
            true
        } else if (arg0 == 1) {
            true
        } else {
            arg0 == 2
        };
        assert!(v0, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_ticket_invalid_path());
    }

    fun assert_valid_timing(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        assert!(arg0 > 0, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_invalid_config());
        assert!(arg1 > 0, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_invalid_config());
        assert!(arg2 > 0, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_invalid_config());
        assert!(arg3 > 0, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_invalid_config());
        assert!(arg4 > 0, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_invalid_config());
        assert!(arg5 > 0, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_invalid_config());
        assert!(arg6 > 0, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_invalid_config());
        let v0 = (arg0 as u128) + (arg1 as u128) + (arg2 as u128);
        assert!((arg5 as u128) >= v0, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_invalid_config());
        assert!((arg5 as u128) + (arg6 as u128) >= v0 + (arg3 as u128), 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_invalid_config());
    }

    fun assert_valid_vote(arg0: u8) {
        assert!(arg0 == 0 || arg0 == 1, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_invalid_input());
    }

    fun blocked_reviewer_status_for(arg0: &MilestoneDisputeCase, arg1: address) : (bool, bool, u8) {
        if (!contains_address(&arg0.blocked_reviewers, arg1)) {
            return (false, false, 0)
        };
        let v0 = BlockedReviewerStatusKey{reviewer: arg1};
        if (0x2::dynamic_field::exists_<BlockedReviewerStatusKey>(&arg0.id, v0)) {
            (true, true, *0x2::dynamic_field::borrow<BlockedReviewerStatusKey, u8>(&arg0.id, v0))
        } else {
            (true, false, 0)
        }
    }

    fun blocked_reviewer_status_from_current_round(arg0: &MilestoneDisputeCase, arg1: address, arg2: bool) : u8 {
        if (arg2) {
            return 0
        };
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg0.revealed_reviewers)) {
            if (*0x1::vector::borrow<address>(&arg0.revealed_reviewers, v0) == arg1) {
                return if (*0x1::vector::borrow<u8>(&arg0.revealed_votes, v0) == 1) {
                    4
                } else {
                    3
                }
            };
            v0 = v0 + 1;
        };
        if (contains_address(&arg0.committers, arg1)) {
            2
        } else {
            1
        }
    }

    fun blocked_status_requires_finalized_penalty_tracking(arg0: u8) : bool {
        arg0 == 2 || arg0 == 1
    }

    public(friend) fun bond_buyer(arg0: &OrderDisputeBond) : address {
        arg0.buyer
    }

    fun bond_id(arg0: &OrderDisputeBond) : address {
        let v0 = 0x2::object::id<OrderDisputeBond>(arg0);
        0x2::object::id_to_address(&v0)
    }

    public(friend) fun bond_order_id(arg0: &OrderDisputeBond) : 0x1::string::String {
        arg0.order_id
    }

    public(friend) fun bond_seller(arg0: &OrderDisputeBond) : address {
        arg0.seller
    }

    fun borrow_dispute_bond_asset_lane_config<T0>(arg0: &DisputeQuorumConfig) : &DisputeBondAssetLaneConfig {
        0x2::dynamic_field::borrow<DisputeBondAssetLaneKey, DisputeBondAssetLaneConfig>(&arg0.id, dispute_bond_asset_lane_key<T0>())
    }

    public fun cancel_pending_dispute_quorum_economics_update(arg0: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::AdminCap, arg1: &mut DisputeQuorumConfig, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::dynamic_field::exists_<PendingDisputeQuorumEconomicsUpdateKey>(&arg1.id, economics_update_key()), 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_no_pending_economics_update());
        let PendingDisputeQuorumEconomicsUpdate {
            min_dispute_bond_per_side_sui       : _,
            max_dispute_bond_per_side_sui       : _,
            target_reviewer_payout_bps          : _,
            target_platform_fallback_payout_bps : _,
            reviewer_noshow_slash_bps           : _,
            reviewer_invalid_reveal_slash_bps   : _,
            reviewer_overturn_slash_bps         : _,
            reviewer_min_stake_sui              : _,
            max_active_cases_per_reviewer       : _,
            platform_fallback_sink              : _,
            effective_at_ms                     : v10,
            treasury_approved                   : _,
        } = 0x2::dynamic_field::remove<PendingDisputeQuorumEconomicsUpdateKey, PendingDisputeQuorumEconomicsUpdate>(&mut arg1.id, economics_update_key());
        let v12 = 0x2::object::id<DisputeQuorumConfig>(arg1);
        let v13 = DisputeQuorumEconomicsUpdateCanceled{
            config_id               : 0x2::object::id_to_address(&v12),
            actor                   : 0x2::tx_context::sender(arg2),
            pending_effective_at_ms : v10,
        };
        0x2::event::emit<DisputeQuorumEconomicsUpdateCanceled>(v13);
    }

    public fun cancel_pending_dispute_quorum_reviewer_threshold_update(arg0: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::AdminCap, arg1: &mut DisputeQuorumConfig, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = reviewer_threshold_update_key();
        assert!(0x2::dynamic_field::exists_<PendingDisputeQuorumReviewerThresholdUpdateKey>(&arg1.id, v0), 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_no_pending_reviewer_threshold_update());
        let PendingDisputeQuorumReviewerThresholdUpdate {
            min_reviewer_level      : _,
            min_reviewer_confidence : _,
            min_reviewer_score      : _,
            effective_at_ms         : v4,
            treasury_approved       : _,
        } = 0x2::dynamic_field::remove<PendingDisputeQuorumReviewerThresholdUpdateKey, PendingDisputeQuorumReviewerThresholdUpdate>(&mut arg1.id, v0);
        let v6 = 0x2::object::id<DisputeQuorumConfig>(arg1);
        let v7 = DisputeQuorumReviewerThresholdUpdateCanceled{
            config_id               : 0x2::object::id_to_address(&v6),
            actor                   : 0x2::tx_context::sender(arg2),
            pending_effective_at_ms : v4,
        };
        0x2::event::emit<DisputeQuorumReviewerThresholdUpdateCanceled>(v7);
    }

    public fun cancel_pending_dispute_quorum_timing_update(arg0: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::AdminCap, arg1: &mut DisputeQuorumConfig, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = timing_update_key();
        assert!(0x2::dynamic_field::exists_<PendingDisputeQuorumTimingUpdateKey>(&arg1.id, v0), 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_no_pending_timing_update());
        let PendingDisputeQuorumTimingUpdate {
            default_reviewer_accept_window_ms : _,
            default_vote_commit_window_ms     : _,
            default_vote_reveal_window_ms     : _,
            default_vote_challenge_window_ms  : _,
            default_max_replacement_rounds    : _,
            default_case_hard_timeout_ms      : _,
            fallback_after_ms                 : _,
            effective_at_ms                   : v8,
            treasury_approved                 : _,
        } = 0x2::dynamic_field::remove<PendingDisputeQuorumTimingUpdateKey, PendingDisputeQuorumTimingUpdate>(&mut arg1.id, v0);
        let v10 = 0x2::object::id<DisputeQuorumConfig>(arg1);
        let v11 = DisputeQuorumTimingUpdateCanceled{
            config_id               : 0x2::object::id_to_address(&v10),
            actor                   : 0x2::tx_context::sender(arg2),
            pending_effective_at_ms : v8,
        };
        0x2::event::emit<DisputeQuorumTimingUpdateCanceled>(v11);
    }

    public fun cancel_pending_order_dispute_bond(arg0: &mut OrderDisputeBond, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == arg0.buyer || v0 == arg0.seller, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_not_authorized());
        assert!(arg0.state == 0, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_invalid_state());
        assert!(!arg0.has_active_case, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_invalid_state());
        let v1 = &mut arg0.buyer_locked;
        let v2 = transfer_balance_to(v1, arg0.buyer, arg1);
        let v3 = &mut arg0.seller_locked;
        arg0.state = 3;
        let v4 = OrderDisputeBondCanceled{
            bond_id       : bond_id(arg0),
            buyer_refund  : v2,
            seller_refund : transfer_balance_to(v3, arg0.seller, arg1),
        };
        0x2::event::emit<OrderDisputeBondCanceled>(v4);
    }

    public fun cancel_pending_order_dispute_typed_bond<T0>(arg0: &mut OrderDisputeBondTyped<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == arg0.buyer || v0 == arg0.seller, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_not_authorized());
        assert!(arg0.state == 0, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_invalid_state());
        assert!(!arg0.has_active_case, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_invalid_state());
        let v1 = &mut arg0.buyer_locked;
        let v2 = transfer_typed_balance_to<T0>(v1, arg0.buyer, arg1);
        let v3 = &mut arg0.seller_locked;
        arg0.state = 3;
        let v4 = OrderDisputeBondCanceled{
            bond_id       : typed_bond_id<T0>(arg0),
            buyer_refund  : v2,
            seller_refund : transfer_typed_balance_to<T0>(v3, arg0.seller, arg1),
        };
        0x2::event::emit<OrderDisputeBondCanceled>(v4);
    }

    fun case_id(arg0: &MilestoneDisputeCase) : address {
        let v0 = 0x2::object::id<MilestoneDisputeCase>(arg0);
        0x2::object::id_to_address(&v0)
    }

    public fun claim_decision_metrics(arg0: &mut MilestoneDisputeCase, arg1: &mut ReviewerRegistry, arg2: &mut ReviewerEntry, arg3: &DisputeQuorumConfig, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg2.owner, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_not_authorized());
        assert!(arg0.state == 3 || arg0.state == 4, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_invalid_state());
        let v0 = MetricsClaimedKey{
            case_id  : case_id(arg0),
            reviewer : arg2.owner,
        };
        assert!(0x2::dynamic_field::exists_<MetricsClaimedKey>(&arg0.id, v0) || record_case_outcome_for_reviewer_if_needed(arg0, arg1, arg2.owner, arg3), 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_not_authorized());
        apply_pending_reviewer_outcomes(arg1, arg2, arg4);
    }

    public fun claim_force_deregistered_reviewer_stake(arg0: &mut ReviewerRegistry, arg1: ReviewerEntry, arg2: &DisputeQuorumConfig, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == arg1.owner, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_not_authorized());
        let v1 = &mut arg1;
        apply_pending_reviewer_outcomes(arg0, v1, arg3);
        let v2 = ReviewerForceDeregisteredKey{owner: v0};
        assert!(0x2::dynamic_field::exists_<ReviewerForceDeregisteredKey>(&arg0.id, v2), 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_invalid_state());
        let v3 = ReviewerCaseCountKey{owner: v0};
        assert!(!0x2::dynamic_field::exists_<ReviewerCaseCountKey>(&arg0.id, v3), 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_invalid_state());
        assert!(pending_blocked_penalty_count(arg0, v0) == 0, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_invalid_state());
        0x2::dynamic_field::remove<ReviewerForceDeregisteredKey, bool>(&mut arg0.id, v2);
        remove_reviewer_last_activity_if_present(arg0, v0);
        let ReviewerEntry {
            id                     : v4,
            owner                  : v5,
            active                 : _,
            transport_type         : _,
            transport_pubkey       : _,
            min_case_reward_sui    : _,
            joined_at_ms           : _,
            updated_at_ms          : _,
            stake_locked           : v12,
            performance_score      : _,
            decisions_total        : _,
            decisions_majority     : _,
            decisions_overturned   : _,
            commit_reveal_failures : _,
            noshow_count           : _,
        } = arg1;
        0x2::object::delete(v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v12, arg3), v5);
        let v19 = ReviewerDeregistered{
            reviewer_entry_id : reviewer_id(&arg1),
            owner             : v5,
        };
        0x2::event::emit<ReviewerDeregistered>(v19);
    }

    fun clear_address_vec(arg0: &mut vector<address>) {
        while (0x1::vector::length<address>(arg0) > 0) {
            0x1::vector::pop_back<address>(arg0);
        };
    }

    fun clear_hash_vec(arg0: &mut vector<vector<u8>>) {
        while (0x1::vector::length<vector<u8>>(arg0) > 0) {
            0x1::vector::pop_back<vector<u8>>(arg0);
        };
    }

    fun clear_u8_vec(arg0: &mut vector<u8>) {
        while (0x1::vector::length<u8>(arg0) > 0) {
            0x1::vector::pop_back<u8>(arg0);
        };
    }

    public fun commit_vote(arg0: &mut MilestoneDisputeCase, arg1: &ReviewerEntry, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(arg0.state == 1, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_invalid_state());
        assert!(v0 == arg1.owner, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_not_authorized());
        assert!(contains_address(&arg0.assigned_reviewers, v0), 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_not_assigned());
        assert!(0x2::clock::timestamp_ms(arg3) <= arg0.commit_deadline_ms, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_commit_window_closed());
        assert!(0x1::vector::length<u8>(&arg2) == 32, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_invalid_input());
        assert!(!contains_address(&arg0.committers, v0), 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_already_committed());
        0x1::vector::push_back<address>(&mut arg0.committers, v0);
        0x1::vector::push_back<vector<u8>>(&mut arg0.committed_hashes, arg2);
        let v1 = ReviewVoteCommitted{
            dispute_case_id : case_id(arg0),
            reviewer        : v0,
        };
        0x2::event::emit<ReviewVoteCommitted>(v1);
    }

    fun complete_fallback_case(arg0: &mut MilestoneDisputeCase, arg1: &mut ReviewerRegistry, arg2: &mut DisputeQuorumConfig, arg3: address, arg4: u64, arg5: u64, arg6: u64, arg7: u64) {
        arg0.state = 4;
        arg0.resolved_path = 2;
        arg0.settlement_path = 2;
        arg0.closed_at_ms = arg7;
        finalize_escrow_dispute_binding(arg2, arg0.escrow_id, arg3, case_id(arg0), 2);
        record_all_case_reviewer_outcomes(arg0, arg1, arg2);
        release_case_activity_counts(arg1, arg0);
        let v0 = DisputeFallbackResolved{
            dispute_case_id : case_id(arg0),
            bond_id         : arg3,
            settlement_path : 2,
            platform_payout : arg4,
            buyer_refund    : arg5,
            seller_refund   : arg6,
            closed_at_ms    : arg7,
        };
        0x2::event::emit<DisputeFallbackResolved>(v0);
    }

    fun complete_quorum_case(arg0: &mut MilestoneDisputeCase, arg1: &mut ReviewerRegistry, arg2: &mut DisputeQuorumConfig, arg3: address, arg4: u8, arg5: u8, arg6: u8, arg7: u64, arg8: u64, arg9: u64) {
        arg0.state = 3;
        arg0.resolved_path = arg4;
        arg0.settlement_path = arg5;
        arg0.closed_at_ms = arg9;
        finalize_escrow_dispute_binding(arg2, arg0.escrow_id, arg3, case_id(arg0), arg5);
        record_all_case_reviewer_outcomes(arg0, arg1, arg2);
        release_case_activity_counts(arg1, arg0);
        let v0 = DisputeQuorumResolved{
            dispute_case_id       : case_id(arg0),
            bond_id               : arg3,
            resolved_path         : arg4,
            settlement_path       : arg5,
            votes_yes             : arg0.votes_yes,
            votes_no              : arg0.votes_no,
            winner_vote           : arg6,
            winner_count          : arg7,
            reviewer_payout_total : arg8,
            closed_at_ms          : arg9,
        };
        0x2::event::emit<DisputeQuorumResolved>(v0);
    }

    fun contains_address(arg0: &vector<address>, arg1: address) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(arg0)) {
            if (*0x1::vector::borrow<address>(arg0, v0) == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    fun count_winning_reviewers(arg0: &MilestoneDisputeCase, arg1: u8) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v0 < 0x1::vector::length<u8>(&arg0.revealed_votes)) {
            if (*0x1::vector::borrow<u8>(&arg0.revealed_votes, v0) == arg1) {
                v1 = v1 + 1;
            };
            v0 = v0 + 1;
        };
        v1
    }

    fun decrement_active_case_count_if_present(arg0: &mut ReviewerRegistry, arg1: address) {
        let v0 = ReviewerCaseCountKey{owner: arg1};
        if (0x2::dynamic_field::exists_<ReviewerCaseCountKey>(&arg0.id, v0)) {
            let v1 = 0x2::dynamic_field::borrow_mut<ReviewerCaseCountKey, u64>(&mut arg0.id, v0);
            if (*v1 > 0) {
                *v1 = *v1 - 1;
            };
        };
    }

    fun decrement_pending_blocked_penalty_count_if_present(arg0: &mut ReviewerRegistry, arg1: address) {
        let v0 = ReviewerPendingBlockedPenaltyCountKey{owner: arg1};
        if (!0x2::dynamic_field::exists_<ReviewerPendingBlockedPenaltyCountKey>(&arg0.id, v0)) {
            return
        };
        if (*0x2::dynamic_field::borrow<ReviewerPendingBlockedPenaltyCountKey, u64>(&arg0.id, v0) <= 1) {
            0x2::dynamic_field::remove<ReviewerPendingBlockedPenaltyCountKey, u64>(&mut arg0.id, v0);
        } else {
            let v1 = 0x2::dynamic_field::borrow_mut<ReviewerPendingBlockedPenaltyCountKey, u64>(&mut arg0.id, v0);
            *v1 = *v1 - 1;
        };
    }

    public fun deregister_reviewer(arg0: &mut ReviewerRegistry, arg1: ReviewerEntry, arg2: &DisputeQuorumConfig, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == arg1.owner, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_not_authorized());
        let v1 = &mut arg1;
        apply_pending_reviewer_outcomes(arg0, v1, arg3);
        assert!(!arg1.active, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_invalid_state());
        let v2 = ReviewerCaseCountKey{owner: v0};
        assert!(0x2::dynamic_field::exists_<ReviewerCaseCountKey>(&arg0.id, v2), 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_reviewer_not_eligible());
        assert!(*0x2::dynamic_field::borrow<ReviewerCaseCountKey, u64>(&arg0.id, v2) == 0, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_invalid_state());
        assert!(pending_blocked_penalty_count(arg0, v0) == 0, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_invalid_state());
        let v3 = ReviewerRegisteredKey{owner: v0};
        if (0x2::dynamic_field::exists_<ReviewerRegisteredKey>(&arg0.id, v3)) {
            0x2::dynamic_field::remove<ReviewerRegisteredKey, bool>(&mut arg0.id, v3);
        };
        0x2::dynamic_field::remove<ReviewerCaseCountKey, u64>(&mut arg0.id, v2);
        remove_reviewer_last_activity_if_present(arg0, v0);
        let v4 = ReviewerForceDeregisteredKey{owner: v0};
        if (0x2::dynamic_field::exists_<ReviewerForceDeregisteredKey>(&arg0.id, v4)) {
            0x2::dynamic_field::remove<ReviewerForceDeregisteredKey, bool>(&mut arg0.id, v4);
        };
        arg0.reviewer_count = arg0.reviewer_count - 1;
        let ReviewerEntry {
            id                     : v5,
            owner                  : v6,
            active                 : _,
            transport_type         : _,
            transport_pubkey       : _,
            min_case_reward_sui    : _,
            joined_at_ms           : _,
            updated_at_ms          : _,
            stake_locked           : v13,
            performance_score      : _,
            decisions_total        : _,
            decisions_majority     : _,
            decisions_overturned   : _,
            commit_reveal_failures : _,
            noshow_count           : _,
        } = arg1;
        0x2::object::delete(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v13, arg3), v6);
        let v20 = ReviewerDeregistered{
            reviewer_entry_id : reviewer_id(&arg1),
            owner             : v6,
        };
        0x2::event::emit<ReviewerDeregistered>(v20);
    }

    fun dispute_bond_asset_lane_flags(arg0: &DisputeBondAssetLaneConfig) : u8 {
        let v0 = 0;
        let v1 = v0;
        if (arg0.enabled) {
            v1 = v0 + 1;
        };
        if (arg0.require_order_currency_match) {
            v1 = v1 + 2;
        };
        if (arg0.invite_only_reviewers) {
            v1 = v1 + 4;
        };
        if (arg0.require_exact_min) {
            v1 = v1 + 8;
        };
        v1
    }

    fun dispute_bond_asset_lane_key<T0>() : DisputeBondAssetLaneKey {
        DisputeBondAssetLaneKey{asset_type_bytes: 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::onchain_asset_lane_manager::exact_type_bytes_for<T0>()}
    }

    fun distribute_fallback_pool(arg0: &mut OrderDisputeBond, arg1: &DisputeQuorumConfig, arg2: &mut 0x2::tx_context::TxContext) : (u64, u64, u64) {
        let v0 = drain_bond_pool(arg0);
        let v1 = (((0x2::balance::value<0x2::sui::SUI>(&v0) as u128) * (arg1.target_platform_fallback_payout_bps as u128) / (10000 as u128)) as u64);
        let v2 = &mut v0;
        transfer_from_pool<0x2::sui::SUI>(v2, v1, arg1.platform_fallback_sink, arg2);
        let v3 = 0x2::balance::value<0x2::sui::SUI>(&v0);
        let v4 = v3 / 2;
        let v5 = v3 - v4;
        let v6 = &mut v0;
        transfer_from_pool<0x2::sui::SUI>(v6, v4, arg0.buyer, arg2);
        let v7 = &mut v0;
        transfer_from_pool<0x2::sui::SUI>(v7, v5, arg0.seller, arg2);
        0x2::balance::destroy_zero<0x2::sui::SUI>(v0);
        (v1, v4, v5)
    }

    fun distribute_quorum_pool(arg0: &MilestoneDisputeCase, arg1: &mut OrderDisputeBond, arg2: &DisputeQuorumConfig, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        let v0 = drain_bond_pool(arg1);
        let v1 = (((0x2::balance::value<0x2::sui::SUI>(&v0) as u128) * (arg2.target_reviewer_payout_bps as u128) / (10000 as u128)) as u64);
        let v2 = count_winning_reviewers(arg0, arg3);
        let v3 = 0;
        if (v2 > 0 && v1 > 0) {
            let v4 = 0;
            while (v4 < 0x1::vector::length<address>(&arg0.revealed_reviewers)) {
                if (*0x1::vector::borrow<u8>(&arg0.revealed_votes, v4) == arg3) {
                    let v5 = &mut v0;
                    let v6 = transfer_from_pool<0x2::sui::SUI>(v5, v1 / v2, *0x1::vector::borrow<address>(&arg0.revealed_reviewers, v4), arg4);
                    v3 = v3 + v6;
                };
                v4 = v4 + 1;
            };
        };
        let v7 = 0x2::balance::value<0x2::sui::SUI>(&v0);
        let v8 = v7 / 2;
        let v9 = &mut v0;
        transfer_from_pool<0x2::sui::SUI>(v9, v8, arg1.buyer, arg4);
        let v10 = &mut v0;
        transfer_from_pool<0x2::sui::SUI>(v10, v7 - v8, arg1.seller, arg4);
        0x2::balance::destroy_zero<0x2::sui::SUI>(v0);
        (v3, v2)
    }

    fun distribute_typed_fallback_pool<T0>(arg0: &mut OrderDisputeBondTyped<T0>, arg1: &DisputeQuorumConfig, arg2: &mut 0x2::tx_context::TxContext) : (u64, u64, u64) {
        let v0 = drain_typed_bond_pool<T0>(arg0);
        let v1 = (((0x2::balance::value<T0>(&v0) as u128) * (arg1.target_platform_fallback_payout_bps as u128) / (10000 as u128)) as u64);
        let v2 = &mut v0;
        transfer_from_pool<T0>(v2, v1, arg1.platform_fallback_sink, arg2);
        let v3 = 0x2::balance::value<T0>(&v0);
        let v4 = v3 / 2;
        let v5 = v3 - v4;
        let v6 = &mut v0;
        transfer_from_pool<T0>(v6, v4, arg0.buyer, arg2);
        let v7 = &mut v0;
        transfer_from_pool<T0>(v7, v5, arg0.seller, arg2);
        0x2::balance::destroy_zero<T0>(v0);
        (v1, v4, v5)
    }

    fun distribute_typed_quorum_pool<T0>(arg0: &MilestoneDisputeCase, arg1: &mut OrderDisputeBondTyped<T0>, arg2: &DisputeQuorumConfig, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        let v0 = drain_typed_bond_pool<T0>(arg1);
        let v1 = (((0x2::balance::value<T0>(&v0) as u128) * (arg2.target_reviewer_payout_bps as u128) / (10000 as u128)) as u64);
        let v2 = count_winning_reviewers(arg0, arg3);
        let v3 = 0;
        if (v2 > 0 && v1 > 0) {
            let v4 = 0;
            while (v4 < 0x1::vector::length<address>(&arg0.revealed_reviewers)) {
                if (*0x1::vector::borrow<u8>(&arg0.revealed_votes, v4) == arg3) {
                    let v5 = &mut v0;
                    let v6 = transfer_from_pool<T0>(v5, v1 / v2, *0x1::vector::borrow<address>(&arg0.revealed_reviewers, v4), arg4);
                    v3 = v3 + v6;
                };
                v4 = v4 + 1;
            };
        };
        let v7 = 0x2::balance::value<T0>(&v0);
        let v8 = v7 / 2;
        let v9 = &mut v0;
        transfer_from_pool<T0>(v9, v8, arg1.buyer, arg4);
        let v10 = &mut v0;
        transfer_from_pool<T0>(v10, v7 - v8, arg1.seller, arg4);
        0x2::balance::destroy_zero<T0>(v0);
        (v3, v2)
    }

    fun drain_bond_pool(arg0: &mut OrderDisputeBond) : 0x2::balance::Balance<0x2::sui::SUI> {
        let v0 = 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.buyer_locked);
        0x2::balance::join<0x2::sui::SUI>(&mut v0, 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.seller_locked));
        v0
    }

    fun drain_typed_bond_pool<T0>(arg0: &mut OrderDisputeBondTyped<T0>) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::balance::withdraw_all<T0>(&mut arg0.buyer_locked);
        0x2::balance::join<T0>(&mut v0, 0x2::balance::withdraw_all<T0>(&mut arg0.seller_locked));
        v0
    }

    fun economics_update_key() : PendingDisputeQuorumEconomicsUpdateKey {
        PendingDisputeQuorumEconomicsUpdateKey{dummy_field: false}
    }

    fun emit_reviewer_invites(arg0: &MilestoneDisputeCase) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg0.invited_reviewers)) {
            let v1 = ReviewerInvited{
                dispute_case_id  : case_id(arg0),
                reviewer         : *0x1::vector::borrow<address>(&arg0.invited_reviewers, v0),
                assignment_round : arg0.assignment_round,
            };
            0x2::event::emit<ReviewerInvited>(v1);
            v0 = v0 + 1;
        };
    }

    fun empty_pending_reviewer_outcome() : PendingReviewerOutcome {
        PendingReviewerOutcome{
            decisions_total        : 0,
            decisions_majority     : 0,
            decisions_overturned   : 0,
            commit_reveal_failures : 0,
            noshow_count           : 0,
            pending_slashes        : 0x1::vector::empty<PendingReviewerSlash>(),
        }
    }

    fun ensure_pending_reviewer_outcome(arg0: &mut ReviewerRegistry, arg1: address) : &mut PendingReviewerOutcome {
        let v0 = PendingReviewerOutcomeKey{owner: arg1};
        if (!0x2::dynamic_field::exists_<PendingReviewerOutcomeKey>(&arg0.id, v0)) {
            let v1 = PendingReviewerOutcomeKey{owner: arg1};
            0x2::dynamic_field::add<PendingReviewerOutcomeKey, PendingReviewerOutcome>(&mut arg0.id, v1, empty_pending_reviewer_outcome());
        };
        let v2 = PendingReviewerOutcomeKey{owner: arg1};
        0x2::dynamic_field::borrow_mut<PendingReviewerOutcomeKey, PendingReviewerOutcome>(&mut arg0.id, v2)
    }

    public fun finalize_case_with_quorum(arg0: &mut MilestoneDisputeCase, arg1: &mut OrderDisputeBond, arg2: &mut ReviewerRegistry, arg3: &mut DisputeQuorumConfig, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.state == 2, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_invalid_state());
        assert!(arg0.votes_yes + arg0.votes_no >= arg0.required_reviewer_votes_floor, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_not_finalizable());
        assert!(has_majority(arg0), 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_not_finalizable());
        assert!(arg0.votes_yes != arg0.votes_no, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_not_finalizable());
        assert!(bond_id(arg1) == arg0.bond_object_id, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_ticket_mismatch());
        assert!(arg1.state == 1 && arg1.has_active_case, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_invalid_state());
        let (v0, v1, v2) = if (arg0.votes_yes > arg0.votes_no) {
            (1, 0, 0)
        } else {
            (0, 1, 1)
        };
        let v3 = 0x2::clock::timestamp_ms(arg4);
        assert_quorum_finalize_time_ready(arg0, v3);
        let v4 = bond_id(arg1);
        let (v5, v6) = distribute_quorum_pool(arg0, arg1, arg3, v0, arg5);
        arg1.state = 2;
        arg1.has_active_case = false;
        complete_quorum_case(arg0, arg2, arg3, v4, v1, v2, v0, v6, v5, v3);
    }

    public fun finalize_case_with_typed_quorum<T0>(arg0: &mut MilestoneDisputeCase, arg1: &mut OrderDisputeBondTyped<T0>, arg2: &mut ReviewerRegistry, arg3: &mut DisputeQuorumConfig, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.state == 2, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_invalid_state());
        assert!(arg0.votes_yes + arg0.votes_no >= arg0.required_reviewer_votes_floor, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_not_finalizable());
        assert!(has_majority(arg0), 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_not_finalizable());
        assert!(arg0.votes_yes != arg0.votes_no, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_not_finalizable());
        assert!(typed_bond_id<T0>(arg1) == arg0.bond_object_id, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_ticket_mismatch());
        assert!(arg1.state == 1 && arg1.has_active_case, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_invalid_state());
        let (v0, v1, v2) = if (arg0.votes_yes > arg0.votes_no) {
            (1, 0, 0)
        } else {
            (0, 1, 1)
        };
        let v3 = 0x2::clock::timestamp_ms(arg4);
        assert_quorum_finalize_time_ready(arg0, v3);
        let v4 = typed_bond_id<T0>(arg1);
        let (v5, v6) = distribute_typed_quorum_pool<T0>(arg0, arg1, arg3, v0, arg5);
        arg1.state = 2;
        arg1.has_active_case = false;
        complete_quorum_case(arg0, arg2, arg3, v4, v1, v2, v0, v6, v5, v3);
    }

    fun finalize_escrow_dispute_binding(arg0: &mut DisputeQuorumConfig, arg1: address, arg2: address, arg3: address, arg4: u8) {
        if (arg1 == @0x0) {
            return
        };
        let v0 = EscrowDisputeBindingKey{escrow_id: arg1};
        let v1 = 0x2::dynamic_field::borrow_mut<EscrowDisputeBindingKey, EscrowDisputeBinding>(&mut arg0.id, v0);
        assert!(v1.bond_object_id == arg2, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_ticket_mismatch());
        assert!(v1.dispute_case_id == arg3, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_ticket_mismatch());
        v1.finalized = true;
        v1.settlement_path = arg4;
    }

    public fun finalized_escrow_binding_settlement_path(arg0: &DisputeQuorumConfig, arg1: address) : u8 {
        let v0 = EscrowDisputeBindingKey{escrow_id: arg1};
        let v1 = 0x2::dynamic_field::borrow<EscrowDisputeBindingKey, EscrowDisputeBinding>(&arg0.id, v0);
        assert!(v1.finalized, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_invalid_state());
        assert_valid_settlement_path(v1.settlement_path);
        v1.settlement_path
    }

    public fun force_deregister_reviewer(arg0: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::AdminCap, arg1: &mut ReviewerRegistry, arg2: address, arg3: &0x2::clock::Clock) {
        let v0 = ReviewerCaseCountKey{owner: arg2};
        assert!(0x2::dynamic_field::exists_<ReviewerCaseCountKey>(&arg1.id, v0), 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_reviewer_not_eligible());
        assert!(*0x2::dynamic_field::borrow<ReviewerCaseCountKey, u64>(&arg1.id, v0) == 0, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_invalid_state());
        let v1 = ReviewerLastActivityKey{owner: arg2};
        assert!(0x2::dynamic_field::exists_<ReviewerLastActivityKey>(&arg1.id, v1), 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_reviewer_not_eligible());
        assert!(0x2::clock::timestamp_ms(arg3) >= *0x2::dynamic_field::borrow<ReviewerLastActivityKey, u64>(&arg1.id, v1) + 7776000000, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_bond_not_ready());
        let v2 = ReviewerForceDeregisteredKey{owner: arg2};
        assert!(!0x2::dynamic_field::exists_<ReviewerForceDeregisteredKey>(&arg1.id, v2), 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_invalid_state());
        let v3 = ReviewerRegisteredKey{owner: arg2};
        if (0x2::dynamic_field::exists_<ReviewerRegisteredKey>(&arg1.id, v3)) {
            0x2::dynamic_field::remove<ReviewerRegisteredKey, bool>(&mut arg1.id, v3);
        };
        0x2::dynamic_field::remove<ReviewerCaseCountKey, u64>(&mut arg1.id, v0);
        0x2::dynamic_field::remove<ReviewerLastActivityKey, u64>(&mut arg1.id, v1);
        0x2::dynamic_field::add<ReviewerForceDeregisteredKey, bool>(&mut arg1.id, v2, true);
        arg1.reviewer_count = arg1.reviewer_count - 1;
        let v4 = ReviewerForceDeregistered{owner: arg2};
        0x2::event::emit<ReviewerForceDeregistered>(v4);
    }

    public fun fund_bond_as_buyer(arg0: &mut OrderDisputeBond, arg1: &DisputeQuorumConfig, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        fund_bond_internal(arg0, arg1, arg2, true, arg4);
    }

    public fun fund_bond_as_seller(arg0: &mut OrderDisputeBond, arg1: &DisputeQuorumConfig, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        fund_bond_internal(arg0, arg1, arg2, false, arg4);
    }

    fun fund_bond_internal(arg0: &mut OrderDisputeBond, arg1: &DisputeQuorumConfig, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: bool, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(arg0.state == 0, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_invalid_state());
        assert!(v1 >= arg1.min_dispute_bond_per_side_sui, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_invalid_policy());
        assert!(v1 <= arg1.max_dispute_bond_per_side_sui, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_invalid_policy());
        if (arg3) {
            assert!(v0 == arg0.buyer, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_not_authorized());
            assert!(!arg0.buyer_bond_paid, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_invalid_state());
            arg0.buyer_bond_paid = true;
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.buyer_locked, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        } else {
            assert!(v0 == arg0.seller, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_not_authorized());
            assert!(!arg0.seller_bond_paid, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_invalid_state());
            arg0.seller_bond_paid = true;
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.seller_locked, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        };
        if (arg0.buyer_bond_paid && arg0.seller_bond_paid) {
            assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.buyer_locked) == 0x2::balance::value<0x2::sui::SUI>(&arg0.seller_locked), 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_invalid_policy());
            arg0.state = 1;
        };
        let v2 = OrderDisputeBondFunded{
            bond_id     : bond_id(arg0),
            funder      : v0,
            amount      : v1,
            buyer_paid  : arg0.buyer_bond_paid,
            seller_paid : arg0.seller_bond_paid,
            state       : arg0.state,
        };
        0x2::event::emit<OrderDisputeBondFunded>(v2);
    }

    public fun fund_typed_bond_as_buyer<T0>(arg0: &mut OrderDisputeBondTyped<T0>, arg1: &DisputeQuorumConfig, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        fund_typed_bond_internal<T0>(arg0, arg1, arg2, true, arg4);
    }

    public fun fund_typed_bond_as_seller<T0>(arg0: &mut OrderDisputeBondTyped<T0>, arg1: &DisputeQuorumConfig, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        fund_typed_bond_internal<T0>(arg0, arg1, arg2, false, arg4);
    }

    fun fund_typed_bond_internal<T0>(arg0: &mut OrderDisputeBondTyped<T0>, arg1: &DisputeQuorumConfig, arg2: 0x2::coin::Coin<T0>, arg3: bool, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::coin::value<T0>(&arg2);
        assert!(arg0.state == 0, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_invalid_state());
        assert_typed_dispute_bond_lane_amount<T0>(arg1, v1);
        if (arg3) {
            assert!(v0 == arg0.buyer, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_not_authorized());
            assert!(!arg0.buyer_bond_paid, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_invalid_state());
            arg0.buyer_bond_paid = true;
            0x2::balance::join<T0>(&mut arg0.buyer_locked, 0x2::coin::into_balance<T0>(arg2));
        } else {
            assert!(v0 == arg0.seller, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_not_authorized());
            assert!(!arg0.seller_bond_paid, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_invalid_state());
            arg0.seller_bond_paid = true;
            0x2::balance::join<T0>(&mut arg0.seller_locked, 0x2::coin::into_balance<T0>(arg2));
        };
        if (arg0.buyer_bond_paid && arg0.seller_bond_paid) {
            assert!(0x2::balance::value<T0>(&arg0.buyer_locked) == 0x2::balance::value<T0>(&arg0.seller_locked), 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_invalid_policy());
            arg0.state = 1;
        };
        let v2 = OrderDisputeBondFunded{
            bond_id     : typed_bond_id<T0>(arg0),
            funder      : v0,
            amount      : v1,
            buyer_paid  : arg0.buyer_bond_paid,
            seller_paid : arg0.seller_bond_paid,
            state       : arg0.state,
        };
        0x2::event::emit<OrderDisputeBondFunded>(v2);
    }

    fun has_dispute_bond_asset_lane_config<T0>(arg0: &DisputeQuorumConfig) : bool {
        0x2::dynamic_field::exists_<DisputeBondAssetLaneKey>(&arg0.id, dispute_bond_asset_lane_key<T0>())
    }

    fun has_majority(arg0: &MilestoneDisputeCase) : bool {
        let v0 = arg0.required_reviewer_votes / 2 + 1;
        arg0.votes_yes >= v0 || arg0.votes_no >= v0
    }

    fun increment_active_case_count(arg0: &mut ReviewerRegistry, arg1: address, arg2: &DisputeQuorumConfig) {
        let v0 = ReviewerCaseCountKey{owner: arg1};
        assert!(0x2::dynamic_field::exists_<ReviewerCaseCountKey>(&arg0.id, v0), 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_reviewer_not_eligible());
        let v1 = 0x2::dynamic_field::borrow_mut<ReviewerCaseCountKey, u64>(&mut arg0.id, v0);
        assert!(*v1 < arg2.max_active_cases_per_reviewer, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_invalid_state());
        *v1 = *v1 + 1;
    }

    fun increment_pending_blocked_penalty_count(arg0: &mut ReviewerRegistry, arg1: address) {
        let v0 = ReviewerPendingBlockedPenaltyCountKey{owner: arg1};
        if (0x2::dynamic_field::exists_<ReviewerPendingBlockedPenaltyCountKey>(&arg0.id, v0)) {
            let v1 = 0x2::dynamic_field::borrow_mut<ReviewerPendingBlockedPenaltyCountKey, u64>(&mut arg0.id, v0);
            *v1 = *v1 + 1;
        } else {
            0x2::dynamic_field::add<ReviewerPendingBlockedPenaltyCountKey, u64>(&mut arg0.id, v0, 1);
        };
    }

    fun index_of_address(arg0: &vector<address>, arg1: address) : u64 {
        let v0 = 0x1::vector::length<address>(arg0);
        let v1 = 0;
        while (v1 < v0) {
            if (*0x1::vector::borrow<address>(arg0, v1) == arg1) {
                return v1
            };
            v1 = v1 + 1;
        };
        v0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = new_config(arg0);
        let v1 = ReviewerRegistry{
            id                           : 0x2::object::new(arg0),
            reviewer_count               : 0,
            bootstrap_approved_reviewers : vector[],
        };
        let v2 = 0x2::object::id<DisputeQuorumConfig>(&v0);
        let v3 = DisputeQuorumConfigInitialized{config_id: 0x2::object::id_to_address(&v2)};
        0x2::event::emit<DisputeQuorumConfigInitialized>(v3);
        let v4 = 0x2::object::id<ReviewerRegistry>(&v1);
        let v5 = ReviewerRegistryInitialized{registry_id: 0x2::object::id_to_address(&v4)};
        0x2::event::emit<ReviewerRegistryInitialized>(v5);
        0x2::transfer::share_object<DisputeQuorumConfig>(v0);
        0x2::transfer::share_object<ReviewerRegistry>(v1);
    }

    public fun init_order_dispute_bond(arg0: 0x1::string::String, arg1: address, arg2: address, arg3: u64, arg4: u64, arg5: &DisputeQuorumConfig, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<OrderDisputeBond>(init_order_dispute_bond_internal(arg0, arg1, arg2, arg3, arg4, arg5, arg7));
    }

    fun init_order_dispute_bond_internal(arg0: 0x1::string::String, arg1: address, arg2: address, arg3: u64, arg4: u64, arg5: &DisputeQuorumConfig, arg6: &mut 0x2::tx_context::TxContext) : OrderDisputeBond {
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(v0 == arg1 || v0 == arg2, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_not_authorized());
        let v1 = if (arg1 != arg2) {
            if (arg1 != @0x0) {
                arg2 != @0x0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_invalid_input());
        assert_non_empty_with_max(&arg0, 128);
        assert_valid_required_votes(arg3, arg4, arg5);
        let v2 = OrderDisputeBond{
            id                            : 0x2::object::new(arg6),
            order_id                      : arg0,
            buyer                         : arg1,
            seller                        : arg2,
            buyer_bond_paid               : false,
            seller_bond_paid              : false,
            buyer_locked                  : 0x2::balance::zero<0x2::sui::SUI>(),
            seller_locked                 : 0x2::balance::zero<0x2::sui::SUI>(),
            required_reviewer_votes       : arg3,
            required_reviewer_votes_floor : arg4,
            reviewer_accept_window_ms     : arg5.default_reviewer_accept_window_ms,
            vote_commit_window_ms         : arg5.default_vote_commit_window_ms,
            vote_reveal_window_ms         : arg5.default_vote_reveal_window_ms,
            vote_challenge_window_ms      : arg5.default_vote_challenge_window_ms,
            max_replacement_rounds        : arg5.default_max_replacement_rounds,
            case_hard_timeout_ms          : arg5.default_case_hard_timeout_ms,
            fallback_after_ms             : arg5.fallback_after_ms,
            state                         : 0,
            has_active_case               : false,
        };
        let v3 = OrderDisputeBondCreated{
            bond_id                       : bond_id(&v2),
            order_id                      : v2.order_id,
            buyer                         : arg1,
            seller                        : arg2,
            required_reviewer_votes       : arg3,
            required_reviewer_votes_floor : arg4,
        };
        0x2::event::emit<OrderDisputeBondCreated>(v3);
        v2
    }

    public fun init_order_dispute_bond_typed<T0>(arg0: 0x1::string::String, arg1: address, arg2: address, arg3: u64, arg4: u64, arg5: &DisputeQuorumConfig, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<OrderDisputeBondTyped<T0>>(init_order_dispute_bond_typed_internal<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg7));
    }

    fun init_order_dispute_bond_typed_internal<T0>(arg0: 0x1::string::String, arg1: address, arg2: address, arg3: u64, arg4: u64, arg5: &DisputeQuorumConfig, arg6: &mut 0x2::tx_context::TxContext) : OrderDisputeBondTyped<T0> {
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(v0 == arg1 || v0 == arg2, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_not_authorized());
        let v1 = if (arg1 != arg2) {
            if (arg1 != @0x0) {
                arg2 != @0x0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_invalid_input());
        assert_non_empty_with_max(&arg0, 128);
        assert_valid_required_votes(arg3, arg4, arg5);
        assert!(0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::payment_assets::is_supported_dispute_bond_typed_coin_type<T0>(), 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_invalid_policy());
        assert!(has_dispute_bond_asset_lane_config<T0>(arg5), 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_invalid_policy());
        assert!(borrow_dispute_bond_asset_lane_config<T0>(arg5).enabled, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_invalid_policy());
        let v2 = OrderDisputeBondTyped<T0>{
            id                            : 0x2::object::new(arg6),
            order_id                      : arg0,
            buyer                         : arg1,
            seller                        : arg2,
            buyer_bond_paid               : false,
            seller_bond_paid              : false,
            buyer_locked                  : 0x2::balance::zero<T0>(),
            seller_locked                 : 0x2::balance::zero<T0>(),
            required_reviewer_votes       : arg3,
            required_reviewer_votes_floor : arg4,
            reviewer_accept_window_ms     : arg5.default_reviewer_accept_window_ms,
            vote_commit_window_ms         : arg5.default_vote_commit_window_ms,
            vote_reveal_window_ms         : arg5.default_vote_reveal_window_ms,
            vote_challenge_window_ms      : arg5.default_vote_challenge_window_ms,
            max_replacement_rounds        : arg5.default_max_replacement_rounds,
            case_hard_timeout_ms          : arg5.default_case_hard_timeout_ms,
            fallback_after_ms             : arg5.fallback_after_ms,
            state                         : 0,
            has_active_case               : false,
        };
        let v3 = OrderDisputeBondCreated{
            bond_id                       : typed_bond_id<T0>(&v2),
            order_id                      : v2.order_id,
            buyer                         : arg1,
            seller                        : arg2,
            required_reviewer_votes       : arg3,
            required_reviewer_votes_floor : arg4,
        };
        0x2::event::emit<OrderDisputeBondCreated>(v3);
        v2
    }

    public fun init_order_dispute_bond_with_policy(arg0: 0x1::string::String, arg1: address, arg2: address, arg3: u8, arg4: u64, arg5: u64, arg6: &DisputeQuorumConfig, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert_valid_funding_policy(arg3);
        init_order_dispute_bond(arg0, arg1, arg2, arg4, arg5, arg6, arg7, arg8);
    }

    fun lower_required_votes_for_scarcity(arg0: &mut MilestoneDisputeCase) {
        if (arg0.required_reviewer_votes > arg0.required_reviewer_votes_floor) {
            arg0.required_reviewer_votes = arg0.required_reviewer_votes - 2;
        };
    }

    fun merge_pending_reviewer_outcome(arg0: &mut PendingReviewerOutcome, arg1: PendingReviewerOutcome) {
        arg0.decisions_total = arg0.decisions_total + arg1.decisions_total;
        arg0.decisions_majority = arg0.decisions_majority + arg1.decisions_majority;
        arg0.decisions_overturned = arg0.decisions_overturned + arg1.decisions_overturned;
        arg0.commit_reveal_failures = arg0.commit_reveal_failures + arg1.commit_reveal_failures;
        arg0.noshow_count = arg0.noshow_count + arg1.noshow_count;
        while (0x1::vector::length<PendingReviewerSlash>(&arg1.pending_slashes) > 0) {
            0x1::vector::push_back<PendingReviewerSlash>(&mut arg0.pending_slashes, 0x1::vector::pop_back<PendingReviewerSlash>(&mut arg1.pending_slashes));
        };
    }

    fun min_u64(arg0: u64, arg1: u64) : u64 {
        if (arg0 <= arg1) {
            arg0
        } else {
            arg1
        }
    }

    fun move_assigned_reviewers_to_blocked(arg0: &mut MilestoneDisputeCase, arg1: &mut ReviewerRegistry, arg2: bool) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg0.assigned_reviewers)) {
            let v1 = *0x1::vector::borrow<address>(&arg0.assigned_reviewers, v0);
            if (!contains_address(&arg0.blocked_reviewers, v1)) {
                let v2 = blocked_reviewer_status_from_current_round(arg0, v1, arg2);
                0x1::vector::push_back<address>(&mut arg0.blocked_reviewers, v1);
                let v3 = BlockedReviewerStatusKey{reviewer: v1};
                0x2::dynamic_field::add<BlockedReviewerStatusKey, u8>(&mut arg0.id, v3, v2);
                if (blocked_status_requires_finalized_penalty_tracking(v2)) {
                    increment_pending_blocked_penalty_count(arg1, v1);
                };
            };
            decrement_active_case_count_if_present(arg1, v1);
            v0 = v0 + 1;
        };
    }

    fun new_config(arg0: &mut 0x2::tx_context::TxContext) : DisputeQuorumConfig {
        DisputeQuorumConfig{
            id                                  : 0x2::object::new(arg0),
            min_reviewer_level                  : 1,
            min_reviewer_confidence             : 1,
            min_reviewer_score                  : 55,
            default_required_reviewer_votes     : 3,
            min_required_reviewer_votes         : 3,
            max_required_reviewer_votes         : 7,
            default_reviewer_accept_window_ms   : 1200000,
            default_vote_commit_window_ms       : 3600000,
            default_vote_reveal_window_ms       : 14400000,
            default_vote_challenge_window_ms    : 1800000,
            default_max_replacement_rounds      : 3,
            default_case_hard_timeout_ms        : 86400000,
            fallback_after_ms                   : 1800000,
            platform_fallback_sink              : @0xa0d4c9a9f935dac9f9bee55ca0632c187077a04d0dffcc479402f2de9a82140,
            min_dispute_bond_per_side_sui       : 10000000,
            max_dispute_bond_per_side_sui       : 1000000000,
            target_reviewer_payout_bps          : 7000,
            target_platform_fallback_payout_bps : 2000,
            reviewer_noshow_slash_bps           : 3000,
            reviewer_invalid_reveal_slash_bps   : 4000,
            reviewer_overturn_slash_bps         : 5000,
            reviewer_min_stake_sui              : 100000000,
            max_active_cases_per_reviewer       : 3,
        }
    }

    public(friend) fun open_milestone_dispute_case(arg0: 0x1::string::String, arg1: address, arg2: &mut DisputeQuorumConfig, arg3: &mut OrderDisputeBond, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : MilestoneDisputeCase {
        open_milestone_dispute_case_internal(arg0, arg1, vector[], arg2, arg3, arg4, arg5)
    }

    public(friend) fun open_milestone_dispute_case_entry(arg0: 0x1::string::String, arg1: address, arg2: &mut DisputeQuorumConfig, arg3: &mut OrderDisputeBond, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<MilestoneDisputeCase>(open_milestone_dispute_case_internal(arg0, arg1, vector[], arg2, arg3, arg4, arg5));
    }

    public(friend) fun open_milestone_dispute_case_entry_typed<T0>(arg0: 0x1::string::String, arg1: address, arg2: &mut DisputeQuorumConfig, arg3: &mut OrderDisputeBondTyped<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<MilestoneDisputeCase>(open_milestone_dispute_case_typed_internal<T0>(arg0, arg1, vector[], arg2, arg3, arg4, arg5));
    }

    public(friend) fun open_milestone_dispute_case_entry_with_invites(arg0: 0x1::string::String, arg1: address, arg2: vector<address>, arg3: &mut DisputeQuorumConfig, arg4: &mut OrderDisputeBond, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<MilestoneDisputeCase>(open_milestone_dispute_case_internal(arg0, arg1, arg2, arg3, arg4, arg5, arg6));
    }

    public(friend) fun open_milestone_dispute_case_entry_with_invites_typed<T0>(arg0: 0x1::string::String, arg1: address, arg2: vector<address>, arg3: &mut DisputeQuorumConfig, arg4: &mut OrderDisputeBondTyped<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<MilestoneDisputeCase>(open_milestone_dispute_case_typed_internal<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6));
    }

    fun open_milestone_dispute_case_internal(arg0: 0x1::string::String, arg1: address, arg2: vector<address>, arg3: &mut DisputeQuorumConfig, arg4: &mut OrderDisputeBond, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : MilestoneDisputeCase {
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(v0 == arg4.buyer || v0 == arg4.seller, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_not_authorized());
        assert!(arg4.state == 1, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_bond_not_ready());
        assert!(!arg4.has_active_case, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_invalid_state());
        assert_non_empty_with_max(&arg0, 128);
        assert_unique_reviewer_list(&arg2, arg4.buyer, arg4.seller);
        let v1 = 0x1::vector::length<address>(&arg2);
        assert!(v1 == 0 || v1 >= arg4.required_reviewer_votes, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_invalid_input());
        let v2 = 0x2::clock::timestamp_ms(arg5);
        let v3 = 0x1::vector::empty<u64>();
        let v4 = &mut v3;
        0x1::vector::push_back<u64>(v4, arg4.reviewer_accept_window_ms);
        0x1::vector::push_back<u64>(v4, arg4.vote_commit_window_ms);
        0x1::vector::push_back<u64>(v4, arg4.vote_reveal_window_ms);
        0x1::vector::push_back<u64>(v4, arg4.vote_challenge_window_ms);
        let v5 = MilestoneDisputeCase{
            id                            : 0x2::object::new(arg6),
            order_id                      : arg4.order_id,
            milestone_id                  : arg0,
            escrow_id                     : arg1,
            buyer                         : arg4.buyer,
            seller                        : arg4.seller,
            bond_object_id                : bond_id(arg4),
            accept_deadline_ms            : v2 + arg4.reviewer_accept_window_ms,
            commit_deadline_ms            : 0,
            reveal_deadline_ms            : 0,
            challenge_deadline_ms         : 0,
            hard_timeout_ms               : v2 + arg4.case_hard_timeout_ms,
            fallback_eligible_at_ms       : v2 + arg4.case_hard_timeout_ms + arg4.fallback_after_ms,
            required_reviewer_votes       : arg4.required_reviewer_votes,
            required_reviewer_votes_floor : arg4.required_reviewer_votes_floor,
            assignment_round              : 0,
            max_replacement_rounds        : arg4.max_replacement_rounds,
            timing_windows_ms             : v3,
            assigned_reviewers            : vector[],
            invited_reviewers             : arg2,
            blocked_reviewers             : vector[],
            committers                    : vector[],
            committed_hashes              : vector[],
            revealed_reviewers            : vector[],
            revealed_votes                : b"",
            votes_yes                     : 0,
            votes_no                      : 0,
            state                         : 0,
            resolved_path                 : 255,
            settlement_path               : 255,
            closed_at_ms                  : 0,
        };
        let v6 = case_id(&v5);
        arg4.has_active_case = true;
        record_escrow_dispute_binding(arg3, arg1, bond_id(arg4), v6);
        let v7 = MilestoneDisputeOpened{
            dispute_case_id : v6,
            bond_id         : bond_id(arg4),
            escrow_id       : arg1,
            order_id        : v5.order_id,
            milestone_id    : v5.milestone_id,
        };
        0x2::event::emit<MilestoneDisputeOpened>(v7);
        emit_reviewer_invites(&v5);
        v5
    }

    public(friend) fun open_milestone_dispute_case_typed<T0>(arg0: 0x1::string::String, arg1: address, arg2: &mut DisputeQuorumConfig, arg3: &mut OrderDisputeBondTyped<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : MilestoneDisputeCase {
        open_milestone_dispute_case_typed_internal<T0>(arg0, arg1, vector[], arg2, arg3, arg4, arg5)
    }

    fun open_milestone_dispute_case_typed_internal<T0>(arg0: 0x1::string::String, arg1: address, arg2: vector<address>, arg3: &mut DisputeQuorumConfig, arg4: &mut OrderDisputeBondTyped<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : MilestoneDisputeCase {
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(v0 == arg4.buyer || v0 == arg4.seller, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_not_authorized());
        assert!(arg4.state == 1, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_bond_not_ready());
        assert!(!arg4.has_active_case, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_invalid_state());
        assert_non_empty_with_max(&arg0, 128);
        assert_unique_reviewer_list(&arg2, arg4.buyer, arg4.seller);
        let v1 = 0x1::vector::length<address>(&arg2);
        assert!(v1 == 0 || v1 >= arg4.required_reviewer_votes, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_invalid_input());
        let v2 = borrow_dispute_bond_asset_lane_config<T0>(arg3);
        assert!(v2.enabled, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_invalid_policy());
        if (v2.invite_only_reviewers) {
            assert!(v1 > 0, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_invalid_policy());
        };
        let v3 = 0x2::clock::timestamp_ms(arg5);
        let v4 = 0x1::vector::empty<u64>();
        let v5 = &mut v4;
        0x1::vector::push_back<u64>(v5, arg4.reviewer_accept_window_ms);
        0x1::vector::push_back<u64>(v5, arg4.vote_commit_window_ms);
        0x1::vector::push_back<u64>(v5, arg4.vote_reveal_window_ms);
        0x1::vector::push_back<u64>(v5, arg4.vote_challenge_window_ms);
        let v6 = MilestoneDisputeCase{
            id                            : 0x2::object::new(arg6),
            order_id                      : arg4.order_id,
            milestone_id                  : arg0,
            escrow_id                     : arg1,
            buyer                         : arg4.buyer,
            seller                        : arg4.seller,
            bond_object_id                : typed_bond_id<T0>(arg4),
            accept_deadline_ms            : v3 + arg4.reviewer_accept_window_ms,
            commit_deadline_ms            : 0,
            reveal_deadline_ms            : 0,
            challenge_deadline_ms         : 0,
            hard_timeout_ms               : v3 + arg4.case_hard_timeout_ms,
            fallback_eligible_at_ms       : v3 + arg4.case_hard_timeout_ms + arg4.fallback_after_ms,
            required_reviewer_votes       : arg4.required_reviewer_votes,
            required_reviewer_votes_floor : arg4.required_reviewer_votes_floor,
            assignment_round              : 0,
            max_replacement_rounds        : arg4.max_replacement_rounds,
            timing_windows_ms             : v4,
            assigned_reviewers            : vector[],
            invited_reviewers             : arg2,
            blocked_reviewers             : vector[],
            committers                    : vector[],
            committed_hashes              : vector[],
            revealed_reviewers            : vector[],
            revealed_votes                : b"",
            votes_yes                     : 0,
            votes_no                      : 0,
            state                         : 0,
            resolved_path                 : 255,
            settlement_path               : 255,
            closed_at_ms                  : 0,
        };
        let v7 = case_id(&v6);
        arg4.has_active_case = true;
        record_escrow_dispute_binding(arg3, arg1, typed_bond_id<T0>(arg4), v7);
        let v8 = MilestoneDisputeOpened{
            dispute_case_id : v7,
            bond_id         : typed_bond_id<T0>(arg4),
            escrow_id       : arg1,
            order_id        : v6.order_id,
            milestone_id    : v6.milestone_id,
        };
        0x2::event::emit<MilestoneDisputeOpened>(v8);
        emit_reviewer_invites(&v6);
        v6
    }

    public(friend) fun open_milestone_dispute_case_with_invites(arg0: 0x1::string::String, arg1: address, arg2: vector<address>, arg3: &mut DisputeQuorumConfig, arg4: &mut OrderDisputeBond, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : MilestoneDisputeCase {
        open_milestone_dispute_case_internal(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    public(friend) fun open_milestone_dispute_case_with_invites_typed<T0>(arg0: 0x1::string::String, arg1: address, arg2: vector<address>, arg3: &mut DisputeQuorumConfig, arg4: &mut OrderDisputeBondTyped<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : MilestoneDisputeCase {
        open_milestone_dispute_case_typed_internal<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    fun pending_blocked_penalty_count(arg0: &ReviewerRegistry, arg1: address) : u64 {
        let v0 = ReviewerPendingBlockedPenaltyCountKey{owner: arg1};
        if (0x2::dynamic_field::exists_<ReviewerPendingBlockedPenaltyCountKey>(&arg0.id, v0)) {
            *0x2::dynamic_field::borrow<ReviewerPendingBlockedPenaltyCountKey, u64>(&arg0.id, v0)
        } else {
            0
        }
    }

    fun pending_outcome_has_changes(arg0: &PendingReviewerOutcome) : bool {
        if (arg0.decisions_total > 0) {
            true
        } else if (arg0.decisions_majority > 0) {
            true
        } else if (arg0.decisions_overturned > 0) {
            true
        } else if (arg0.commit_reveal_failures > 0) {
            true
        } else if (arg0.noshow_count > 0) {
            true
        } else {
            0x1::vector::length<PendingReviewerSlash>(&arg0.pending_slashes) > 0
        }
    }

    fun profile_passes_reviewer_thresholds(arg0: &DisputeQuorumConfig, arg1: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::reputation::ReputationProfile) : bool {
        let v0 = 0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::reputation::seller_level(arg1);
        let v1 = 0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::reputation::buyer_level(arg1);
        let v2 = if (v0 > v1) {
            v0
        } else {
            v1
        };
        let v3 = 0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::reputation::seller_score(arg1);
        let v4 = 0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::reputation::buyer_score(arg1);
        let v5 = if (v3 > v4) {
            v3
        } else {
            v4
        };
        let v6 = 0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::reputation::seller_confidence(arg1);
        let v7 = 0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::reputation::buyer_confidence(arg1);
        let v8 = if (v6 > v7) {
            v6
        } else {
            v7
        };
        threshold_summary_passes_reviewer_thresholds(arg0, v2, v5, v8)
    }

    fun push_pending_reviewer_slash(arg0: &mut PendingReviewerOutcome, arg1: u64, arg2: address) {
        if (arg1 == 0) {
            return
        };
        let v0 = PendingReviewerSlash{
            bps  : arg1,
            sink : arg2,
        };
        0x1::vector::push_back<PendingReviewerSlash>(&mut arg0.pending_slashes, v0);
    }

    public fun queue_dispute_quorum_economics_update(arg0: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::AdminCap, arg1: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::GovernanceConfig, arg2: &mut DisputeQuorumConfig, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: address, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::assert_incident_not_frozen(arg1);
        assert_valid_economics(arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
        assert!(!0x2::dynamic_field::exists_<PendingDisputeQuorumEconomicsUpdateKey>(&arg2.id, economics_update_key()), 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_pending_economics_update_already_exists());
        let v0 = 0x2::clock::timestamp_ms(arg13) + 0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::cap_rotation_timelock_ms(arg1);
        let v1 = PendingDisputeQuorumEconomicsUpdate{
            min_dispute_bond_per_side_sui       : arg3,
            max_dispute_bond_per_side_sui       : arg4,
            target_reviewer_payout_bps          : arg5,
            target_platform_fallback_payout_bps : arg6,
            reviewer_noshow_slash_bps           : arg7,
            reviewer_invalid_reveal_slash_bps   : arg8,
            reviewer_overturn_slash_bps         : arg9,
            reviewer_min_stake_sui              : arg10,
            max_active_cases_per_reviewer       : arg11,
            platform_fallback_sink              : arg12,
            effective_at_ms                     : v0,
            treasury_approved                   : false,
        };
        0x2::dynamic_field::add<PendingDisputeQuorumEconomicsUpdateKey, PendingDisputeQuorumEconomicsUpdate>(&mut arg2.id, economics_update_key(), v1);
        let v2 = 0x2::object::id<DisputeQuorumConfig>(arg2);
        let v3 = DisputeQuorumEconomicsUpdateQueued{
            config_id       : 0x2::object::id_to_address(&v2),
            actor           : 0x2::tx_context::sender(arg14),
            effective_at_ms : v0,
        };
        0x2::event::emit<DisputeQuorumEconomicsUpdateQueued>(v3);
    }

    public fun queue_dispute_quorum_reviewer_threshold_update(arg0: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::AdminCap, arg1: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::GovernanceConfig, arg2: &mut DisputeQuorumConfig, arg3: u8, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::assert_incident_not_frozen(arg1);
        assert_valid_reviewer_threshold_fields(arg3, arg4, arg5);
        let v0 = reviewer_threshold_update_key();
        assert!(!0x2::dynamic_field::exists_<PendingDisputeQuorumReviewerThresholdUpdateKey>(&arg2.id, v0), 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_pending_reviewer_threshold_update_already_exists());
        let v1 = 0x2::clock::timestamp_ms(arg6) + 0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::cap_rotation_timelock_ms(arg1);
        let v2 = PendingDisputeQuorumReviewerThresholdUpdate{
            min_reviewer_level      : arg3,
            min_reviewer_confidence : arg4,
            min_reviewer_score      : arg5,
            effective_at_ms         : v1,
            treasury_approved       : false,
        };
        0x2::dynamic_field::add<PendingDisputeQuorumReviewerThresholdUpdateKey, PendingDisputeQuorumReviewerThresholdUpdate>(&mut arg2.id, v0, v2);
        let v3 = 0x2::object::id<DisputeQuorumConfig>(arg2);
        let v4 = DisputeQuorumReviewerThresholdUpdateQueued{
            config_id       : 0x2::object::id_to_address(&v3),
            actor           : 0x2::tx_context::sender(arg7),
            effective_at_ms : v1,
        };
        0x2::event::emit<DisputeQuorumReviewerThresholdUpdateQueued>(v4);
    }

    public fun queue_dispute_quorum_timing_update(arg0: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::AdminCap, arg1: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::GovernanceConfig, arg2: &mut DisputeQuorumConfig, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::assert_incident_not_frozen(arg1);
        assert_valid_timing(arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        let v0 = timing_update_key();
        assert!(!0x2::dynamic_field::exists_<PendingDisputeQuorumTimingUpdateKey>(&arg2.id, v0), 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_pending_timing_update_already_exists());
        let v1 = 0x2::clock::timestamp_ms(arg10) + 0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::cap_rotation_timelock_ms(arg1);
        let v2 = PendingDisputeQuorumTimingUpdate{
            default_reviewer_accept_window_ms : arg3,
            default_vote_commit_window_ms     : arg4,
            default_vote_reveal_window_ms     : arg5,
            default_vote_challenge_window_ms  : arg6,
            default_max_replacement_rounds    : arg7,
            default_case_hard_timeout_ms      : arg8,
            fallback_after_ms                 : arg9,
            effective_at_ms                   : v1,
            treasury_approved                 : false,
        };
        0x2::dynamic_field::add<PendingDisputeQuorumTimingUpdateKey, PendingDisputeQuorumTimingUpdate>(&mut arg2.id, v0, v2);
        let v3 = 0x2::object::id<DisputeQuorumConfig>(arg2);
        let v4 = DisputeQuorumTimingUpdateQueued{
            config_id       : 0x2::object::id_to_address(&v3),
            actor           : 0x2::tx_context::sender(arg11),
            effective_at_ms : v1,
        };
        0x2::event::emit<DisputeQuorumTimingUpdateQueued>(v4);
    }

    fun recompute_reviewer_performance_score(arg0: &ReviewerEntry) : u64 {
        let v0 = arg0.decisions_total + arg0.commit_reveal_failures + arg0.noshow_count;
        min_u64((score_ratio_or_neutral(arg0.decisions_majority, arg0.decisions_total) * 45 + score_inverse_failure_or_neutral(arg0.noshow_count, v0) * 25 + score_inverse_failure_or_neutral(arg0.commit_reveal_failures, v0) * 20 + score_ratio_or_neutral(arg0.decisions_total, v0) * 10 + 50 * 10) / 110, 100)
    }

    fun record_all_case_reviewer_outcomes(arg0: &mut MilestoneDisputeCase, arg1: &mut ReviewerRegistry, arg2: &DisputeQuorumConfig) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg0.blocked_reviewers)) {
            let v1 = *0x1::vector::borrow<address>(&arg0.blocked_reviewers, v0);
            record_case_outcome_for_reviewer_if_needed(arg0, arg1, v1, arg2);
            v0 = v0 + 1;
        };
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(&arg0.assigned_reviewers)) {
            let v3 = *0x1::vector::borrow<address>(&arg0.assigned_reviewers, v2);
            record_case_outcome_for_reviewer_if_needed(arg0, arg1, v3, arg2);
            v2 = v2 + 1;
        };
    }

    fun record_case_outcome_for_reviewer_if_needed(arg0: &mut MilestoneDisputeCase, arg1: &mut ReviewerRegistry, arg2: address, arg3: &DisputeQuorumConfig) : bool {
        let v0 = MetricsClaimedKey{
            case_id  : case_id(arg0),
            reviewer : arg2,
        };
        if (0x2::dynamic_field::exists_<MetricsClaimedKey>(&arg0.id, v0)) {
            return true
        };
        let (v1, v2) = summarize_case_outcome_for_reviewer(arg0, arg2, arg3);
        let v3 = v2;
        if (!v1) {
            return false
        };
        let (_, v5, v6) = blocked_reviewer_status_for(arg0, arg2);
        if (v5 && blocked_status_requires_finalized_penalty_tracking(v6)) {
            decrement_pending_blocked_penalty_count_if_present(arg1, arg2);
        };
        if (pending_outcome_has_changes(&v3)) {
            let v7 = ensure_pending_reviewer_outcome(arg1, arg2);
            merge_pending_reviewer_outcome(v7, v3);
        };
        0x2::dynamic_field::add<MetricsClaimedKey, bool>(&mut arg0.id, v0, true);
        true
    }

    fun record_escrow_dispute_binding(arg0: &mut DisputeQuorumConfig, arg1: address, arg2: address, arg3: address) {
        if (arg1 == @0x0) {
            return
        };
        let v0 = EscrowDisputeBindingKey{escrow_id: arg1};
        assert!(!0x2::dynamic_field::exists_<EscrowDisputeBindingKey>(&arg0.id, v0), 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_escrow_already_bound());
        let v1 = EscrowDisputeBindingKey{escrow_id: arg1};
        let v2 = EscrowDisputeBinding{
            bond_object_id  : arg2,
            dispute_case_id : arg3,
            settlement_path : 255,
            finalized       : false,
        };
        0x2::dynamic_field::add<EscrowDisputeBindingKey, EscrowDisputeBinding>(&mut arg0.id, v1, v2);
    }

    fun register_reviewer_core(arg0: &mut ReviewerRegistry, arg1: &DisputeQuorumConfig, arg2: u8, arg3: vector<u8>, arg4: u64, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : ReviewerEntry {
        let v0 = 0x2::tx_context::sender(arg7);
        assert!(v0 != @0x0, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_invalid_input());
        assert!(!reviewer_force_deregistered(arg0, v0), 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_invalid_state());
        assert_transport_pubkey(&arg3);
        assert!(arg4 > 0, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_invalid_input());
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg5);
        assert!(v1 >= arg1.reviewer_min_stake_sui, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_insufficient_stake());
        let v2 = ReviewerRegisteredKey{owner: v0};
        assert!(!0x2::dynamic_field::exists_<ReviewerRegisteredKey>(&arg0.id, v2), 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_reviewer_already_registered());
        let v3 = ReviewerRegisteredKey{owner: v0};
        0x2::dynamic_field::add<ReviewerRegisteredKey, bool>(&mut arg0.id, v3, true);
        let v4 = ReviewerCaseCountKey{owner: v0};
        0x2::dynamic_field::add<ReviewerCaseCountKey, u64>(&mut arg0.id, v4, 0);
        arg0.reviewer_count = arg0.reviewer_count + 1;
        let v5 = 0x2::clock::timestamp_ms(arg6);
        set_reviewer_last_activity(arg0, v0, v5);
        let v6 = ReviewerEntry{
            id                     : 0x2::object::new(arg7),
            owner                  : v0,
            active                 : true,
            transport_type         : arg2,
            transport_pubkey       : arg3,
            min_case_reward_sui    : arg4,
            joined_at_ms           : v5,
            updated_at_ms          : v5,
            stake_locked           : 0x2::coin::into_balance<0x2::sui::SUI>(arg5),
            performance_score      : 50,
            decisions_total        : 0,
            decisions_majority     : 0,
            decisions_overturned   : 0,
            commit_reveal_failures : 0,
            noshow_count           : 0,
        };
        let v7 = ReviewerRegistered{
            reviewer_entry_id : reviewer_id(&v6),
            owner             : v0,
            stake_locked      : v1,
        };
        0x2::event::emit<ReviewerRegistered>(v7);
        v6
    }

    public fun register_reviewer_entry(arg0: &mut ReviewerRegistry, arg1: &DisputeQuorumConfig, arg2: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::reputation::ReputationProfile, arg3: u8, arg4: vector<u8>, arg5: u64, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        assert!(0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::reputation::owner(arg2) == v0, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_not_authorized());
        assert!(profile_passes_reviewer_thresholds(arg1, arg2), 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_reviewer_not_eligible());
        0x2::transfer::transfer<ReviewerEntry>(register_reviewer_core(arg0, arg1, arg3, arg4, arg5, arg6, arg7, arg8), v0);
    }

    public fun register_reviewer_entry_with_reputation_cfg(arg0: &mut ReviewerRegistry, arg1: &DisputeQuorumConfig, arg2: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::reputation::ReputationFeeConfig, arg3: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::reputation::ReputationProfile, arg4: u8, arg5: vector<u8>, arg6: u64, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg9);
        assert!(0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::reputation::owner(arg3) == v0, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_not_authorized());
        assert!(shared_participant_state_passes_reviewer_thresholds(arg1, arg2, v0), 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_reviewer_not_eligible());
        0x2::transfer::transfer<ReviewerEntry>(register_reviewer_core(arg0, arg1, arg4, arg5, arg6, arg7, arg8, arg9), v0);
    }

    public(friend) fun release_active_order_dispute_bond_without_case(arg0: &mut OrderDisputeBond, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.state == 1, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_invalid_state());
        assert!(!arg0.has_active_case, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_invalid_state());
        let v0 = &mut arg0.buyer_locked;
        let v1 = transfer_balance_to(v0, arg0.buyer, arg1);
        let v2 = &mut arg0.seller_locked;
        arg0.buyer_bond_paid = false;
        arg0.seller_bond_paid = false;
        arg0.state = 4;
        let v3 = OrderDisputeBondReleased{
            bond_id       : bond_id(arg0),
            buyer_refund  : v1,
            seller_refund : transfer_balance_to(v2, arg0.seller, arg1),
        };
        0x2::event::emit<OrderDisputeBondReleased>(v3);
    }

    public(friend) fun release_active_order_dispute_typed_bond_without_case<T0>(arg0: &mut OrderDisputeBondTyped<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.state == 1, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_invalid_state());
        assert!(!arg0.has_active_case, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_invalid_state());
        let v0 = &mut arg0.buyer_locked;
        let v1 = transfer_typed_balance_to<T0>(v0, arg0.buyer, arg1);
        let v2 = &mut arg0.seller_locked;
        arg0.buyer_bond_paid = false;
        arg0.seller_bond_paid = false;
        arg0.state = 4;
        let v3 = OrderDisputeBondReleased{
            bond_id       : typed_bond_id<T0>(arg0),
            buyer_refund  : v1,
            seller_refund : transfer_typed_balance_to<T0>(v2, arg0.seller, arg1),
        };
        0x2::event::emit<OrderDisputeBondReleased>(v3);
    }

    fun release_case_activity_counts(arg0: &mut ReviewerRegistry, arg1: &MilestoneDisputeCase) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1.assigned_reviewers)) {
            decrement_active_case_count_if_present(arg0, *0x1::vector::borrow<address>(&arg1.assigned_reviewers, v0));
            v0 = v0 + 1;
        };
    }

    fun remove_reviewer_last_activity_if_present(arg0: &mut ReviewerRegistry, arg1: address) {
        let v0 = ReviewerLastActivityKey{owner: arg1};
        if (0x2::dynamic_field::exists_<ReviewerLastActivityKey>(&arg0.id, v0)) {
            0x2::dynamic_field::remove<ReviewerLastActivityKey, u64>(&mut arg0.id, v0);
        };
    }

    fun reset_replacement_round_buffers(arg0: &mut MilestoneDisputeCase) {
        let v0 = &mut arg0.assigned_reviewers;
        clear_address_vec(v0);
        let v1 = &mut arg0.committers;
        clear_address_vec(v1);
        let v2 = &mut arg0.committed_hashes;
        clear_hash_vec(v2);
        let v3 = &mut arg0.revealed_reviewers;
        clear_address_vec(v3);
        let v4 = &mut arg0.revealed_votes;
        clear_u8_vec(v4);
        arg0.votes_yes = 0;
        arg0.votes_no = 0;
        arg0.commit_deadline_ms = 0;
        arg0.reveal_deadline_ms = 0;
        arg0.challenge_deadline_ms = 0;
    }

    public fun resolve_case_with_platform_fallback(arg0: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::ArbCap, arg1: &mut MilestoneDisputeCase, arg2: &mut OrderDisputeBond, arg3: &mut ReviewerRegistry, arg4: &mut DisputeQuorumConfig, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.state != 3 && arg1.state != 4, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_invalid_state());
        assert!(!has_majority(arg1), 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_not_finalizable());
        assert!(0x2::clock::timestamp_ms(arg5) >= arg1.fallback_eligible_at_ms, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_fallback_not_ready());
        assert!(bond_id(arg2) == arg1.bond_object_id, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_ticket_mismatch());
        assert!(arg2.state == 1 && arg2.has_active_case, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_bond_not_ready());
        let v0 = bond_id(arg2);
        let (v1, v2, v3) = distribute_fallback_pool(arg2, arg4, arg6);
        arg2.state = 2;
        arg2.has_active_case = false;
        complete_fallback_case(arg1, arg3, arg4, v0, v1, v2, v3, 0x2::clock::timestamp_ms(arg5));
    }

    public fun resolve_case_with_timeout_fallback(arg0: &mut MilestoneDisputeCase, arg1: &mut OrderDisputeBond, arg2: &mut ReviewerRegistry, arg3: &mut DisputeQuorumConfig, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg4) >= arg0.hard_timeout_ms, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_fallback_not_ready());
        resolve_timeout_fallback_internal(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public fun resolve_case_with_typed_platform_fallback<T0>(arg0: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::ArbCap, arg1: &mut MilestoneDisputeCase, arg2: &mut OrderDisputeBondTyped<T0>, arg3: &mut ReviewerRegistry, arg4: &mut DisputeQuorumConfig, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.state != 3 && arg1.state != 4, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_invalid_state());
        assert!(!has_majority(arg1), 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_not_finalizable());
        assert!(0x2::clock::timestamp_ms(arg5) >= arg1.fallback_eligible_at_ms, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_fallback_not_ready());
        assert!(typed_bond_id<T0>(arg2) == arg1.bond_object_id, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_ticket_mismatch());
        assert!(arg2.state == 1 && arg2.has_active_case, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_bond_not_ready());
        let v0 = typed_bond_id<T0>(arg2);
        let (v1, v2, v3) = distribute_typed_fallback_pool<T0>(arg2, arg4, arg6);
        arg2.state = 2;
        arg2.has_active_case = false;
        complete_fallback_case(arg1, arg3, arg4, v0, v1, v2, v3, 0x2::clock::timestamp_ms(arg5));
    }

    public fun resolve_case_with_typed_timeout_fallback<T0>(arg0: &mut MilestoneDisputeCase, arg1: &mut OrderDisputeBondTyped<T0>, arg2: &mut ReviewerRegistry, arg3: &mut DisputeQuorumConfig, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg4) >= arg0.hard_timeout_ms, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_fallback_not_ready());
        assert!(arg0.state != 3 && arg0.state != 4, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_invalid_state());
        assert!(!has_majority(arg0), 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_not_finalizable());
        assert!(0x2::clock::timestamp_ms(arg4) >= arg0.fallback_eligible_at_ms, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_fallback_not_ready());
        assert!(typed_bond_id<T0>(arg1) == arg0.bond_object_id, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_ticket_mismatch());
        assert!(arg1.state == 1 && arg1.has_active_case, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_bond_not_ready());
        let v0 = typed_bond_id<T0>(arg1);
        let (v1, v2, v3) = distribute_typed_fallback_pool<T0>(arg1, arg3, arg5);
        arg1.state = 2;
        arg1.has_active_case = false;
        complete_fallback_case(arg0, arg2, arg3, v0, v1, v2, v3, 0x2::clock::timestamp_ms(arg4));
    }

    fun resolve_timeout_fallback_internal(arg0: &mut MilestoneDisputeCase, arg1: &mut OrderDisputeBond, arg2: &mut ReviewerRegistry, arg3: &mut DisputeQuorumConfig, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.state != 3 && arg0.state != 4, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_invalid_state());
        assert!(!has_majority(arg0), 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_not_finalizable());
        assert!(0x2::clock::timestamp_ms(arg4) >= arg0.fallback_eligible_at_ms, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_fallback_not_ready());
        assert!(bond_id(arg1) == arg0.bond_object_id, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_ticket_mismatch());
        assert!(arg1.state == 1 && arg1.has_active_case, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_bond_not_ready());
        let v0 = bond_id(arg1);
        let (v1, v2, v3) = distribute_fallback_pool(arg1, arg3, arg5);
        arg1.state = 2;
        arg1.has_active_case = false;
        complete_fallback_case(arg0, arg2, arg3, v0, v1, v2, v3, 0x2::clock::timestamp_ms(arg4));
    }

    public fun reveal_vote(arg0: &mut MilestoneDisputeCase, arg1: &ReviewerEntry, arg2: u8, arg3: vector<u8>, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(arg0.state == 1 || arg0.state == 2, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_invalid_state());
        assert!(v0 == arg1.owner, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_not_authorized());
        assert!(contains_address(&arg0.assigned_reviewers, v0), 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_not_assigned());
        assert_valid_vote(arg2);
        let v1 = 0x2::clock::timestamp_ms(arg5);
        assert!(v1 > arg0.commit_deadline_ms, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_commit_window_closed());
        assert!(v1 <= arg0.reveal_deadline_ms, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_reveal_window_closed());
        assert!(!contains_address(&arg0.revealed_reviewers, v0), 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_already_revealed());
        let v2 = index_of_address(&arg0.committers, v0);
        assert!(v2 < 0x1::vector::length<address>(&arg0.committers), 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_missing_commit());
        assert!(*0x1::vector::borrow<vector<u8>>(&arg0.committed_hashes, v2) == vote_commit_hash(case_id(arg0), v0, arg2, arg3), 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_invalid_reveal());
        0x1::vector::push_back<address>(&mut arg0.revealed_reviewers, v0);
        0x1::vector::push_back<u8>(&mut arg0.revealed_votes, arg2);
        if (arg2 == 1) {
            arg0.votes_yes = arg0.votes_yes + 1;
        } else {
            arg0.votes_no = arg0.votes_no + 1;
        };
        arg0.state = 2;
        if (has_majority(arg0) && arg0.challenge_deadline_ms == 0) {
            arg0.challenge_deadline_ms = v1 + timing_window(arg0, 3);
        };
        let v3 = ReviewVoteRevealed{
            dispute_case_id : case_id(arg0),
            reviewer        : v0,
            vote            : arg2,
        };
        0x2::event::emit<ReviewVoteRevealed>(v3);
    }

    fun reviewer_force_deregistered(arg0: &ReviewerRegistry, arg1: address) : bool {
        let v0 = ReviewerForceDeregisteredKey{owner: arg1};
        0x2::dynamic_field::exists_<ReviewerForceDeregisteredKey>(&arg0.id, v0)
    }

    fun reviewer_id(arg0: &ReviewerEntry) : address {
        let v0 = 0x2::object::id<ReviewerEntry>(arg0);
        0x2::object::id_to_address(&v0)
    }

    fun reviewer_meets_stake_threshold(arg0: &ReviewerEntry, arg1: &DisputeQuorumConfig) : bool {
        0x2::balance::value<0x2::sui::SUI>(&arg0.stake_locked) >= arg1.reviewer_min_stake_sui
    }

    fun reviewer_threshold_update_key() : PendingDisputeQuorumReviewerThresholdUpdateKey {
        PendingDisputeQuorumReviewerThresholdUpdateKey{dummy_field: false}
    }

    fun score_inverse_failure_or_neutral(arg0: u64, arg1: u64) : u64 {
        if (arg1 == 0) {
            50
        } else {
            min_u64((arg1 - min_u64(arg0, arg1)) * 100 / arg1, 100)
        }
    }

    fun score_ratio_or_neutral(arg0: u64, arg1: u64) : u64 {
        if (arg1 == 0) {
            50
        } else {
            min_u64(arg0 * 100 / arg1, 100)
        }
    }

    public fun set_dispute_bond_asset_lane_config<T0>(arg0: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::AdminCap, arg1: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::GovernanceConfig, arg2: &mut DisputeQuorumConfig, arg3: bool, arg4: bool, arg5: bool, arg6: bool, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::assert_incident_not_frozen(arg1);
        assert!(arg7 > 0 && arg7 <= arg8, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_invalid_policy());
        assert!(0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::payment_assets::is_supported_dispute_bond_typed_coin_type<T0>(), 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_invalid_policy());
        assert!(arg4, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_invalid_policy());
        let v0 = DisputeBondAssetLaneConfig{
            enabled                      : arg3,
            require_order_currency_match : arg4,
            invite_only_reviewers        : arg5,
            require_exact_min            : arg6,
            min_amount                   : arg7,
            max_amount                   : arg8,
        };
        upsert_dispute_bond_asset_lane_config<T0>(arg2, v0);
        let v1 = 0x2::object::id<DisputeQuorumConfig>(arg2);
        let v2 = DisputeBondAssetLaneConfigChanged{
            config_id        : 0x2::object::id_to_address(&v1),
            actor            : 0x2::tx_context::sender(arg9),
            asset_type_bytes : 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::onchain_asset_lane_manager::exact_type_bytes_for<T0>(),
            flags            : dispute_bond_asset_lane_flags(&v0),
            min_amount       : arg7,
            max_amount       : arg8,
        };
        0x2::event::emit<DisputeBondAssetLaneConfigChanged>(v2);
    }

    public fun set_reviewer_bootstrap_allowlist(arg0: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::AdminCap, arg1: &mut ReviewerRegistry, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.bootstrap_approved_reviewers = arg2;
        let v0 = 0x2::object::id<ReviewerRegistry>(arg1);
        let v1 = ReviewerBootstrapAllowlistChanged{
            registry_id    : 0x2::object::id_to_address(&v0),
            actor          : 0x2::tx_context::sender(arg3),
            approved_count : 0x1::vector::length<address>(&arg1.bootstrap_approved_reviewers),
        };
        0x2::event::emit<ReviewerBootstrapAllowlistChanged>(v1);
    }

    fun set_reviewer_last_activity(arg0: &mut ReviewerRegistry, arg1: address, arg2: u64) {
        let v0 = ReviewerLastActivityKey{owner: arg1};
        if (0x2::dynamic_field::exists_<ReviewerLastActivityKey>(&arg0.id, v0)) {
            0x2::dynamic_field::remove<ReviewerLastActivityKey, u64>(&mut arg0.id, v0);
        };
        0x2::dynamic_field::add<ReviewerLastActivityKey, u64>(&mut arg0.id, v0, arg2);
    }

    public(friend) fun share_milestone_dispute_case(arg0: MilestoneDisputeCase) {
        0x2::transfer::share_object<MilestoneDisputeCase>(arg0);
    }

    fun shared_participant_state_passes_reviewer_thresholds(arg0: &DisputeQuorumConfig, arg1: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::reputation::ReputationFeeConfig, arg2: address) : bool {
        let (v0, v1, v2) = 0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::reputation::best_threshold_summary_for_owner(arg1, arg2);
        threshold_summary_passes_reviewer_thresholds(arg0, v0, v1, v2)
    }

    public fun start_replacement_round(arg0: &mut MilestoneDisputeCase, arg1: &mut ReviewerRegistry, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        start_replacement_round_internal(arg0, arg1, vector[], arg2, arg3);
    }

    fun start_replacement_round_internal(arg0: &mut MilestoneDisputeCase, arg1: &mut ReviewerRegistry, arg2: vector<address>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(v0 == arg0.buyer || v0 == arg0.seller, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_not_authorized());
        assert!(arg0.state != 3 && arg0.state != 4, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_invalid_state());
        assert!(arg0.assignment_round < arg0.max_replacement_rounds, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_replacement_exhausted());
        assert_unique_reviewer_list(&arg2, arg0.buyer, arg0.seller);
        assert_invited_reviewers_not_blocked(arg0, &arg2);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        assert!(v1 < arg0.hard_timeout_ms, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_not_finalizable());
        let v2 = arg0.state == 0;
        if (v2) {
            assert!(v1 > arg0.accept_deadline_ms, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_not_finalizable());
            assert!(0x1::vector::length<address>(&arg0.assigned_reviewers) < arg0.required_reviewer_votes, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_not_finalizable());
        } else {
            assert!(v1 > arg0.reveal_deadline_ms, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_not_finalizable());
            assert!(!has_majority(arg0), 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_not_finalizable());
        };
        if (0x1::vector::length<address>(&arg0.invited_reviewers) > 0) {
            assert!(0x1::vector::length<address>(&arg2) > 0, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_invalid_policy());
        };
        move_assigned_reviewers_to_blocked(arg0, arg1, v2);
        reset_replacement_round_buffers(arg0);
        arg0.invited_reviewers = arg2;
        arg0.assignment_round = arg0.assignment_round + 1;
        if (v2) {
            lower_required_votes_for_scarcity(arg0);
        };
        arg0.state = 0;
        arg0.accept_deadline_ms = v1 + timing_window(arg0, 0);
        let v3 = ReplacementRoundStarted{
            dispute_case_id         : case_id(arg0),
            assignment_round        : arg0.assignment_round,
            required_reviewer_votes : arg0.required_reviewer_votes,
        };
        0x2::event::emit<ReplacementRoundStarted>(v3);
        emit_reviewer_invites(arg0);
    }

    public fun start_replacement_round_with_invites(arg0: &mut MilestoneDisputeCase, arg1: &mut ReviewerRegistry, arg2: vector<address>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<address>(&arg2) > 0, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_invalid_policy());
        start_replacement_round_internal(arg0, arg1, arg2, arg3, arg4);
    }

    fun summarize_case_outcome_for_reviewer(arg0: &MilestoneDisputeCase, arg1: address, arg2: &DisputeQuorumConfig) : (bool, PendingReviewerOutcome) {
        let v0 = empty_pending_reviewer_outcome();
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg0.revealed_reviewers)) {
            if (*0x1::vector::borrow<address>(&arg0.revealed_reviewers, v1) == arg1) {
                let v2 = &mut v0;
                add_revealed_reviewer_outcome(v2, arg0, *0x1::vector::borrow<u8>(&arg0.revealed_votes, v1), arg2);
                return (true, v0)
            };
            v1 = v1 + 1;
        };
        let (v3, v4, v5) = blocked_reviewer_status_for(arg0, arg1);
        if (v3) {
            if (!v4 || v5 == 0) {
                return (true, v0)
            };
            if (v5 == 2) {
                v0.commit_reveal_failures = 1;
                let v6 = &mut v0;
                push_pending_reviewer_slash(v6, arg2.reviewer_invalid_reveal_slash_bps, arg2.platform_fallback_sink);
                return (true, v0)
            };
            if (v5 == 1) {
                v0.noshow_count = 1;
                let v7 = &mut v0;
                push_pending_reviewer_slash(v7, arg2.reviewer_noshow_slash_bps, arg2.platform_fallback_sink);
                return (true, v0)
            };
            let v8 = if (v5 == 4) {
                1
            } else {
                0
            };
            let v9 = &mut v0;
            add_revealed_reviewer_outcome(v9, arg0, v8, arg2);
            return (true, v0)
        };
        if (!contains_address(&arg0.assigned_reviewers, arg1)) {
            return (false, v0)
        };
        if (contains_address(&arg0.committers, arg1)) {
            v0.commit_reveal_failures = 1;
            let v10 = &mut v0;
            push_pending_reviewer_slash(v10, arg2.reviewer_invalid_reveal_slash_bps, arg2.platform_fallback_sink);
        } else {
            v0.noshow_count = 1;
            let v11 = &mut v0;
            push_pending_reviewer_slash(v11, arg2.reviewer_noshow_slash_bps, arg2.platform_fallback_sink);
        };
        (true, v0)
    }

    fun threshold_summary_passes_reviewer_thresholds(arg0: &DisputeQuorumConfig, arg1: u8, arg2: u64, arg3: u64) : bool {
        if (arg1 >= arg0.min_reviewer_level) {
            if (arg2 >= arg0.min_reviewer_score) {
                arg3 >= arg0.min_reviewer_confidence
            } else {
                false
            }
        } else {
            false
        }
    }

    fun timing_update_key() : PendingDisputeQuorumTimingUpdateKey {
        PendingDisputeQuorumTimingUpdateKey{dummy_field: false}
    }

    fun timing_window(arg0: &MilestoneDisputeCase, arg1: u64) : u64 {
        *0x1::vector::borrow<u64>(&arg0.timing_windows_ms, arg1)
    }

    fun transfer_balance_to(arg0: &mut 0x2::balance::Balance<0x2::sui::SUI>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(arg0);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(arg0, v0), arg2), arg1);
        };
        v0
    }

    fun transfer_from_pool<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::balance::value<T0>(arg0);
        let v1 = if (arg1 > v0) {
            v0
        } else {
            arg1
        };
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(arg0, v1), arg3), arg2);
        };
        v1
    }

    fun transfer_typed_balance_to<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::balance::value<T0>(arg0);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(arg0, v0), arg2), arg1);
        };
        v0
    }

    public(friend) fun typed_bond_buyer<T0>(arg0: &OrderDisputeBondTyped<T0>) : address {
        arg0.buyer
    }

    fun typed_bond_id<T0>(arg0: &OrderDisputeBondTyped<T0>) : address {
        let v0 = 0x2::object::id<OrderDisputeBondTyped<T0>>(arg0);
        0x2::object::id_to_address(&v0)
    }

    public(friend) fun typed_bond_order_id<T0>(arg0: &OrderDisputeBondTyped<T0>) : 0x1::string::String {
        arg0.order_id
    }

    public(friend) fun typed_bond_seller<T0>(arg0: &OrderDisputeBondTyped<T0>) : address {
        arg0.seller
    }

    public fun update_reviewer(arg0: &mut ReviewerRegistry, arg1: &mut ReviewerEntry, arg2: &DisputeQuorumConfig, arg3: u8, arg4: vector<u8>, arg5: u64, arg6: bool, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        assert!(v0 == arg1.owner, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_not_authorized());
        let v1 = ReviewerRegisteredKey{owner: v0};
        assert!(0x2::dynamic_field::exists_<ReviewerRegisteredKey>(&arg0.id, v1), 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_reviewer_not_eligible());
        apply_pending_reviewer_outcomes(arg0, arg1, arg8);
        assert_transport_pubkey(&arg4);
        assert!(arg5 > 0, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_invalid_input());
        arg1.transport_type = arg3;
        arg1.transport_pubkey = arg4;
        arg1.min_case_reward_sui = arg5;
        arg1.active = arg6;
        arg1.updated_at_ms = 0x2::clock::timestamp_ms(arg7);
        set_reviewer_last_activity(arg0, v0, arg1.updated_at_ms);
        let v2 = ReviewerUpdated{
            reviewer_entry_id : reviewer_id(arg1),
            owner             : v0,
            active            : arg6,
        };
        0x2::event::emit<ReviewerUpdated>(v2);
    }

    fun upsert_dispute_bond_asset_lane_config<T0>(arg0: &mut DisputeQuorumConfig, arg1: DisputeBondAssetLaneConfig) {
        let v0 = dispute_bond_asset_lane_key<T0>();
        if (0x2::dynamic_field::exists_<DisputeBondAssetLaneKey>(&arg0.id, v0)) {
            0x2::dynamic_field::remove<DisputeBondAssetLaneKey, DisputeBondAssetLaneConfig>(&mut arg0.id, v0);
        };
        0x2::dynamic_field::add<DisputeBondAssetLaneKey, DisputeBondAssetLaneConfig>(&mut arg0.id, v0, arg1);
    }

    fun vote_commit_hash(arg0: address, arg1: address, arg2: u8, arg3: vector<u8>) : vector<u8> {
        let v0 = b"";
        0x1::vector::push_back<u8>(&mut v0, arg2);
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<address>(&arg0));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<address>(&arg1));
        0x1::vector::append<u8>(&mut v0, arg3);
        0x1::hash::sha2_256(v0)
    }

    fun winner_vote(arg0: &MilestoneDisputeCase) : u8 {
        if (arg0.votes_yes >= arg0.required_reviewer_votes / 2 + 1) {
            1
        } else {
            0
        }
    }

    // decompiled from Move bytecode v7
}

