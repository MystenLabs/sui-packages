module 0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item_manager {
    public fun admin_lock_newly_minted(arg0: &0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::admin::AdminCap, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item::Item, arg3: 0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::promise::Promise<0x2::object::ID>, arg4: &mut 0x2::tx_context::TxContext) {
        0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::admin::verify(arg0, arg4);
        assert!(0x2::kiosk_extension::is_installed<0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::extension::AresRPG>(arg1), 101);
        0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::promise::resolve<0x2::object::ID>(arg3, 0x2::object::id<0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item::Item>(&arg2));
        0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::events::emit_item_mint_event(0x2::object::id<0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item::Item>(&arg2), 0x2::object::id<0x2::kiosk::Kiosk>(arg1));
        0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::extension::place_item_in_extension(arg1, arg2, arg4);
    }

    public fun admin_mint(arg0: &0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::admin::AdminCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u8, arg6: u32, arg7: bool, arg8: &mut 0x2::tx_context::TxContext) : (0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item::Item, 0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::promise::Promise<0x2::object::ID>) {
        0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::admin::verify(arg0, arg8);
        let v0 = 0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item::new(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        (v0, 0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::promise::await<0x2::object::ID>(0x2::object::id<0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item::Item>(&v0)))
    }

    public fun destroy_item(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: &0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::protected_policy::AresRPG_TransferPolicy<0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item::Item>, arg3: 0x2::object::ID, arg4: &0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::version::assert_latest(arg4);
        let v0 = 0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::protected_policy::extract_from_kiosk<0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item::Item>(arg2, arg0, arg1, arg3, arg5);
        0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::events::emit_item_destroy_event(0x2::object::id<0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item::Item>(&v0), 0x2::object::id<0x2::kiosk::Kiosk>(arg0));
        0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item::destroy(v0);
    }

    public fun merge_items_different_kiosk(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: 0x2::object::ID, arg6: &0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::protected_policy::AresRPG_TransferPolicy<0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item::Item>, arg7: &0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::version::Version, arg8: &mut 0x2::tx_context::TxContext) {
        0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::version::assert_latest(arg7);
        let v0 = 0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::protected_policy::extract_from_kiosk<0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item::Item>(arg6, arg3, arg4, arg5, arg8);
        let v1 = 0x2::kiosk::borrow_mut<0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item::Item>(arg0, arg1, arg2);
        0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::events::emit_item_merge_event(arg2, 0x2::object::id<0x2::kiosk::Kiosk>(arg0), arg5, 0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item::amount(&v0) + 0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item::amount(v1), 0x2::object::id<0x2::kiosk::Kiosk>(arg3));
        0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item::merge(v1, v0);
    }

    public fun merge_items_single_kiosk(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: &0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::protected_policy::AresRPG_TransferPolicy<0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item::Item>, arg5: &0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::version::assert_latest(arg5);
        let v0 = 0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::protected_policy::extract_from_kiosk<0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item::Item>(arg4, arg0, arg1, arg3, arg6);
        let v1 = 0x2::object::id<0x2::kiosk::Kiosk>(arg0);
        let v2 = 0x2::kiosk::borrow_mut<0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item::Item>(arg0, arg1, arg2);
        0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::events::emit_item_merge_event(arg2, v1, arg3, 0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item::amount(&v0) + 0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item::amount(v2), v1);
        0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item::merge(v2, v0);
    }

    public fun split_item(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: &0x2::transfer_policy::TransferPolicy<0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item::Item>, arg3: 0x2::object::ID, arg4: u32, arg5: &0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::version::Version, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::version::assert_latest(arg5);
        let v0 = 0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item::split(0x2::kiosk::borrow_mut<0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item::Item>(arg0, arg1, arg3), arg4, arg6);
        let v1 = 0x2::object::id<0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item::Item>(&v0);
        0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::events::emit_item_split_event(arg3, 0x2::object::id<0x2::kiosk::Kiosk>(arg0), v1, arg4);
        0x2::kiosk::lock<0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item::Item>(arg0, arg1, arg2, v0);
        v1
    }

    public fun withdraw(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: &0x2::transfer_policy::TransferPolicy<0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item::Item>, arg3: 0x2::object::ID, arg4: &0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::version::assert_latest(arg4);
        let v0 = 0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::extension::take_item_from_extension(arg0, arg1, arg3, arg5);
        0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::events::emit_item_withdraw_event(0x2::object::id<0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item::Item>(&v0), 0x2::object::id<0x2::kiosk::Kiosk>(arg0));
        0x2::kiosk::lock<0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item::Item>(arg0, arg1, arg2, v0);
    }

    // decompiled from Move bytecode v6
}

