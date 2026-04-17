module 0x85abbe7ca8a197b2fd6b5eed2920d4b93effffb56a1502844ed3822297f63816::dwallet_subname_policy {
    struct SubnamePolicy has key {
        id: 0x2::object::UID,
        dwallet_cap: 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap,
        owner_cap_id: 0x2::object::ID,
        max_subnames: u64,
        issued_count: u64,
        expiration_ms: u64,
    }

    struct OwnerCap has store, key {
        id: 0x2::object::UID,
        policy_id: 0x2::object::ID,
    }

    struct PolicyCreated has copy, drop {
        policy_id: 0x2::object::ID,
        max_subnames: u64,
        expiration_ms: u64,
    }

    struct DelegateApproved has copy, drop {
        policy_id: 0x2::object::ID,
        digest_len: u64,
        issued: u64,
    }

    struct OwnerApproved has copy, drop {
        policy_id: 0x2::object::ID,
        digest_len: u64,
    }

    public fun delegate_approve_spike(arg0: &mut SubnamePolicy, arg1: &mut 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::DWalletCoordinator, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::MessageApproval {
        assert!(0x2::clock::timestamp_ms(arg3) < arg0.expiration_ms, 2);
        assert!(arg0.issued_count < arg0.max_subnames, 1);
        arg0.issued_count = arg0.issued_count + 1;
        let v0 = DelegateApproved{
            policy_id  : 0x2::object::uid_to_inner(&arg0.id),
            digest_len : 0x1::vector::length<u8>(&arg2),
            issued     : arg0.issued_count,
        };
        0x2::event::emit<DelegateApproved>(v0);
        0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::approve_message(arg1, &arg0.dwallet_cap, 0, 0, arg2)
    }

    public fun expiration_ms(arg0: &SubnamePolicy) : u64 {
        arg0.expiration_ms
    }

    public fun init_policy(arg0: 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : OwnerCap {
        let v0 = 0x2::object::new(arg3);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = OwnerCap{
            id        : 0x2::object::new(arg3),
            policy_id : v1,
        };
        let v3 = SubnamePolicy{
            id            : v0,
            dwallet_cap   : arg0,
            owner_cap_id  : 0x2::object::id<OwnerCap>(&v2),
            max_subnames  : arg1,
            issued_count  : 0,
            expiration_ms : arg2,
        };
        let v4 = PolicyCreated{
            policy_id     : v1,
            max_subnames  : arg1,
            expiration_ms : arg2,
        };
        0x2::event::emit<PolicyCreated>(v4);
        0x2::transfer::share_object<SubnamePolicy>(v3);
        v2
    }

    public fun issued_count(arg0: &SubnamePolicy) : u64 {
        arg0.issued_count
    }

    public fun max_subnames(arg0: &SubnamePolicy) : u64 {
        arg0.max_subnames
    }

    public fun owner_approve(arg0: &SubnamePolicy, arg1: &OwnerCap, arg2: &mut 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::DWalletCoordinator, arg3: vector<u8>) : 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::MessageApproval {
        assert!(arg1.policy_id == 0x2::object::uid_to_inner(&arg0.id), 3);
        let v0 = OwnerApproved{
            policy_id  : 0x2::object::uid_to_inner(&arg0.id),
            digest_len : 0x1::vector::length<u8>(&arg3),
        };
        0x2::event::emit<OwnerApproved>(v0);
        0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::approve_message(arg2, &arg0.dwallet_cap, 0, 0, arg3)
    }

    public fun owner_cap_id(arg0: &SubnamePolicy) : 0x2::object::ID {
        arg0.owner_cap_id
    }

    public fun policy_id(arg0: &SubnamePolicy) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public(friend) fun reclaim_quota(arg0: &mut SubnamePolicy, arg1: u64) {
        if (arg1 >= arg0.issued_count) {
            arg0.issued_count = 0;
        } else {
            arg0.issued_count = arg0.issued_count - arg1;
        };
    }

    public fun remaining(arg0: &SubnamePolicy) : u64 {
        arg0.max_subnames - arg0.issued_count
    }

    // decompiled from Move bytecode v7
}

