module 0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::reputation {
    struct ScoreBoard has key {
        id: 0x2::object::UID,
    }

    struct AgentScore has key {
        id: 0x2::object::UID,
        agent: address,
        review_count: u64,
        stars_sum: u64,
        job_stars: 0x2::table::Table<0x2::object::ID, u8>,
        created_at_ms: u64,
        updated_at_ms: u64,
    }

    struct DistinctCountKey has copy, drop, store {
        dummy_field: bool,
    }

    struct BuyerSeenKey has copy, drop, store {
        buyer: address,
    }

    struct RejectedAfterDeliveryKey has copy, drop, store {
        dummy_field: bool,
    }

    struct NoDeliveryKey has copy, drop, store {
        dummy_field: bool,
    }

    struct AsBuyerRejectedKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ActiveSellerJobsKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ScoreBoardCreated has copy, drop {
        board_id: 0x2::object::ID,
        timestamp_ms: u64,
    }

    struct ScoreCreated has copy, drop {
        score_id: 0x2::object::ID,
        agent: address,
        timestamp_ms: u64,
    }

    struct ReviewSubmitted has copy, drop {
        score_id: 0x2::object::ID,
        agent: address,
        job_id: 0x2::object::ID,
        buyer: address,
        stars: u8,
        previous_stars: u8,
        review_count: u64,
        stars_sum: u64,
        timestamp_ms: u64,
    }

    struct ReviewSubmittedV2 has copy, drop {
        score_id: 0x2::object::ID,
        agent: address,
        job_id: 0x2::object::ID,
        buyer: address,
        stars: u8,
        previous_stars: u8,
        review_count: u64,
        stars_sum: u64,
        distinct_buyers: u64,
        timestamp_ms: u64,
    }

    struct OutcomeRecorded has copy, drop {
        score_id: 0x2::object::ID,
        agent: address,
        job_id: 0x2::object::ID,
        kind: u8,
        value: u64,
        timestamp_ms: u64,
    }

    struct ActiveSellerJobsChanged has copy, drop {
        score_id: 0x2::object::ID,
        agent: address,
        job_id: 0x2::object::ID,
        active_seller_jobs: u64,
        delta: u8,
        timestamp_ms: u64,
    }

    public fun active_cap_for_level(arg0: &0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::FeeConfig, arg1: u8) : u64 {
        0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::config_tier_active_cap(arg0, arg1)
    }

    public fun active_seller_jobs(arg0: &AgentScore) : u64 {
        let v0 = ActiveSellerJobsKey{dummy_field: false};
        if (0x2::dynamic_field::exists<ActiveSellerJobsKey>(&arg0.id, v0)) {
            let v2 = ActiveSellerJobsKey{dummy_field: false};
            *0x2::dynamic_field::borrow<ActiveSellerJobsKey, u64>(&arg0.id, v2)
        } else {
            0
        }
    }

    public fun agent(arg0: &AgentScore) : address {
        arg0.agent
    }

    fun apply_review(arg0: &mut AgentScore, arg1: 0x2::object::ID, arg2: address, arg3: u8, arg4: u64) {
        let v0 = if (0x2::table::contains<0x2::object::ID, u8>(&arg0.job_stars, arg1)) {
            let v1 = 0x2::table::remove<0x2::object::ID, u8>(&mut arg0.job_stars, arg1);
            arg0.stars_sum = arg0.stars_sum - (v1 as u64);
            v1
        } else {
            arg0.review_count = arg0.review_count + 1;
            0
        };
        let v2 = if (v0 == 0) {
            let v3 = BuyerSeenKey{buyer: arg2};
            !0x2::dynamic_field::exists<BuyerSeenKey>(&arg0.id, v3)
        } else {
            false
        };
        if (v2) {
            let v4 = BuyerSeenKey{buyer: arg2};
            0x2::dynamic_field::add<BuyerSeenKey, bool>(&mut arg0.id, v4, true);
            let v5 = DistinctCountKey{dummy_field: false};
            if (0x2::dynamic_field::exists<DistinctCountKey>(&arg0.id, v5)) {
                let v6 = DistinctCountKey{dummy_field: false};
                let v7 = 0x2::dynamic_field::borrow_mut<DistinctCountKey, u64>(&mut arg0.id, v6);
                *v7 = *v7 + 1;
            } else {
                let v8 = DistinctCountKey{dummy_field: false};
                0x2::dynamic_field::add<DistinctCountKey, u64>(&mut arg0.id, v8, 1);
            };
        };
        0x2::table::add<0x2::object::ID, u8>(&mut arg0.job_stars, arg1, arg3);
        arg0.stars_sum = arg0.stars_sum + (arg3 as u64);
        arg0.updated_at_ms = arg4;
        let v9 = 0x2::object::uid_to_inner(&arg0.id);
        let v10 = ReviewSubmitted{
            score_id       : v9,
            agent          : arg0.agent,
            job_id         : arg1,
            buyer          : arg2,
            stars          : arg3,
            previous_stars : v0,
            review_count   : arg0.review_count,
            stars_sum      : arg0.stars_sum,
            timestamp_ms   : arg4,
        };
        0x2::event::emit<ReviewSubmitted>(v10);
        let v11 = ReviewSubmittedV2{
            score_id        : v9,
            agent           : arg0.agent,
            job_id          : arg1,
            buyer           : arg2,
            stars           : arg3,
            previous_stars  : v0,
            review_count    : arg0.review_count,
            stars_sum       : arg0.stars_sum,
            distinct_buyers : distinct_buyers(arg0),
            timestamp_ms    : arg4,
        };
        0x2::event::emit<ReviewSubmittedV2>(v11);
    }

    public fun as_buyer_rejected(arg0: &AgentScore) : u64 {
        let v0 = AsBuyerRejectedKey{dummy_field: false};
        outcome_count<AsBuyerRejectedKey>(arg0, v0)
    }

    public fun avg_scale() : u64 {
        10
    }

    public fun create_empty_score(arg0: &mut ScoreBoard, arg1: address, arg2: &0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::FeeConfig, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::assert_version_pkg(arg2);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = AgentScore{
            id            : 0x2::derived_object::claim<address>(&mut arg0.id, arg1),
            agent         : arg1,
            review_count  : 0,
            stars_sum     : 0,
            job_stars     : 0x2::table::new<0x2::object::ID, u8>(arg4),
            created_at_ms : v0,
            updated_at_ms : v0,
        };
        let v2 = ScoreCreated{
            score_id     : 0x2::object::uid_to_inner(&v1.id),
            agent        : arg1,
            timestamp_ms : v0,
        };
        0x2::event::emit<ScoreCreated>(v2);
        0x2::transfer::share_object<AgentScore>(v1);
    }

    public fun create_score_board(arg0: &0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::AdminCap, arg1: &mut 0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::FeeConfig, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::assert_version_pkg(arg1);
        let v0 = ScoreBoard{id: 0x2::object::new(arg3)};
        let v1 = 0x2::object::uid_to_inner(&v0.id);
        0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::record_score_board_pkg(arg1, v1);
        let v2 = ScoreBoardCreated{
            board_id     : v1,
            timestamp_ms : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<ScoreBoardCreated>(v2);
        0x2::transfer::share_object<ScoreBoard>(v0);
    }

    public(friend) fun decrement_active(arg0: &mut AgentScore, arg1: 0x2::object::ID, arg2: u64) {
        let v0 = ActiveSellerJobsKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<ActiveSellerJobsKey>(&arg0.id, v0)) {
            return
        };
        let v1 = ActiveSellerJobsKey{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow_mut<ActiveSellerJobsKey, u64>(&mut arg0.id, v1);
        if (*v2 == 0) {
            return
        };
        *v2 = *v2 - 1;
        arg0.updated_at_ms = arg2;
        let v3 = ActiveSellerJobsChanged{
            score_id           : 0x2::object::uid_to_inner(&arg0.id),
            agent              : arg0.agent,
            job_id             : arg1,
            active_seller_jobs : *v2,
            delta              : 1,
            timestamp_ms       : arg2,
        };
        0x2::event::emit<ActiveSellerJobsChanged>(v3);
    }

    public fun deliver_v2<T0>(arg0: &mut 0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::Job<T0>, arg1: &mut AgentScore, arg2: vector<u8>, arg3: &0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::FeeConfig, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert!(!0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::is_batch_origin_job<T0>(arg0), 10);
        assert!(arg1.agent == 0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::seller<T0>(arg0), 4);
        0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::deliver<T0>(arg0, arg2, arg3, arg4, arg5);
        on_job_delivered<T0>(arg1, arg0, 0x2::clock::timestamp_ms(arg4));
    }

    public fun distinct_buyers(arg0: &AgentScore) : u64 {
        let v0 = DistinctCountKey{dummy_field: false};
        if (0x2::dynamic_field::exists<DistinctCountKey>(&arg0.id, v0)) {
            let v2 = DistinctCountKey{dummy_field: false};
            *0x2::dynamic_field::borrow<DistinctCountKey, u64>(&arg0.id, v2)
        } else {
            0
        }
    }

    public fun effective_seller_level(arg0: &AgentScore, arg1: &0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::FeeConfig) : u8 {
        if (no_delivery(arg0) >= 0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::config_no_delivery_regression_floor(arg1)) {
            1
        } else {
            seller_level(arg0)
        }
    }

    public fun has_buyer_reviewed(arg0: &AgentScore, arg1: address) : bool {
        let v0 = BuyerSeenKey{buyer: arg1};
        0x2::dynamic_field::exists<BuyerSeenKey>(&arg0.id, v0)
    }

    public fun has_job_review(arg0: &AgentScore, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, u8>(&arg0.job_stars, arg1)
    }

    public fun has_score(arg0: &ScoreBoard, arg1: address) : bool {
        0x2::derived_object::exists<address>(&arg0.id, arg1)
    }

    public(friend) fun increment_active(arg0: &mut AgentScore, arg1: 0x2::object::ID, arg2: u64) {
        let v0 = ActiveSellerJobsKey{dummy_field: false};
        let v1 = if (0x2::dynamic_field::exists<ActiveSellerJobsKey>(&arg0.id, v0)) {
            let v2 = ActiveSellerJobsKey{dummy_field: false};
            let v3 = 0x2::dynamic_field::borrow_mut<ActiveSellerJobsKey, u64>(&mut arg0.id, v2);
            *v3 = *v3 + 1;
            *v3
        } else {
            let v4 = ActiveSellerJobsKey{dummy_field: false};
            0x2::dynamic_field::add<ActiveSellerJobsKey, u64>(&mut arg0.id, v4, 1);
            1
        };
        arg0.updated_at_ms = arg2;
        let v5 = ActiveSellerJobsChanged{
            score_id           : 0x2::object::uid_to_inner(&arg0.id),
            agent              : arg0.agent,
            job_id             : arg1,
            active_seller_jobs : v1,
            delta              : 0,
            timestamp_ms       : arg2,
        };
        0x2::event::emit<ActiveSellerJobsChanged>(v5);
    }

    public fun job_stars(arg0: &AgentScore, arg1: 0x2::object::ID) : u8 {
        *0x2::table::borrow<0x2::object::ID, u8>(&arg0.job_stars, arg1)
    }

    public fun level4_max_no_delivery() : u64 {
        2
    }

    public fun level4_min_reviews() : u64 {
        10
    }

    public fun max_stars() : u8 {
        5
    }

    public fun meets_min_avg(arg0: &AgentScore) : bool {
        meets_proven(arg0) && arg0.stars_sum * 10 >= arg0.review_count * 40
    }

    public fun meets_min_reviews(arg0: &AgentScore) : bool {
        meets_proven(arg0)
    }

    public fun meets_min_seller_level(arg0: &AgentScore, arg1: &0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::FeeConfig, arg2: u8) : bool {
        effective_seller_level(arg0, arg1) >= arg2
    }

    public fun meets_proven(arg0: &AgentScore) : bool {
        distinct_buyers(arg0) >= 3
    }

    public fun min_stars() : u8 {
        1
    }

    public fun no_delivery(arg0: &AgentScore) : u64 {
        let v0 = NoDeliveryKey{dummy_field: false};
        outcome_count<NoDeliveryKey>(arg0, v0)
    }

    public(friend) fun on_job_delivered<T0>(arg0: &mut AgentScore, arg1: &mut 0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::Job<T0>, arg2: u64) {
        if (0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::is_claimed_job<T0>(arg1) && !0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::is_active_freed<T0>(arg1)) {
            0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::mark_active_freed_pkg<T0>(arg1);
            decrement_active(arg0, 0x2::object::id<0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::Job<T0>>(arg1), arg2);
        };
    }

    fun outcome_count<T0: copy + drop + store>(arg0: &AgentScore, arg1: T0) : u64 {
        if (0x2::dynamic_field::exists<T0>(&arg0.id, arg1)) {
            *0x2::dynamic_field::borrow<T0, u64>(&arg0.id, arg1)
        } else {
            0
        }
    }

    public fun proven_min_avg_stars_x10() : u64 {
        40
    }

    public fun proven_min_reviews() : u64 {
        3
    }

    public(friend) fun record_as_buyer_rejected_pkg(arg0: &mut AgentScore, arg1: 0x2::object::ID, arg2: u64) {
        let v0 = AsBuyerRejectedKey{dummy_field: false};
        record_outcome<AsBuyerRejectedKey>(arg0, arg1, v0, 2, arg2);
    }

    public(friend) fun record_no_delivery_pkg(arg0: &mut AgentScore, arg1: 0x2::object::ID, arg2: u64) {
        let v0 = NoDeliveryKey{dummy_field: false};
        record_outcome<NoDeliveryKey>(arg0, arg1, v0, 1, arg2);
    }

    fun record_outcome<T0: copy + drop + store>(arg0: &mut AgentScore, arg1: 0x2::object::ID, arg2: T0, arg3: u8, arg4: u64) {
        let v0 = if (0x2::dynamic_field::exists<T0>(&arg0.id, arg2)) {
            let v1 = 0x2::dynamic_field::borrow_mut<T0, u64>(&mut arg0.id, arg2);
            *v1 = *v1 + 1;
            *v1
        } else {
            0x2::dynamic_field::add<T0, u64>(&mut arg0.id, arg2, 1);
            1
        };
        arg0.updated_at_ms = arg4;
        let v2 = OutcomeRecorded{
            score_id     : 0x2::object::uid_to_inner(&arg0.id),
            agent        : arg0.agent,
            job_id       : arg1,
            kind         : arg3,
            value        : v0,
            timestamp_ms : arg4,
        };
        0x2::event::emit<OutcomeRecorded>(v2);
    }

    public(friend) fun record_rejected_after_delivery_pkg(arg0: &mut AgentScore, arg1: 0x2::object::ID, arg2: u64) {
        let v0 = RejectedAfterDeliveryKey{dummy_field: false};
        record_outcome<RejectedAfterDeliveryKey>(arg0, arg1, v0, 0, arg2);
    }

    public fun refund_v2<T0>(arg0: &mut 0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::Job<T0>, arg1: &mut AgentScore, arg2: &0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::FeeConfig, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::is_batch_origin_job<T0>(arg0), 9);
        assert!(arg1.agent == 0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::seller<T0>(arg0), 4);
        0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::refund_settle_pkg<T0>(arg0, arg2, arg3, arg4);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = 0x2::object::id<0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::Job<T0>>(arg0);
        let v2 = NoDeliveryKey{dummy_field: false};
        record_outcome<NoDeliveryKey>(arg1, v1, v2, 1, v0);
        if (0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::is_claimed_job<T0>(arg0) && !0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::is_active_freed<T0>(arg0)) {
            decrement_active(arg1, v1, v0);
        };
    }

    public fun reject_v2<T0>(arg0: &mut 0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::Job<T0>, arg1: &mut AgentScore, arg2: &0x7669be207f9ac28a34d2cbd45dcfdade11e6fd503ad24e687c180931be9a45e9::registry::Registry, arg3: &0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::FeeConfig, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::is_batch_origin_job<T0>(arg0), 9);
        assert!(!0x7669be207f9ac28a34d2cbd45dcfdade11e6fd503ad24e687c180931be9a45e9::registry::is_registered(arg2, 0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::buyer<T0>(arg0)), 7);
        assert!(arg1.agent == 0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::seller<T0>(arg0), 4);
        0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::reject_settle_pkg<T0>(arg0, arg3, arg4, arg5);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = 0x2::object::id<0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::Job<T0>>(arg0);
        let v2 = RejectedAfterDeliveryKey{dummy_field: false};
        record_outcome<RejectedAfterDeliveryKey>(arg1, v1, v2, 0, v0);
        if (0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::is_claimed_job<T0>(arg0) && !0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::is_active_freed<T0>(arg0)) {
            decrement_active(arg1, v1, v0);
        };
    }

    public fun reject_v2_agent_buyer<T0>(arg0: &mut 0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::Job<T0>, arg1: &mut AgentScore, arg2: &mut AgentScore, arg3: &0x7669be207f9ac28a34d2cbd45dcfdade11e6fd503ad24e687c180931be9a45e9::registry::Registry, arg4: &0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::FeeConfig, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::is_batch_origin_job<T0>(arg0), 9);
        let v0 = 0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::buyer<T0>(arg0);
        assert!(0x7669be207f9ac28a34d2cbd45dcfdade11e6fd503ad24e687c180931be9a45e9::registry::is_registered(arg3, v0), 8);
        assert!(arg1.agent == 0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::seller<T0>(arg0), 4);
        assert!(arg2.agent == v0, 6);
        0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::reject_settle_pkg<T0>(arg0, arg4, arg5, arg6);
        let v1 = 0x2::clock::timestamp_ms(arg5);
        let v2 = 0x2::object::id<0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::Job<T0>>(arg0);
        let v3 = RejectedAfterDeliveryKey{dummy_field: false};
        record_outcome<RejectedAfterDeliveryKey>(arg1, v2, v3, 0, v1);
        let v4 = AsBuyerRejectedKey{dummy_field: false};
        record_outcome<AsBuyerRejectedKey>(arg2, v2, v4, 2, v1);
        if (0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::is_claimed_job<T0>(arg0) && !0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::is_active_freed<T0>(arg0)) {
            decrement_active(arg1, v2, v1);
        };
    }

    public fun rejected_after_delivery(arg0: &AgentScore) : u64 {
        let v0 = RejectedAfterDeliveryKey{dummy_field: false};
        outcome_count<RejectedAfterDeliveryKey>(arg0, v0)
    }

    public fun release_v2<T0>(arg0: &mut 0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::Job<T0>, arg1: &mut AgentScore, arg2: &0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::FeeConfig, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::is_batch_origin_job<T0>(arg0), 9);
        assert!(arg1.agent == 0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::seller<T0>(arg0), 4);
        0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::release_settle_pkg<T0>(arg0, arg2, arg3, arg4);
        if (0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::is_claimed_job<T0>(arg0) && !0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::is_active_freed<T0>(arg0)) {
            decrement_active(arg1, 0x2::object::id<0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::Job<T0>>(arg0), 0x2::clock::timestamp_ms(arg3));
        };
    }

    public fun review_count(arg0: &AgentScore) : u64 {
        arg0.review_count
    }

    public fun score_address(arg0: &ScoreBoard, arg1: address) : address {
        0x2::derived_object::derive_address<address>(0x2::object::uid_to_inner(&arg0.id), arg1)
    }

    public fun seller_level(arg0: &AgentScore) : u8 {
        if (meets_min_avg(arg0)) {
            if (arg0.review_count >= 10 && no_delivery(arg0) <= 2) {
                4
            } else {
                3
            }
        } else if (meets_proven(arg0)) {
            2
        } else {
            1
        }
    }

    public fun stars_sum(arg0: &AgentScore) : u64 {
        arg0.stars_sum
    }

    public fun submit_first_review<T0>(arg0: &mut ScoreBoard, arg1: &0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::Job<T0>, arg2: u8, arg3: &0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::FeeConfig, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::assert_version_pkg(arg3);
        let v0 = validate_review<T0>(arg1, arg2, arg5);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        let v2 = AgentScore{
            id            : 0x2::derived_object::claim<address>(&mut arg0.id, v0),
            agent         : v0,
            review_count  : 0,
            stars_sum     : 0,
            job_stars     : 0x2::table::new<0x2::object::ID, u8>(arg5),
            created_at_ms : v1,
            updated_at_ms : v1,
        };
        let v3 = ScoreCreated{
            score_id     : 0x2::object::uid_to_inner(&v2.id),
            agent        : v0,
            timestamp_ms : v1,
        };
        0x2::event::emit<ScoreCreated>(v3);
        let v4 = &mut v2;
        apply_review(v4, 0x2::object::id<0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::Job<T0>>(arg1), 0x2::tx_context::sender(arg5), arg2, v1);
        0x2::transfer::share_object<AgentScore>(v2);
    }

    public fun submit_review<T0>(arg0: &mut AgentScore, arg1: &0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::Job<T0>, arg2: u8, arg3: &0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::FeeConfig, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::assert_version_pkg(arg3);
        assert!(arg0.agent == validate_review<T0>(arg1, arg2, arg5), 4);
        apply_review(arg0, 0x2::object::id<0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::Job<T0>>(arg1), 0x2::tx_context::sender(arg5), arg2, 0x2::clock::timestamp_ms(arg4));
    }

    fun validate_review<T0>(arg0: &0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::Job<T0>, arg1: u8, arg2: &0x2::tx_context::TxContext) : address {
        assert!(arg1 >= 1 && arg1 <= 5, 3);
        let v0 = 0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::buyer<T0>(arg0);
        let v1 = 0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::seller<T0>(arg0);
        assert!(0x2::tx_context::sender(arg2) == v0, 0);
        assert!(v0 != v1, 5);
        let v2 = 0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::state<T0>(arg0);
        assert!(v2 == 0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::state_released() || v2 == 0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::state_rejected(), 1);
        assert!(0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::delivered_at_ms<T0>(arg0) > 0, 2);
        v1
    }

    // decompiled from Move bytecode v7
}

