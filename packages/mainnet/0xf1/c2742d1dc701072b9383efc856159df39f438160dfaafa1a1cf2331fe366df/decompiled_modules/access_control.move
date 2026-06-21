module 0xf1c2742d1dc701072b9383efc856159df39f438160dfaafa1a1cf2331fe366df::access_control {
    struct AccessPolicy has key {
        id: 0x2::object::UID,
        owner: address,
        file_id: address,
        gate_type: u8,
        allowed_addresses: vector<address>,
        gate_data: vector<u8>,
        permission: u8,
        expires_at_ms: u64,
        max_downloads: u64,
        download_count: u64,
        revoked: bool,
        created_at_ms: u64,
    }

    struct PolicyCreatedEvent has copy, drop {
        policy_id: address,
        file_id: address,
        owner: address,
        gate_type: u8,
        permission: u8,
    }

    struct PolicyRevokedEvent has copy, drop {
        policy_id: address,
        file_id: address,
    }

    struct AccessGrantedEvent has copy, drop {
        policy_id: address,
        file_id: address,
        accessor: address,
        permission: u8,
        download_count: u64,
    }

    public fun add_allowed_address(arg0: &mut AccessPolicy, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 304);
        assert!(arg0.gate_type == 0, 306);
        if (!0x1::vector::contains<address>(&arg0.allowed_addresses, &arg1)) {
            0x1::vector::push_back<address>(&mut arg0.allowed_addresses, arg1);
        };
    }

    public fun can_edit(arg0: &AccessPolicy) : bool {
        arg0.permission == 2
    }

    public fun can_share(arg0: &AccessPolicy) : bool {
        arg0.permission >= 1
    }

    public fun create_master_policy(arg0: &0xf1c2742d1dc701072b9383efc856159df39f438160dfaafa1a1cf2331fe366df::admin::SystemConfig, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : address {
        0xf1c2742d1dc701072b9383efc856159df39f438160dfaafa1a1cf2331fe366df::admin::assert_not_paused(arg0);
        let v0 = AccessPolicy{
            id                : 0x2::object::new(arg3),
            owner             : 0x2::tx_context::sender(arg3),
            file_id           : arg1,
            gate_type         : 255,
            allowed_addresses : 0x1::vector::empty<address>(),
            gate_data         : 0x1::vector::empty<u8>(),
            permission        : 2,
            expires_at_ms     : 0,
            max_downloads     : 0,
            download_count    : 0,
            revoked           : false,
            created_at_ms     : 0x2::clock::timestamp_ms(arg2),
        };
        let v1 = 0x2::object::id_address<AccessPolicy>(&v0);
        let v2 = PolicyCreatedEvent{
            policy_id  : v1,
            file_id    : arg1,
            owner      : 0x2::tx_context::sender(arg3),
            gate_type  : 255,
            permission : 2,
        };
        0x2::event::emit<PolicyCreatedEvent>(v2);
        0x2::transfer::share_object<AccessPolicy>(v0);
        v1
    }

    public fun create_master_policy_entry(arg0: &0xf1c2742d1dc701072b9383efc856159df39f438160dfaafa1a1cf2331fe366df::admin::SystemConfig, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        create_master_policy(arg0, arg1, arg2, arg3);
    }

    public fun create_public_policy(arg0: &0xf1c2742d1dc701072b9383efc856159df39f438160dfaafa1a1cf2331fe366df::admin::SystemConfig, arg1: address, arg2: u8, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xf1c2742d1dc701072b9383efc856159df39f438160dfaafa1a1cf2331fe366df::admin::assert_not_paused(arg0);
        assert!(arg2 == 1 || arg2 == 2, 305);
        let v0 = AccessPolicy{
            id                : 0x2::object::new(arg6),
            owner             : 0x2::tx_context::sender(arg6),
            file_id           : arg1,
            gate_type         : 1,
            allowed_addresses : 0x1::vector::empty<address>(),
            gate_data         : 0x1::vector::empty<u8>(),
            permission        : arg2,
            expires_at_ms     : arg3,
            max_downloads     : arg4,
            download_count    : 0,
            revoked           : false,
            created_at_ms     : 0x2::clock::timestamp_ms(arg5),
        };
        let v1 = PolicyCreatedEvent{
            policy_id  : 0x2::object::id_address<AccessPolicy>(&v0),
            file_id    : arg1,
            owner      : 0x2::tx_context::sender(arg6),
            gate_type  : 1,
            permission : arg2,
        };
        0x2::event::emit<PolicyCreatedEvent>(v1);
        0x2::transfer::share_object<AccessPolicy>(v0);
    }

    public fun create_share_policy(arg0: &0xf1c2742d1dc701072b9383efc856159df39f438160dfaafa1a1cf2331fe366df::admin::SystemConfig, arg1: address, arg2: vector<address>, arg3: u8, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0xf1c2742d1dc701072b9383efc856159df39f438160dfaafa1a1cf2331fe366df::admin::assert_not_paused(arg0);
        assert!(arg3 == 1 || arg3 == 2, 305);
        let v0 = AccessPolicy{
            id                : 0x2::object::new(arg7),
            owner             : 0x2::tx_context::sender(arg7),
            file_id           : arg1,
            gate_type         : 0,
            allowed_addresses : arg2,
            gate_data         : 0x1::vector::empty<u8>(),
            permission        : arg3,
            expires_at_ms     : arg4,
            max_downloads     : arg5,
            download_count    : 0,
            revoked           : false,
            created_at_ms     : 0x2::clock::timestamp_ms(arg6),
        };
        let v1 = PolicyCreatedEvent{
            policy_id  : 0x2::object::id_address<AccessPolicy>(&v0),
            file_id    : arg1,
            owner      : 0x2::tx_context::sender(arg7),
            gate_type  : 0,
            permission : arg3,
        };
        0x2::event::emit<PolicyCreatedEvent>(v1);
        0x2::transfer::share_object<AccessPolicy>(v0);
    }

    public fun download_count(arg0: &AccessPolicy) : u64 {
        arg0.download_count
    }

    public fun expires_at(arg0: &AccessPolicy) : u64 {
        arg0.expires_at_ms
    }

    public fun file_id(arg0: &AccessPolicy) : address {
        arg0.file_id
    }

    public fun gate_type(arg0: &AccessPolicy) : u8 {
        arg0.gate_type
    }

    public fun is_allowed(arg0: &AccessPolicy, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.allowed_addresses, &arg1)
    }

    public fun is_master(arg0: &AccessPolicy) : bool {
        arg0.gate_type == 255
    }

    public fun is_public(arg0: &AccessPolicy) : bool {
        arg0.gate_type == 1
    }

    public fun is_revoked(arg0: &AccessPolicy) : bool {
        arg0.revoked
    }

    public fun owner(arg0: &AccessPolicy) : address {
        arg0.owner
    }

    public fun permission(arg0: &AccessPolicy) : u8 {
        arg0.permission
    }

    public fun permission_edit() : u8 {
        2
    }

    public fun permission_share() : u8 {
        1
    }

    public fun remove_allowed_address(arg0: &mut AccessPolicy, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 304);
        assert!(arg0.gate_type == 0, 306);
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.allowed_addresses, &arg1);
        if (v0) {
            0x1::vector::remove<address>(&mut arg0.allowed_addresses, v1);
        };
    }

    public fun revoke_policy(arg0: &mut AccessPolicy, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 304);
        arg0.revoked = true;
        let v0 = PolicyRevokedEvent{
            policy_id : 0x2::object::id_address<AccessPolicy>(arg0),
            file_id   : arg0.file_id,
        };
        0x2::event::emit<PolicyRevokedEvent>(v0);
    }

    entry fun seal_approve(arg0: vector<u8>, arg1: &mut AccessPolicy, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(!arg1.revoked, 303);
        if (arg1.expires_at_ms > 0) {
            assert!(0x2::clock::timestamp_ms(arg2) < arg1.expires_at_ms, 301);
        };
        if (arg1.max_downloads > 0) {
            assert!(arg1.download_count < arg1.max_downloads, 302);
        };
        if (arg1.gate_type == 255) {
            assert!(v0 == arg1.owner, 300);
        } else if (arg1.gate_type == 1) {
        } else if (arg1.gate_type == 0) {
            if (v0 != arg1.owner) {
                assert!(0x1::vector::contains<address>(&arg1.allowed_addresses, &v0), 300);
            };
        } else {
            assert!(arg1.gate_type == 2 || arg1.gate_type == 3, 306);
            abort 306
        };
        arg1.download_count = arg1.download_count + 1;
        let v1 = AccessGrantedEvent{
            policy_id      : 0x2::object::id_address<AccessPolicy>(arg1),
            file_id        : arg1.file_id,
            accessor       : v0,
            permission     : arg1.permission,
            download_count : arg1.download_count,
        };
        0x2::event::emit<AccessGrantedEvent>(v1);
    }

    public fun update_expiry(arg0: &mut AccessPolicy, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 304);
        arg0.expires_at_ms = arg1;
    }

    public fun update_max_downloads(arg0: &mut AccessPolicy, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 304);
        arg0.max_downloads = arg1;
    }

    public fun update_permission(arg0: &mut AccessPolicy, arg1: u8, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 304);
        assert!(arg1 == 1 || arg1 == 2, 305);
        arg0.permission = arg1;
    }

    // decompiled from Move bytecode v7
}

