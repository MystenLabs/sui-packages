module 0x1f015c1a000631f2c0afd0258b299c63ffb8e5452e0c0f9be8fc28d2e20ad9b4::gated_vault {
    struct GatedVaultRegistryItem has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x18d1215fb5a050ed22da5cdefb9601adead8a9c3576e30c9bc03cbdb2eb17b47::generis::GENERIS>,
        unlock_date: u64,
    }

    struct GatedVaultRegistry has store, key {
        id: 0x2::object::UID,
        registry: 0x2::table::Table<address, 0x2::table::Table<0x2::object::ID, GatedVaultRegistryItem>>,
    }

    struct GatedVaultAdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun balance(arg0: &GatedVaultRegistryItem) : u64 {
        0x2::balance::value<0x18d1215fb5a050ed22da5cdefb9601adead8a9c3576e30c9bc03cbdb2eb17b47::generis::GENERIS>(&arg0.balance)
    }

    public(friend) fun add_to_registry(arg0: &mut GatedVaultRegistry, arg1: &0x2::clock::Clock, arg2: u64, arg3: 0x2::coin::Coin<0x18d1215fb5a050ed22da5cdefb9601adead8a9c3576e30c9bc03cbdb2eb17b47::generis::GENERIS>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        if (!0x2::table::contains<address, 0x2::table::Table<0x2::object::ID, GatedVaultRegistryItem>>(&arg0.registry, 0x2::tx_context::sender(arg4))) {
            0x2::table::add<address, 0x2::table::Table<0x2::object::ID, GatedVaultRegistryItem>>(&mut arg0.registry, 0x2::tx_context::sender(arg4), 0x2::table::new<0x2::object::ID, GatedVaultRegistryItem>(arg4));
        };
        let v0 = GatedVaultRegistryItem{
            id          : 0x2::object::new(arg4),
            balance     : 0x2::coin::into_balance<0x18d1215fb5a050ed22da5cdefb9601adead8a9c3576e30c9bc03cbdb2eb17b47::generis::GENERIS>(arg3),
            unlock_date : 0x1f015c1a000631f2c0afd0258b299c63ffb8e5452e0c0f9be8fc28d2e20ad9b4::vault_constants::get_lock_duration_for_level(arg1, arg2),
        };
        let v1 = 0x2::object::id<GatedVaultRegistryItem>(&v0);
        0x2::table::add<0x2::object::ID, GatedVaultRegistryItem>(0x2::table::borrow_mut<address, 0x2::table::Table<0x2::object::ID, GatedVaultRegistryItem>>(&mut arg0.registry, 0x2::tx_context::sender(arg4)), v1, v0);
        v1
    }

    public(friend) fun add_to_registry_from_migration(arg0: &mut GatedVaultRegistry, arg1: u64, arg2: 0x2::coin::Coin<0x18d1215fb5a050ed22da5cdefb9601adead8a9c3576e30c9bc03cbdb2eb17b47::generis::GENERIS>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        if (!0x2::table::contains<address, 0x2::table::Table<0x2::object::ID, GatedVaultRegistryItem>>(&arg0.registry, 0x2::tx_context::sender(arg3))) {
            0x2::table::add<address, 0x2::table::Table<0x2::object::ID, GatedVaultRegistryItem>>(&mut arg0.registry, 0x2::tx_context::sender(arg3), 0x2::table::new<0x2::object::ID, GatedVaultRegistryItem>(arg3));
        };
        let v0 = GatedVaultRegistryItem{
            id          : 0x2::object::new(arg3),
            balance     : 0x2::coin::into_balance<0x18d1215fb5a050ed22da5cdefb9601adead8a9c3576e30c9bc03cbdb2eb17b47::generis::GENERIS>(arg2),
            unlock_date : arg1,
        };
        let v1 = 0x2::object::id<GatedVaultRegistryItem>(&v0);
        0x2::table::add<0x2::object::ID, GatedVaultRegistryItem>(0x2::table::borrow_mut<address, 0x2::table::Table<0x2::object::ID, GatedVaultRegistryItem>>(&mut arg0.registry, 0x2::tx_context::sender(arg3)), v1, v0);
        v1
    }

    public entry fun admin_unlock_vault(arg0: &GatedVaultAdminCap, arg1: &mut GatedVaultRegistry, arg2: address, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<address, 0x2::table::Table<0x2::object::ID, GatedVaultRegistryItem>>(&arg1.registry, arg2), 1);
        let v0 = 0x2::table::borrow_mut<address, 0x2::table::Table<0x2::object::ID, GatedVaultRegistryItem>>(&mut arg1.registry, arg2);
        assert!(0x2::table::contains<0x2::object::ID, GatedVaultRegistryItem>(v0, arg3), 1);
        let GatedVaultRegistryItem {
            id          : v1,
            balance     : v2,
            unlock_date : _,
        } = 0x2::table::remove<0x2::object::ID, GatedVaultRegistryItem>(v0, arg3);
        0x2::object::delete(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x18d1215fb5a050ed22da5cdefb9601adead8a9c3576e30c9bc03cbdb2eb17b47::generis::GENERIS>>(0x2::coin::from_balance<0x18d1215fb5a050ed22da5cdefb9601adead8a9c3576e30c9bc03cbdb2eb17b47::generis::GENERIS>(v2, arg4), arg2);
    }

    public entry fun claim_unlocked_vault(arg0: &mut GatedVaultRegistry, arg1: &0x2::clock::Clock, arg2: address, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<address, 0x2::table::Table<0x2::object::ID, GatedVaultRegistryItem>>(&arg0.registry, arg2), 1);
        let v0 = 0x2::table::borrow_mut<address, 0x2::table::Table<0x2::object::ID, GatedVaultRegistryItem>>(&mut arg0.registry, arg2);
        assert!(0x2::table::contains<0x2::object::ID, GatedVaultRegistryItem>(v0, arg3), 1);
        let GatedVaultRegistryItem {
            id          : v1,
            balance     : v2,
            unlock_date : v3,
        } = 0x2::table::remove<0x2::object::ID, GatedVaultRegistryItem>(v0, arg3);
        assert!(0x2::clock::timestamp_ms(arg1) >= v3, 2);
        0x2::object::delete(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x18d1215fb5a050ed22da5cdefb9601adead8a9c3576e30c9bc03cbdb2eb17b47::generis::GENERIS>>(0x2::coin::from_balance<0x18d1215fb5a050ed22da5cdefb9601adead8a9c3576e30c9bc03cbdb2eb17b47::generis::GENERIS>(v2, arg4), arg2);
    }

    public fun get_registry(arg0: &GatedVaultRegistry) : &0x2::table::Table<address, 0x2::table::Table<0x2::object::ID, GatedVaultRegistryItem>> {
        &arg0.registry
    }

    public fun get_unlock_date(arg0: &GatedVaultRegistry, arg1: address, arg2: 0x2::object::ID) : u64 {
        0x2::table::borrow<0x2::object::ID, GatedVaultRegistryItem>(0x2::table::borrow<address, 0x2::table::Table<0x2::object::ID, GatedVaultRegistryItem>>(&arg0.registry, arg1), arg2).unlock_date
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GatedVaultRegistry{
            id       : 0x2::object::new(arg0),
            registry : 0x2::table::new<address, 0x2::table::Table<0x2::object::ID, GatedVaultRegistryItem>>(arg0),
        };
        0x2::transfer::public_share_object<GatedVaultRegistry>(v0);
        let v1 = GatedVaultAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<GatedVaultAdminCap>(v1, @0xc333120e29ae0b59f924836c2eff13a06b9009324dee51fe8aa880107c7b08be);
    }

    public fun remove_from_registry_for_migration(arg0: &mut GatedVaultRegistry, arg1: address, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 == 0x2::tx_context::sender(arg3), 9223372754114314239);
        let GatedVaultRegistryItem {
            id          : v0,
            balance     : v1,
            unlock_date : _,
        } = 0x2::table::remove<0x2::object::ID, GatedVaultRegistryItem>(0x2::table::borrow_mut<address, 0x2::table::Table<0x2::object::ID, GatedVaultRegistryItem>>(&mut arg0.registry, arg1), arg2);
        0x2::object::delete(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x18d1215fb5a050ed22da5cdefb9601adead8a9c3576e30c9bc03cbdb2eb17b47::generis::GENERIS>>(0x2::coin::from_balance<0x18d1215fb5a050ed22da5cdefb9601adead8a9c3576e30c9bc03cbdb2eb17b47::generis::GENERIS>(v1, arg3), arg1);
    }

    public fun unlock_date(arg0: &GatedVaultRegistryItem) : u64 {
        arg0.unlock_date
    }

    // decompiled from Move bytecode v6
}

