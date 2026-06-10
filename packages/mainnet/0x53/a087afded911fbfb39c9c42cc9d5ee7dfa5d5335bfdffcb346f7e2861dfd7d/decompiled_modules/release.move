module 0x9db741d5dfea02b1aadedaff43e73bde3972adf82beadf7cc6da26f107bfbc54::release {
    struct Release has store, key {
        id: 0x2::object::UID,
        repo_id: 0x2::object::ID,
        version: 0x1::string::String,
        source_snapshot: 0x1::string::String,
        build_artifact: 0x1::string::String,
        test_report: 0x1::string::String,
        published_by: address,
    }

    struct ReleaseLink has store, key {
        id: 0x2::object::UID,
        release_id: 0x2::object::ID,
        repo_id: 0x2::object::ID,
        merged_pr_id: 0x2::object::ID,
    }

    struct ReleasePublished has copy, drop {
        release_id: 0x2::object::ID,
        repo_id: 0x2::object::ID,
        version: 0x1::string::String,
        source_snapshot: 0x1::string::String,
        build_artifact: 0x1::string::String,
        test_report: 0x1::string::String,
        published_by: address,
    }

    struct ReleaseLinked has copy, drop {
        link_id: 0x2::object::ID,
        release_id: 0x2::object::ID,
        repo_id: 0x2::object::ID,
        merged_pr_id: 0x2::object::ID,
    }

    public fun link_merged_pr(arg0: &ReleaseLink) : 0x2::object::ID {
        arg0.merged_pr_id
    }

    public fun link_release(arg0: &ReleaseLink) : 0x2::object::ID {
        arg0.release_id
    }

    public fun link_repo(arg0: &ReleaseLink) : 0x2::object::ID {
        arg0.repo_id
    }

    public fun publish_release(arg0: &mut 0x9db741d5dfea02b1aadedaff43e73bde3972adf82beadf7cc6da26f107bfbc54::forge::Repository, arg1: &0x9db741d5dfea02b1aadedaff43e73bde3972adf82beadf7cc6da26f107bfbc54::forge::RepoOwnerCap, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) {
        publish_release_internal(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    fun publish_release_internal(arg0: &mut 0x9db741d5dfea02b1aadedaff43e73bde3972adf82beadf7cc6da26f107bfbc54::forge::Repository, arg1: &0x9db741d5dfea02b1aadedaff43e73bde3972adf82beadf7cc6da26f107bfbc54::forge::RepoOwnerCap, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0x9db741d5dfea02b1aadedaff43e73bde3972adf82beadf7cc6da26f107bfbc54::forge::assert_owner(arg0, arg1);
        let v0 = Release{
            id              : 0x2::object::new(arg6),
            repo_id         : 0x2::object::id<0x9db741d5dfea02b1aadedaff43e73bde3972adf82beadf7cc6da26f107bfbc54::forge::Repository>(arg0),
            version         : arg2,
            source_snapshot : arg3,
            build_artifact  : arg4,
            test_report     : arg5,
            published_by    : 0x2::tx_context::sender(arg6),
        };
        let v1 = 0x2::object::id<Release>(&v0);
        0x9db741d5dfea02b1aadedaff43e73bde3972adf82beadf7cc6da26f107bfbc54::forge::set_latest_release(arg0, v1);
        let v2 = ReleasePublished{
            release_id      : v1,
            repo_id         : 0x2::object::id<0x9db741d5dfea02b1aadedaff43e73bde3972adf82beadf7cc6da26f107bfbc54::forge::Repository>(arg0),
            version         : v0.version,
            source_snapshot : v0.source_snapshot,
            build_artifact  : v0.build_artifact,
            test_report     : v0.test_report,
            published_by    : v0.published_by,
        };
        0x2::event::emit<ReleasePublished>(v2);
        0x2::transfer::share_object<Release>(v0);
        v1
    }

    public fun publish_release_v2(arg0: &mut 0x9db741d5dfea02b1aadedaff43e73bde3972adf82beadf7cc6da26f107bfbc54::forge::Repository, arg1: &0x9db741d5dfea02b1aadedaff43e73bde3972adf82beadf7cc6da26f107bfbc54::forge::RepoOwnerCap, arg2: &0x9db741d5dfea02b1aadedaff43e73bde3972adf82beadf7cc6da26f107bfbc54::pull_request::PullRequest, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x9db741d5dfea02b1aadedaff43e73bde3972adf82beadf7cc6da26f107bfbc54::pull_request::pr_repo(arg2) == 0x2::object::id<0x9db741d5dfea02b1aadedaff43e73bde3972adf82beadf7cc6da26f107bfbc54::forge::Repository>(arg0), 0);
        assert!(0x9db741d5dfea02b1aadedaff43e73bde3972adf82beadf7cc6da26f107bfbc54::pull_request::pr_status(arg2) == 0x9db741d5dfea02b1aadedaff43e73bde3972adf82beadf7cc6da26f107bfbc54::pull_request::status_merged(), 1);
        let v0 = 0x2::object::id<0x9db741d5dfea02b1aadedaff43e73bde3972adf82beadf7cc6da26f107bfbc54::forge::Repository>(arg0);
        let v1 = 0x2::object::id<0x9db741d5dfea02b1aadedaff43e73bde3972adf82beadf7cc6da26f107bfbc54::pull_request::PullRequest>(arg2);
        let v2 = publish_release_internal(arg0, arg1, arg3, 0x9db741d5dfea02b1aadedaff43e73bde3972adf82beadf7cc6da26f107bfbc54::pull_request::pr_head(arg2), arg4, arg5, arg6);
        let v3 = ReleaseLink{
            id           : 0x2::object::new(arg6),
            release_id   : v2,
            repo_id      : v0,
            merged_pr_id : v1,
        };
        let v4 = ReleaseLinked{
            link_id      : 0x2::object::id<ReleaseLink>(&v3),
            release_id   : v2,
            repo_id      : v0,
            merged_pr_id : v1,
        };
        0x2::event::emit<ReleaseLinked>(v4);
        0x2::transfer::share_object<ReleaseLink>(v3);
    }

    public fun release_artifact(arg0: &Release) : 0x1::string::String {
        arg0.build_artifact
    }

    public fun release_publisher(arg0: &Release) : address {
        arg0.published_by
    }

    public fun release_repo(arg0: &Release) : 0x2::object::ID {
        arg0.repo_id
    }

    public fun release_source(arg0: &Release) : 0x1::string::String {
        arg0.source_snapshot
    }

    public fun release_test_report(arg0: &Release) : 0x1::string::String {
        arg0.test_report
    }

    public fun release_version(arg0: &Release) : 0x1::string::String {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

