module 0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::character_inventory {
    struct SlotKey has copy, drop, store {
        slot: 0x1::string::String,
    }

    public fun equip_item<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: 0x1::string::String, arg4: 0x2::kiosk::PurchaseCap<T0>, arg5: &0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::version::assert_latest(arg5);
        assert!(item_slot_valid(arg3), 101);
        0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::events::emit_item_equip_event(arg2, arg3, 0x2::object::id<0x2::kiosk::Kiosk>(arg0), 0x2::kiosk::purchase_cap_item<T0>(&arg4));
        let v0 = SlotKey{slot: arg3};
        0x2::object_bag::add<SlotKey, 0x2::kiosk::PurchaseCap<T0>>(0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::character::borrow_inventory_mut(0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::extension::borrow_character_mut(arg0, arg1, arg2, arg6)), v0, arg4);
    }

    fun item_slot_valid(arg0: 0x1::string::String) : bool {
        arg0 == 0x1::string::utf8(b"hat") || arg0 == 0x1::string::utf8(b"amulet") || arg0 == 0x1::string::utf8(b"cloack") || arg0 == 0x1::string::utf8(b"left_ring") || arg0 == 0x1::string::utf8(b"right_ring") || arg0 == 0x1::string::utf8(b"belt") || arg0 == 0x1::string::utf8(b"boots") || arg0 == 0x1::string::utf8(b"pet") || arg0 == 0x1::string::utf8(b"weapon") || arg0 == 0x1::string::utf8(b"relic_1") || arg0 == 0x1::string::utf8(b"relic_2") || arg0 == 0x1::string::utf8(b"relic_3") || arg0 == 0x1::string::utf8(b"relic_4") || arg0 == 0x1::string::utf8(b"relic_5") || arg0 == 0x1::string::utf8(b"relic_6") || arg0 == 0x1::string::utf8(b"title")
    }

    public fun unequip_item<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: 0x1::string::String, arg4: &0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::version::Version, arg5: &mut 0x2::tx_context::TxContext) : 0x2::kiosk::PurchaseCap<T0> {
        0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::version::assert_latest(arg4);
        assert!(item_slot_valid(arg3), 101);
        let v0 = SlotKey{slot: arg3};
        let v1 = 0x2::object_bag::remove<SlotKey, 0x2::kiosk::PurchaseCap<T0>>(0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::character::borrow_inventory_mut(0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::extension::borrow_character_mut(arg0, arg1, arg2, arg5)), v0);
        0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::events::emit_item_unequip_event(arg2, arg3, 0x2::object::id<0x2::kiosk::Kiosk>(arg0), 0x2::kiosk::purchase_cap_item<T0>(&v1));
        v1
    }

    // decompiled from Move bytecode v6
}

