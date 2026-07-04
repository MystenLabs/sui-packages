module 0x351469211bb89243d4124dba8b1ccbafc8ee968c064c6392730213f77235f6ad::referee {
    struct RefereeConfig has copy, drop, store {
        referee_type: u8,
        timeout_ms: u64,
        grace_period_ms: u64,
        base_penalty: u64,
        penalty_per_hour: u64,
        max_penalty: u64,
        penalties_enabled: bool,
        min_response_time_ms: u64,
    }

    struct Dispute has copy, drop, store {
        id: u64,
        raised_by: address,
        against: address,
        violation_type: u8,
        status: u8,
        evidence_hash: vector<u8>,
        state_nonce: u64,
        raised_at: u64,
        response_deadline: u64,
        resolved_at: u64,
        resolution: Resolution,
    }

    struct Resolution has copy, drop, store {
        party_a_amount: u64,
        party_b_amount: u64,
        penalty_deducted: u64,
        reason: u8,
    }

    struct DisputeHistory has copy, drop, store {
        disputes_raised: u64,
        disputes_against: u64,
        disputes_won: u64,
        disputes_lost: u64,
        total_penalties_paid: u64,
        consecutive_timeouts: u64,
    }

    struct CommitteeMember has copy, drop, store {
        address: address,
        weight: u64,
        active: bool,
    }

    struct Committee has drop, store {
        members: vector<CommitteeMember>,
        threshold: u64,
        total_weight: u64,
    }

    struct Vote has copy, drop, store {
        voter: address,
        in_favor_of_a: bool,
        suggested_penalty: u64,
        timestamp: u64,
    }

    struct DisputeCreated has copy, drop {
        id: u64,
        raised_by: address,
        against: address,
        violation_type: u8,
    }

    struct DisputeResolved has copy, drop {
        id: u64,
        status: u8,
        party_a_amount: u64,
        party_b_amount: u64,
        penalty_deducted: u64,
    }

    struct DisputeAutoResolved has copy, drop {
        id: u64,
        awarded_to: address,
        amount: u64,
        penalty: u64,
    }

    public fun add_committee_member(arg0: &mut Committee, arg1: address, arg2: u64) {
        assert!(arg2 > 0, 13906837520122904577);
        let v0 = &arg0.members;
        let v1 = 0;
        while (v1 < 0x1::vector::length<CommitteeMember>(v0)) {
            let v2 = 0x1::vector::borrow<CommitteeMember>(v0, v1);
            let v3 = v2.address == arg1 && v2.active;
            assert!(!v3, 13906837541597741057);
            v1 = v1 + 1;
        };
        let v4 = CommitteeMember{
            address : arg1,
            weight  : arg2,
            active  : true,
        };
        0x1::vector::push_back<CommitteeMember>(&mut arg0.members, v4);
        arg0.total_weight = arg0.total_weight + arg2;
    }

    fun assert_valid_timeout(arg0: u64) {
        assert!(arg0 > 0, 13906835613157425153);
    }

    public fun auto_resolve_timeout(arg0: &mut Dispute, arg1: u64, arg2: u64, arg3: address, arg4: &0x2::clock::Clock) {
        assert!(can_auto_resolve(arg0, arg4), 13906837099216371717);
        arg0.status = 6;
        arg0.resolved_at = 0x2::clock::timestamp_ms(arg4);
        let v0 = safe_penalty(arg2, arg1);
        let v1 = arg1 - v0;
        let (v2, v3) = if (arg0.raised_by == arg3) {
            (v1, 0)
        } else {
            (0, v1)
        };
        arg0.resolution = create_resolution(v2, v3, v0, 4);
        let v4 = DisputeAutoResolved{
            id         : arg0.id,
            awarded_to : arg0.raised_by,
            amount     : v1,
            penalty    : v0,
        };
        0x2::event::emit<DisputeAutoResolved>(v4);
    }

    public fun calculate_graduated_penalty(arg0: &RefereeConfig, arg1: &DisputeHistory, arg2: u64, arg3: &0x2::clock::Clock) : u64 {
        let v0 = if (arg1.consecutive_timeouts > 0) {
            arg1.consecutive_timeouts + 1
        } else {
            1
        };
        let v1 = (((calculate_penalty(arg0, arg2, arg3) as u128) * (v0 as u128)) as u64);
        if (v1 > arg0.max_penalty) {
            arg0.max_penalty
        } else {
            v1
        }
    }

    public fun calculate_penalty(arg0: &RefereeConfig, arg1: u64, arg2: &0x2::clock::Clock) : u64 {
        if (!arg0.penalties_enabled) {
            return 0
        };
        let v0 = time_since_timeout(arg0, arg1, arg2);
        if (v0 == 0) {
            return 0
        };
        let v1 = arg0.base_penalty;
        let v2 = v1;
        if (arg0.penalty_per_hour > 0) {
            v2 = v1 + ((((v0 / 3600000) as u128) * (arg0.penalty_per_hour as u128)) as u64);
        };
        if (v2 > arg0.max_penalty) {
            arg0.max_penalty
        } else {
            v2
        }
    }

    public fun can_auto_resolve(arg0: &Dispute, arg1: &0x2::clock::Clock) : bool {
        if (arg0.status != 1) {
            return false
        };
        0x2::clock::timestamp_ms(arg1) >= arg0.response_deadline
    }

    public fun can_resolve(arg0: &Dispute) : bool {
        arg0.status == 1 || arg0.status == 2
    }

    public fun committee_member_count(arg0: &Committee) : u64 {
        0x1::vector::length<CommitteeMember>(&arg0.members)
    }

    public fun committee_threshold(arg0: &Committee) : u64 {
        arg0.threshold
    }

    public fun committee_total_weight(arg0: &Committee) : u64 {
        arg0.total_weight
    }

    public fun config_base_penalty(arg0: &RefereeConfig) : u64 {
        arg0.base_penalty
    }

    public fun config_grace_period_ms(arg0: &RefereeConfig) : u64 {
        arg0.grace_period_ms
    }

    public fun config_max_penalty(arg0: &RefereeConfig) : u64 {
        arg0.max_penalty
    }

    public fun config_penalties_enabled(arg0: &RefereeConfig) : bool {
        arg0.penalties_enabled
    }

    public fun config_penalty_per_hour(arg0: &RefereeConfig) : u64 {
        arg0.penalty_per_hour
    }

    public fun config_referee_type(arg0: &RefereeConfig) : u8 {
        arg0.referee_type
    }

    public fun config_timeout_ms(arg0: &RefereeConfig) : u64 {
        arg0.timeout_ms
    }

    public fun create_committee(arg0: u64) : Committee {
        Committee{
            members      : 0x1::vector::empty<CommitteeMember>(),
            threshold    : arg0,
            total_weight : 0,
        }
    }

    public fun create_config(arg0: u8, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: bool, arg7: u64) : RefereeConfig {
        assert!(arg0 <= 2, 13906835527258079233);
        assert!(arg1 > 0, 13906835531553046529);
        assert!(arg5 >= arg3, 13906835535848013825);
        RefereeConfig{
            referee_type         : arg0,
            timeout_ms           : arg1,
            grace_period_ms      : arg2,
            base_penalty         : arg3,
            penalty_per_hour     : arg4,
            max_penalty          : arg5,
            penalties_enabled    : arg6,
            min_response_time_ms : arg7,
        }
    }

    public fun create_dispute(arg0: u64, arg1: address, arg2: u8, arg3: vector<u8>, arg4: u64, arg5: &RefereeConfig, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) : Dispute {
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = 0x2::clock::timestamp_ms(arg6);
        let v2 = (v1 as u128) + (arg5.timeout_ms as u128);
        let v3 = if (v2 > 18446744073709551615) {
            18446744073709551615
        } else {
            (v2 as u64)
        };
        let v4 = DisputeCreated{
            id             : arg0,
            raised_by      : v0,
            against        : arg1,
            violation_type : arg2,
        };
        0x2::event::emit<DisputeCreated>(v4);
        Dispute{
            id                : arg0,
            raised_by         : v0,
            against           : arg1,
            violation_type    : arg2,
            status            : 1,
            evidence_hash     : arg3,
            state_nonce       : arg4,
            raised_at         : v1,
            response_deadline : v3,
            resolved_at       : 0,
            resolution        : empty_resolution(),
        }
    }

    public fun create_penalty_config(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : RefereeConfig {
        assert_valid_timeout(arg0);
        assert!(arg3 >= arg1, 13906835724826574849);
        RefereeConfig{
            referee_type         : 0,
            timeout_ms           : arg0,
            grace_period_ms      : 0,
            base_penalty         : arg1,
            penalty_per_hour     : arg2,
            max_penalty          : arg3,
            penalties_enabled    : true,
            min_response_time_ms : 0,
        }
    }

    public fun create_resolution(arg0: u64, arg1: u64, arg2: u64, arg3: u8) : Resolution {
        Resolution{
            party_a_amount   : arg0,
            party_b_amount   : arg1,
            penalty_deducted : arg2,
            reason           : arg3,
        }
    }

    public fun create_timeout_config(arg0: u64) : RefereeConfig {
        assert_valid_timeout(arg0);
        RefereeConfig{
            referee_type         : 0,
            timeout_ms           : arg0,
            grace_period_ms      : 0,
            base_penalty         : 0,
            penalty_per_hour     : 0,
            max_penalty          : 0,
            penalties_enabled    : false,
            min_response_time_ms : 0,
        }
    }

    public fun create_vote(arg0: bool, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) : Vote {
        Vote{
            voter             : 0x2::tx_context::sender(arg3),
            in_favor_of_a     : arg0,
            suggested_penalty : arg1,
            timestamp         : 0x2::clock::timestamp_ms(arg2),
        }
    }

    public fun default_config() : RefereeConfig {
        RefereeConfig{
            referee_type         : 0,
            timeout_ms           : 3600000,
            grace_period_ms      : 0,
            base_penalty         : 0,
            penalty_per_hour     : 0,
            max_penalty          : 0,
            penalties_enabled    : false,
            min_response_time_ms : 0,
        }
    }

    public fun dispute_against(arg0: &Dispute) : address {
        arg0.against
    }

    public fun dispute_evidence_hash(arg0: &Dispute) : &vector<u8> {
        &arg0.evidence_hash
    }

    public fun dispute_id(arg0: &Dispute) : u64 {
        arg0.id
    }

    public fun dispute_raised_at(arg0: &Dispute) : u64 {
        arg0.raised_at
    }

    public fun dispute_raised_by(arg0: &Dispute) : address {
        arg0.raised_by
    }

    public fun dispute_resolution(arg0: &Dispute) : &Resolution {
        &arg0.resolution
    }

    public fun dispute_resolved_at(arg0: &Dispute) : u64 {
        arg0.resolved_at
    }

    public fun dispute_response_deadline(arg0: &Dispute) : u64 {
        arg0.response_deadline
    }

    public fun dispute_state_nonce(arg0: &Dispute) : u64 {
        arg0.state_nonce
    }

    public fun dispute_status(arg0: &Dispute) : u8 {
        arg0.status
    }

    public fun dispute_status_none() : u8 {
        0
    }

    public fun dispute_status_raised() : u8 {
        1
    }

    public fun dispute_status_resolved_a() : u8 {
        3
    }

    public fun dispute_status_resolved_b() : u8 {
        4
    }

    public fun dispute_status_resolved_split() : u8 {
        5
    }

    public fun dispute_status_timed_out() : u8 {
        6
    }

    public fun dispute_status_under_review() : u8 {
        2
    }

    public fun dispute_violation_type(arg0: &Dispute) : u8 {
        arg0.violation_type
    }

    public fun empty_resolution() : Resolution {
        Resolution{
            party_a_amount   : 0,
            party_b_amount   : 0,
            penalty_deducted : 0,
            reason           : 0,
        }
    }

    public fun history_consecutive_timeouts(arg0: &DisputeHistory) : u64 {
        arg0.consecutive_timeouts
    }

    public fun history_disputes_against(arg0: &DisputeHistory) : u64 {
        arg0.disputes_against
    }

    public fun history_disputes_lost(arg0: &DisputeHistory) : u64 {
        arg0.disputes_lost
    }

    public fun history_disputes_raised(arg0: &DisputeHistory) : u64 {
        arg0.disputes_raised
    }

    public fun history_disputes_won(arg0: &DisputeHistory) : u64 {
        arg0.disputes_won
    }

    public fun history_total_penalties_paid(arg0: &DisputeHistory) : u64 {
        arg0.total_penalties_paid
    }

    public fun is_response_too_fast(arg0: &RefereeConfig, arg1: u64, arg2: &0x2::clock::Clock) : bool {
        if (arg0.min_response_time_ms == 0) {
            return false
        };
        let v0 = 0x2::clock::timestamp_ms(arg2);
        if (v0 <= arg1) {
            return true
        };
        v0 - arg1 < arg0.min_response_time_ms
    }

    public fun is_timeout_reached(arg0: &RefereeConfig, arg1: u64, arg2: &0x2::clock::Clock) : bool {
        (0x2::clock::timestamp_ms(arg2) as u128) >= (arg1 as u128) + (arg0.timeout_ms as u128)
    }

    public fun is_timeout_with_grace_reached(arg0: &RefereeConfig, arg1: u64, arg2: &0x2::clock::Clock) : bool {
        (0x2::clock::timestamp_ms(arg2) as u128) >= (arg1 as u128) + (arg0.timeout_ms as u128) + (arg0.grace_period_ms as u128)
    }

    public fun new_dispute_history() : DisputeHistory {
        DisputeHistory{
            disputes_raised      : 0,
            disputes_against     : 0,
            disputes_won         : 0,
            disputes_lost        : 0,
            total_penalties_paid : 0,
            consecutive_timeouts : 0,
        }
    }

    public fun record_dispute_against(arg0: &mut DisputeHistory) {
        arg0.disputes_against = arg0.disputes_against + 1;
    }

    public fun record_dispute_lost(arg0: &mut DisputeHistory, arg1: u64) {
        arg0.disputes_lost = arg0.disputes_lost + 1;
        arg0.total_penalties_paid = arg0.total_penalties_paid + arg1;
    }

    public fun record_dispute_raised(arg0: &mut DisputeHistory) {
        arg0.disputes_raised = arg0.disputes_raised + 1;
    }

    public fun record_dispute_won(arg0: &mut DisputeHistory) {
        arg0.disputes_won = arg0.disputes_won + 1;
        arg0.consecutive_timeouts = 0;
    }

    public fun record_timeout(arg0: &mut DisputeHistory, arg1: u64) {
        arg0.disputes_lost = arg0.disputes_lost + 1;
        arg0.total_penalties_paid = arg0.total_penalties_paid + arg1;
        arg0.consecutive_timeouts = arg0.consecutive_timeouts + 1;
    }

    public fun referee_type_automated() : u8 {
        0
    }

    public fun referee_type_committee() : u8 {
        2
    }

    public fun referee_type_designated() : u8 {
        1
    }

    public fun remove_committee_member(arg0: &mut Committee, arg1: address) {
        let v0 = &arg0.members;
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<CommitteeMember>(v0)) {
            let v3 = 0x1::vector::borrow<CommitteeMember>(v0, v1);
            if (v3.address == arg1 && v3.active) {
                v2 = 0x1::option::some<u64>(v1);
                /* label 10 */
                if (0x1::option::is_some<u64>(&v2)) {
                    let v4 = 0x1::vector::borrow_mut<CommitteeMember>(&mut arg0.members, 0x1::option::destroy_some<u64>(v2));
                    v4.active = false;
                    arg0.total_weight = arg0.total_weight - v4.weight;
                };
                return
            };
            v1 = v1 + 1;
        };
        v2 = 0x1::option::none<u64>();
        /* goto 10 */
    }

    public fun reset_consecutive_timeouts(arg0: &mut DisputeHistory) {
        arg0.consecutive_timeouts = 0;
    }

    public fun resolution_party_a_amount(arg0: &Resolution) : u64 {
        arg0.party_a_amount
    }

    public fun resolution_party_b_amount(arg0: &Resolution) : u64 {
        arg0.party_b_amount
    }

    public fun resolution_penalty_deducted(arg0: &Resolution) : u64 {
        arg0.penalty_deducted
    }

    public fun resolution_reason(arg0: &Resolution) : u8 {
        arg0.reason
    }

    public fun resolve_for_a(arg0: &mut Dispute, arg1: u64, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) {
        assert!(can_resolve(arg0), 13906836811453431811);
        arg0.status = 3;
        arg0.resolved_at = 0x2::clock::timestamp_ms(arg4);
        arg0.resolution = create_resolution(arg1, arg2, arg3, 1);
        let v0 = DisputeResolved{
            id               : arg0.id,
            status           : 3,
            party_a_amount   : arg1,
            party_b_amount   : arg2,
            penalty_deducted : arg3,
        };
        0x2::event::emit<DisputeResolved>(v0);
    }

    public fun resolve_for_b(arg0: &mut Dispute, arg1: u64, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) {
        assert!(can_resolve(arg0), 13906836905942712323);
        arg0.status = 4;
        arg0.resolved_at = 0x2::clock::timestamp_ms(arg4);
        arg0.resolution = create_resolution(arg1, arg2, arg3, 2);
        let v0 = DisputeResolved{
            id               : arg0.id,
            status           : 4,
            party_a_amount   : arg1,
            party_b_amount   : arg2,
            penalty_deducted : arg3,
        };
        0x2::event::emit<DisputeResolved>(v0);
    }

    public fun resolve_split(arg0: &mut Dispute, arg1: u64, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) {
        assert!(can_resolve(arg0), 13906837000431992835);
        arg0.status = 5;
        arg0.resolved_at = 0x2::clock::timestamp_ms(arg4);
        arg0.resolution = create_resolution(arg1, arg2, arg3, 3);
        let v0 = DisputeResolved{
            id               : arg0.id,
            status           : 5,
            party_a_amount   : arg1,
            party_b_amount   : arg2,
            penalty_deducted : arg3,
        };
        0x2::event::emit<DisputeResolved>(v0);
    }

    public fun safe_penalty(arg0: u64, arg1: u64) : u64 {
        if (arg0 > arg1) {
            arg1
        } else {
            arg0
        }
    }

    public fun time_since_timeout(arg0: &RefereeConfig, arg1: u64, arg2: &0x2::clock::Clock) : u64 {
        let v0 = (arg1 as u128) + (arg0.timeout_ms as u128);
        let v1 = (0x2::clock::timestamp_ms(arg2) as u128);
        if (v1 <= v0) {
            0
        } else {
            ((v1 - v0) as u64)
        }
    }

    public fun time_until_timeout(arg0: &RefereeConfig, arg1: u64, arg2: &0x2::clock::Clock) : u64 {
        let v0 = (arg1 as u128) + (arg0.timeout_ms as u128);
        let v1 = (0x2::clock::timestamp_ms(arg2) as u128);
        if (v1 >= v0) {
            0
        } else {
            ((v0 - v1) as u64)
        }
    }

    public fun violation_double_spend() : u8 {
        2
    }

    public fun violation_forgery() : u8 {
        3
    }

    public fun violation_invalid_state() : u8 {
        1
    }

    public fun violation_no_response() : u8 {
        0
    }

    public fun vote_in_favor_of_a(arg0: &Vote) : bool {
        arg0.in_favor_of_a
    }

    public fun vote_suggested_penalty(arg0: &Vote) : u64 {
        arg0.suggested_penalty
    }

    public fun vote_voter(arg0: &Vote) : address {
        arg0.voter
    }

    public fun votes_meet_threshold(arg0: &Committee, arg1: &vector<Vote>, arg2: bool) : bool {
        let v0 = 0;
        let v1 = 0x2::vec_set::empty<address>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<Vote>(arg1)) {
            let v3 = 0x1::vector::borrow<Vote>(arg1, v2);
            if (!0x2::vec_set::contains<address>(&v1, &v3.voter) && v3.in_favor_of_a == arg2) {
                let v4 = 0;
                while (v4 < 0x1::vector::length<CommitteeMember>(&arg0.members)) {
                    let v5 = 0x1::vector::borrow<CommitteeMember>(&arg0.members, v4);
                    if (v5.address == v3.voter && v5.active) {
                        v0 = v0 + v5.weight;
                        0x2::vec_set::insert<address>(&mut v1, v3.voter);
                        break
                    };
                    v4 = v4 + 1;
                };
            };
            v2 = v2 + 1;
        };
        v0 >= arg0.threshold
    }

    public fun would_exceed_deposit(arg0: u64, arg1: u64) : bool {
        arg0 > arg1
    }

    // decompiled from Move bytecode v7
}

