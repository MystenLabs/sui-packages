module 0x179af5a6954da7be035339a9fb4aa9aecd0be6b0dfc6f92775bfc4588cc29832::governance_registry {
    struct GovernanceRegistry has key {
        id: 0x2::object::UID,
        owner: address,
        config_blob_id: 0x1::string::String,
        policy_blob_id: 0x1::string::String,
        audit_blob_id: 0x1::string::String,
        trust_blob_id: 0x1::string::String,
        updated_at_ms: u64,
        version: u64,
    }

    struct GovernanceRegistryOwnerCap has store, key {
        id: 0x2::object::UID,
        registry_id: 0x2::object::ID,
    }

    struct RegistryCreated has copy, drop {
        registry_id: 0x2::object::ID,
        owner: address,
    }

    struct RegistryUpdated has copy, drop {
        registry_id: 0x2::object::ID,
        field_name: 0x1::string::String,
        old_blob_id: 0x1::string::String,
        new_blob_id: 0x1::string::String,
        updated_by: address,
        version: u64,
    }

    fun assert_non_empty_blob_id(arg0: &0x1::string::String) {
        assert!(0x1::string::length(arg0) > 0, 1);
    }

    fun assert_owner_cap(arg0: &GovernanceRegistry, arg1: &GovernanceRegistryOwnerCap) {
        assert!(arg1.registry_id == 0x2::object::id<GovernanceRegistry>(arg0), 2);
    }

    public fun create(arg0: &mut 0x2::tx_context::TxContext) : (GovernanceRegistry, GovernanceRegistryOwnerCap) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = GovernanceRegistry{
            id             : 0x2::object::new(arg0),
            owner          : v0,
            config_blob_id : 0x1::string::utf8(b""),
            policy_blob_id : 0x1::string::utf8(b""),
            audit_blob_id  : 0x1::string::utf8(b""),
            trust_blob_id  : 0x1::string::utf8(b""),
            updated_at_ms  : 0,
            version        : 0,
        };
        let v2 = 0x2::object::id<GovernanceRegistry>(&v1);
        let v3 = GovernanceRegistryOwnerCap{
            id          : 0x2::object::new(arg0),
            registry_id : v2,
        };
        let v4 = RegistryCreated{
            registry_id : v2,
            owner       : v0,
        };
        0x2::event::emit<RegistryCreated>(v4);
        (v1, v3)
    }

    public entry fun create_and_transfer(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let (v1, v2) = create(arg0);
        0x2::transfer::transfer<GovernanceRegistry>(v1, v0);
        0x2::transfer::transfer<GovernanceRegistryOwnerCap>(v2, v0);
    }

    fun do_update_audit_blob_id(arg0: &mut GovernanceRegistry, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert_non_empty_blob_id(&arg1);
        let v0 = arg0.version + 1;
        arg0.audit_blob_id = arg1;
        arg0.updated_at_ms = 0x2::clock::timestamp_ms(arg2);
        arg0.version = v0;
        let v1 = RegistryUpdated{
            registry_id : 0x2::object::id<GovernanceRegistry>(arg0),
            field_name  : 0x1::string::utf8(b"audit"),
            old_blob_id : arg0.audit_blob_id,
            new_blob_id : arg0.audit_blob_id,
            updated_by  : 0x2::tx_context::sender(arg3),
            version     : v0,
        };
        0x2::event::emit<RegistryUpdated>(v1);
    }

    fun do_update_config_blob_id(arg0: &mut GovernanceRegistry, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert_non_empty_blob_id(&arg1);
        let v0 = arg0.version + 1;
        arg0.config_blob_id = arg1;
        arg0.updated_at_ms = 0x2::clock::timestamp_ms(arg2);
        arg0.version = v0;
        let v1 = RegistryUpdated{
            registry_id : 0x2::object::id<GovernanceRegistry>(arg0),
            field_name  : 0x1::string::utf8(b"config"),
            old_blob_id : arg0.config_blob_id,
            new_blob_id : arg0.config_blob_id,
            updated_by  : 0x2::tx_context::sender(arg3),
            version     : v0,
        };
        0x2::event::emit<RegistryUpdated>(v1);
    }

    fun do_update_policy_blob_id(arg0: &mut GovernanceRegistry, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert_non_empty_blob_id(&arg1);
        let v0 = arg0.version + 1;
        arg0.policy_blob_id = arg1;
        arg0.updated_at_ms = 0x2::clock::timestamp_ms(arg2);
        arg0.version = v0;
        let v1 = RegistryUpdated{
            registry_id : 0x2::object::id<GovernanceRegistry>(arg0),
            field_name  : 0x1::string::utf8(b"policy"),
            old_blob_id : arg0.policy_blob_id,
            new_blob_id : arg0.policy_blob_id,
            updated_by  : 0x2::tx_context::sender(arg3),
            version     : v0,
        };
        0x2::event::emit<RegistryUpdated>(v1);
    }

    fun do_update_trust_blob_id(arg0: &mut GovernanceRegistry, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert_non_empty_blob_id(&arg1);
        let v0 = arg0.version + 1;
        arg0.trust_blob_id = arg1;
        arg0.updated_at_ms = 0x2::clock::timestamp_ms(arg2);
        arg0.version = v0;
        let v1 = RegistryUpdated{
            registry_id : 0x2::object::id<GovernanceRegistry>(arg0),
            field_name  : 0x1::string::utf8(b"trust"),
            old_blob_id : arg0.trust_blob_id,
            new_blob_id : arg0.trust_blob_id,
            updated_by  : 0x2::tx_context::sender(arg3),
            version     : v0,
        };
        0x2::event::emit<RegistryUpdated>(v1);
    }

    public fun get_audit_blob_id(arg0: &GovernanceRegistry) : 0x1::string::String {
        arg0.audit_blob_id
    }

    public fun get_config_blob_id(arg0: &GovernanceRegistry) : 0x1::string::String {
        arg0.config_blob_id
    }

    public fun get_policy_blob_id(arg0: &GovernanceRegistry) : 0x1::string::String {
        arg0.policy_blob_id
    }

    public fun get_trust_blob_id(arg0: &GovernanceRegistry) : 0x1::string::String {
        arg0.trust_blob_id
    }

    public fun get_version(arg0: &GovernanceRegistry) : u64 {
        arg0.version
    }

    public entry fun transfer_ownership(arg0: &mut GovernanceRegistry, arg1: GovernanceRegistryOwnerCap, arg2: address, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 0);
        assert!(arg1.registry_id == 0x2::object::id<GovernanceRegistry>(arg0), 2);
        arg0.owner = arg2;
        0x2::transfer::transfer<GovernanceRegistryOwnerCap>(arg1, arg2);
    }

    public entry fun update_audit_blob_id(arg0: &mut GovernanceRegistry, arg1: &GovernanceRegistryOwnerCap, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_owner_cap(arg0, arg1);
        do_update_audit_blob_id(arg0, arg2, arg3, arg4);
    }

    public entry fun update_config_blob_id(arg0: &mut GovernanceRegistry, arg1: &GovernanceRegistryOwnerCap, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_owner_cap(arg0, arg1);
        do_update_config_blob_id(arg0, arg2, arg3, arg4);
    }

    public entry fun update_policy_blob_id(arg0: &mut GovernanceRegistry, arg1: &GovernanceRegistryOwnerCap, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_owner_cap(arg0, arg1);
        do_update_policy_blob_id(arg0, arg2, arg3, arg4);
    }

    public entry fun update_trust_blob_id(arg0: &mut GovernanceRegistry, arg1: &GovernanceRegistryOwnerCap, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_owner_cap(arg0, arg1);
        do_update_trust_blob_id(arg0, arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v7
}

