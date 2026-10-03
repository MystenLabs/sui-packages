module 0x5e3e75de3e1f661ffcad9bd0d53f3ea97e2e48f0765d2b2d9532256806409bb9::social {
    struct SocialRegistryV1 has key {
        id: 0x2::object::UID,
        version: u64,
        counts: 0x2::table::Table<0x2::object::ID, FollowCountsV1>,
        edges: 0x2::table::Table<FollowKeyV1, FollowEdgeV1>,
    }

    struct FollowCountsV1 has copy, drop, store {
        follower_count: u64,
        following_count: u64,
    }

    struct FollowKeyV1 has copy, drop, store {
        follower: 0x2::object::ID,
        following: 0x2::object::ID,
    }

    struct FollowEdgeV1 has copy, drop, store {
        following: bool,
        revision: u64,
    }

    struct SocialRegistryCreatedV1 has copy, drop {
        social_registry_id: 0x2::object::ID,
    }

    struct FollowChangedV1 has copy, drop {
        social_registry_id: 0x2::object::ID,
        profile_registry_id: 0x2::object::ID,
        follower: 0x2::object::ID,
        following: 0x2::object::ID,
        desired: bool,
        revision: u64,
        follower_following_count: u64,
        following_follower_count: u64,
    }

    public fun counts(arg0: &SocialRegistryV1, arg1: 0x2::object::ID) : (u64, u64) {
        assert!(arg0.version == 1, 0);
        if (!0x2::table::contains<0x2::object::ID, FollowCountsV1>(&arg0.counts, arg1)) {
            return (0, 0)
        };
        let v0 = 0x2::table::borrow<0x2::object::ID, FollowCountsV1>(&arg0.counts, arg1);
        (v0.follower_count, v0.following_count)
    }

    public fun edge(arg0: &SocialRegistryV1, arg1: 0x2::object::ID, arg2: 0x2::object::ID) : (bool, u64) {
        assert!(arg0.version == 1, 0);
        let v0 = FollowKeyV1{
            follower  : arg1,
            following : arg2,
        };
        if (!0x2::table::contains<FollowKeyV1, FollowEdgeV1>(&arg0.edges, v0)) {
            return (false, 0)
        };
        let v1 = 0x2::table::borrow<FollowKeyV1, FollowEdgeV1>(&arg0.edges, v0);
        (v1.following, v1.revision)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SocialRegistryV1{
            id      : 0x2::object::new(arg0),
            version : 1,
            counts  : 0x2::table::new<0x2::object::ID, FollowCountsV1>(arg0),
            edges   : 0x2::table::new<FollowKeyV1, FollowEdgeV1>(arg0),
        };
        let v1 = SocialRegistryCreatedV1{social_registry_id: 0x2::object::id<SocialRegistryV1>(&v0)};
        0x2::event::emit<SocialRegistryCreatedV1>(v1);
        0x2::transfer::share_object<SocialRegistryV1>(v0);
    }

    public fun set_follow(arg0: &mut SocialRegistryV1, arg1: &0x5e3e75de3e1f661ffcad9bd0d53f3ea97e2e48f0765d2b2d9532256806409bb9::profile::ProfileRegistryV1, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: address, arg5: u64, arg6: bool, arg7: &0x2::tx_context::TxContext) : (bool, u64) {
        assert!(arg0.version == 1, 0);
        assert!(0x5e3e75de3e1f661ffcad9bd0d53f3ea97e2e48f0765d2b2d9532256806409bb9::profile::is_registered_profile(arg1, 0x2::tx_context::sender(arg7), arg2), 1);
        assert!(0x5e3e75de3e1f661ffcad9bd0d53f3ea97e2e48f0765d2b2d9532256806409bb9::profile::is_registered_profile(arg1, arg4, arg3), 2);
        assert!(arg2 != arg3, 3);
        let v0 = FollowKeyV1{
            follower  : arg2,
            following : arg3,
        };
        let v1 = if (0x2::table::contains<FollowKeyV1, FollowEdgeV1>(&arg0.edges, v0)) {
            *0x2::table::borrow<FollowKeyV1, FollowEdgeV1>(&arg0.edges, v0)
        } else {
            FollowEdgeV1{following: false, revision: 0}
        };
        let v2 = v1;
        assert!(v2.revision == arg5, 4);
        if (v2.following == arg6) {
            return (v2.following, v2.revision)
        };
        assert!(v2.revision < 18446744073709551615, 7);
        if (!0x2::table::contains<0x2::object::ID, FollowCountsV1>(&arg0.counts, arg2)) {
            let v3 = FollowCountsV1{
                follower_count  : 0,
                following_count : 0,
            };
            0x2::table::add<0x2::object::ID, FollowCountsV1>(&mut arg0.counts, arg2, v3);
        };
        if (!0x2::table::contains<0x2::object::ID, FollowCountsV1>(&arg0.counts, arg3)) {
            let v4 = FollowCountsV1{
                follower_count  : 0,
                following_count : 0,
            };
            0x2::table::add<0x2::object::ID, FollowCountsV1>(&mut arg0.counts, arg3, v4);
        };
        let v5 = 0x2::table::borrow<0x2::object::ID, FollowCountsV1>(&arg0.counts, arg2).following_count;
        let v6 = 0x2::table::borrow<0x2::object::ID, FollowCountsV1>(&arg0.counts, arg3).follower_count;
        if (arg6) {
            assert!(v5 < 18446744073709551615 && v6 < 18446744073709551615, 5);
        } else {
            assert!(v5 > 0 && v6 > 0, 6);
        };
        let v7 = if (arg6) {
            v5 + 1
        } else {
            v5 - 1
        };
        let v8 = if (arg6) {
            v6 + 1
        } else {
            v6 - 1
        };
        0x2::table::borrow_mut<0x2::object::ID, FollowCountsV1>(&mut arg0.counts, arg2).following_count = v7;
        0x2::table::borrow_mut<0x2::object::ID, FollowCountsV1>(&mut arg0.counts, arg3).follower_count = v8;
        let v9 = v2.revision + 1;
        if (0x2::table::contains<FollowKeyV1, FollowEdgeV1>(&arg0.edges, v0)) {
            let v10 = 0x2::table::borrow_mut<FollowKeyV1, FollowEdgeV1>(&mut arg0.edges, v0);
            v10.following = arg6;
            v10.revision = v9;
        } else {
            let v11 = FollowEdgeV1{
                following : arg6,
                revision  : v9,
            };
            0x2::table::add<FollowKeyV1, FollowEdgeV1>(&mut arg0.edges, v0, v11);
        };
        let v12 = FollowChangedV1{
            social_registry_id       : 0x2::object::id<SocialRegistryV1>(arg0),
            profile_registry_id      : 0x5e3e75de3e1f661ffcad9bd0d53f3ea97e2e48f0765d2b2d9532256806409bb9::profile::registry_id(arg1),
            follower                 : arg2,
            following                : arg3,
            desired                  : arg6,
            revision                 : v9,
            follower_following_count : v7,
            following_follower_count : v8,
        };
        0x2::event::emit<FollowChangedV1>(v12);
        (arg6, v9)
    }

    // decompiled from Move bytecode v7
}

