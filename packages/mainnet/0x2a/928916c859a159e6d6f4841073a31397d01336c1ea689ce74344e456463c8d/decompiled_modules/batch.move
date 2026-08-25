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

    public fun amount<T0>(arg0: &BatchOpening<T0>) : u64 {
        arg0.amount
    }

    fun assert_invariant<T0>(arg0: &BatchOpening<T0>) {
        assert!(0x2::balance::value<T0>(&arg0.escrow) == arg0.amount * arg0.slots_remaining, 21);
    }

    public fun batch_claim<T0>(arg0: &mut BatchOpening<T0>, arg1: &0x7669be207f9ac28a34d2cbd45dcfdade11e6fd503ad24e687c180931be9a45e9::registry::Registry, arg2: &mut 0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::reputation::AgentScore, arg3: &0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::FeeConfig, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::assert_version_pkg(arg3);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = 0x2::tx_context::sender(arg5);
        assert!(v0 <= arg0.open_until_ms, 10);
        assert!(arg0.slots_remaining > 0, 11);
        assert!(claims_of<T0>(arg0, v1) < arg0.max_claims_per_agent, 12);
        assert!(v1 != arg0.buyer, 13);
        assert!(0x7669be207f9ac28a34d2cbd45dcfdade11e6fd503ad24e687c180931be9a45e9::registry::is_registered(arg1, v1), 14);
        assert!(0x7669be207f9ac28a34d2cbd45dcfdade11e6fd503ad24e687c180931be9a45e9::registry::is_active(0x7669be207f9ac28a34d2cbd45dcfdade11e6fd503ad24e687c180931be9a45e9::registry::borrow_record(arg1, v1)), 14);
        assert!(0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::reputation::agent(arg2) == v1, 15);
        let v2 = arg0.claim_policy;
        if (v2 != 0) {
            if (v2 == 2) {
                assert!(0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::reputation::meets_min_avg(arg2), 16);
            } else {
                assert!(0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::reputation::meets_proven(arg2), 16);
            };
        };
        assert!(0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::reputation::active_seller_jobs(arg2) < 0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::reputation::active_cap_for_level(arg3, 0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::reputation::effective_seller_level(arg2, arg3)), 18);
        if (arg0.min_seller_level > 0) {
            assert!(0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::reputation::meets_min_seller_level(arg2, arg3, arg0.min_seller_level), 17);
        };
        let v3 = 0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::create_claimed<T0>(arg0.buyer, v1, 0x2::balance::split<T0>(&mut arg0.escrow, arg0.amount), arg0.fee_bps, arg0.spec_hash, v0 + arg0.sla_ms, arg0.review_window_ms, arg0.reject_split_bps, arg3, arg4, arg5);
        if (0x2::table::contains<address, u8>(&arg0.claims_by_agent, v1)) {
            let v4 = 0x2::table::borrow_mut<address, u8>(&mut arg0.claims_by_agent, v1);
            *v4 = *v4 + 1;
        } else {
            0x2::table::add<address, u8>(&mut arg0.claims_by_agent, v1, 1);
        };
        arg0.slots_remaining = arg0.slots_remaining - 1;
        assert_invariant<T0>(arg0);
        0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::reputation::increment_active(arg2, v3, v0);
        let v5 = BatchSlotClaimed{
            batch_id        : 0x2::object::uid_to_inner(&arg0.id),
            job_id          : v3,
            buyer           : arg0.buyer,
            claimer         : v1,
            amount          : arg0.amount,
            slots_remaining : arg0.slots_remaining,
            timestamp_ms    : v0,
        };
        0x2::event::emit<BatchSlotClaimed>(v5);
        v3
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
        assert!(arg1 >= 1 && arg1 <= 0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::config_max_batch_slots(arg10), 0);
        assert!(arg7 <= 2, 1);
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
        let v4 = 0x2::object::uid_to_inner(&v3.id);
        let v5 = BatchOpeningCreated{
            batch_id             : v4,
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
        0x2::event::emit<BatchOpeningCreated>(v5);
        0x2::transfer::share_object<BatchOpening<T0>>(v3);
        v4
    }

    public fun created_at_ms<T0>(arg0: &BatchOpening<T0>) : u64 {
        arg0.created_at_ms
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

