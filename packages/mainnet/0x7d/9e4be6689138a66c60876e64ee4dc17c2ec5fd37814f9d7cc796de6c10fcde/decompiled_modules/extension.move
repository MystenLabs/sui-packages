module 0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::extension {
    struct AresRPG has drop {
        dummy_field: bool,
    }

    struct StorageKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    public fun remove(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: &0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::version::Version) {
        0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::version::assert_latest(arg2);
        0x2::kiosk_extension::remove<AresRPG>(arg0, arg1);
    }

    public fun admin_borrow_character_val(arg0: &0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::admin::AdminCap, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) : (0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::character::Character, 0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::promise::Promise<0x2::object::ID>) {
        0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::admin::verify(arg0, arg3);
        let v0 = StorageKey<0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::character::Character>{dummy_field: false};
        (0x2::object_bag::remove<0x2::object::ID, 0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::character::Character>(borrow_object_bag<0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::character::Character>(arg1, v0, arg3), arg2), 0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::promise::await<0x2::object::ID>(arg2))
    }

    public fun admin_return_character_val(arg0: &0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::admin::AdminCap, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::character::Character, arg3: 0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::promise::Promise<0x2::object::ID>, arg4: &mut 0x2::tx_context::TxContext) {
        0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::admin::verify(arg0, arg4);
        let v0 = 0x2::object::id<0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::character::Character>(&arg2);
        assert!(0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::promise::value<0x2::object::ID>(&arg3) == &v0, 1);
        0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::promise::resolve<0x2::object::ID>(arg3, 0x2::object::id<0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::character::Character>(&arg2));
        let v1 = StorageKey<0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::character::Character>{dummy_field: false};
        0x2::object_bag::add<0x2::object::ID, 0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::character::Character>(borrow_object_bag<0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::character::Character>(arg1, v1, arg4), 0x2::object::id<0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::character::Character>(&arg2), arg2);
    }

    public(friend) fun borrow_character_mut(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) : &mut 0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::character::Character {
        assert!(0x2::kiosk::has_access(arg0, arg1), 3);
        let v0 = StorageKey<0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::character::Character>{dummy_field: false};
        0x2::object_bag::borrow_mut<0x2::object::ID, 0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::character::Character>(borrow_object_bag<0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::character::Character>(arg0, v0, arg3), arg2)
    }

    public(friend) fun borrow_item_mut(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) : &mut 0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item::Item {
        assert!(0x2::kiosk::has_access(arg0, arg1), 3);
        let v0 = StorageKey<0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item::Item>{dummy_field: false};
        0x2::object_bag::borrow_mut<0x2::object::ID, 0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item::Item>(borrow_object_bag<0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item::Item>(arg0, v0, arg3), arg2)
    }

    fun borrow_object_bag<T0>(arg0: &mut 0x2::kiosk::Kiosk, arg1: StorageKey<T0>, arg2: &mut 0x2::tx_context::TxContext) : &mut 0x2::object_bag::ObjectBag {
        let v0 = AresRPG{dummy_field: false};
        let v1 = 0x2::kiosk_extension::storage_mut<AresRPG>(v0, arg0);
        if (!0x2::bag::contains<StorageKey<T0>>(v1, arg1)) {
            0x2::bag::add<StorageKey<T0>, 0x2::object_bag::ObjectBag>(v1, arg1, 0x2::object_bag::new(arg2));
        };
        0x2::bag::borrow_mut<StorageKey<T0>, 0x2::object_bag::ObjectBag>(v1, arg1)
    }

    public fun install(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: &0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::version::assert_latest(arg2);
        0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::events::emit_extension_install_event(0x2::object::id<0x2::kiosk::Kiosk>(arg0));
        let v0 = AresRPG{dummy_field: false};
        0x2::kiosk_extension::add<AresRPG>(v0, arg0, arg1, 11, arg3);
    }

    public(friend) fun place_character_in_extension(arg0: &mut 0x2::kiosk::Kiosk, arg1: 0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::character::Character, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::kiosk_extension::is_installed<AresRPG>(arg0), 2);
        0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::character::set_selected(&mut arg1, true);
        0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::character::set_kiosk_id(&mut arg1, 0x2::object::id<0x2::kiosk::Kiosk>(arg0));
        let v0 = StorageKey<0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::character::Character>{dummy_field: false};
        0x2::object_bag::add<0x2::object::ID, 0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::character::Character>(borrow_object_bag<0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::character::Character>(arg0, v0, arg2), 0x2::object::id<0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::character::Character>(&arg1), arg1);
    }

    public(friend) fun place_item_in_extension(arg0: &mut 0x2::kiosk::Kiosk, arg1: 0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item::Item, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::kiosk_extension::is_installed<AresRPG>(arg0), 2);
        let v0 = StorageKey<0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item::Item>{dummy_field: false};
        0x2::object_bag::add<0x2::object::ID, 0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item::Item>(borrow_object_bag<0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item::Item>(arg0, v0, arg2), 0x2::object::id<0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item::Item>(&arg1), arg1);
    }

    public(friend) fun take_character_from_extension(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) : 0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::character::Character {
        assert!(0x2::kiosk::has_access(arg0, arg1), 3);
        let v0 = StorageKey<0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::character::Character>{dummy_field: false};
        let v1 = 0x2::object_bag::remove<0x2::object::ID, 0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::character::Character>(borrow_object_bag<0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::character::Character>(arg0, v0, arg3), arg2);
        0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::character::set_selected(&mut v1, false);
        0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::character::remove_kiosk_id(&mut v1);
        v1
    }

    public(friend) fun take_item_from_extension(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) : 0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item::Item {
        assert!(0x2::kiosk::has_access(arg0, arg1), 3);
        let v0 = StorageKey<0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item::Item>{dummy_field: false};
        0x2::object_bag::remove<0x2::object::ID, 0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item::Item>(borrow_object_bag<0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item::Item>(arg0, v0, arg3), arg2)
    }

    // decompiled from Move bytecode v6
}

