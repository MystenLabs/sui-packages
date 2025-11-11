module 0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::ylds {
    struct YLDS has drop {
        dummy_field: bool,
    }

    public fun add_to_deny_list(arg0: &0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::cap_deny_list_manager::DenyListManagerCap, arg1: &mut 0x2::coin::DenyCapV2<YLDS>, arg2: &mut 0x2::deny_list::DenyList, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::functions_add_to_deny_list::add_to_deny_list<YLDS>(arg0, arg1, arg2, arg3, arg4);
    }

    public fun burn_for_redemption(arg0: &mut 0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::root_root::Root, arg1: &mut 0x2::coin::TreasuryCap<YLDS>, arg2: &mut 0x2::coin::Coin<YLDS>, arg3: 0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::types_redemption::Redemption, arg4: &mut 0x2::tx_context::TxContext) {
        0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::root_root::verify_version(arg0);
        0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::functions_burn_for_redemption::burn_for_redemption<YLDS>(arg0, arg1, arg2, arg3, arg4);
    }

    public fun emergency_burn(arg0: &0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::cap_ylds_admin::YldsAdminCap, arg1: &mut 0x2::coin::TreasuryCap<YLDS>, arg2: 0x2::coin::Coin<YLDS>, arg3: &mut 0x2::tx_context::TxContext) {
        0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::functions_emergency_burn::emergency_burn<YLDS>(arg0, arg1, arg2, arg3);
    }

    public fun mint_from_receipt(arg0: &mut 0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::root_root::Root, arg1: &mut 0x2::coin::TreasuryCap<YLDS>, arg2: 0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::types_receipt::Receipt, arg3: &mut 0x2::tx_context::TxContext) {
        0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::root_root::verify_version(arg0);
        0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::functions_mint_from_receipt::mint_from_receipt<YLDS>(arg0, arg1, arg2, arg3);
    }

    public fun redemption_request_exists(arg0: &0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::root_root::Root, arg1: 0x1::string::String) : bool {
        0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::functions_redemption_request_exists::redemption_request_exists(0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::root_root::borrow_redemption_registry(arg0), arg1)
    }

    public fun remove_from_deny_list(arg0: &0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::cap_deny_list_manager::DenyListManagerCap, arg1: &mut 0x2::coin::DenyCapV2<YLDS>, arg2: &mut 0x2::deny_list::DenyList, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::functions_remove_from_deny_list::remove_from_deny_list<YLDS>(arg0, arg1, arg2, arg3, arg4);
    }

    public fun burn_for_redemption_args(arg0: &mut 0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::root_root::Root, arg1: &mut 0x2::coin::TreasuryCap<YLDS>, arg2: &mut 0x2::coin::Coin<YLDS>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::types_redemption::new_redemption(0x1::string::utf8(arg3), 0x1::string::utf8(arg4), 0x1::string::utf8(arg5), arg6, 0x2::tx_context::sender(arg7));
        burn_for_redemption(arg0, arg1, arg2, v0, arg7);
    }

    public fun get_redemption_stats(arg0: &0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::root_root::Root) : (u64, u64) {
        let v0 = 0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::root_root::borrow_redemption_registry(arg0);
        (0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::types_redemption_registry::get_total_burned(v0), 0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::types_redemption_registry::get_redemption_count(v0))
    }

    public fun get_registry_stats(arg0: &0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::root_root::Root) : (u64, u64) {
        let v0 = 0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::root_root::borrow_receipt_registry(arg0);
        (0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::types_receipt_registry::get_total_minted(v0), 0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::types_receipt_registry::get_receipt_count(v0))
    }

    fun init(arg0: YLDS, arg1: &mut 0x2::tx_context::TxContext) {
        0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::functions_init::init_contract<YLDS>(arg0, arg1);
    }

    public fun is_receipt_used(arg0: &0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::root_root::Root, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String) : bool {
        0x2::table::contains<0x1::string::String, bool>(0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::types_receipt_registry::get_used_receipts(0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::root_root::borrow_receipt_registry(arg0)), 0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::functions_create_receipt_id::create_receipt_id(arg1, arg2, arg3))
    }

    entry fun migrate(arg0: &mut 0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::root_root::Root, arg1: &0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::cap_ylds_admin::YldsAdminCap) {
        let v0 = 0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::root_version::get_root_version();
        assert!(0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::root_cap_registry::get_admin(0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::root_root::borrow_cap_registry(arg0)) == 0x2::object::id<0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::cap_ylds_admin::YldsAdminCap>(arg1), 0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::errors::e_admin_required());
        assert!(0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::root_root::get_version(arg0) < v0, 0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::errors::e_invalid_root_version());
        0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::root_root::set_version(arg0, v0);
    }

    public fun mint_from_receipt_args(arg0: &mut 0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::root_root::Root, arg1: &mut 0x2::coin::TreasuryCap<YLDS>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        mint_from_receipt(arg0, arg1, 0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::types_receipt::new_receipt(0x1::string::utf8(arg2), 0x1::string::utf8(arg3), 0x1::string::utf8(arg4), arg5, arg6), arg7);
    }

    public fun transfer_admin_capability(arg0: 0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::cap_ylds_admin::YldsAdminCap, arg1: address) {
        0x2::transfer::public_transfer<0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::cap_ylds_admin::YldsAdminCap>(arg0, arg1);
    }

    public fun transfer_deny_list_capability(arg0: 0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::cap_deny_list_manager::DenyListManagerCap, arg1: address) {
        0x2::transfer::public_transfer<0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::cap_deny_list_manager::DenyListManagerCap>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

