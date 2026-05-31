module 0x9db741d5dfea02b1aadedaff43e73bde3972adf82beadf7cc6da26f107bfbc54::pull_request {
    struct PullRequest has store, key {
        id: 0x2::object::UID,
        repo_id: 0x2::object::ID,
        author: address,
        base_snapshot: 0x1::string::String,
        head_snapshot: 0x1::string::String,
        diff_manifest: 0x1::string::String,
        title: 0x1::string::String,
        status: u8,
        review_refs: vector<0x1::string::String>,
        approvals: u64,
    }

    struct Review has store, key {
        id: 0x2::object::UID,
        pr_id: 0x2::object::ID,
        reviewer: address,
        verdict: u8,
        report_blob: 0x1::string::String,
    }

    struct PrOpened has copy, drop {
        pr_id: 0x2::object::ID,
        repo_id: 0x2::object::ID,
        author: address,
        base_snapshot: 0x1::string::String,
        head_snapshot: 0x1::string::String,
    }

    struct ReviewSubmitted has copy, drop {
        review_id: 0x2::object::ID,
        pr_id: 0x2::object::ID,
        reviewer: address,
        verdict: u8,
        report_blob: 0x1::string::String,
    }

    struct PrMerged has copy, drop {
        pr_id: 0x2::object::ID,
        repo_id: 0x2::object::ID,
        merged_snapshot: 0x1::string::String,
    }

    struct PrClosed has copy, drop {
        pr_id: 0x2::object::ID,
        repo_id: 0x2::object::ID,
    }

    public fun close_pr(arg0: &0x9db741d5dfea02b1aadedaff43e73bde3972adf82beadf7cc6da26f107bfbc54::forge::Repository, arg1: &mut PullRequest, arg2: &0x9db741d5dfea02b1aadedaff43e73bde3972adf82beadf7cc6da26f107bfbc54::forge::RepoOwnerCap) {
        0x9db741d5dfea02b1aadedaff43e73bde3972adf82beadf7cc6da26f107bfbc54::forge::assert_owner(arg0, arg2);
        assert!(arg1.repo_id == 0x2::object::id<0x9db741d5dfea02b1aadedaff43e73bde3972adf82beadf7cc6da26f107bfbc54::forge::Repository>(arg0), 0);
        assert!(arg1.status == 0, 1);
        arg1.status = 2;
        let v0 = PrClosed{
            pr_id   : 0x2::object::id<PullRequest>(arg1),
            repo_id : arg1.repo_id,
        };
        0x2::event::emit<PrClosed>(v0);
    }

    public fun merge_pr(arg0: &mut 0x9db741d5dfea02b1aadedaff43e73bde3972adf82beadf7cc6da26f107bfbc54::forge::Repository, arg1: &mut 0x9db741d5dfea02b1aadedaff43e73bde3972adf82beadf7cc6da26f107bfbc54::reputation::RepoReputation, arg2: &mut PullRequest, arg3: &0x9db741d5dfea02b1aadedaff43e73bde3972adf82beadf7cc6da26f107bfbc54::forge::RepoOwnerCap, arg4: &0x2::tx_context::TxContext) {
        0x9db741d5dfea02b1aadedaff43e73bde3972adf82beadf7cc6da26f107bfbc54::forge::assert_owner(arg0, arg3);
        assert!(arg2.repo_id == 0x2::object::id<0x9db741d5dfea02b1aadedaff43e73bde3972adf82beadf7cc6da26f107bfbc54::forge::Repository>(arg0), 0);
        assert!(arg2.status == 0, 1);
        assert!(arg2.base_snapshot == 0x9db741d5dfea02b1aadedaff43e73bde3972adf82beadf7cc6da26f107bfbc54::forge::current_snapshot(arg0), 2);
        assert!(arg2.approvals >= (0x9db741d5dfea02b1aadedaff43e73bde3972adf82beadf7cc6da26f107bfbc54::forge::min_approvals(arg0) as u64), 3);
        0x9db741d5dfea02b1aadedaff43e73bde3972adf82beadf7cc6da26f107bfbc54::forge::update_ref(arg0, arg3, arg2.head_snapshot);
        arg2.status = 1;
        let v0 = PrMerged{
            pr_id           : 0x2::object::id<PullRequest>(arg2),
            repo_id         : arg2.repo_id,
            merged_snapshot : arg2.head_snapshot,
        };
        0x2::event::emit<PrMerged>(v0);
        0x9db741d5dfea02b1aadedaff43e73bde3972adf82beadf7cc6da26f107bfbc54::reputation::bump_pr_merged(arg1, arg2.author, arg4);
    }

    public fun open_pr_as_agent(arg0: &0x9db741d5dfea02b1aadedaff43e73bde3972adf82beadf7cc6da26f107bfbc54::forge::Repository, arg1: &mut 0x9db741d5dfea02b1aadedaff43e73bde3972adf82beadf7cc6da26f107bfbc54::reputation::RepoReputation, arg2: &0x9db741d5dfea02b1aadedaff43e73bde3972adf82beadf7cc6da26f107bfbc54::forge::AgentCap, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) {
        0x9db741d5dfea02b1aadedaff43e73bde3972adf82beadf7cc6da26f107bfbc54::forge::assert_agent_scope(arg0, arg2, 0x9db741d5dfea02b1aadedaff43e73bde3972adf82beadf7cc6da26f107bfbc54::forge::scope_open_pr(), arg6);
        open_pr_internal(arg0, arg1, arg3, arg4, arg5, arg6);
    }

    public fun open_pr_as_owner(arg0: &0x9db741d5dfea02b1aadedaff43e73bde3972adf82beadf7cc6da26f107bfbc54::forge::Repository, arg1: &mut 0x9db741d5dfea02b1aadedaff43e73bde3972adf82beadf7cc6da26f107bfbc54::reputation::RepoReputation, arg2: &0x9db741d5dfea02b1aadedaff43e73bde3972adf82beadf7cc6da26f107bfbc54::forge::RepoOwnerCap, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) {
        0x9db741d5dfea02b1aadedaff43e73bde3972adf82beadf7cc6da26f107bfbc54::forge::assert_owner(arg0, arg2);
        open_pr_internal(arg0, arg1, arg3, arg4, arg5, arg6);
    }

    fun open_pr_internal(arg0: &0x9db741d5dfea02b1aadedaff43e73bde3972adf82beadf7cc6da26f107bfbc54::forge::Repository, arg1: &mut 0x9db741d5dfea02b1aadedaff43e73bde3972adf82beadf7cc6da26f107bfbc54::reputation::RepoReputation, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = PullRequest{
            id            : 0x2::object::new(arg5),
            repo_id       : 0x2::object::id<0x9db741d5dfea02b1aadedaff43e73bde3972adf82beadf7cc6da26f107bfbc54::forge::Repository>(arg0),
            author        : 0x2::tx_context::sender(arg5),
            base_snapshot : 0x9db741d5dfea02b1aadedaff43e73bde3972adf82beadf7cc6da26f107bfbc54::forge::current_snapshot(arg0),
            head_snapshot : arg2,
            diff_manifest : arg3,
            title         : arg4,
            status        : 0,
            review_refs   : 0x1::vector::empty<0x1::string::String>(),
            approvals     : 0,
        };
        let v1 = PrOpened{
            pr_id         : 0x2::object::id<PullRequest>(&v0),
            repo_id       : v0.repo_id,
            author        : v0.author,
            base_snapshot : v0.base_snapshot,
            head_snapshot : v0.head_snapshot,
        };
        0x2::event::emit<PrOpened>(v1);
        0x9db741d5dfea02b1aadedaff43e73bde3972adf82beadf7cc6da26f107bfbc54::reputation::bump_pr_opened(arg1, 0x2::tx_context::sender(arg5), arg5);
        0x2::transfer::share_object<PullRequest>(v0);
    }

    public fun pr_approvals(arg0: &PullRequest) : u64 {
        arg0.approvals
    }

    public fun pr_author(arg0: &PullRequest) : address {
        arg0.author
    }

    public fun pr_base(arg0: &PullRequest) : 0x1::string::String {
        arg0.base_snapshot
    }

    public fun pr_diff_manifest(arg0: &PullRequest) : 0x1::string::String {
        arg0.diff_manifest
    }

    public fun pr_head(arg0: &PullRequest) : 0x1::string::String {
        arg0.head_snapshot
    }

    public fun pr_repo(arg0: &PullRequest) : 0x2::object::ID {
        arg0.repo_id
    }

    public fun pr_review_count(arg0: &PullRequest) : u64 {
        0x1::vector::length<0x1::string::String>(&arg0.review_refs)
    }

    public fun pr_status(arg0: &PullRequest) : u8 {
        arg0.status
    }

    public fun review_blob(arg0: &Review) : 0x1::string::String {
        arg0.report_blob
    }

    public fun review_reporter(arg0: &Review) : address {
        arg0.reviewer
    }

    public fun review_verdict(arg0: &Review) : u8 {
        arg0.verdict
    }

    public fun status_closed() : u8 {
        2
    }

    public fun status_merged() : u8 {
        1
    }

    public fun status_open() : u8 {
        0
    }

    public fun submit_review_as_agent(arg0: &0x9db741d5dfea02b1aadedaff43e73bde3972adf82beadf7cc6da26f107bfbc54::forge::Repository, arg1: &mut 0x9db741d5dfea02b1aadedaff43e73bde3972adf82beadf7cc6da26f107bfbc54::reputation::RepoReputation, arg2: &mut PullRequest, arg3: &0x9db741d5dfea02b1aadedaff43e73bde3972adf82beadf7cc6da26f107bfbc54::forge::AgentCap, arg4: u8, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) {
        0x9db741d5dfea02b1aadedaff43e73bde3972adf82beadf7cc6da26f107bfbc54::forge::assert_agent_scope(arg0, arg3, 0x9db741d5dfea02b1aadedaff43e73bde3972adf82beadf7cc6da26f107bfbc54::forge::scope_review(), arg6);
        submit_review_internal(arg0, arg1, arg2, arg4, arg5, arg6);
    }

    public fun submit_review_as_owner(arg0: &0x9db741d5dfea02b1aadedaff43e73bde3972adf82beadf7cc6da26f107bfbc54::forge::Repository, arg1: &mut 0x9db741d5dfea02b1aadedaff43e73bde3972adf82beadf7cc6da26f107bfbc54::reputation::RepoReputation, arg2: &mut PullRequest, arg3: &0x9db741d5dfea02b1aadedaff43e73bde3972adf82beadf7cc6da26f107bfbc54::forge::RepoOwnerCap, arg4: u8, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) {
        0x9db741d5dfea02b1aadedaff43e73bde3972adf82beadf7cc6da26f107bfbc54::forge::assert_owner(arg0, arg3);
        submit_review_internal(arg0, arg1, arg2, arg4, arg5, arg6);
    }

    fun submit_review_internal(arg0: &0x9db741d5dfea02b1aadedaff43e73bde3972adf82beadf7cc6da26f107bfbc54::forge::Repository, arg1: &mut 0x9db741d5dfea02b1aadedaff43e73bde3972adf82beadf7cc6da26f107bfbc54::reputation::RepoReputation, arg2: &mut PullRequest, arg3: u8, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.repo_id == 0x2::object::id<0x9db741d5dfea02b1aadedaff43e73bde3972adf82beadf7cc6da26f107bfbc54::forge::Repository>(arg0), 0);
        assert!(arg2.status == 0, 1);
        let v0 = Review{
            id          : 0x2::object::new(arg5),
            pr_id       : 0x2::object::id<PullRequest>(arg2),
            reviewer    : 0x2::tx_context::sender(arg5),
            verdict     : arg3,
            report_blob : arg4,
        };
        0x1::vector::push_back<0x1::string::String>(&mut arg2.review_refs, arg4);
        if (arg3 == 1) {
            arg2.approvals = arg2.approvals + 1;
        };
        let v1 = ReviewSubmitted{
            review_id   : 0x2::object::id<Review>(&v0),
            pr_id       : 0x2::object::id<PullRequest>(arg2),
            reviewer    : v0.reviewer,
            verdict     : arg3,
            report_blob : arg4,
        };
        0x2::event::emit<ReviewSubmitted>(v1);
        0x9db741d5dfea02b1aadedaff43e73bde3972adf82beadf7cc6da26f107bfbc54::reputation::bump_review(arg1, 0x2::tx_context::sender(arg5), arg5);
        0x2::transfer::share_object<Review>(v0);
    }

    public fun verdict_approve() : u8 {
        1
    }

    public fun verdict_comment() : u8 {
        3
    }

    public fun verdict_request_changes() : u8 {
        2
    }

    // decompiled from Move bytecode v7
}

