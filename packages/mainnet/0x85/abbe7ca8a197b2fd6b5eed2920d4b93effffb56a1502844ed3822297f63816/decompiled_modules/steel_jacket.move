module 0x85abbe7ca8a197b2fd6b5eed2920d4b93effffb56a1502844ed3822297f63816::steel_jacket {
    struct SteelJacket has key {
        id: 0x2::object::UID,
        policy_id: 0x2::object::ID,
        grace_period_ms: u64,
        pruned_count: u64,
        last_grind_ms: u64,
    }

    struct SteelJacketCap has store, key {
        id: 0x2::object::UID,
        jacket_id: 0x2::object::ID,
    }

    struct JacketAttached has copy, drop {
        jacket_id: 0x2::object::ID,
        policy_id: 0x2::object::ID,
        grace_period_ms: u64,
    }

    struct PruneRecorded has copy, drop {
        jacket_id: 0x2::object::ID,
        policy_id: 0x2::object::ID,
        subname: vector<u8>,
        pruned_at_ms: u64,
        pruned_total: u64,
    }

    public fun attach(arg0: &0x85abbe7ca8a197b2fd6b5eed2920d4b93effffb56a1502844ed3822297f63816::dwallet_subname_policy::SubnamePolicy, arg1: &0x85abbe7ca8a197b2fd6b5eed2920d4b93effffb56a1502844ed3822297f63816::dwallet_subname_policy::OwnerCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : SteelJacketCap {
        assert!(0x85abbe7ca8a197b2fd6b5eed2920d4b93effffb56a1502844ed3822297f63816::dwallet_subname_policy::owner_cap_id(arg0) == 0x2::object::id<0x85abbe7ca8a197b2fd6b5eed2920d4b93effffb56a1502844ed3822297f63816::dwallet_subname_policy::OwnerCap>(arg1), 10);
        let v0 = 0x2::object::new(arg3);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = 0x85abbe7ca8a197b2fd6b5eed2920d4b93effffb56a1502844ed3822297f63816::dwallet_subname_policy::policy_id(arg0);
        let v3 = SteelJacket{
            id              : v0,
            policy_id       : v2,
            grace_period_ms : arg2,
            pruned_count    : 0,
            last_grind_ms   : 0,
        };
        let v4 = SteelJacketCap{
            id        : 0x2::object::new(arg3),
            jacket_id : v1,
        };
        let v5 = JacketAttached{
            jacket_id       : v1,
            policy_id       : v2,
            grace_period_ms : arg2,
        };
        0x2::event::emit<JacketAttached>(v5);
        0x2::transfer::share_object<SteelJacket>(v3);
        v4
    }

    public fun cap_jacket_id(arg0: &SteelJacketCap) : 0x2::object::ID {
        arg0.jacket_id
    }

    public fun grace_period_ms(arg0: &SteelJacket) : u64 {
        arg0.grace_period_ms
    }

    public fun jacket_policy_id(arg0: &SteelJacket) : 0x2::object::ID {
        arg0.policy_id
    }

    public fun last_grind_ms(arg0: &SteelJacket) : u64 {
        arg0.last_grind_ms
    }

    public fun pruned_count(arg0: &SteelJacket) : u64 {
        arg0.pruned_count
    }

    public fun record_prune(arg0: &mut 0x85abbe7ca8a197b2fd6b5eed2920d4b93effffb56a1502844ed3822297f63816::dwallet_subname_policy::SubnamePolicy, arg1: &mut SteelJacket, arg2: &SteelJacketCap, arg3: vector<u8>, arg4: &0x2::clock::Clock) {
        assert!(arg2.jacket_id == 0x2::object::uid_to_inner(&arg1.id), 11);
        assert!(arg1.policy_id == 0x85abbe7ca8a197b2fd6b5eed2920d4b93effffb56a1502844ed3822297f63816::dwallet_subname_policy::policy_id(arg0), 10);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        assert!(v0 >= 0x85abbe7ca8a197b2fd6b5eed2920d4b93effffb56a1502844ed3822297f63816::dwallet_subname_policy::expiration_ms(arg0) + arg1.grace_period_ms, 12);
        0x85abbe7ca8a197b2fd6b5eed2920d4b93effffb56a1502844ed3822297f63816::dwallet_subname_policy::reclaim_quota(arg0, 1);
        arg1.pruned_count = arg1.pruned_count + 1;
        arg1.last_grind_ms = v0;
        let v1 = PruneRecorded{
            jacket_id    : 0x2::object::uid_to_inner(&arg1.id),
            policy_id    : arg1.policy_id,
            subname      : arg3,
            pruned_at_ms : v0,
            pruned_total : arg1.pruned_count,
        };
        0x2::event::emit<PruneRecorded>(v1);
    }

    // decompiled from Move bytecode v7
}

