module 0x5e3e75de3e1f661ffcad9bd0d53f3ea97e2e48f0765d2b2d9532256806409bb9::community_votes {
    struct VoteRegistryV1 has key {
        id: 0x2::object::UID,
        version: u64,
        counts: 0x2::table::Table<0x2::object::ID, VoteCountsV1>,
        edges: 0x2::table::Table<VoteKeyV1, VoteEdgeV1>,
    }

    struct VoteCountsV1 has copy, drop, store {
        up_count: u64,
        down_count: u64,
    }

    struct VoteKeyV1 has copy, drop, store {
        actor: 0x2::object::ID,
        post: 0x2::object::ID,
    }

    struct VoteEdgeV1 has copy, drop, store {
        state: u8,
        revision: u64,
    }

    struct VoteRegistryCreatedV1 has copy, drop {
        registry_id: 0x2::object::ID,
    }

    struct VoteChangedV1 has copy, drop {
        registry_id: 0x2::object::ID,
        community_registry_id: 0x2::object::ID,
        profile_registry_id: 0x2::object::ID,
        post_id: 0x2::object::ID,
        actor: 0x2::object::ID,
        state: u8,
        revision: u64,
        up_count: u64,
        down_count: u64,
    }

    fun assert_target(arg0: &VoteRegistryV1, arg1: &0x5e3e75de3e1f661ffcad9bd0d53f3ea97e2e48f0765d2b2d9532256806409bb9::community_posts::CommunityRegistryV1, arg2: &0x5e3e75de3e1f661ffcad9bd0d53f3ea97e2e48f0765d2b2d9532256806409bb9::profile::ProfileRegistryV1, arg3: &0x5e3e75de3e1f661ffcad9bd0d53f3ea97e2e48f0765d2b2d9532256806409bb9::community_posts::PostV1) {
        assert!(arg0.version == 1, 0);
        0x5e3e75de3e1f661ffcad9bd0d53f3ea97e2e48f0765d2b2d9532256806409bb9::community_posts::assert_post(arg1, arg2, arg3);
    }

    public fun counts(arg0: &VoteRegistryV1, arg1: &0x5e3e75de3e1f661ffcad9bd0d53f3ea97e2e48f0765d2b2d9532256806409bb9::community_posts::CommunityRegistryV1, arg2: &0x5e3e75de3e1f661ffcad9bd0d53f3ea97e2e48f0765d2b2d9532256806409bb9::profile::ProfileRegistryV1, arg3: &0x5e3e75de3e1f661ffcad9bd0d53f3ea97e2e48f0765d2b2d9532256806409bb9::community_posts::PostV1) : (u64, u64) {
        assert_target(arg0, arg1, arg2, arg3);
        let v0 = 0x2::object::id<0x5e3e75de3e1f661ffcad9bd0d53f3ea97e2e48f0765d2b2d9532256806409bb9::community_posts::PostV1>(arg3);
        if (!0x2::table::contains<0x2::object::ID, VoteCountsV1>(&arg0.counts, v0)) {
            return (0, 0)
        };
        let v1 = 0x2::table::borrow<0x2::object::ID, VoteCountsV1>(&arg0.counts, v0);
        (v1.up_count, v1.down_count)
    }

    public fun edge(arg0: &VoteRegistryV1, arg1: &0x5e3e75de3e1f661ffcad9bd0d53f3ea97e2e48f0765d2b2d9532256806409bb9::community_posts::CommunityRegistryV1, arg2: &0x5e3e75de3e1f661ffcad9bd0d53f3ea97e2e48f0765d2b2d9532256806409bb9::profile::ProfileRegistryV1, arg3: &0x5e3e75de3e1f661ffcad9bd0d53f3ea97e2e48f0765d2b2d9532256806409bb9::community_posts::PostV1, arg4: 0x2::object::ID, arg5: address) : (u8, u64) {
        assert_target(arg0, arg1, arg2, arg3);
        assert!(0x5e3e75de3e1f661ffcad9bd0d53f3ea97e2e48f0765d2b2d9532256806409bb9::profile::is_registered_profile(arg2, arg5, arg4), 1);
        let v0 = VoteKeyV1{
            actor : arg4,
            post  : 0x2::object::id<0x5e3e75de3e1f661ffcad9bd0d53f3ea97e2e48f0765d2b2d9532256806409bb9::community_posts::PostV1>(arg3),
        };
        let v1 = previous(arg0, v0);
        (v1.state, v1.revision)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = VoteRegistryV1{
            id      : 0x2::object::new(arg0),
            version : 1,
            counts  : 0x2::table::new<0x2::object::ID, VoteCountsV1>(arg0),
            edges   : 0x2::table::new<VoteKeyV1, VoteEdgeV1>(arg0),
        };
        let v1 = VoteRegistryCreatedV1{registry_id: 0x2::object::id<VoteRegistryV1>(&v0)};
        0x2::event::emit<VoteRegistryCreatedV1>(v1);
        0x2::transfer::share_object<VoteRegistryV1>(v0);
    }

    fun previous(arg0: &VoteRegistryV1, arg1: VoteKeyV1) : VoteEdgeV1 {
        if (!0x2::table::contains<VoteKeyV1, VoteEdgeV1>(&arg0.edges, arg1)) {
            return VoteEdgeV1{
                state    : 0,
                revision : 0,
            }
        };
        let v0 = *0x2::table::borrow<VoteKeyV1, VoteEdgeV1>(&arg0.edges, arg1);
        let v1 = if (v0.state <= 2) {
            if (v0.revision > 0) {
                0x2::table::contains<0x2::object::ID, VoteCountsV1>(&arg0.counts, arg1.post)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 2);
        v0
    }

    public fun set_vote(arg0: &mut VoteRegistryV1, arg1: &0x5e3e75de3e1f661ffcad9bd0d53f3ea97e2e48f0765d2b2d9532256806409bb9::community_posts::CommunityRegistryV1, arg2: &0x5e3e75de3e1f661ffcad9bd0d53f3ea97e2e48f0765d2b2d9532256806409bb9::profile::ProfileRegistryV1, arg3: &0x5e3e75de3e1f661ffcad9bd0d53f3ea97e2e48f0765d2b2d9532256806409bb9::community_posts::PostV1, arg4: 0x2::object::ID, arg5: u64, arg6: u8, arg7: &0x2::tx_context::TxContext) : (u8, u64) {
        assert_target(arg0, arg1, arg2, arg3);
        assert!(0x5e3e75de3e1f661ffcad9bd0d53f3ea97e2e48f0765d2b2d9532256806409bb9::profile::is_registered_profile(arg2, 0x2::tx_context::sender(arg7), arg4), 1);
        assert!(arg6 <= 2, 2);
        let v0 = 0x2::object::id<0x5e3e75de3e1f661ffcad9bd0d53f3ea97e2e48f0765d2b2d9532256806409bb9::community_posts::PostV1>(arg3);
        let v1 = VoteKeyV1{
            actor : arg4,
            post  : v0,
        };
        let v2 = previous(arg0, v1);
        assert!(v2.revision == arg5, 3);
        if (v2.state == arg6) {
            return (v2.state, v2.revision)
        };
        assert!(v2.revision < 18446744073709551615, 6);
        let v3 = if (0x2::table::contains<0x2::object::ID, VoteCountsV1>(&arg0.counts, v0)) {
            *0x2::table::borrow<0x2::object::ID, VoteCountsV1>(&arg0.counts, v0)
        } else {
            VoteCountsV1{up_count: 0, down_count: 0}
        };
        let v4 = v3;
        if (v2.state == 1) {
            assert!(v4.up_count > 0, 5);
            v4.up_count = v4.up_count - 1;
        } else if (v2.state == 2) {
            assert!(v4.down_count > 0, 5);
            v4.down_count = v4.down_count - 1;
        };
        if (arg6 == 1) {
            assert!(v4.up_count < 18446744073709551615, 4);
            v4.up_count = v4.up_count + 1;
        } else if (arg6 == 2) {
            assert!(v4.down_count < 18446744073709551615, 4);
            v4.down_count = v4.down_count + 1;
        };
        let v5 = v2.revision + 1;
        if (0x2::table::contains<0x2::object::ID, VoteCountsV1>(&arg0.counts, v0)) {
            *0x2::table::borrow_mut<0x2::object::ID, VoteCountsV1>(&mut arg0.counts, v0) = v4;
        } else {
            0x2::table::add<0x2::object::ID, VoteCountsV1>(&mut arg0.counts, v0, v4);
        };
        if (0x2::table::contains<VoteKeyV1, VoteEdgeV1>(&arg0.edges, v1)) {
            let v6 = VoteEdgeV1{
                state    : arg6,
                revision : v5,
            };
            *0x2::table::borrow_mut<VoteKeyV1, VoteEdgeV1>(&mut arg0.edges, v1) = v6;
        } else {
            let v7 = VoteEdgeV1{
                state    : arg6,
                revision : v5,
            };
            0x2::table::add<VoteKeyV1, VoteEdgeV1>(&mut arg0.edges, v1, v7);
        };
        let v8 = VoteChangedV1{
            registry_id           : 0x2::object::id<VoteRegistryV1>(arg0),
            community_registry_id : 0x2::object::id<0x5e3e75de3e1f661ffcad9bd0d53f3ea97e2e48f0765d2b2d9532256806409bb9::community_posts::CommunityRegistryV1>(arg1),
            profile_registry_id   : 0x5e3e75de3e1f661ffcad9bd0d53f3ea97e2e48f0765d2b2d9532256806409bb9::profile::registry_id(arg2),
            post_id               : v0,
            actor                 : arg4,
            state                 : arg6,
            revision              : v5,
            up_count              : v4.up_count,
            down_count            : v4.down_count,
        };
        0x2::event::emit<VoteChangedV1>(v8);
        (arg6, v5)
    }

    // decompiled from Move bytecode v7
}

