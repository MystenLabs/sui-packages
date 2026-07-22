module 0xf8a87879e4b1eee43c94495184a1e319d342049585d9f2f1168e892af726c837::stoken_factory {
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

    struct FactoryIndexKey has copy, drop, store {
        dummy_field: bool,
    }

    struct FactoryIndex has store {
        vaults: 0x2::table::Table<u64, 0x2::object::ID>,
    }

    public fun accept_version(arg0: &mut FactoryRegistry, arg1: &FactoryAdminCap, arg2: &0x2::clock::Clock) {
        assert!(arg1.factory_id == 0x2::object::id<FactoryRegistry>(arg0), 1);
        assert_version(arg0);
        assert!(0x1::option::is_some<PendingVersion>(&arg0.pending_version), 703);
        let v0 = 0x1::option::extract<PendingVersion>(&mut arg0.pending_version);
        assert!(0x2::clock::timestamp_ms(arg2) / 1000 >= v0.timestamp + arg0.version_change_cooldown_secs, 704);
        arg0.current_version = v0.new_version;
    }

    fun add_index(arg0: &mut FactoryRegistry, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = FactoryIndexKey{dummy_field: false};
        if (!0x2::dynamic_field::exists_with_type<FactoryIndexKey, FactoryIndex>(&arg0.id, v0)) {
            let v1 = FactoryIndexKey{dummy_field: false};
            let v2 = FactoryIndex{vaults: 0x2::table::new<u64, 0x2::object::ID>(arg1)};
            0x2::dynamic_field::add<FactoryIndexKey, FactoryIndex>(&mut arg0.id, v1, v2);
        };
    }

    public fun assert_registry_matches_cap(arg0: &FactoryRegistry, arg1: &FactoryAdminCap) {
        assert!(arg1.factory_id == 0x2::object::id<FactoryRegistry>(arg0), 1);
        assert_version(arg0);
    }

    fun assert_version(arg0: &FactoryRegistry) {
        assert!(arg0.version == 1, 9);
    }

    public fun cancel_version(arg0: &mut FactoryRegistry, arg1: &FactoryAdminCap) {
        assert!(arg1.factory_id == 0x2::object::id<FactoryRegistry>(arg0), 1);
        assert_version(arg0);
        arg0.pending_version = 0x1::option::none<PendingVersion>();
    }

    public fun create_factory(arg0: u64, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : FactoryAdminCap {
        assert!(arg0 >= 0xf8a87879e4b1eee43c94495184a1e319d342049585d9f2f1168e892af726c837::stoken_math::min_cooldown_secs() && arg0 <= 0xf8a87879e4b1eee43c94495184a1e319d342049585d9f2f1168e892af726c837::stoken_math::max_cooldown_secs(), 5);
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
        let v1 = &mut v0;
        add_index(v1, arg2);
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

    public fun get_vault_at(arg0: &FactoryRegistry, arg1: u64) : 0x2::object::ID {
        *0x2::table::borrow<u64, 0x2::object::ID>(&index(arg0).vaults, arg1)
    }

    public fun get_vault_count(arg0: &FactoryRegistry) : u64 {
        arg0.vault_count
    }

    public fun get_vaults(arg0: &FactoryRegistry) : &vector<0x2::object::ID> {
        &arg0.vaults
    }

    fun index(arg0: &FactoryRegistry) : &FactoryIndex {
        let v0 = FactoryIndexKey{dummy_field: false};
        0x2::dynamic_field::borrow<FactoryIndexKey, FactoryIndex>(&arg0.id, v0)
    }

    fun index_mut(arg0: &mut FactoryRegistry) : &mut FactoryIndex {
        let v0 = FactoryIndexKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<FactoryIndexKey, FactoryIndex>(&mut arg0.id, v0)
    }

    public fun migrate(arg0: &mut FactoryRegistry, arg1: &FactoryAdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.factory_id == 0x2::object::id<FactoryRegistry>(arg0), 1);
        assert!(arg0.version < 1, 10);
        add_index(arg0, arg2);
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::object::ID>(&arg0.vaults)) {
            if (!0x2::table::contains<u64, 0x2::object::ID>(&index(arg0).vaults, v0)) {
                let v1 = *0x1::vector::borrow<0x2::object::ID>(&arg0.vaults, v0);
                let v2 = index_mut(arg0);
                0x2::table::add<u64, 0x2::object::ID>(&mut v2.vaults, v0, v1);
            };
            v0 = v0 + 1;
        };
        arg0.version = 1;
    }

    public fun propose_version(arg0: &mut FactoryRegistry, arg1: &FactoryAdminCap, arg2: u64, arg3: &0x2::clock::Clock) {
        assert!(arg1.factory_id == 0x2::object::id<FactoryRegistry>(arg0), 1);
        assert_version(arg0);
        assert!(arg2 != arg0.current_version, 702);
        let v0 = PendingVersion{
            new_version : arg2,
            timestamp   : 0x2::clock::timestamp_ms(arg3) / 1000,
        };
        arg0.pending_version = 0x1::option::some<PendingVersion>(v0);
    }

    public fun register_vault(arg0: &mut FactoryRegistry, arg1: &FactoryAdminCap, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock) {
        assert!(arg1.factory_id == 0x2::object::id<FactoryRegistry>(arg0), 1);
        assert_version(arg0);
        let v0 = arg0.vault_count;
        let v1 = index_mut(arg0);
        0x2::table::add<u64, 0x2::object::ID>(&mut v1.vaults, v0, arg2);
        arg0.vault_count = arg0.vault_count + 1;
        0xf8a87879e4b1eee43c94495184a1e319d342049585d9f2f1168e892af726c837::stoken_events::emit_factory_vault_created(0x2::object::id<FactoryRegistry>(arg0), arg2, v0, 0x2::clock::timestamp_ms(arg3));
    }

    // decompiled from Move bytecode v7
}

