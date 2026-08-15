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
        0x2::table::add<0x2::object::ID, u8>(&mut arg0.job_stars, arg1, arg3);
        arg0.stars_sum = arg0.stars_sum + (arg3 as u64);
        arg0.updated_at_ms = arg4;
        let v2 = ReviewSubmitted{
            score_id       : 0x2::object::uid_to_inner(&arg0.id),
            agent          : arg0.agent,
            job_id         : arg1,
            buyer          : arg2,
            stars          : arg3,
            previous_stars : v0,
            review_count   : arg0.review_count,
            stars_sum      : arg0.stars_sum,
            timestamp_ms   : arg4,
        };
        0x2::event::emit<ReviewSubmitted>(v2);
    }

    public fun avg_scale() : u64 {
        10
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

    public fun has_job_review(arg0: &AgentScore, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, u8>(&arg0.job_stars, arg1)
    }

    public fun has_score(arg0: &ScoreBoard, arg1: address) : bool {
        0x2::derived_object::exists<address>(&arg0.id, arg1)
    }

    public fun job_stars(arg0: &AgentScore, arg1: 0x2::object::ID) : u8 {
        *0x2::table::borrow<0x2::object::ID, u8>(&arg0.job_stars, arg1)
    }

    public fun max_stars() : u8 {
        5
    }

    public fun meets_min_avg(arg0: &AgentScore) : bool {
        meets_min_reviews(arg0) && arg0.stars_sum * 10 >= arg0.review_count * 40
    }

    public fun meets_min_reviews(arg0: &AgentScore) : bool {
        arg0.review_count >= 3
    }

    public fun min_stars() : u8 {
        1
    }

    public fun proven_min_avg_stars_x10() : u64 {
        40
    }

    public fun proven_min_reviews() : u64 {
        3
    }

    public fun review_count(arg0: &AgentScore) : u64 {
        arg0.review_count
    }

    public fun score_address(arg0: &ScoreBoard, arg1: address) : address {
        0x2::derived_object::derive_address<address>(0x2::object::uid_to_inner(&arg0.id), arg1)
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
        assert!(0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::state<T0>(arg0) == 0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::state_released(), 1);
        assert!(0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::delivered_at_ms<T0>(arg0) > 0, 2);
        v1
    }

    // decompiled from Move bytecode v7
}

