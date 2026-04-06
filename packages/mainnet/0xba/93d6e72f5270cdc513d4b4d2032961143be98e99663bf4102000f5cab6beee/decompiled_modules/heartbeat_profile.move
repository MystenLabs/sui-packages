module 0x179af5a6954da7be035339a9fb4aa9aecd0be6b0dfc6f92775bfc4588cc29832::heartbeat_profile {
    struct HeartbeatProfileAnchor has store, key {
        id: 0x2::object::UID,
        owner: address,
        agent_id: 0x1::string::String,
        timezone: 0x1::string::String,
        default_mode_id: 0x1::string::String,
        profile_json: 0x1::string::String,
        overrides_json: 0x1::string::String,
        version: u64,
        created_at_ms: u64,
        updated_at_ms: u64,
    }

    struct HeartbeatProfileOwnerCap has store, key {
        id: 0x2::object::UID,
        anchor_id: 0x2::object::ID,
    }

    struct HeartbeatProfileCreated has copy, drop {
        anchor_id: 0x2::object::ID,
        owner: address,
        agent_id: 0x1::string::String,
        version: u64,
        timestamp_ms: u64,
    }

    struct HeartbeatProfileUpdated has copy, drop {
        anchor_id: 0x2::object::ID,
        old_version: u64,
        new_version: u64,
        timestamp_ms: u64,
    }

    struct HeartbeatOverrideUpdated has copy, drop {
        anchor_id: 0x2::object::ID,
        version: u64,
        timestamp_ms: u64,
    }

    entry fun clear_overrides(arg0: &mut HeartbeatProfileAnchor, arg1: &HeartbeatProfileOwnerCap, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        set_overrides(arg0, arg1, 0x1::string::utf8(b"[]"), arg2, arg3, arg4);
    }

    public fun create_anchor(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (HeartbeatProfileAnchor, HeartbeatProfileOwnerCap) {
        assert!(!0x1::string::is_empty(&arg0), 2);
        assert!(!0x1::string::is_empty(&arg1), 3);
        assert!(!0x1::string::is_empty(&arg2), 4);
        assert!(!0x1::string::is_empty(&arg3), 5);
        assert!(!0x1::string::is_empty(&arg4), 7);
        let v0 = 0x2::clock::timestamp_ms(arg6);
        let v1 = 0x2::tx_context::sender(arg7);
        let v2 = HeartbeatProfileAnchor{
            id              : 0x2::object::new(arg7),
            owner           : v1,
            agent_id        : arg0,
            timezone        : arg1,
            default_mode_id : arg2,
            profile_json    : arg3,
            overrides_json  : arg4,
            version         : arg5,
            created_at_ms   : v0,
            updated_at_ms   : v0,
        };
        let v3 = HeartbeatProfileOwnerCap{
            id        : 0x2::object::new(arg7),
            anchor_id : 0x2::object::id<HeartbeatProfileAnchor>(&v2),
        };
        let v4 = HeartbeatProfileCreated{
            anchor_id    : 0x2::object::id<HeartbeatProfileAnchor>(&v2),
            owner        : v1,
            agent_id     : v2.agent_id,
            version      : v2.version,
            timestamp_ms : v0,
        };
        0x2::event::emit<HeartbeatProfileCreated>(v4);
        (v2, v3)
    }

    entry fun create_and_transfer(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = create_anchor(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        0x2::transfer::transfer<HeartbeatProfileAnchor>(v0, 0x2::tx_context::sender(arg7));
        0x2::transfer::transfer<HeartbeatProfileOwnerCap>(v1, 0x2::tx_context::sender(arg7));
    }

    public fun set_overrides(arg0: &mut HeartbeatProfileAnchor, arg1: &HeartbeatProfileOwnerCap, arg2: 0x1::string::String, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == arg0.owner, 0);
        assert!(arg1.anchor_id == 0x2::object::id<HeartbeatProfileAnchor>(arg0), 1);
        assert!(!0x1::string::is_empty(&arg2), 7);
        assert!(arg3 > arg0.version, 6);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        arg0.overrides_json = arg2;
        arg0.version = arg3;
        arg0.updated_at_ms = v0;
        let v1 = HeartbeatOverrideUpdated{
            anchor_id    : 0x2::object::id<HeartbeatProfileAnchor>(arg0),
            version      : arg3,
            timestamp_ms : v0,
        };
        0x2::event::emit<HeartbeatOverrideUpdated>(v1);
    }

    entry fun update(arg0: &mut HeartbeatProfileAnchor, arg1: &HeartbeatProfileOwnerCap, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        update_anchor(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public fun update_anchor(arg0: &mut HeartbeatProfileAnchor, arg1: &HeartbeatProfileOwnerCap, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg7) == arg0.owner, 0);
        assert!(arg1.anchor_id == 0x2::object::id<HeartbeatProfileAnchor>(arg0), 1);
        assert!(!0x1::string::is_empty(&arg2), 3);
        assert!(!0x1::string::is_empty(&arg3), 4);
        assert!(!0x1::string::is_empty(&arg4), 5);
        assert!(arg5 > arg0.version, 6);
        let v0 = 0x2::clock::timestamp_ms(arg6);
        arg0.timezone = arg2;
        arg0.default_mode_id = arg3;
        arg0.profile_json = arg4;
        arg0.version = arg5;
        arg0.updated_at_ms = v0;
        let v1 = HeartbeatProfileUpdated{
            anchor_id    : 0x2::object::id<HeartbeatProfileAnchor>(arg0),
            old_version  : arg0.version,
            new_version  : arg5,
            timestamp_ms : v0,
        };
        0x2::event::emit<HeartbeatProfileUpdated>(v1);
    }

    entry fun update_overrides(arg0: &mut HeartbeatProfileAnchor, arg1: &HeartbeatProfileOwnerCap, arg2: 0x1::string::String, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        set_overrides(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    // decompiled from Move bytecode v7
}

