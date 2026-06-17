module 0xc4890633ccec9dfcc595c17fd512da3ca7cccbd023294e9f30f882b2047f76b0::stoken_factory {
    struct FactoryAdminCap has store, key {
        id: 0x2::object::UID,
        factory_id: 0x2::object::ID,
    }

    struct FactoryRegistry has key {
        id: 0x2::object::UID,
        version: u64,
        admin: address,
        vaults: vector<0x2::object::ID>,
        vault_count: u64,
        current_version: u64,
        pending_version: 0x1::option::Option<PendingVersion>,
        version_change_cooldown_secs: u64,
    }

    struct PendingVersion has copy, drop, store {
        new_version: u64,
        timestamp: u64,
    }

    public fun accept_version(arg0: &mut FactoryRegistry, arg1: &FactoryAdminCap, arg2: &0x2::clock::Clock) {
        assert!(arg1.factory_id == 0x2::object::id<FactoryRegistry>(arg0), 0xc4890633ccec9dfcc595c17fd512da3ca7cccbd023294e9f30f882b2047f76b0::stoken_errors::unauthorized());
        assert_version(arg0);
        assert!(0x1::option::is_some<PendingVersion>(&arg0.pending_version), 0xc4890633ccec9dfcc595c17fd512da3ca7cccbd023294e9f30f882b2047f76b0::stoken_errors::factory_no_pending_version_change());
        let v0 = 0x1::option::extract<PendingVersion>(&mut arg0.pending_version);
        assert!(0x2::clock::timestamp_ms(arg2) / 1000 >= v0.timestamp + arg0.version_change_cooldown_secs, 0xc4890633ccec9dfcc595c17fd512da3ca7cccbd023294e9f30f882b2047f76b0::stoken_errors::factory_version_change_timelock_active());
        arg0.current_version = v0.new_version;
    }

    public fun assert_registry_matches_cap(arg0: &FactoryRegistry, arg1: &FactoryAdminCap) {
        assert!(arg1.factory_id == 0x2::object::id<FactoryRegistry>(arg0), 0xc4890633ccec9dfcc595c17fd512da3ca7cccbd023294e9f30f882b2047f76b0::stoken_errors::unauthorized());
        assert_version(arg0);
    }

    fun assert_version(arg0: &FactoryRegistry) {
        assert!(arg0.version == 1, 0xc4890633ccec9dfcc595c17fd512da3ca7cccbd023294e9f30f882b2047f76b0::stoken_errors::wrong_version());
    }

    public fun cancel_version(arg0: &mut FactoryRegistry, arg1: &FactoryAdminCap) {
        assert!(arg1.factory_id == 0x2::object::id<FactoryRegistry>(arg0), 0xc4890633ccec9dfcc595c17fd512da3ca7cccbd023294e9f30f882b2047f76b0::stoken_errors::unauthorized());
        assert_version(arg0);
        arg0.pending_version = 0x1::option::none<PendingVersion>();
    }

    public fun create_factory(arg0: u64, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : FactoryAdminCap {
        let v0 = FactoryRegistry{
            id                           : 0x2::object::new(arg2),
            version                      : 1,
            admin                        : 0x2::tx_context::sender(arg2),
            vaults                       : 0x1::vector::empty<0x2::object::ID>(),
            vault_count                  : 0,
            current_version              : 1,
            pending_version              : 0x1::option::none<PendingVersion>(),
            version_change_cooldown_secs : arg0,
        };
        0x2::transfer::share_object<FactoryRegistry>(v0);
        FactoryAdminCap{
            id         : 0x2::object::new(arg2),
            factory_id : 0x2::object::id<FactoryRegistry>(&v0),
        }
    }

    public fun current_module_version() : u64 {
        1
    }

    public fun get_current_version(arg0: &FactoryRegistry) : u64 {
        arg0.current_version
    }

    public fun get_module_version(arg0: &FactoryRegistry) : u64 {
        arg0.version
    }

    public fun get_vault_count(arg0: &FactoryRegistry) : u64 {
        arg0.vault_count
    }

    public fun get_vaults(arg0: &FactoryRegistry) : &vector<0x2::object::ID> {
        &arg0.vaults
    }

    public fun migrate(arg0: &mut FactoryRegistry, arg1: &FactoryAdminCap) {
        assert!(arg1.factory_id == 0x2::object::id<FactoryRegistry>(arg0), 0xc4890633ccec9dfcc595c17fd512da3ca7cccbd023294e9f30f882b2047f76b0::stoken_errors::unauthorized());
        assert!(arg0.version < 1, 0xc4890633ccec9dfcc595c17fd512da3ca7cccbd023294e9f30f882b2047f76b0::stoken_errors::not_upgrade());
        arg0.version = 1;
    }

    public fun propose_version(arg0: &mut FactoryRegistry, arg1: &FactoryAdminCap, arg2: u64, arg3: &0x2::clock::Clock) {
        assert!(arg1.factory_id == 0x2::object::id<FactoryRegistry>(arg0), 0xc4890633ccec9dfcc595c17fd512da3ca7cccbd023294e9f30f882b2047f76b0::stoken_errors::unauthorized());
        assert_version(arg0);
        assert!(arg2 != arg0.current_version, 0xc4890633ccec9dfcc595c17fd512da3ca7cccbd023294e9f30f882b2047f76b0::stoken_errors::factory_version_unchanged());
        let v0 = PendingVersion{
            new_version : arg2,
            timestamp   : 0x2::clock::timestamp_ms(arg3) / 1000,
        };
        arg0.pending_version = 0x1::option::some<PendingVersion>(v0);
    }

    public fun register_vault(arg0: &mut FactoryRegistry, arg1: &FactoryAdminCap, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock) {
        assert!(arg1.factory_id == 0x2::object::id<FactoryRegistry>(arg0), 0xc4890633ccec9dfcc595c17fd512da3ca7cccbd023294e9f30f882b2047f76b0::stoken_errors::unauthorized());
        assert_version(arg0);
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.vaults, arg2);
        arg0.vault_count = arg0.vault_count + 1;
        0xc4890633ccec9dfcc595c17fd512da3ca7cccbd023294e9f30f882b2047f76b0::stoken_events::emit_factory_vault_created(0x2::object::id<FactoryRegistry>(arg0), arg2, arg0.vault_count, 0x2::clock::timestamp_ms(arg3));
    }

    // decompiled from Move bytecode v7
}

