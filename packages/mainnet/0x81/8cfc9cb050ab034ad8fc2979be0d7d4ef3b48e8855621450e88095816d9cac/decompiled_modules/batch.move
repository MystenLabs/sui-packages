module 0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::batch {
    struct BatchOpening<phantom T0> has key {
        id: 0x2::object::UID,
        buyer: address,
        escrow: 0x2::balance::Balance<T0>,
        amount: u64,
        slots_total: u64,
        slots_remaining: u64,
        fee_bps: u64,
        spec_hash: vector<u8>,
        open_until_ms: u64,
        sla_ms: u64,
        review_window_ms: u64,
        reject_split_bps: u64,
        claim_policy: u8,
        min_seller_level: u8,
        max_claims_per_agent: u8,
        claims_by_agent: 0x2::table::Table<address, u8>,
        created_at_ms: u64,
    }

    struct ActiveClaimsSemanticsKey has copy, drop, store {
        dummy_field: bool,
    }

    struct BatchOpeningCreated has copy, drop {
        batch_id: 0x2::object::ID,
        buyer: address,
        amount: u64,
        slots_total: u64,
        fee_bps: u64,
        spec_hash: vector<u8>,
        open_until_ms: u64,
        sla_ms: u64,
        review_window_ms: u64,
        reject_split_bps: u64,
        claim_policy: u8,
        min_seller_level: u8,
        max_claims_per_agent: u8,
        timestamp_ms: u64,
    }

    struct BatchSlotClaimed has copy, drop {
        batch_id: 0x2::object::ID,
        job_id: 0x2::object::ID,
        buyer: address,
        claimer: address,
        amount: u64,
        slots_remaining: u64,
        timestamp_ms: u64,
    }

    struct BatchOpeningCancelled has copy, drop {
        batch_id: 0x2::object::ID,
        buyer: address,
        refunded: u64,
        slots_cancelled: u64,
        timestamp_ms: u64,
    }

    struct BatchOpeningRefunded has copy, drop {
        batch_id: 0x2::object::ID,
        buyer: address,
        refunded: u64,
        slots_refunded: u64,
        timestamp_ms: u64,
    }

    struct BatchSlotHoldReleased has copy, drop {
        batch_id: 0x2::object::ID,
        job_id: 0x2::object::ID,
        agent: address,
        claims_remaining_for_agent: u8,
        timestamp_ms: u64,
    }

    public fun amount<T0>(arg0: &BatchOpening<T0>) : u64 {
        arg0.amount
    }

    fun assert_batch_origin<T0>(arg0: &BatchOpening<T0>, arg1: &0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::Job<T0>) {
        let v0 = 0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::batch_origin<T0>(arg1);
        assert!(0x1::option::is_some<0x2::object::ID>(&v0), 23);
        assert!(0x1::option::extract<0x2::object::ID>(&mut v0) == 0x2::object::uid_to_inner(&arg0.id), 24);
    }

    fun assert_invariant<T0>(arg0: &BatchOpening<T0>) {
        assert!(0x2::balance::value<T0>(&arg0.escrow) == arg0.amount * arg0.slots_remaining, 21);
    }

    public fun batch_claim<T0>(arg0: &mut BatchOpening<T0>, arg1: &0x7669be207f9ac28a34d2cbd45dcfdade11e6fd503ad24e687c180931be9a45e9::registry::Registry, arg2: &mut 0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::reputation::AgentScore, arg3: &0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::FeeConfig, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::assert_version_pkg(arg3);
        assert!(has_active_claims_semantics<T0>(arg0), 22);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = 0x2::tx_context::sender(arg5);
        assert!(v0 <= arg0.open_until_ms, 10);
        assert!(arg0.slots_remaining > 0, 11);
        assert!(v1 != arg0.buyer, 13);
        assert!(0x7669be207f9ac28a34d2cbd45dcfdade11e6fd503ad24e687c180931be9a45e9::registry::is_registered(arg1, v1), 14);
        assert!(0x7669be207f9ac28a34d2cbd45dcfdade11e6fd503ad24e687c180931be9a45e9::registry::is_active(0x7669be207f9ac28a34d2cbd45dcfdade11e6fd503ad24e687c180931be9a45e9::registry::borrow_record(arg1, v1)), 14);
        assert!(0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::reputation::agent(arg2) == v1, 15);
        let v2 = 0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::reputation::active_cap_for_level(arg3, 0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::reputation::effective_seller_level(arg2, arg3));
        assert!((claims_of<T0>(arg0, v1) as u64) < 0x1::u64::min((arg0.max_claims_per_agent as u64), v2), 12);
        let v3 = arg0.claim_policy;
        if (v3 != 0) {
            if (v3 == 2) {
                assert!(0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::reputation::meets_min_avg(arg2), 16);
            } else {
                assert!(0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::reputation::meets_proven(arg2), 16);
            };
        };
        assert!(0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::reputation::active_seller_jobs(arg2) < v2, 18);
        if (arg0.min_seller_level > 0) {
            assert!(0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::reputation::meets_min_seller_level(arg2, arg3, arg0.min_seller_level), 17);
        };
        let v4 = 0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::create_claimed_from_batch<T0>(0x2::object::uid_to_inner(&arg0.id), arg0.buyer, v1, 0x2::balance::split<T0>(&mut arg0.escrow, arg0.amount), arg0.fee_bps, arg0.spec_hash, v0 + arg0.sla_ms, arg0.review_window_ms, arg0.reject_split_bps, arg3, arg4, arg5);
        if (0x2::table::contains<address, u8>(&arg0.claims_by_agent, v1)) {
            let v5 = 0x2::table::borrow_mut<address, u8>(&mut arg0.claims_by_agent, v1);
            *v5 = *v5 + 1;
        } else {
            0x2::table::add<address, u8>(&mut arg0.claims_by_agent, v1, 1);
        };
        arg0.slots_remaining = arg0.slots_remaining - 1;
        assert_invariant<T0>(arg0);
        0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::reputation::increment_active(arg2, v4, v0);
        let v6 = BatchSlotClaimed{
            batch_id        : 0x2::object::uid_to_inner(&arg0.id),
            job_id          : v4,
            buyer           : arg0.buyer,
            claimer         : v1,
            amount          : arg0.amount,
            slots_remaining : arg0.slots_remaining,
            timestamp_ms    : v0,
        };
        0x2::event::emit<BatchSlotClaimed>(v6);
        v4
    }

    public fun batch_refund<T0>(arg0: &mut BatchOpening<T0>, arg1: &mut 0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::Job<T0>, arg2: &mut 0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::reputation::AgentScore, arg3: &0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::FeeConfig, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::assert_version_pkg(arg3);
        assert_batch_origin<T0>(arg0, arg1);
        assert!(0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::reputation::agent(arg2) == 0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::seller<T0>(arg1), 25);
        0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::refund_settle_pkg<T0>(arg1, arg3, arg4, arg5);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = 0x2::object::id<0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::Job<T0>>(arg1);
        0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::reputation::record_no_delivery_pkg(arg2, v1, v0);
        if (0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::is_claimed_job<T0>(arg1) && !0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::is_active_freed<T0>(arg1)) {
            0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::reputation::decrement_active(arg2, v1, v0);
        };
        if (!0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::is_batch_hold_released<T0>(arg1)) {
            free_wave_hold<T0>(arg0, arg1, v0);
        };
    }

    public fun batch_reject<T0>(arg0: &mut BatchOpening<T0>, arg1: &mut 0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::Job<T0>, arg2: &mut 0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::reputation::AgentScore, arg3: &0x7669be207f9ac28a34d2cbd45dcfdade11e6fd503ad24e687c180931be9a45e9::registry::Registry, arg4: &0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::FeeConfig, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::assert_version_pkg(arg4);
        assert_batch_origin<T0>(arg0, arg1);
        assert!(!0x7669be207f9ac28a34d2cbd45dcfdade11e6fd503ad24e687c180931be9a45e9::registry::is_registered(arg3, 0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::buyer<T0>(arg1)), 27);
        assert!(0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::reputation::agent(arg2) == 0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::seller<T0>(arg1), 25);
        0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::reject_settle_pkg<T0>(arg1, arg4, arg5, arg6);
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = 0x2::object::id<0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::Job<T0>>(arg1);
        0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::reputation::record_rejected_after_delivery_pkg(arg2, v1, v0);
        if (0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::is_claimed_job<T0>(arg1) && !0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::is_active_freed<T0>(arg1)) {
            0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::reputation::decrement_active(arg2, v1, v0);
        };
        if (!0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::is_batch_hold_released<T0>(arg1)) {
            free_wave_hold<T0>(arg0, arg1, v0);
        };
    }

    public fun batch_reject_agent_buyer<T0>(arg0: &mut BatchOpening<T0>, arg1: &mut 0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::Job<T0>, arg2: &mut 0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::reputation::AgentScore, arg3: &mut 0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::reputation::AgentScore, arg4: &0x7669be207f9ac28a34d2cbd45dcfdade11e6fd503ad24e687c180931be9a45e9::registry::Registry, arg5: &0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::FeeConfig, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::assert_version_pkg(arg5);
        assert_batch_origin<T0>(arg0, arg1);
        let v0 = 0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::buyer<T0>(arg1);
        assert!(0x7669be207f9ac28a34d2cbd45dcfdade11e6fd503ad24e687c180931be9a45e9::registry::is_registered(arg4, v0), 28);
        assert!(0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::reputation::agent(arg2) == 0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::seller<T0>(arg1), 25);
        assert!(0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::reputation::agent(arg3) == v0, 26);
        0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::reject_settle_pkg<T0>(arg1, arg5, arg6, arg7);
        let v1 = 0x2::clock::timestamp_ms(arg6);
        let v2 = 0x2::object::id<0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::Job<T0>>(arg1);
        0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::reputation::record_rejected_after_delivery_pkg(arg2, v2, v1);
        0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::reputation::record_as_buyer_rejected_pkg(arg3, v2, v1);
        if (0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::is_claimed_job<T0>(arg1) && !0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::is_active_freed<T0>(arg1)) {
            0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::reputation::decrement_active(arg2, v2, v1);
        };
        if (!0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::is_batch_hold_released<T0>(arg1)) {
            free_wave_hold<T0>(arg0, arg1, v1);
        };
    }

    public fun batch_release<T0>(arg0: &mut BatchOpening<T0>, arg1: &mut 0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::Job<T0>, arg2: &mut 0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::reputation::AgentScore, arg3: &0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::FeeConfig, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::assert_version_pkg(arg3);
        assert_batch_origin<T0>(arg0, arg1);
        assert!(0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::reputation::agent(arg2) == 0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::seller<T0>(arg1), 25);
        0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::release_settle_pkg<T0>(arg1, arg3, arg4, arg5);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        if (0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::is_claimed_job<T0>(arg1) && !0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::is_active_freed<T0>(arg1)) {
            0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::reputation::decrement_active(arg2, 0x2::object::id<0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::Job<T0>>(arg1), v0);
        };
        if (!0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::is_batch_hold_released<T0>(arg1)) {
            free_wave_hold<T0>(arg0, arg1, v0);
        };
    }

    public fun buyer<T0>(arg0: &BatchOpening<T0>) : address {
        arg0.buyer
    }

    public fun cancel_batch_open<T0>(arg0: &mut BatchOpening<T0>, arg1: &0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::FeeConfig, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::assert_version_pkg(arg1);
        assert!(0x2::tx_context::sender(arg3) == arg0.buyer, 19);
        let (v0, v1) = drain_remainder<T0>(arg0, arg3);
        let v2 = BatchOpeningCancelled{
            batch_id        : 0x2::object::uid_to_inner(&arg0.id),
            buyer           : arg0.buyer,
            refunded        : v0,
            slots_cancelled : v1,
            timestamp_ms    : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<BatchOpeningCancelled>(v2);
    }

    public fun claim_policy<T0>(arg0: &BatchOpening<T0>) : u8 {
        arg0.claim_policy
    }

    public fun claims_by_agent<T0>(arg0: &BatchOpening<T0>, arg1: address) : u8 {
        claims_of<T0>(arg0, arg1)
    }

    fun claims_of<T0>(arg0: &BatchOpening<T0>, arg1: address) : u8 {
        if (0x2::table::contains<address, u8>(&arg0.claims_by_agent, arg1)) {
            *0x2::table::borrow<address, u8>(&arg0.claims_by_agent, arg1)
        } else {
            0
        }
    }

    public fun create_batch_open<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u8, arg8: u8, arg9: u8, arg10: &0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::FeeConfig, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::assert_version_pkg(arg10);
        assert!(arg7 == 0, 1);
        do_create_batch_open<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12)
    }

    public fun created_at_ms<T0>(arg0: &BatchOpening<T0>) : u64 {
        arg0.created_at_ms
    }

    public fun deliver_v2<T0>(arg0: &mut BatchOpening<T0>, arg1: &mut 0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::Job<T0>, arg2: &mut 0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::reputation::AgentScore, arg3: vector<u8>, arg4: &0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::FeeConfig, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert_batch_origin<T0>(arg0, arg1);
        assert!(0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::reputation::agent(arg2) == 0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::seller<T0>(arg1), 25);
        0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::deliver<T0>(arg1, arg3, arg4, arg5, arg6);
        let v0 = 0x2::clock::timestamp_ms(arg5);
        0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::reputation::on_job_delivered<T0>(arg2, arg1, v0);
        free_wave_hold<T0>(arg0, arg1, v0);
    }

    fun do_create_batch_open<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u8, arg8: u8, arg9: u8, arg10: &0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::FeeConfig, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(arg1 >= 1 && arg1 <= 0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::config_max_batch_slots(arg10), 0);
        assert!(arg8 <= 4, 2);
        assert!(arg9 >= 1, 3);
        let v0 = 0x2::coin::value<T0>(&arg0);
        let v1 = v0 / arg1;
        assert!(v1 > 0 && v1 * arg1 == v0, 4);
        0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::assert_amount_in_bounds_pkg(arg10, v1);
        let v2 = 0x2::clock::timestamp_ms(arg11);
        assert!(arg3 > v2, 5);
        assert!(arg3 <= v2 + 2592000000, 6);
        assert!(arg4 > 0 && arg4 <= 0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::max_deliver_horizon_ms_pkg(), 7);
        assert!(arg5 <= 0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::max_review_window_ms_pkg(), 8);
        assert!(arg6 == 0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::bps_denominator_pkg(), 9);
        let v3 = BatchOpening<T0>{
            id                   : 0x2::object::new(arg12),
            buyer                : 0x2::tx_context::sender(arg12),
            escrow               : 0x2::coin::into_balance<T0>(arg0),
            amount               : v1,
            slots_total          : arg1,
            slots_remaining      : arg1,
            fee_bps              : 0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::config_fee_bps(arg10),
            spec_hash            : arg2,
            open_until_ms        : arg3,
            sla_ms               : arg4,
            review_window_ms     : arg5,
            reject_split_bps     : arg6,
            claim_policy         : arg7,
            min_seller_level     : arg8,
            max_claims_per_agent : arg9,
            claims_by_agent      : 0x2::table::new<address, u8>(arg12),
            created_at_ms        : v2,
        };
        let v4 = ActiveClaimsSemanticsKey{dummy_field: false};
        0x2::dynamic_field::add<ActiveClaimsSemanticsKey, bool>(&mut v3.id, v4, true);
        let v5 = 0x2::object::uid_to_inner(&v3.id);
        let v6 = BatchOpeningCreated{
            batch_id             : v5,
            buyer                : v3.buyer,
            amount               : v1,
            slots_total          : arg1,
            fee_bps              : v3.fee_bps,
            spec_hash            : v3.spec_hash,
            open_until_ms        : arg3,
            sla_ms               : arg4,
            review_window_ms     : arg5,
            reject_split_bps     : arg6,
            claim_policy         : arg7,
            min_seller_level     : arg8,
            max_claims_per_agent : arg9,
            timestamp_ms         : v2,
        };
        0x2::event::emit<BatchOpeningCreated>(v6);
        0x2::transfer::share_object<BatchOpening<T0>>(v3);
        v5
    }

    fun drain_remainder<T0>(arg0: &mut BatchOpening<T0>, arg1: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        let v0 = arg0.slots_remaining;
        assert!(v0 > 0, 11);
        arg0.slots_remaining = 0;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.escrow), arg1), arg0.buyer);
        assert_invariant<T0>(arg0);
        (0x2::balance::value<T0>(&arg0.escrow), v0)
    }

    public fun escrow_value<T0>(arg0: &BatchOpening<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.escrow)
    }

    public fun fee_bps<T0>(arg0: &BatchOpening<T0>) : u64 {
        arg0.fee_bps
    }

    fun free_wave_hold<T0>(arg0: &mut BatchOpening<T0>, arg1: &mut 0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::Job<T0>, arg2: u64) {
        0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::mark_batch_hold_released_pkg<T0>(arg1);
        let v0 = 0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::seller<T0>(arg1);
        let v1 = if (0x2::table::contains<address, u8>(&arg0.claims_by_agent, v0)) {
            let v2 = 0x2::table::remove<address, u8>(&mut arg0.claims_by_agent, v0);
            if (v2 > 1) {
                0x2::table::add<address, u8>(&mut arg0.claims_by_agent, v0, v2 - 1);
                v2 - 1
            } else {
                0
            }
        } else {
            0
        };
        let v3 = BatchSlotHoldReleased{
            batch_id                   : 0x2::object::uid_to_inner(&arg0.id),
            job_id                     : 0x2::object::id<0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::Job<T0>>(arg1),
            agent                      : v0,
            claims_remaining_for_agent : v1,
            timestamp_ms               : arg2,
        };
        0x2::event::emit<BatchSlotHoldReleased>(v3);
    }

    public fun has_active_claims_semantics<T0>(arg0: &BatchOpening<T0>) : bool {
        let v0 = ActiveClaimsSemanticsKey{dummy_field: false};
        0x2::dynamic_field::exists<ActiveClaimsSemanticsKey>(&arg0.id, v0)
    }

    public fun max_claims_per_agent<T0>(arg0: &BatchOpening<T0>) : u8 {
        arg0.max_claims_per_agent
    }

    public fun min_seller_level<T0>(arg0: &BatchOpening<T0>) : u8 {
        arg0.min_seller_level
    }

    public fun open_until_ms<T0>(arg0: &BatchOpening<T0>) : u64 {
        arg0.open_until_ms
    }

    public fun refund_batch_expired<T0>(arg0: &mut BatchOpening<T0>, arg1: &0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::FeeConfig, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::assert_version_pkg(arg1);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 > arg0.open_until_ms, 20);
        let (v1, v2) = drain_remainder<T0>(arg0, arg3);
        let v3 = BatchOpeningRefunded{
            batch_id       : 0x2::object::uid_to_inner(&arg0.id),
            buyer          : arg0.buyer,
            refunded       : v1,
            slots_refunded : v2,
            timestamp_ms   : v0,
        };
        0x2::event::emit<BatchOpeningRefunded>(v3);
    }

    public fun reject_split_bps<T0>(arg0: &BatchOpening<T0>) : u64 {
        arg0.reject_split_bps
    }

    public fun review_window_ms<T0>(arg0: &BatchOpening<T0>) : u64 {
        arg0.review_window_ms
    }

    public fun sla_ms<T0>(arg0: &BatchOpening<T0>) : u64 {
        arg0.sla_ms
    }

    public fun slots_remaining<T0>(arg0: &BatchOpening<T0>) : u64 {
        arg0.slots_remaining
    }

    public fun slots_total<T0>(arg0: &BatchOpening<T0>) : u64 {
        arg0.slots_total
    }

    public fun spec_hash<T0>(arg0: &BatchOpening<T0>) : vector<u8> {
        arg0.spec_hash
    }

    // decompiled from Move bytecode v7
}

