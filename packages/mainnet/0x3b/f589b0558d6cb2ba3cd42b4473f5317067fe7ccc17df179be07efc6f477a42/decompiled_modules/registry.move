module 0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::registry {
    struct GlobalRegistry has key {
        id: 0x2::object::UID,
        registries: 0x2::table::Table<address, 0x2::object::ID>,
        total_users: u64,
    }

    struct DatabaseRegistry has key {
        id: 0x2::object::UID,
        owner: address,
        owned_databases: vector<0x2::object::ID>,
        accessible_databases: vector<0x2::object::ID>,
    }

    struct RegistryCreated has copy, drop {
        registry_id: 0x2::object::ID,
        owner: address,
    }

    struct DatabaseAddedToRegistry has copy, drop {
        registry_owner: address,
        database_id: 0x2::object::ID,
        is_owned: bool,
    }

    struct DatabaseRemovedFromRegistry has copy, drop {
        registry_owner: address,
        database_id: 0x2::object::ID,
        is_owned: bool,
    }

    public entry fun add_accessible_database(arg0: &mut DatabaseRegistry, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.owner, 102);
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.accessible_databases, arg1);
        let v1 = DatabaseAddedToRegistry{
            registry_owner : v0,
            database_id    : arg1,
            is_owned       : false,
        };
        0x2::event::emit<DatabaseAddedToRegistry>(v1);
    }

    public entry fun add_owned_database(arg0: &mut DatabaseRegistry, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.owner, 102);
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.owned_databases, arg1);
        let v1 = DatabaseAddedToRegistry{
            registry_owner : v0,
            database_id    : arg1,
            is_owned       : true,
        };
        0x2::event::emit<DatabaseAddedToRegistry>(v1);
    }

    public entry fun create_registry(arg0: &mut GlobalRegistry, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(!0x2::table::contains<address, 0x2::object::ID>(&arg0.registries, v0), 100);
        let v1 = DatabaseRegistry{
            id                   : 0x2::object::new(arg1),
            owner                : v0,
            owned_databases      : 0x1::vector::empty<0x2::object::ID>(),
            accessible_databases : 0x1::vector::empty<0x2::object::ID>(),
        };
        let v2 = 0x2::object::id<DatabaseRegistry>(&v1);
        0x2::table::add<address, 0x2::object::ID>(&mut arg0.registries, v0, v2);
        arg0.total_users = arg0.total_users + 1;
        let v3 = RegistryCreated{
            registry_id : v2,
            owner       : v0,
        };
        0x2::event::emit<RegistryCreated>(v3);
        0x2::transfer::transfer<DatabaseRegistry>(v1, v0);
    }

    fun find_database_index(arg0: &vector<0x2::object::ID>, arg1: 0x2::object::ID) : (bool, u64) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::object::ID>(arg0)) {
            if (0x1::vector::borrow<0x2::object::ID>(arg0, v0) == &arg1) {
                return (true, v0)
            };
            v0 = v0 + 1;
        };
        (false, 0)
    }

    public fun get_accessible_databases(arg0: &DatabaseRegistry) : &vector<0x2::object::ID> {
        &arg0.accessible_databases
    }

    public fun get_or_create_registry(arg0: &mut GlobalRegistry, arg1: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::tx_context::sender(arg1);
        if (0x2::table::contains<address, 0x2::object::ID>(&arg0.registries, v0)) {
            *0x2::table::borrow<address, 0x2::object::ID>(&arg0.registries, v0)
        } else {
            let v2 = DatabaseRegistry{
                id                   : 0x2::object::new(arg1),
                owner                : v0,
                owned_databases      : 0x1::vector::empty<0x2::object::ID>(),
                accessible_databases : 0x1::vector::empty<0x2::object::ID>(),
            };
            let v3 = 0x2::object::id<DatabaseRegistry>(&v2);
            0x2::table::add<address, 0x2::object::ID>(&mut arg0.registries, v0, v3);
            arg0.total_users = arg0.total_users + 1;
            let v4 = RegistryCreated{
                registry_id : v3,
                owner       : v0,
            };
            0x2::event::emit<RegistryCreated>(v4);
            0x2::transfer::transfer<DatabaseRegistry>(v2, v0);
            v3
        }
    }

    public fun get_owned_databases(arg0: &DatabaseRegistry) : &vector<0x2::object::ID> {
        &arg0.owned_databases
    }

    public fun get_registry_id(arg0: &GlobalRegistry, arg1: address) : 0x1::option::Option<0x2::object::ID> {
        if (0x2::table::contains<address, 0x2::object::ID>(&arg0.registries, arg1)) {
            0x1::option::some<0x2::object::ID>(*0x2::table::borrow<address, 0x2::object::ID>(&arg0.registries, arg1))
        } else {
            0x1::option::none<0x2::object::ID>()
        }
    }

    public fun get_registry_owner(arg0: &DatabaseRegistry) : address {
        arg0.owner
    }

    public fun get_total_users(arg0: &GlobalRegistry) : u64 {
        arg0.total_users
    }

    public fun has_registry(arg0: &GlobalRegistry, arg1: address) : bool {
        0x2::table::contains<address, 0x2::object::ID>(&arg0.registries, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GlobalRegistry{
            id          : 0x2::object::new(arg0),
            registries  : 0x2::table::new<address, 0x2::object::ID>(arg0),
            total_users : 0,
        };
        0x2::transfer::share_object<GlobalRegistry>(v0);
    }

    public entry fun remove_accessible_database(arg0: &mut DatabaseRegistry, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.owner, 102);
        let (v1, v2) = find_database_index(&arg0.accessible_databases, arg1);
        assert!(v1, 101);
        0x1::vector::remove<0x2::object::ID>(&mut arg0.accessible_databases, v2);
        let v3 = DatabaseRemovedFromRegistry{
            registry_owner : v0,
            database_id    : arg1,
            is_owned       : false,
        };
        0x2::event::emit<DatabaseRemovedFromRegistry>(v3);
    }

    public entry fun remove_owned_database(arg0: &mut DatabaseRegistry, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.owner, 102);
        let (v1, v2) = find_database_index(&arg0.owned_databases, arg1);
        assert!(v1, 101);
        0x1::vector::remove<0x2::object::ID>(&mut arg0.owned_databases, v2);
        let v3 = DatabaseRemovedFromRegistry{
            registry_owner : v0,
            database_id    : arg1,
            is_owned       : true,
        };
        0x2::event::emit<DatabaseRemovedFromRegistry>(v3);
    }

    // decompiled from Move bytecode v6
}

