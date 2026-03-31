module 0x179af5a6954da7be035339a9fb4aa9aecd0be6b0dfc6f92775bfc4588cc29832::seal_approve {
    struct SealPolicy has key {
        id: 0x2::object::UID,
        version: u64,
        agent_id: 0x2::object::ID,
        grants: 0x2::table::Table<address, u64>,
    }

    struct SealPolicyCap has store, key {
        id: 0x2::object::UID,
        policy_id: 0x2::object::ID,
    }

    struct AccessGranted has copy, drop {
        policy_id: 0x2::object::ID,
        agent_id: 0x2::object::ID,
        grantee: address,
        expiry_ms: u64,
        granted_by: address,
    }

    struct AccessRevoked has copy, drop {
        policy_id: 0x2::object::ID,
        agent_id: 0x2::object::ID,
        grantee: address,
        revoked_by: address,
    }

    struct PolicyCreated has copy, drop {
        policy_id: 0x2::object::ID,
        agent_id: 0x2::object::ID,
        owner: address,
    }

    entry fun seal_approve(arg0: vector<u8>, arg1: &SealPolicy, arg2: &0x179af5a6954da7be035339a9fb4aa9aecd0be6b0dfc6f92775bfc4588cc29832::agent::Agent) {
        assert!(arg1.version == 1, 101);
        assert_identity_matches_agent(&arg0, arg2);
        assert!(0x2::object::id<0x179af5a6954da7be035339a9fb4aa9aecd0be6b0dfc6f92775bfc4588cc29832::agent::Agent>(arg2) == arg1.agent_id, 100);
    }

    fun assert_identity_matches_agent(arg0: &vector<u8>, arg1: &0x179af5a6954da7be035339a9fb4aa9aecd0be6b0dfc6f92775bfc4588cc29832::agent::Agent) {
        let v0 = 0x2::object::id<0x179af5a6954da7be035339a9fb4aa9aecd0be6b0dfc6f92775bfc4588cc29832::agent::Agent>(arg1);
        let v1 = 0x2::object::id_to_bytes(&v0);
        let v2 = 0x1::vector::length<u8>(&v1);
        assert!(0x1::vector::length<u8>(arg0) >= v2, 100);
        let v3 = 0;
        while (v3 < v2) {
            assert!(*0x1::vector::borrow<u8>(arg0, v3) == *0x1::vector::borrow<u8>(&v1, v3), 100);
            v3 = v3 + 1;
        };
    }

    fun assert_identity_matches_policy(arg0: &vector<u8>, arg1: &SealPolicy) {
        let v0 = 0x2::object::id_to_bytes(&arg1.agent_id);
        let v1 = 0x1::vector::length<u8>(&v0);
        assert!(0x1::vector::length<u8>(arg0) >= v1, 100);
        let v2 = 0;
        while (v2 < v1) {
            assert!(*0x1::vector::borrow<u8>(arg0, v2) == *0x1::vector::borrow<u8>(&v0, v2), 100);
            v2 = v2 + 1;
        };
    }

    fun check_grantee_access(arg0: &SealPolicy, arg1: address, arg2: &0x2::clock::Clock) : bool {
        if (!0x2::table::contains<address, u64>(&arg0.grants, arg1)) {
            return false
        };
        0x2::clock::timestamp_ms(arg2) <= *0x2::table::borrow<address, u64>(&arg0.grants, arg1)
    }

    public fun create_policy(arg0: &0x179af5a6954da7be035339a9fb4aa9aecd0be6b0dfc6f92775bfc4588cc29832::agent::Agent, arg1: &mut 0x2::tx_context::TxContext) : (SealPolicy, SealPolicyCap) {
        let v0 = 0x2::object::id<0x179af5a6954da7be035339a9fb4aa9aecd0be6b0dfc6f92775bfc4588cc29832::agent::Agent>(arg0);
        let v1 = SealPolicy{
            id       : 0x2::object::new(arg1),
            version  : 1,
            agent_id : v0,
            grants   : 0x2::table::new<address, u64>(arg1),
        };
        let v2 = 0x2::object::id<SealPolicy>(&v1);
        let v3 = SealPolicyCap{
            id        : 0x2::object::new(arg1),
            policy_id : v2,
        };
        let v4 = PolicyCreated{
            policy_id : v2,
            agent_id  : v0,
            owner     : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<PolicyCreated>(v4);
        (v1, v3)
    }

    entry fun create_policy_entry(arg0: &0x179af5a6954da7be035339a9fb4aa9aecd0be6b0dfc6f92775bfc4588cc29832::agent::Agent, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = create_policy(arg0, arg1);
        0x2::transfer::share_object<SealPolicy>(v0);
        0x2::transfer::transfer<SealPolicyCap>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun get_agent_id(arg0: &SealPolicy) : 0x2::object::ID {
        arg0.agent_id
    }

    public fun get_grant_expiry(arg0: &SealPolicy, arg1: address) : u64 {
        assert!(0x2::table::contains<address, u64>(&arg0.grants, arg1), 104);
        *0x2::table::borrow<address, u64>(&arg0.grants, arg1)
    }

    public fun get_version(arg0: &SealPolicy) : u64 {
        arg0.version
    }

    public fun grant_access(arg0: &mut SealPolicy, arg1: &SealPolicyCap, arg2: address, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 101);
        assert!(arg1.policy_id == 0x2::object::id<SealPolicy>(arg0), 102);
        assert!(!0x2::table::contains<address, u64>(&arg0.grants, arg2), 103);
        assert!(arg3 > 0x2::clock::timestamp_ms(arg4), 105);
        0x2::table::add<address, u64>(&mut arg0.grants, arg2, arg3);
        let v0 = AccessGranted{
            policy_id  : 0x2::object::id<SealPolicy>(arg0),
            agent_id   : arg0.agent_id,
            grantee    : arg2,
            expiry_ms  : arg3,
            granted_by : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<AccessGranted>(v0);
    }

    public fun has_access(arg0: &SealPolicy, arg1: address, arg2: &0x2::clock::Clock) : bool {
        check_grantee_access(arg0, arg1, arg2)
    }

    public fun revoke_access(arg0: &mut SealPolicy, arg1: &SealPolicyCap, arg2: address, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 101);
        assert!(arg1.policy_id == 0x2::object::id<SealPolicy>(arg0), 102);
        assert!(0x2::table::contains<address, u64>(&arg0.grants, arg2), 104);
        0x2::table::remove<address, u64>(&mut arg0.grants, arg2);
        let v0 = AccessRevoked{
            policy_id  : 0x2::object::id<SealPolicy>(arg0),
            agent_id   : arg0.agent_id,
            grantee    : arg2,
            revoked_by : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<AccessRevoked>(v0);
    }

    entry fun seal_approve_grantee(arg0: vector<u8>, arg1: &SealPolicy, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1.version == 1, 101);
        assert_identity_matches_policy(&arg0, arg1);
        assert!(check_grantee_access(arg1, 0x2::tx_context::sender(arg3), arg2), 100);
    }

    // decompiled from Move bytecode v6
}

