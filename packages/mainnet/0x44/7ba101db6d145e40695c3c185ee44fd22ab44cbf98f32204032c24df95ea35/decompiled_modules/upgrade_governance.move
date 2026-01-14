module 0x447ba101db6d145e40695c3c185ee44fd22ab44cbf98f32204032c24df95ea35::upgrade_governance {
    struct UpgradeRequest has copy, drop, store {
        request_id: u64,
        new_provider_id: 0x2::object::ID,
        new_version: u64,
        current_provider_id: 0x2::object::ID,
        current_version: u64,
        proposer: address,
        signatures: vector<address>,
        created_at: u64,
        expires_at: u64,
        executed: bool,
    }

    struct UpgradeGovernance has key {
        id: 0x2::object::UID,
        registry_id: 0x2::object::ID,
        admin_cap: 0x447ba101db6d145e40695c3c185ee44fd22ab44cbf98f32204032c24df95ea35::oracle_registry::RegistryAdminCap,
        authorized_admins: vector<address>,
        required_signatures: u64,
        upgrade_requests: 0x2::table::Table<u64, UpgradeRequest>,
        next_request_id: u64,
        owner: address,
    }

    struct UpgradeRequestCreatedEvent has copy, drop {
        request_id: u64,
        new_provider_id: 0x2::object::ID,
        new_version: u64,
        current_provider_id: 0x2::object::ID,
        current_version: u64,
        proposer: address,
        timestamp: u64,
    }

    struct UpgradeRequestSignedEvent has copy, drop {
        request_id: u64,
        signer: address,
        signature_count: u64,
        required_signatures: u64,
        timestamp: u64,
    }

    struct UpgradeRequestExecutedEvent has copy, drop {
        request_id: u64,
        new_provider_id: 0x2::object::ID,
        new_version: u64,
        executor: address,
        timestamp: u64,
    }

    struct AdminUpdatedEvent has copy, drop {
        admins: vector<address>,
        required_signatures: u64,
        updated_by: address,
        timestamp: u64,
    }

    struct UPGRADE_GOVERNANCE has drop {
        dummy_field: bool,
    }

    public fun create_and_share_governance(arg0: &0x447ba101db6d145e40695c3c185ee44fd22ab44cbf98f32204032c24df95ea35::oracle_registry::OracleRegistry, arg1: 0x447ba101db6d145e40695c3c185ee44fd22ab44cbf98f32204032c24df95ea35::oracle_registry::RegistryAdminCap, arg2: vector<address>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 > 0, 4);
        assert!(arg3 <= 0x1::vector::length<address>(&arg2), 4);
        assert!(0x1::vector::length<address>(&arg2) > 0, 1);
        let v0 = UpgradeGovernance{
            id                  : 0x2::object::new(arg4),
            registry_id         : 0x2::object::id<0x447ba101db6d145e40695c3c185ee44fd22ab44cbf98f32204032c24df95ea35::oracle_registry::OracleRegistry>(arg0),
            admin_cap           : arg1,
            authorized_admins   : arg2,
            required_signatures : arg3,
            upgrade_requests    : 0x2::table::new<u64, UpgradeRequest>(arg4),
            next_request_id     : 0,
            owner               : 0x2::tx_context::sender(arg4),
        };
        0x2::transfer::share_object<UpgradeGovernance>(v0);
    }

    public fun create_upgrade_request(arg0: &mut UpgradeGovernance, arg1: &0x447ba101db6d145e40695c3c185ee44fd22ab44cbf98f32204032c24df95ea35::oracle_registry::OracleRegistry, arg2: 0x2::object::ID, arg3: u64, arg4: &0x2::tx_context::TxContext) : u64 {
        verify_registry_association(arg0, arg1);
        let v0 = 0x2::tx_context::sender(arg4);
        verify_authorized_admin(arg0, v0);
        assert!(arg3 > 0, 7);
        assert!(0x447ba101db6d145e40695c3c185ee44fd22ab44cbf98f32204032c24df95ea35::oracle_registry::is_provider_registered(arg1, arg2), 8);
        let v1 = 0x447ba101db6d145e40695c3c185ee44fd22ab44cbf98f32204032c24df95ea35::oracle_registry::get_current_provider_id(arg1);
        let v2 = 0x447ba101db6d145e40695c3c185ee44fd22ab44cbf98f32204032c24df95ea35::oracle_registry::get_current_provider_version(arg1);
        let v3 = 0x2::tx_context::epoch_timestamp_ms(arg4);
        let v4 = arg0.next_request_id;
        arg0.next_request_id = arg0.next_request_id + 1;
        let v5 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v5, v0);
        let v6 = UpgradeRequest{
            request_id          : v4,
            new_provider_id     : arg2,
            new_version         : arg3,
            current_provider_id : v1,
            current_version     : v2,
            proposer            : v0,
            signatures          : v5,
            created_at          : v3,
            expires_at          : v3 + 604800000,
            executed            : false,
        };
        0x2::table::add<u64, UpgradeRequest>(&mut arg0.upgrade_requests, v4, v6);
        let v7 = UpgradeRequestCreatedEvent{
            request_id          : v4,
            new_provider_id     : arg2,
            new_version         : arg3,
            current_provider_id : v1,
            current_version     : v2,
            proposer            : v0,
            timestamp           : v3,
        };
        0x2::event::emit<UpgradeRequestCreatedEvent>(v7);
        v4
    }

    public fun execute_upgrade_request(arg0: &mut UpgradeGovernance, arg1: &mut 0x447ba101db6d145e40695c3c185ee44fd22ab44cbf98f32204032c24df95ea35::oracle_registry::OracleRegistry, arg2: &0x447ba101db6d145e40695c3c185ee44fd22ab44cbf98f32204032c24df95ea35::oracle_provider::OracleProvider, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        verify_registry_association(arg0, arg1);
        assert!(0x2::table::contains<u64, UpgradeRequest>(&arg0.upgrade_requests, arg3), 2);
        let v0 = 0x2::table::borrow_mut<u64, UpgradeRequest>(&mut arg0.upgrade_requests, arg3);
        assert!(!v0.executed, 6);
        assert!(0x2::object::id<0x447ba101db6d145e40695c3c185ee44fd22ab44cbf98f32204032c24df95ea35::oracle_provider::OracleProvider>(arg2) == v0.new_provider_id, 8);
        let v1 = 0x2::tx_context::epoch_timestamp_ms(arg4);
        assert!(v1 <= v0.expires_at, 5);
        assert!(0x1::vector::length<address>(&v0.signatures) >= arg0.required_signatures, 4);
        0x447ba101db6d145e40695c3c185ee44fd22ab44cbf98f32204032c24df95ea35::oracle_registry::activate_provider(arg1, &arg0.admin_cap, arg2, arg4);
        v0.executed = true;
        let v2 = UpgradeRequestExecutedEvent{
            request_id      : arg3,
            new_provider_id : v0.new_provider_id,
            new_version     : v0.new_version,
            executor        : 0x2::tx_context::sender(arg4),
            timestamp       : v1,
        };
        0x2::event::emit<UpgradeRequestExecutedEvent>(v2);
    }

    public fun get_authorized_admins(arg0: &UpgradeGovernance) : &vector<address> {
        &arg0.authorized_admins
    }

    public fun get_registry_id(arg0: &UpgradeGovernance) : 0x2::object::ID {
        arg0.registry_id
    }

    public fun get_required_signatures(arg0: &UpgradeGovernance) : u64 {
        arg0.required_signatures
    }

    public fun get_upgrade_request(arg0: &UpgradeGovernance, arg1: u64) : &UpgradeRequest {
        0x2::table::borrow<u64, UpgradeRequest>(&arg0.upgrade_requests, arg1)
    }

    fun init(arg0: UPGRADE_GOVERNANCE, arg1: &mut 0x2::tx_context::TxContext) {
    }

    public fun is_authorized_admin(arg0: &UpgradeGovernance, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.authorized_admins, &arg1)
    }

    public fun sign_upgrade_request(arg0: &mut UpgradeGovernance, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<u64, UpgradeRequest>(&arg0.upgrade_requests, arg1), 2);
        let v0 = 0x2::tx_context::sender(arg2);
        verify_authorized_admin(arg0, v0);
        let v1 = 0x2::table::borrow_mut<u64, UpgradeRequest>(&mut arg0.upgrade_requests, arg1);
        assert!(!v1.executed, 6);
        let v2 = 0x2::tx_context::epoch_timestamp_ms(arg2);
        assert!(v2 <= v1.expires_at, 5);
        let v3 = 0;
        while (v3 < 0x1::vector::length<address>(&v1.signatures)) {
            assert!(*0x1::vector::borrow<address>(&v1.signatures, v3) != v0, 3);
            v3 = v3 + 1;
        };
        0x1::vector::push_back<address>(&mut v1.signatures, v0);
        let v4 = UpgradeRequestSignedEvent{
            request_id          : arg1,
            signer              : v0,
            signature_count     : 0x1::vector::length<address>(&v1.signatures),
            required_signatures : arg0.required_signatures,
            timestamp           : v2,
        };
        0x2::event::emit<UpgradeRequestSignedEvent>(v4);
    }

    public fun transfer_ownership(arg0: &mut UpgradeGovernance, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 9);
        arg0.owner = arg1;
    }

    public fun update_authorized_admins(arg0: &mut UpgradeGovernance, arg1: vector<address>, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 9);
        assert!(arg2 > 0, 4);
        assert!(arg2 <= 0x1::vector::length<address>(&arg1), 4);
        assert!(0x1::vector::length<address>(&arg1) > 0, 1);
        arg0.authorized_admins = arg1;
        arg0.required_signatures = arg2;
        let v0 = AdminUpdatedEvent{
            admins              : arg0.authorized_admins,
            required_signatures : arg0.required_signatures,
            updated_by          : 0x2::tx_context::sender(arg3),
            timestamp           : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x2::event::emit<AdminUpdatedEvent>(v0);
    }

    fun verify_authorized_admin(arg0: &UpgradeGovernance, arg1: address) {
        assert!(0x1::vector::contains<address>(&arg0.authorized_admins, &arg1), 1);
    }

    fun verify_registry_association(arg0: &UpgradeGovernance, arg1: &0x447ba101db6d145e40695c3c185ee44fd22ab44cbf98f32204032c24df95ea35::oracle_registry::OracleRegistry) {
        assert!(arg0.registry_id == 0x2::object::id<0x447ba101db6d145e40695c3c185ee44fd22ab44cbf98f32204032c24df95ea35::oracle_registry::OracleRegistry>(arg1), 9);
    }

    // decompiled from Move bytecode v6
}

