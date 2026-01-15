module 0x447ba101db6d145e40695c3c185ee44fd22ab44cbf98f32204032c24df95ea35::oracle_registry {
    struct ProviderInfo has copy, drop, store {
        provider_id: 0x2::object::ID,
        version: u64,
        is_active: bool,
        registered_at: u64,
    }

    struct RegistryAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct OracleRegistry has key {
        id: 0x2::object::UID,
        current_provider_id: 0x2::object::ID,
        providers: 0x2::table::Table<0x2::object::ID, ProviderInfo>,
        version_index: 0x2::table::Table<u64, 0x2::object::ID>,
        created_at: u64,
    }

    struct ProviderRegisteredEvent has copy, drop {
        provider_id: 0x2::object::ID,
        version: u64,
        registered_by: address,
        timestamp: u64,
    }

    struct ProviderActivatedEvent has copy, drop {
        provider_id: 0x2::object::ID,
        version: u64,
        previous_provider_id: 0x2::object::ID,
        activated_by: address,
        timestamp: u64,
    }

    struct ProviderDeactivatedEvent has copy, drop {
        provider_id: 0x2::object::ID,
        version: u64,
        deactivated_by: address,
        timestamp: u64,
    }

    struct ORACLE_REGISTRY has drop {
        dummy_field: bool,
    }

    public fun activate_provider(arg0: &mut OracleRegistry, arg1: &RegistryAdminCap, arg2: &0x447ba101db6d145e40695c3c185ee44fd22ab44cbf98f32204032c24df95ea35::oracle_provider::OracleProvider, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0x447ba101db6d145e40695c3c185ee44fd22ab44cbf98f32204032c24df95ea35::oracle_provider::OracleProvider>(arg2);
        assert!(0x2::table::contains<0x2::object::ID, ProviderInfo>(&arg0.providers, v0), 1);
        let v1 = arg0.current_provider_id;
        if (v1 != 0x2::object::id_from_address(@0x0) && 0x2::table::contains<0x2::object::ID, ProviderInfo>(&arg0.providers, v1)) {
            let v2 = 0x2::table::borrow_mut<0x2::object::ID, ProviderInfo>(&mut arg0.providers, v1);
            v2.is_active = false;
            let v3 = ProviderDeactivatedEvent{
                provider_id    : v1,
                version        : v2.version,
                deactivated_by : 0x2::tx_context::sender(arg3),
                timestamp      : 0x2::tx_context::epoch_timestamp_ms(arg3),
            };
            0x2::event::emit<ProviderDeactivatedEvent>(v3);
        };
        let v4 = 0x2::table::borrow_mut<0x2::object::ID, ProviderInfo>(&mut arg0.providers, v0);
        v4.is_active = true;
        arg0.current_provider_id = v0;
        let v5 = ProviderActivatedEvent{
            provider_id          : v0,
            version              : v4.version,
            previous_provider_id : v1,
            activated_by         : 0x2::tx_context::sender(arg3),
            timestamp            : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x2::event::emit<ProviderActivatedEvent>(v5);
    }

    public fun create_and_share_registry(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OracleRegistry{
            id                  : 0x2::object::new(arg0),
            current_provider_id : 0x2::object::id_from_address(@0x0),
            providers           : 0x2::table::new<0x2::object::ID, ProviderInfo>(arg0),
            version_index       : 0x2::table::new<u64, 0x2::object::ID>(arg0),
            created_at          : 0x2::tx_context::epoch_timestamp_ms(arg0),
        };
        let v1 = RegistryAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<OracleRegistry>(v0);
        0x2::transfer::public_transfer<RegistryAdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun deactivate_provider(arg0: &mut OracleRegistry, arg1: &RegistryAdminCap, arg2: &0x447ba101db6d145e40695c3c185ee44fd22ab44cbf98f32204032c24df95ea35::oracle_provider::OracleProvider, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0x447ba101db6d145e40695c3c185ee44fd22ab44cbf98f32204032c24df95ea35::oracle_provider::OracleProvider>(arg2);
        assert!(0x2::table::contains<0x2::object::ID, ProviderInfo>(&arg0.providers, v0), 1);
        assert!(arg0.current_provider_id != v0, 5);
        let v1 = 0x2::table::borrow_mut<0x2::object::ID, ProviderInfo>(&mut arg0.providers, v0);
        v1.is_active = false;
        let v2 = ProviderDeactivatedEvent{
            provider_id    : v0,
            version        : v1.version,
            deactivated_by : 0x2::tx_context::sender(arg3),
            timestamp      : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x2::event::emit<ProviderDeactivatedEvent>(v2);
    }

    public fun get_current_provider_id(arg0: &OracleRegistry) : 0x2::object::ID {
        assert!(arg0.current_provider_id != 0x2::object::id_from_address(@0x0), 5);
        arg0.current_provider_id
    }

    public fun get_current_provider_id_for_protocols(arg0: &OracleRegistry) : 0x2::object::ID {
        get_current_provider_id(arg0)
    }

    public fun get_current_provider_version(arg0: &OracleRegistry) : u64 {
        assert!(arg0.current_provider_id != 0x2::object::id_from_address(@0x0), 5);
        0x2::table::borrow<0x2::object::ID, ProviderInfo>(&arg0.providers, arg0.current_provider_id).version
    }

    public fun get_major_version(arg0: u64) : u64 {
        arg0 / 1000000
    }

    public fun get_minor_version(arg0: u64) : u64 {
        arg0 % 1000000 / 1000
    }

    public fun get_patch_version(arg0: u64) : u64 {
        arg0 % 1000
    }

    public fun get_provider_id_by_version(arg0: &OracleRegistry, arg1: u64) : 0x2::object::ID {
        *0x2::table::borrow<u64, 0x2::object::ID>(&arg0.version_index, arg1)
    }

    public fun get_provider_info(arg0: &OracleRegistry, arg1: 0x2::object::ID) : &ProviderInfo {
        0x2::table::borrow<0x2::object::ID, ProviderInfo>(&arg0.providers, arg1)
    }

    fun init(arg0: ORACLE_REGISTRY, arg1: &mut 0x2::tx_context::TxContext) {
    }

    public fun is_provider_active(arg0: &OracleRegistry, arg1: 0x2::object::ID) : bool {
        if (!0x2::table::contains<0x2::object::ID, ProviderInfo>(&arg0.providers, arg1)) {
            return false
        };
        0x2::table::borrow<0x2::object::ID, ProviderInfo>(&arg0.providers, arg1).is_active
    }

    public fun is_provider_registered(arg0: &OracleRegistry, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, ProviderInfo>(&arg0.providers, arg1)
    }

    public fun register_provider(arg0: &mut OracleRegistry, arg1: &RegistryAdminCap, arg2: &0x447ba101db6d145e40695c3c185ee44fd22ab44cbf98f32204032c24df95ea35::oracle_provider::OracleProvider, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        assert!(arg3 > 0, 4);
        let v0 = 0x2::object::id<0x447ba101db6d145e40695c3c185ee44fd22ab44cbf98f32204032c24df95ea35::oracle_provider::OracleProvider>(arg2);
        assert!(!0x2::table::contains<0x2::object::ID, ProviderInfo>(&arg0.providers, v0), 2);
        let v1 = 0x2::tx_context::epoch_timestamp_ms(arg4);
        let v2 = ProviderInfo{
            provider_id   : v0,
            version       : arg3,
            is_active     : false,
            registered_at : v1,
        };
        0x2::table::add<0x2::object::ID, ProviderInfo>(&mut arg0.providers, v0, v2);
        0x2::table::add<u64, 0x2::object::ID>(&mut arg0.version_index, arg3, v0);
        let v3 = ProviderRegisteredEvent{
            provider_id   : v0,
            version       : arg3,
            registered_by : 0x2::tx_context::sender(arg4),
            timestamp     : v1,
        };
        0x2::event::emit<ProviderRegisteredEvent>(v3);
    }

    // decompiled from Move bytecode v6
}

