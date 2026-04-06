module 0x179af5a6954da7be035339a9fb4aa9aecd0be6b0dfc6f92775bfc4588cc29832::agent_identity {
    struct AgentIdentityAnchor has store, key {
        id: 0x2::object::UID,
        owner: address,
        agent_id: 0x1::string::String,
        latest_blob_id: 0x1::string::String,
        latest_checksum: 0x1::string::String,
        version: u64,
        created_at_ms: u64,
        updated_at_ms: u64,
    }

    struct AgentIdentityOwnerCap has store, key {
        id: 0x2::object::UID,
        anchor_id: 0x2::object::ID,
    }

    struct IdentityAnchorCreated has copy, drop {
        anchor_id: 0x2::object::ID,
        owner: address,
        version: u64,
        timestamp_ms: u64,
    }

    struct IdentityAnchorUpdated has copy, drop {
        anchor_id: 0x2::object::ID,
        old_version: u64,
        new_version: u64,
        timestamp_ms: u64,
    }

    public fun create_anchor(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (AgentIdentityAnchor, AgentIdentityOwnerCap) {
        assert!(!0x1::string::is_empty(&arg0), 2);
        assert!(!0x1::string::is_empty(&arg1), 3);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = 0x2::tx_context::sender(arg5);
        let v2 = AgentIdentityAnchor{
            id              : 0x2::object::new(arg5),
            owner           : v1,
            agent_id        : arg0,
            latest_blob_id  : arg1,
            latest_checksum : arg2,
            version         : arg3,
            created_at_ms   : v0,
            updated_at_ms   : v0,
        };
        let v3 = AgentIdentityOwnerCap{
            id        : 0x2::object::new(arg5),
            anchor_id : 0x2::object::id<AgentIdentityAnchor>(&v2),
        };
        let v4 = IdentityAnchorCreated{
            anchor_id    : 0x2::object::id<AgentIdentityAnchor>(&v2),
            owner        : v1,
            version      : v2.version,
            timestamp_ms : v0,
        };
        0x2::event::emit<IdentityAnchorCreated>(v4);
        (v2, v3)
    }

    entry fun create_and_transfer(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = create_anchor(arg0, arg1, arg2, arg3, arg4, arg5);
        0x2::transfer::transfer<AgentIdentityAnchor>(v0, 0x2::tx_context::sender(arg5));
        0x2::transfer::transfer<AgentIdentityOwnerCap>(v1, 0x2::tx_context::sender(arg5));
    }

    entry fun update(arg0: &mut AgentIdentityAnchor, arg1: &AgentIdentityOwnerCap, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        update_anchor(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public fun update_anchor(arg0: &mut AgentIdentityAnchor, arg1: &AgentIdentityOwnerCap, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg6) == arg0.owner, 0);
        assert!(arg1.anchor_id == 0x2::object::id<AgentIdentityAnchor>(arg0), 1);
        assert!(!0x1::string::is_empty(&arg2), 3);
        assert!(arg4 > arg0.version, 4);
        let v0 = 0x2::clock::timestamp_ms(arg5);
        arg0.latest_blob_id = arg2;
        arg0.latest_checksum = arg3;
        arg0.version = arg4;
        arg0.updated_at_ms = v0;
        let v1 = IdentityAnchorUpdated{
            anchor_id    : 0x2::object::id<AgentIdentityAnchor>(arg0),
            old_version  : arg0.version,
            new_version  : arg4,
            timestamp_ms : v0,
        };
        0x2::event::emit<IdentityAnchorUpdated>(v1);
    }

    // decompiled from Move bytecode v7
}

