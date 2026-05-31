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

    struct ReleasePublished has copy, drop {
        release_id: 0x2::object::ID,
        repo_id: 0x2::object::ID,
        version: 0x1::string::String,
        source_snapshot: 0x1::string::String,
        build_artifact: 0x1::string::String,
        test_report: 0x1::string::String,
        published_by: address,
    }

    public fun publish_release(arg0: &mut 0x9db741d5dfea02b1aadedaff43e73bde3972adf82beadf7cc6da26f107bfbc54::forge::Repository, arg1: &0x9db741d5dfea02b1aadedaff43e73bde3972adf82beadf7cc6da26f107bfbc54::forge::RepoOwnerCap, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) {
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

