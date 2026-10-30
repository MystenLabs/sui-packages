module 0x4f0ae3750035ebb49e154ec816163907c0b6d53b12c8e40b3940ce367e5c2fd7::factory {
    struct PendingFactory has key {
        id: 0x2::object::UID,
    }

    struct RegistryFactory has key {
        id: 0x2::object::UID,
        upgrade_cap_id: 0x2::object::ID,
        super_admin: address,
    }

    struct FactoryCreated has copy, drop {
        factory_id: 0x2::object::ID,
        super_admin: address,
        upgrade_cap_id: 0x2::object::ID,
    }

    struct FactorySuperAdminTransferred has copy, drop {
        factory_id: 0x2::object::ID,
        from: address,
        to: address,
    }

    struct FactoryEmergencyRotated has copy, drop {
        factory_id: 0x2::object::ID,
        from: address,
        to: address,
    }

    fun assert_factory_super_admin(arg0: &RegistryFactory, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.super_admin, 13835058965815230465);
    }

    fun assert_upgrade_cap(arg0: &RegistryFactory, arg1: &0x2::package::UpgradeCap) {
        assert!(arg0.upgrade_cap_id == 0x2::object::id<0x2::package::UpgradeCap>(arg1), 13835340462266908675);
    }

    public fun bind_upgrade_cap(arg0: PendingFactory, arg1: &0x2::package::UpgradeCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::with_defining_ids<RegistryFactory>();
        let v1 = 0x2::package::upgrade_package(arg1);
        assert!(0x2::address::to_ascii_string(0x2::object::id_to_address(&v1)) == 0x1::type_name::address_string(&v0), 13835339899626192899);
        let PendingFactory { id: v2 } = arg0;
        0x2::object::delete(v2);
        let v3 = 0x2::object::id<0x2::package::UpgradeCap>(arg1);
        let v4 = 0x2::tx_context::sender(arg2);
        let v5 = RegistryFactory{
            id             : 0x2::object::new(arg2),
            upgrade_cap_id : v3,
            super_admin    : v4,
        };
        let v6 = FactoryCreated{
            factory_id     : 0x2::object::id<RegistryFactory>(&v5),
            super_admin    : v4,
            upgrade_cap_id : v3,
        };
        0x2::event::emit<FactoryCreated>(v6);
        0x2::transfer::share_object<RegistryFactory>(v5);
    }

    public fun create_registry(arg0: &mut RegistryFactory, arg1: &0x4f0ae3750035ebb49e154ec816163907c0b6d53b12c8e40b3940ce367e5c2fd7::version::Version, arg2: 0x1::string::String, arg3: address, arg4: address, arg5: &0x2::tx_context::TxContext) : (0x4f0ae3750035ebb49e154ec816163907c0b6d53b12c8e40b3940ce367e5c2fd7::registry::Registry, 0x4f0ae3750035ebb49e154ec816163907c0b6d53b12c8e40b3940ce367e5c2fd7::registry::RegistryFinalize) {
        0x4f0ae3750035ebb49e154ec816163907c0b6d53b12c8e40b3940ce367e5c2fd7::version::check_is_valid(arg1);
        assert_factory_super_admin(arg0, arg5);
        0x4f0ae3750035ebb49e154ec816163907c0b6d53b12c8e40b3940ce367e5c2fd7::registry::new(&mut arg0.id, arg2, arg3, arg4)
    }

    public fun emergency_rotate_factory_super_admin(arg0: &mut RegistryFactory, arg1: &0x4f0ae3750035ebb49e154ec816163907c0b6d53b12c8e40b3940ce367e5c2fd7::version::Version, arg2: &mut 0x2::package::UpgradeCap, arg3: address) {
        0x4f0ae3750035ebb49e154ec816163907c0b6d53b12c8e40b3940ce367e5c2fd7::version::check_is_valid(arg1);
        assert_upgrade_cap(arg0, arg2);
        arg0.super_admin = arg3;
        let v0 = FactoryEmergencyRotated{
            factory_id : 0x2::object::id<RegistryFactory>(arg0),
            from       : arg0.super_admin,
            to         : arg3,
        };
        0x2::event::emit<FactoryEmergencyRotated>(v0);
    }

    public fun factory_super_admin(arg0: &RegistryFactory) : address {
        arg0.super_admin
    }

    public fun factory_upgrade_cap_id(arg0: &RegistryFactory) : 0x2::object::ID {
        arg0.upgrade_cap_id
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PendingFactory{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<PendingFactory>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun migrate(arg0: &RegistryFactory, arg1: &mut 0x4f0ae3750035ebb49e154ec816163907c0b6d53b12c8e40b3940ce367e5c2fd7::version::Version, arg2: &0x2::tx_context::TxContext) {
        assert_factory_super_admin(arg0, arg2);
        0x4f0ae3750035ebb49e154ec816163907c0b6d53b12c8e40b3940ce367e5c2fd7::version::migrate(arg1);
    }

    public fun migrate_registry(arg0: &RegistryFactory, arg1: &mut 0x4f0ae3750035ebb49e154ec816163907c0b6d53b12c8e40b3940ce367e5c2fd7::registry::Registry, arg2: &0x2::tx_context::TxContext) {
        assert_factory_super_admin(arg0, arg2);
        0x4f0ae3750035ebb49e154ec816163907c0b6d53b12c8e40b3940ce367e5c2fd7::registry::migrate_internal(arg1);
    }

    public fun registry_address(arg0: &RegistryFactory, arg1: 0x1::string::String) : address {
        0x2::derived_object::derive_address<0x1::string::String>(0x2::object::id<RegistryFactory>(arg0), arg1)
    }

    public fun registry_exists(arg0: &RegistryFactory, arg1: 0x1::string::String) : bool {
        0x2::derived_object::exists<0x1::string::String>(&arg0.id, arg1)
    }

    public fun set_registry_admin(arg0: &RegistryFactory, arg1: &mut 0x4f0ae3750035ebb49e154ec816163907c0b6d53b12c8e40b3940ce367e5c2fd7::registry::Registry, arg2: &0x4f0ae3750035ebb49e154ec816163907c0b6d53b12c8e40b3940ce367e5c2fd7::version::Version, arg3: address, arg4: &0x2::tx_context::TxContext) {
        0x4f0ae3750035ebb49e154ec816163907c0b6d53b12c8e40b3940ce367e5c2fd7::version::check_is_valid(arg2);
        assert_factory_super_admin(arg0, arg4);
        0x4f0ae3750035ebb49e154ec816163907c0b6d53b12c8e40b3940ce367e5c2fd7::registry::set_admin_internal(arg1, arg3);
    }

    public fun transfer_factory_super_admin(arg0: &mut RegistryFactory, arg1: &0x4f0ae3750035ebb49e154ec816163907c0b6d53b12c8e40b3940ce367e5c2fd7::version::Version, arg2: address, arg3: &0x2::tx_context::TxContext) {
        0x4f0ae3750035ebb49e154ec816163907c0b6d53b12c8e40b3940ce367e5c2fd7::version::check_is_valid(arg1);
        assert_factory_super_admin(arg0, arg3);
        arg0.super_admin = arg2;
        let v0 = FactorySuperAdminTransferred{
            factory_id : 0x2::object::id<RegistryFactory>(arg0),
            from       : arg0.super_admin,
            to         : arg2,
        };
        0x2::event::emit<FactorySuperAdminTransferred>(v0);
    }

    // decompiled from Move bytecode v7
}

