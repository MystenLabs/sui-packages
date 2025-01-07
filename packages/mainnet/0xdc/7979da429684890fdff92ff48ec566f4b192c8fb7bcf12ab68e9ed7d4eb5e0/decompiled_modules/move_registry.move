module 0xdc7979da429684890fdff92ff48ec566f4b192c8fb7bcf12ab68e9ed7d4eb5e0::move_registry {
    struct MoveRegistry has key {
        id: 0x2::object::UID,
        registry: 0x2::table::Table<0xdc7979da429684890fdff92ff48ec566f4b192c8fb7bcf12ab68e9ed7d4eb5e0::name::Name, 0xdc7979da429684890fdff92ff48ec566f4b192c8fb7bcf12ab68e9ed7d4eb5e0::app_record::AppRecord>,
    }

    struct MOVE_REGISTRY has drop {
        dummy_field: bool,
    }

    public fun remove(arg0: &mut MoveRegistry, arg1: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xdc7979da429684890fdff92ff48ec566f4b192c8fb7bcf12ab68e9ed7d4eb5e0::name::new(arg2, 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::domain(arg1));
        assert!(!0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::has_expired(arg1, arg3), 4);
        assert!(0x2::table::contains<0xdc7979da429684890fdff92ff48ec566f4b192c8fb7bcf12ab68e9ed7d4eb5e0::name::Name, 0xdc7979da429684890fdff92ff48ec566f4b192c8fb7bcf12ab68e9ed7d4eb5e0::app_record::AppRecord>(&arg0.registry, v0), 3);
        let v1 = 0x2::table::remove<0xdc7979da429684890fdff92ff48ec566f4b192c8fb7bcf12ab68e9ed7d4eb5e0::name::Name, 0xdc7979da429684890fdff92ff48ec566f4b192c8fb7bcf12ab68e9ed7d4eb5e0::app_record::AppRecord>(&mut arg0.registry, v0);
        assert!(!0xdc7979da429684890fdff92ff48ec566f4b192c8fb7bcf12ab68e9ed7d4eb5e0::app_record::is_immutable(&v1), 6);
        0xdc7979da429684890fdff92ff48ec566f4b192c8fb7bcf12ab68e9ed7d4eb5e0::app_record::burn(v1);
    }

    public fun assign_package(arg0: &mut MoveRegistry, arg1: &mut 0xdc7979da429684890fdff92ff48ec566f4b192c8fb7bcf12ab68e9ed7d4eb5e0::app_record::AppCap, arg2: &0x3f59564f9caa6769a2b16e30ab0756441bad340339858373c6c38bbc15f67eb9::package_info::PackageInfo) {
        let v0 = borrow_record_mut(arg0, arg1);
        assert!(!0xdc7979da429684890fdff92ff48ec566f4b192c8fb7bcf12ab68e9ed7d4eb5e0::app_record::is_immutable(v0), 1);
        0xdc7979da429684890fdff92ff48ec566f4b192c8fb7bcf12ab68e9ed7d4eb5e0::app_record::assign_package(v0, arg1, arg2);
    }

    public fun set_network(arg0: &mut MoveRegistry, arg1: &0xdc7979da429684890fdff92ff48ec566f4b192c8fb7bcf12ab68e9ed7d4eb5e0::app_record::AppCap, arg2: 0x1::string::String, arg3: 0xdc7979da429684890fdff92ff48ec566f4b192c8fb7bcf12ab68e9ed7d4eb5e0::app_info::AppInfo) {
        0xdc7979da429684890fdff92ff48ec566f4b192c8fb7bcf12ab68e9ed7d4eb5e0::app_record::set_network(borrow_record_mut(arg0, arg1), arg2, arg3);
    }

    public fun unset_network(arg0: &mut MoveRegistry, arg1: &0xdc7979da429684890fdff92ff48ec566f4b192c8fb7bcf12ab68e9ed7d4eb5e0::app_record::AppCap, arg2: 0x1::string::String) {
        0xdc7979da429684890fdff92ff48ec566f4b192c8fb7bcf12ab68e9ed7d4eb5e0::app_record::unset_network(borrow_record_mut(arg0, arg1), arg2);
    }

    public(friend) fun app_exists(arg0: &MoveRegistry, arg1: 0xdc7979da429684890fdff92ff48ec566f4b192c8fb7bcf12ab68e9ed7d4eb5e0::name::Name) : bool {
        0x2::table::contains<0xdc7979da429684890fdff92ff48ec566f4b192c8fb7bcf12ab68e9ed7d4eb5e0::name::Name, 0xdc7979da429684890fdff92ff48ec566f4b192c8fb7bcf12ab68e9ed7d4eb5e0::app_record::AppRecord>(&arg0.registry, arg1)
    }

    fun borrow_record_mut(arg0: &mut MoveRegistry, arg1: &0xdc7979da429684890fdff92ff48ec566f4b192c8fb7bcf12ab68e9ed7d4eb5e0::app_record::AppCap) : &mut 0xdc7979da429684890fdff92ff48ec566f4b192c8fb7bcf12ab68e9ed7d4eb5e0::app_record::AppRecord {
        assert!(app_exists(arg0, 0xdc7979da429684890fdff92ff48ec566f4b192c8fb7bcf12ab68e9ed7d4eb5e0::app_record::app(arg1)), 3);
        let v0 = 0x2::table::borrow_mut<0xdc7979da429684890fdff92ff48ec566f4b192c8fb7bcf12ab68e9ed7d4eb5e0::name::Name, 0xdc7979da429684890fdff92ff48ec566f4b192c8fb7bcf12ab68e9ed7d4eb5e0::app_record::AppRecord>(&mut arg0.registry, 0xdc7979da429684890fdff92ff48ec566f4b192c8fb7bcf12ab68e9ed7d4eb5e0::app_record::app(arg1));
        assert!(0xdc7979da429684890fdff92ff48ec566f4b192c8fb7bcf12ab68e9ed7d4eb5e0::app_record::is_valid_for(arg1, v0), 2);
        v0
    }

    fun init(arg0: MOVE_REGISTRY, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<MOVE_REGISTRY>(arg0, arg1);
        let v0 = MoveRegistry{
            id       : 0x2::object::new(arg1),
            registry : 0x2::table::new<0xdc7979da429684890fdff92ff48ec566f4b192c8fb7bcf12ab68e9ed7d4eb5e0::name::Name, 0xdc7979da429684890fdff92ff48ec566f4b192c8fb7bcf12ab68e9ed7d4eb5e0::app_record::AppRecord>(arg1),
        };
        0x2::transfer::share_object<MoveRegistry>(v0);
    }

    public fun register(arg0: &mut MoveRegistry, arg1: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0xdc7979da429684890fdff92ff48ec566f4b192c8fb7bcf12ab68e9ed7d4eb5e0::app_record::AppCap {
        let v0 = 0xdc7979da429684890fdff92ff48ec566f4b192c8fb7bcf12ab68e9ed7d4eb5e0::name::new(arg2, 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::domain(arg1));
        assert!(!0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::has_expired(arg1, arg3), 4);
        let v1 = 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::domain(arg1);
        assert!(!0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::is_subdomain(&v1), 5);
        let (v2, v3) = 0xdc7979da429684890fdff92ff48ec566f4b192c8fb7bcf12ab68e9ed7d4eb5e0::app_record::new(v0, 0x2::object::id<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(arg1), arg4);
        0x2::table::add<0xdc7979da429684890fdff92ff48ec566f4b192c8fb7bcf12ab68e9ed7d4eb5e0::name::Name, 0xdc7979da429684890fdff92ff48ec566f4b192c8fb7bcf12ab68e9ed7d4eb5e0::app_record::AppRecord>(&mut arg0.registry, v0, v2);
        v3
    }

    // decompiled from Move bytecode v6
}

