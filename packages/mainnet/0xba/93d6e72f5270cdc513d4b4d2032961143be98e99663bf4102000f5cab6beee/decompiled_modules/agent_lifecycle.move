module 0x179af5a6954da7be035339a9fb4aa9aecd0be6b0dfc6f92775bfc4588cc29832::agent_lifecycle {
    struct AgentLifecycleAnchor has store, key {
        id: 0x2::object::UID,
        owner: address,
        agent_id: 0x1::string::String,
        latest_snapshot_blob_id: 0x1::string::String,
        latest_transition_blob_id: 0x1::string::String,
        latest_checksum: 0x1::string::String,
        current_state: 0x1::string::String,
        version: u64,
        created_at_ms: u64,
        updated_at_ms: u64,
    }

    struct AgentLifecycleOwnerCap has store, key {
        id: 0x2::object::UID,
        anchor_id: 0x2::object::ID,
    }

    struct LifecycleAnchorCreated has copy, drop {
        anchor_id: 0x2::object::ID,
        owner: address,
        state: 0x1::string::String,
        version: u64,
        timestamp_ms: u64,
    }

    struct LifecycleAnchorUpdated has copy, drop {
        anchor_id: 0x2::object::ID,
        old_state: 0x1::string::String,
        new_state: 0x1::string::String,
        old_version: u64,
        new_version: u64,
        timestamp_ms: u64,
    }

    public fun create_anchor(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (AgentLifecycleAnchor, AgentLifecycleOwnerCap) {
        assert!(!0x1::string::is_empty(&arg0), 2);
        assert!(!0x1::string::is_empty(&arg1), 3);
        assert!(!0x1::string::is_empty(&arg4), 4);
        let v0 = 0x2::clock::timestamp_ms(arg6);
        let v1 = 0x2::tx_context::sender(arg7);
        let v2 = AgentLifecycleAnchor{
            id                        : 0x2::object::new(arg7),
            owner                     : v1,
            agent_id                  : arg0,
            latest_snapshot_blob_id   : arg1,
            latest_transition_blob_id : arg2,
            latest_checksum           : arg3,
            current_state             : arg4,
            version                   : arg5,
            created_at_ms             : v0,
            updated_at_ms             : v0,
        };
        let v3 = AgentLifecycleOwnerCap{
            id        : 0x2::object::new(arg7),
            anchor_id : 0x2::object::id<AgentLifecycleAnchor>(&v2),
        };
        let v4 = LifecycleAnchorCreated{
            anchor_id    : 0x2::object::id<AgentLifecycleAnchor>(&v2),
            owner        : v1,
            state        : v2.current_state,
            version      : v2.version,
            timestamp_ms : v0,
        };
        0x2::event::emit<LifecycleAnchorCreated>(v4);
        (v2, v3)
    }

    entry fun create_and_transfer(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = create_anchor(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        0x2::transfer::transfer<AgentLifecycleAnchor>(v0, 0x2::tx_context::sender(arg7));
        0x2::transfer::transfer<AgentLifecycleOwnerCap>(v1, 0x2::tx_context::sender(arg7));
    }

    entry fun update(arg0: &mut AgentLifecycleAnchor, arg1: &AgentLifecycleOwnerCap, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u64, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) {
        update_anchor(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public fun update_anchor(arg0: &mut AgentLifecycleAnchor, arg1: &AgentLifecycleOwnerCap, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u64, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg8) == arg0.owner, 0);
        assert!(arg1.anchor_id == 0x2::object::id<AgentLifecycleAnchor>(arg0), 1);
        assert!(!0x1::string::is_empty(&arg2), 3);
        assert!(!0x1::string::is_empty(&arg5), 4);
        assert!(arg6 > arg0.version, 5);
        let v0 = 0x2::clock::timestamp_ms(arg7);
        arg0.latest_snapshot_blob_id = arg2;
        arg0.latest_transition_blob_id = arg3;
        arg0.latest_checksum = arg4;
        arg0.current_state = arg5;
        arg0.version = arg6;
        arg0.updated_at_ms = v0;
        let v1 = LifecycleAnchorUpdated{
            anchor_id    : 0x2::object::id<AgentLifecycleAnchor>(arg0),
            old_state    : arg0.current_state,
            new_state    : arg5,
            old_version  : arg0.version,
            new_version  : arg6,
            timestamp_ms : v0,
        };
        0x2::event::emit<LifecycleAnchorUpdated>(v1);
    }

    // decompiled from Move bytecode v7
}

