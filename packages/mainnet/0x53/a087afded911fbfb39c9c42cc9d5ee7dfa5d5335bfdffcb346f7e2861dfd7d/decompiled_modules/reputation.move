module 0x9db741d5dfea02b1aadedaff43e73bde3972adf82beadf7cc6da26f107bfbc54::reputation {
    struct RepoReputation has key {
        id: 0x2::object::UID,
        repo_id: 0x2::object::ID,
        profiles: 0x2::table::Table<address, AgentProfile>,
        vouch_pairs: 0x2::vec_set::VecSet<vector<u8>>,
    }

    struct AgentProfile has copy, drop, store {
        prs_opened: u64,
        prs_merged: u64,
        reviews: u64,
        ci_runs: u64,
        vouches: u64,
        score: u64,
        last_epoch: u64,
    }

    struct AgentReliability has copy, drop, store {
        disputed: u64,
        expired: u64,
    }

    struct ReliabilityLedger has key {
        id: 0x2::object::UID,
        records: 0x2::table::Table<address, AgentReliability>,
    }

    struct ReputationUpdated has copy, drop {
        repo_id: 0x2::object::ID,
        agent: address,
        prs_opened: u64,
        prs_merged: u64,
        reviews: u64,
        ci_runs: u64,
        vouches: u64,
        score: u64,
        last_epoch: u64,
    }

    struct AgentVouched has copy, drop {
        repo_id: 0x2::object::ID,
        voucher: address,
        subject: address,
    }

    fun emit(arg0: &RepoReputation, arg1: address, arg2: &AgentProfile) {
        let v0 = ReputationUpdated{
            repo_id    : arg0.repo_id,
            agent      : arg1,
            prs_opened : arg2.prs_opened,
            prs_merged : arg2.prs_merged,
            reviews    : arg2.reviews,
            ci_runs    : arg2.ci_runs,
            vouches    : arg2.vouches,
            score      : arg2.score,
            last_epoch : arg2.last_epoch,
        };
        0x2::event::emit<ReputationUpdated>(v0);
    }

    public(friend) fun bump_ci_run(arg0: &mut RepoReputation, arg1: address, arg2: &0x2::tx_context::TxContext) {
        let v0 = ensure(arg0, arg1);
        v0.ci_runs = v0.ci_runs + 1;
        refresh(v0, arg2);
        let v1 = *v0;
        emit(arg0, arg1, &v1);
    }

    public(friend) fun bump_pr_merged(arg0: &mut RepoReputation, arg1: address, arg2: &0x2::tx_context::TxContext) {
        let v0 = ensure(arg0, arg1);
        v0.prs_merged = v0.prs_merged + 1;
        refresh(v0, arg2);
        let v1 = *v0;
        emit(arg0, arg1, &v1);
    }

    public(friend) fun bump_pr_opened(arg0: &mut RepoReputation, arg1: address, arg2: &0x2::tx_context::TxContext) {
        let v0 = ensure(arg0, arg1);
        v0.prs_opened = v0.prs_opened + 1;
        refresh(v0, arg2);
        let v1 = *v0;
        emit(arg0, arg1, &v1);
    }

    public(friend) fun bump_review(arg0: &mut RepoReputation, arg1: address, arg2: &0x2::tx_context::TxContext) {
        let v0 = ensure(arg0, arg1);
        v0.reviews = v0.reviews + 1;
        refresh(v0, arg2);
        let v1 = *v0;
        emit(arg0, arg1, &v1);
    }

    public fun ci_runs(arg0: &AgentProfile) : u64 {
        arg0.ci_runs
    }

    fun compute_score(arg0: &AgentProfile) : u64 {
        arg0.prs_merged * 10 + arg0.reviews * 3 + arg0.ci_runs * 2 + arg0.vouches * 5
    }

    public fun create_reliability_ledger(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ReliabilityLedger{
            id      : 0x2::object::new(arg0),
            records : 0x2::table::new<address, AgentReliability>(arg0),
        };
        0x2::transfer::share_object<ReliabilityLedger>(v0);
    }

    fun ensure(arg0: &mut RepoReputation, arg1: address) : &mut AgentProfile {
        if (!0x2::table::contains<address, AgentProfile>(&arg0.profiles, arg1)) {
            let v0 = AgentProfile{
                prs_opened : 0,
                prs_merged : 0,
                reviews    : 0,
                ci_runs    : 0,
                vouches    : 0,
                score      : 0,
                last_epoch : 0,
            };
            0x2::table::add<address, AgentProfile>(&mut arg0.profiles, arg1, v0);
        };
        0x2::table::borrow_mut<address, AgentProfile>(&mut arg0.profiles, arg1)
    }

    fun ensure_reliability(arg0: &mut ReliabilityLedger, arg1: address) {
        if (!0x2::table::contains<address, AgentReliability>(&arg0.records, arg1)) {
            let v0 = AgentReliability{
                disputed : 0,
                expired  : 0,
            };
            0x2::table::add<address, AgentReliability>(&mut arg0.records, arg1, v0);
        };
    }

    public fun last_epoch(arg0: &AgentProfile) : u64 {
        arg0.last_epoch
    }

    public fun ledger_repo(arg0: &RepoReputation) : 0x2::object::ID {
        arg0.repo_id
    }

    public(friend) fun new_ledger(arg0: 0x2::object::ID, arg1: &mut 0x2::tx_context::TxContext) : RepoReputation {
        RepoReputation{
            id          : 0x2::object::new(arg1),
            repo_id     : arg0,
            profiles    : 0x2::table::new<address, AgentProfile>(arg1),
            vouch_pairs : 0x2::vec_set::empty<vector<u8>>(),
        }
    }

    public(friend) fun note_disputed(arg0: &mut ReliabilityLedger, arg1: address) {
        ensure_reliability(arg0, arg1);
        let v0 = 0x2::table::borrow_mut<address, AgentReliability>(&mut arg0.records, arg1);
        v0.disputed = v0.disputed + 1;
    }

    public(friend) fun note_expired(arg0: &mut ReliabilityLedger, arg1: address) {
        ensure_reliability(arg0, arg1);
        let v0 = 0x2::table::borrow_mut<address, AgentReliability>(&mut arg0.records, arg1);
        v0.expired = v0.expired + 1;
    }

    public fun profile(arg0: &RepoReputation, arg1: address) : AgentProfile {
        if (0x2::table::contains<address, AgentProfile>(&arg0.profiles, arg1)) {
            *0x2::table::borrow<address, AgentProfile>(&arg0.profiles, arg1)
        } else {
            AgentProfile{prs_opened: 0, prs_merged: 0, reviews: 0, ci_runs: 0, vouches: 0, score: 0, last_epoch: 0}
        }
    }

    public fun prs_merged(arg0: &AgentProfile) : u64 {
        arg0.prs_merged
    }

    public fun prs_opened(arg0: &AgentProfile) : u64 {
        arg0.prs_opened
    }

    fun refresh(arg0: &mut AgentProfile, arg1: &0x2::tx_context::TxContext) {
        arg0.score = compute_score(arg0);
        arg0.last_epoch = 0x2::tx_context::epoch(arg1);
    }

    public fun rel_disputed(arg0: &AgentReliability) : u64 {
        arg0.disputed
    }

    public fun rel_expired(arg0: &AgentReliability) : u64 {
        arg0.expired
    }

    public fun reliability_of(arg0: &ReliabilityLedger, arg1: address) : AgentReliability {
        if (0x2::table::contains<address, AgentReliability>(&arg0.records, arg1)) {
            *0x2::table::borrow<address, AgentReliability>(&arg0.records, arg1)
        } else {
            AgentReliability{disputed: 0, expired: 0}
        }
    }

    public fun reviews(arg0: &AgentProfile) : u64 {
        arg0.reviews
    }

    public fun score(arg0: &AgentProfile) : u64 {
        arg0.score
    }

    public fun score_of(arg0: &RepoReputation, arg1: address) : u64 {
        if (0x2::table::contains<address, AgentProfile>(&arg0.profiles, arg1)) {
            0x2::table::borrow<address, AgentProfile>(&arg0.profiles, arg1).score
        } else {
            0
        }
    }

    public(friend) fun share_ledger(arg0: RepoReputation) {
        0x2::transfer::share_object<RepoReputation>(arg0);
    }

    public fun top_runner(arg0: &RepoReputation, arg1: vector<address>) : address {
        let v0 = 0x1::vector::length<address>(&arg1);
        assert!(v0 > 0, 100);
        let v1 = *0x1::vector::borrow<address>(&arg1, 0);
        let v2 = v1;
        let v3 = score_of(arg0, v1);
        let v4 = 1;
        while (v4 < v0) {
            let v5 = *0x1::vector::borrow<address>(&arg1, v4);
            v3 = score_of(arg0, v5);
            if (v3 > v3) {
                v2 = v5;
            };
            v4 = v4 + 1;
        };
        v2
    }

    public fun vouch(arg0: &mut RepoReputation, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 != arg1, 0);
        assert!(score_of(arg0, v0) >= 10, 2);
        let v1 = 0x2::address::to_bytes(v0);
        0x1::vector::append<u8>(&mut v1, 0x2::address::to_bytes(arg1));
        assert!(!0x2::vec_set::contains<vector<u8>>(&arg0.vouch_pairs, &v1), 1);
        0x2::vec_set::insert<vector<u8>>(&mut arg0.vouch_pairs, v1);
        let v2 = ensure(arg0, arg1);
        v2.vouches = v2.vouches + 1;
        refresh(v2, arg2);
        let v3 = *v2;
        emit(arg0, arg1, &v3);
        let v4 = AgentVouched{
            repo_id : arg0.repo_id,
            voucher : v0,
            subject : arg1,
        };
        0x2::event::emit<AgentVouched>(v4);
    }

    public fun vouches(arg0: &AgentProfile) : u64 {
        arg0.vouches
    }

    // decompiled from Move bytecode v7
}

