module 0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::arbiter {
    struct ArbitrationCourt has store, key {
        id: 0x2::object::UID,
        arbitrators: 0x2::table::Table<address, ArbitratorRecord>,
        arbitrator_count: u64,
        total_staked: u64,
        config: 0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::types::CourtConfig,
        collected_fees: 0x2::balance::Balance<0x2::sui::SUI>,
        total_disputes: u64,
        total_resolved: u64,
        created_at: u64,
    }

    struct ArbitratorRecord has store {
        stake: 0x2::balance::Balance<0x2::sui::SUI>,
        reputation: u64,
        cases_handled: u64,
        accuracy_score: u64,
        active_cases: u64,
        specializations: vector<0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::types::Specialization>,
        joined_at: u64,
        active: bool,
    }

    struct Dispute has store, key {
        id: 0x2::object::UID,
        court_id: 0x2::object::ID,
        claimant: address,
        respondent: address,
        dispute_type: u8,
        related_object: 0x1::option::Option<0x2::object::ID>,
        claim_amount: u64,
        description: vector<u8>,
        claimant_evidence: vector<0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::types::Evidence>,
        respondent_evidence: vector<0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::types::Evidence>,
        escrow: 0x2::balance::Balance<0x2::sui::SUI>,
        assigned_arbitrators: vector<address>,
        required_consensus: u8,
        votes: 0x2::table::Table<address, 0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::types::ArbitratorVote>,
        votes_cast: u64,
        evidence_deadline: u64,
        deliberation_deadline: u64,
        appeal_deadline: u64,
        ruling: 0x1::option::Option<0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::types::Ruling>,
        status: u8,
        filed_at: u64,
    }

    struct CourtAdminCap has store, key {
        id: 0x2::object::UID,
        court_id: 0x2::object::ID,
    }

    public fun add_arbitrator_stake(arg0: &mut ArbitrationCourt, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::table::contains<address, ArbitratorRecord>(&arg0.arbitrators, v0), 0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::errors::not_arbitrator());
        let v1 = 0x2::table::borrow_mut<address, ArbitratorRecord>(&mut arg0.arbitrators, v0);
        let v2 = 0x2::balance::value<0x2::sui::SUI>(&v1.stake);
        let v3 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        0x2::balance::join<0x2::sui::SUI>(&mut v1.stake, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        arg0.total_staked = arg0.total_staked + v3;
        0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::events::emit_arbitrator_stake_updated(0x2::object::id<ArbitrationCourt>(arg0), v0, v2, v2 + v3, 0x2::clock::timestamp_ms(arg2));
    }

    public fun appeal_ruling(arg0: &mut ArbitrationCourt, arg1: &mut Dispute, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = 0x2::tx_context::sender(arg4);
        assert!(arg1.court_id == 0x2::object::id<ArbitrationCourt>(arg0), 0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::errors::not_found());
        assert!(0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::types::is_dispute_ruled(arg1.status), 0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::errors::invalid_status());
        assert!(v0 < arg1.appeal_deadline, 0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::errors::appeal_period_over());
        assert!(v1 == arg1.claimant || v1 == arg1.respondent, 0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::errors::not_party_to_dispute());
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= 0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::types::config_appeal_fee(&arg0.config), 0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::errors::insufficient_appeal_fee());
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.collected_fees, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        arg1.status = 0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::types::dispute_status_appealed();
        0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::events::emit_dispute_appealed(0x2::object::id<ArbitrationCourt>(arg0), 0x2::object::id<Dispute>(arg1), v1, 0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::types::config_appeal_fee(&arg0.config), v0);
    }

    public fun arbitrator_count(arg0: &ArbitrationCourt) : u64 {
        arg0.arbitrator_count
    }

    public fun assign_arbitrators(arg0: &mut ArbitrationCourt, arg1: &mut Dispute, arg2: vector<address>, arg3: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(arg1.court_id == 0x2::object::id<ArbitrationCourt>(arg0), 0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::errors::not_found());
        assert!(v0 >= arg1.evidence_deadline, 0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::errors::evidence_period_not_started());
        assert!(0x1::vector::is_empty<address>(&arg1.assigned_arbitrators), 0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::errors::already_completed());
        let v1 = 0x1::vector::length<address>(&arg2);
        assert!(v1 >= (0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::types::config_min_arbitrators(&arg0.config) as u64), 0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::errors::length_mismatch());
        let v2 = 0;
        while (v2 < v1) {
            let v3 = *0x1::vector::borrow<address>(&arg2, v2);
            assert!(0x2::table::contains<address, ArbitratorRecord>(&arg0.arbitrators, v3), 0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::errors::not_arbitrator());
            let v4 = 0x2::table::borrow_mut<address, ArbitratorRecord>(&mut arg0.arbitrators, v3);
            assert!(v4.active, 0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::errors::arbitrator_suspended());
            assert!(v4.reputation >= 0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::types::min_reputation(), 0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::errors::reputation_too_low());
            assert!(v3 != arg1.claimant && v3 != arg1.respondent, 0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::errors::conflict_of_interest());
            v4.active_cases = v4.active_cases + 1;
            0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::events::emit_arbitrator_assigned(0x2::object::id<ArbitrationCourt>(arg0), 0x2::object::id<Dispute>(arg1), v3, v0);
            v2 = v2 + 1;
        };
        arg1.assigned_arbitrators = arg2;
        arg1.required_consensus = ((v1 * 2 / 3) as u8) + 1;
        arg1.status = 0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::types::dispute_status_deliberation();
        0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::events::emit_dispute_deliberation_started(0x2::object::id<ArbitrationCourt>(arg0), 0x2::object::id<Dispute>(arg1), arg1.deliberation_deadline, v1, v0);
    }

    public fun create_court(arg0: 0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::types::CourtConfig, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : (ArbitrationCourt, CourtAdminCap) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = ArbitrationCourt{
            id               : 0x2::object::new(arg2),
            arbitrators      : 0x2::table::new<address, ArbitratorRecord>(arg2),
            arbitrator_count : 0,
            total_staked     : 0,
            config           : arg0,
            collected_fees   : 0x2::balance::zero<0x2::sui::SUI>(),
            total_disputes   : 0,
            total_resolved   : 0,
            created_at       : v0,
        };
        let v2 = 0x2::object::id<ArbitrationCourt>(&v1);
        0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::events::emit_court_created(v2, 0x2::tx_context::sender(arg2), 0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::types::config_dispute_fee(&arg0), 0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::types::config_min_stake(&arg0), v0);
        let v3 = CourtAdminCap{
            id       : 0x2::object::new(arg2),
            court_id : v2,
        };
        (v1, v3)
    }

    public fun dispute_claim_amount(arg0: &Dispute) : u64 {
        arg0.claim_amount
    }

    public fun dispute_parties(arg0: &Dispute) : (address, address) {
        (arg0.claimant, arg0.respondent)
    }

    public fun dispute_status(arg0: &Dispute) : u8 {
        arg0.status
    }

    public fun file_dispute(arg0: &mut ArbitrationCourt, arg1: address, arg2: u8, arg3: 0x1::option::Option<0x2::object::ID>, arg4: u64, arg5: vector<u8>, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : Dispute {
        let v0 = 0x2::clock::timestamp_ms(arg8);
        let v1 = 0x2::tx_context::sender(arg9);
        assert!(v1 != arg1, 0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::errors::cannot_dispute_self());
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg6) >= 0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::types::config_dispute_fee(&arg0.config), 0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::errors::fee_not_paid());
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.collected_fees, 0x2::coin::into_balance<0x2::sui::SUI>(arg6));
        let v2 = 0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::types::config_evidence_period(&arg0.config);
        0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::types::config_appeal_period(&arg0.config);
        let v3 = Dispute{
            id                    : 0x2::object::new(arg9),
            court_id              : 0x2::object::id<ArbitrationCourt>(arg0),
            claimant              : v1,
            respondent            : arg1,
            dispute_type          : arg2,
            related_object        : arg3,
            claim_amount          : arg4,
            description           : arg5,
            claimant_evidence     : 0x1::vector::empty<0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::types::Evidence>(),
            respondent_evidence   : 0x1::vector::empty<0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::types::Evidence>(),
            escrow                : 0x2::coin::into_balance<0x2::sui::SUI>(arg7),
            assigned_arbitrators  : 0x1::vector::empty<address>(),
            required_consensus    : 2,
            votes                 : 0x2::table::new<address, 0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::types::ArbitratorVote>(arg9),
            votes_cast            : 0,
            evidence_deadline     : v0 + v2,
            deliberation_deadline : v0 + v2 + 0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::types::config_deliberation_period(&arg0.config),
            appeal_deadline       : 0,
            ruling                : 0x1::option::none<0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::types::Ruling>(),
            status                : 0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::types::dispute_status_filed(),
            filed_at              : v0,
        };
        arg0.total_disputes = arg0.total_disputes + 1;
        0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::events::emit_dispute_filed(0x2::object::id<ArbitrationCourt>(arg0), 0x2::object::id<Dispute>(&v3), v1, arg1, arg2, arg4, v0);
        v3
    }

    public fun finalize_dispute(arg0: &mut ArbitrationCourt, arg1: &mut Dispute, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(arg1.court_id == 0x2::object::id<ArbitrationCourt>(arg0), 0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::errors::not_found());
        assert!(0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::types::is_dispute_ruled(arg1.status), 0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::errors::invalid_status());
        assert!(v0 >= arg1.appeal_deadline, 0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::errors::appeal_period_not_over());
        let v1 = 0x1::option::borrow<0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::types::Ruling>(&arg1.ruling);
        let v2 = 0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::types::ruling_decision(v1);
        let v3 = 0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::types::ruling_award_amount(v1);
        arg1.status = 0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::types::dispute_status_final();
        arg0.total_resolved = arg0.total_resolved + 1;
        let v4 = 0;
        while (v4 < 0x1::vector::length<address>(&arg1.assigned_arbitrators)) {
            let v5 = *0x1::vector::borrow<address>(&arg1.assigned_arbitrators, v4);
            if (0x2::table::contains<address, 0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::types::ArbitratorVote>(&arg1.votes, v5)) {
                let v6 = 0x2::table::borrow_mut<address, ArbitratorRecord>(&mut arg0.arbitrators, v5);
                if (0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::types::vote_decision(0x2::table::borrow<address, 0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::types::ArbitratorVote>(&arg1.votes, v5)) == v2) {
                    let v7 = if (v6.reputation + 10 > 1000) {
                        1000
                    } else {
                        v6.reputation + 10
                    };
                    v6.reputation = v7;
                    let v8 = if (v6.accuracy_score + 1 > 100) {
                        100
                    } else {
                        v6.accuracy_score + 1
                    };
                    v6.accuracy_score = v8;
                } else {
                    let v9 = if (v6.reputation < 15) {
                        0
                    } else {
                        v6.reputation - 15
                    };
                    v6.reputation = v9;
                    let v10 = if (v6.accuracy_score < 1) {
                        0
                    } else {
                        v6.accuracy_score - 1
                    };
                    v6.accuracy_score = v10;
                };
                0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::events::emit_arbitrator_reputation_updated(0x2::object::id<ArbitrationCourt>(arg0), v5, v6.reputation, v6.reputation, v0);
            };
            v4 = v4 + 1;
        };
        let v11 = 0x2::balance::value<0x2::sui::SUI>(&arg1.escrow);
        let v12 = if (v2 == 0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::types::decision_claimant_wins()) {
            if (v3 > v11) {
                v11
            } else {
                v3
            }
        } else if (v2 == 0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::types::decision_respondent_wins()) {
            0
        } else {
            v11 / 2
        };
        let v13 = if (v12 > 0) {
            0x2::coin::take<0x2::sui::SUI>(&mut arg1.escrow, v12, arg3)
        } else {
            0x2::coin::zero<0x2::sui::SUI>(arg3)
        };
        let v14 = if (v2 == 0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::types::decision_claimant_wins()) {
            arg1.claimant
        } else {
            arg1.respondent
        };
        0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::events::emit_dispute_finalized(0x2::object::id<ArbitrationCourt>(arg0), 0x2::object::id<Dispute>(arg1), v2, v12, v0);
        if (v12 > 0) {
            0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::events::emit_award_paid(0x2::object::id<ArbitrationCourt>(arg0), 0x2::object::id<Dispute>(arg1), v14, v12, v0);
        };
        v13
    }

    public fun get_ruling_decision(arg0: &Dispute) : 0x1::option::Option<u8> {
        if (0x1::option::is_some<0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::types::Ruling>(&arg0.ruling)) {
            0x1::option::some<u8>(0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::types::ruling_decision(0x1::option::borrow<0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::types::Ruling>(&arg0.ruling)))
        } else {
            0x1::option::none<u8>()
        }
    }

    public fun has_ruling(arg0: &Dispute) : bool {
        0x1::option::is_some<0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::types::Ruling>(&arg0.ruling)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public fun is_arbitrator(arg0: &ArbitrationCourt, arg1: address) : bool {
        0x2::table::contains<address, ArbitratorRecord>(&arg0.arbitrators, arg1)
    }

    public fun issue_ruling(arg0: &mut ArbitrationCourt, arg1: &mut Dispute, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(arg1.court_id == 0x2::object::id<ArbitrationCourt>(arg0), 0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::errors::not_found());
        assert!(0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::types::is_dispute_in_deliberation(arg1.status), 0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::errors::invalid_status());
        assert!(arg1.votes_cast >= (arg1.required_consensus as u64), 0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::errors::consensus_not_reached());
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        let v4 = 0x1::vector::length<address>(&arg1.assigned_arbitrators);
        let v5 = 0;
        while (v5 < v4) {
            let v6 = *0x1::vector::borrow<address>(&arg1.assigned_arbitrators, v5);
            if (0x2::table::contains<address, 0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::types::ArbitratorVote>(&arg1.votes, v6)) {
                let v7 = 0x2::table::borrow<address, 0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::types::ArbitratorVote>(&arg1.votes, v6);
                let v8 = 0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::types::vote_decision(v7);
                if (v8 == 0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::types::decision_claimant_wins()) {
                    v1 = v1 + 1;
                    v3 = v3 + 0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::types::vote_award_amount(v7);
                } else if (v8 == 0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::types::decision_respondent_wins()) {
                    v2 = v2 + 1;
                };
            };
            v5 = v5 + 1;
        };
        let (v9, v10) = if (v1 > v2) {
            (0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::types::decision_claimant_wins(), v3 / v1)
        } else if (v2 > v1) {
            (0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::types::decision_respondent_wins(), 0)
        } else {
            (0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::types::decision_split(), arg1.claim_amount / 2)
        };
        arg1.ruling = 0x1::option::some<0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::types::Ruling>(0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::types::new_ruling(v9, v10, 0x1::vector::empty<0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::types::ArbitratorVote>(), 0x1::vector::empty<u8>(), v0));
        arg1.status = 0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::types::dispute_status_ruled();
        arg1.appeal_deadline = v0 + 0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::types::config_appeal_period(&arg0.config);
        let v11 = 0;
        while (v11 < v4) {
            let v12 = 0x2::table::borrow_mut<address, ArbitratorRecord>(&mut arg0.arbitrators, *0x1::vector::borrow<address>(&arg1.assigned_arbitrators, v11));
            v12.cases_handled = v12.cases_handled + 1;
            v12.active_cases = v12.active_cases - 1;
            v11 = v11 + 1;
        };
        0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::events::emit_ruling_issued(0x2::object::id<ArbitrationCourt>(arg0), 0x2::object::id<Dispute>(arg1), v9, v10, v1, v2, v0);
    }

    public fun join_as_arbitrator(arg0: &mut ArbitrationCourt, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(!0x2::table::contains<address, ArbitratorRecord>(&arg0.arbitrators, v1), 0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::errors::already_arbitrator());
        assert!(v2 >= 0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::types::config_min_stake(&arg0.config), 0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::errors::insufficient_arbitrator_stake());
        let v3 = ArbitratorRecord{
            stake           : 0x2::coin::into_balance<0x2::sui::SUI>(arg1),
            reputation      : 0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::types::starting_reputation(),
            cases_handled   : 0,
            accuracy_score  : 100,
            active_cases    : 0,
            specializations : 0x1::vector::empty<0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::types::Specialization>(),
            joined_at       : v0,
            active          : true,
        };
        0x2::table::add<address, ArbitratorRecord>(&mut arg0.arbitrators, v1, v3);
        arg0.arbitrator_count = arg0.arbitrator_count + 1;
        arg0.total_staked = arg0.total_staked + v2;
        0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::events::emit_arbitrator_joined(0x2::object::id<ArbitrationCourt>(arg0), v1, v2, v0);
    }

    public fun leave_as_arbitrator(arg0: &mut ArbitrationCourt, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, ArbitratorRecord>(&arg0.arbitrators, v0), 0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::errors::not_arbitrator());
        assert!(0x2::table::borrow<address, ArbitratorRecord>(&arg0.arbitrators, v0).active_cases == 0, 0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::errors::arbitrator_has_active_cases());
        let ArbitratorRecord {
            stake           : v1,
            reputation      : _,
            cases_handled   : _,
            accuracy_score  : _,
            active_cases    : _,
            specializations : _,
            joined_at       : _,
            active          : _,
        } = 0x2::table::remove<address, ArbitratorRecord>(&mut arg0.arbitrators, v0);
        let v9 = v1;
        let v10 = 0x2::balance::value<0x2::sui::SUI>(&v9);
        arg0.arbitrator_count = arg0.arbitrator_count - 1;
        arg0.total_staked = arg0.total_staked - v10;
        0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::events::emit_arbitrator_left(0x2::object::id<ArbitrationCourt>(arg0), v0, v10, 0x2::clock::timestamp_ms(arg1));
        0x2::coin::from_balance<0x2::sui::SUI>(v9, arg2)
    }

    public fun select_arbitrators_deterministic(arg0: &ArbitrationCourt, arg1: &Dispute, arg2: &vector<address>, arg3: u64) : vector<address> {
        let v0 = 0x1::vector::length<address>(arg2);
        assert!(v0 >= arg3, 0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::errors::length_mismatch());
        assert!(arg3 >= (0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::types::config_min_arbitrators(&arg0.config) as u64), 0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::errors::length_mismatch());
        let v1 = 0x2::object::id_bytes<Dispute>(arg1);
        let v2 = 0x1::vector::length<u8>(&v1);
        let v3 = 0x1::vector::empty<address>();
        let v4 = 0;
        while (v4 < v0) {
            let v5 = *0x1::vector::borrow<address>(arg2, v4);
            if (0x2::table::contains<address, ArbitratorRecord>(&arg0.arbitrators, v5)) {
                let v6 = 0x2::table::borrow<address, ArbitratorRecord>(&arg0.arbitrators, v5);
                let v7 = if (v6.active) {
                    if (v6.reputation >= 0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::types::min_reputation()) {
                        if (v5 != arg1.claimant) {
                            v5 != arg1.respondent
                        } else {
                            false
                        }
                    } else {
                        false
                    }
                } else {
                    false
                };
                if (v7) {
                    0x1::vector::push_back<address>(&mut v3, v5);
                };
            };
            v4 = v4 + 1;
        };
        let v8 = 0x1::vector::length<address>(&v3);
        assert!(v8 >= arg3, 0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::errors::length_mismatch());
        let v9 = 0x1::vector::empty<address>();
        let v10 = 0;
        let v11 = 0;
        while (v11 < arg3) {
            let v12 = (*0x1::vector::borrow<u8>(&v1, v10 % v2) as u64) << 8 | (*0x1::vector::borrow<u8>(&v1, (v10 + 1) % v2) as u64);
            v10 = v10 + 2;
            0x1::vector::swap<address>(&mut v3, v11, v11 + v12 % (v8 - v11));
            0x1::vector::push_back<address>(&mut v9, *0x1::vector::borrow<address>(&v3, v11));
            v11 = v11 + 1;
        };
        v9
    }

    public fun submit_evidence(arg0: &mut Dispute, arg1: u8, arg2: vector<u8>, arg3: vector<u8>, arg4: bool, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = 0x2::tx_context::sender(arg6);
        assert!(v1 == arg0.claimant || v1 == arg0.respondent, 0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::errors::not_party_to_dispute());
        assert!(0x1::vector::length<u8>(&arg2) == 32, 0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::errors::invalid_hash_length());
        assert!(v0 < arg0.evidence_deadline, 0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::errors::evidence_period_ended());
        if (v1 == arg0.claimant) {
            assert!(0x1::vector::length<0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::types::Evidence>(&arg0.claimant_evidence) < 0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::types::max_evidence_items(), 0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::errors::evidence_limit_reached());
            0x1::vector::push_back<0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::types::Evidence>(&mut arg0.claimant_evidence, 0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::types::new_evidence(v1, arg1, arg2, arg3, v0, arg4));
        } else {
            assert!(0x1::vector::length<0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::types::Evidence>(&arg0.respondent_evidence) < 0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::types::max_evidence_items(), 0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::errors::evidence_limit_reached());
            0x1::vector::push_back<0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::types::Evidence>(&mut arg0.respondent_evidence, 0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::types::new_evidence(v1, arg1, arg2, arg3, v0, arg4));
        };
        if (0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::types::is_dispute_filed(arg0.status)) {
            arg0.status = 0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::types::dispute_status_evidence();
            0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::events::emit_dispute_evidence_phase_started(arg0.court_id, 0x2::object::id<Dispute>(arg0), arg0.evidence_deadline, v0);
        };
        0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::events::emit_evidence_submitted(arg0.court_id, 0x2::object::id<Dispute>(arg0), v1, arg1, arg2, v0);
    }

    public fun submit_vote(arg0: &mut ArbitrationCourt, arg1: &mut Dispute, arg2: u8, arg3: u64, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = 0x2::tx_context::sender(arg6);
        assert!(arg1.court_id == 0x2::object::id<ArbitrationCourt>(arg0), 0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::errors::not_found());
        assert!(0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::types::is_dispute_in_deliberation(arg1.status), 0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::errors::invalid_status());
        assert!(v0 < arg1.deliberation_deadline, 0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::errors::voting_period_ended());
        assert!(0x1::vector::contains<address>(&arg1.assigned_arbitrators, &v1), 0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::errors::not_assigned_to_case());
        assert!(!0x2::table::contains<address, 0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::types::ArbitratorVote>(&arg1.votes, v1), 0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::errors::already_voted_on_ruling());
        0x2::table::add<address, 0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::types::ArbitratorVote>(&mut arg1.votes, v1, 0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::types::new_arbitrator_vote(v1, arg2, arg3, arg4, v0));
        arg1.votes_cast = arg1.votes_cast + 1;
        0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::events::emit_arbitrator_voted(0x2::object::id<ArbitrationCourt>(arg0), 0x2::object::id<Dispute>(arg1), v1, arg2, arg3, v0);
    }

    public fun total_disputes(arg0: &ArbitrationCourt) : u64 {
        arg0.total_disputes
    }

    public fun total_resolved(arg0: &ArbitrationCourt) : u64 {
        arg0.total_resolved
    }

    public fun total_staked(arg0: &ArbitrationCourt) : u64 {
        arg0.total_staked
    }

    public fun update_court_config(arg0: &mut ArbitrationCourt, arg1: &CourtAdminCap, arg2: 0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::types::CourtConfig, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(arg1.court_id == 0x2::object::id<ArbitrationCourt>(arg0), 0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::errors::not_authorized());
        arg0.config = arg2;
        0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::events::emit_court_parameters_updated(0x2::object::id<ArbitrationCourt>(arg0), 0x2::tx_context::sender(arg4), 0x2::clock::timestamp_ms(arg3));
    }

    // decompiled from Move bytecode v6
}

