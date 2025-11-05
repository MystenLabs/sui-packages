module 0x4f8d43678577326eccaf0ed68cb1f5e85e3cbcc6344d8c0fab5463304409e7b7::root_root {
    struct Root has key {
        id: 0x2::object::UID,
        version: u32,
    }

    public(friend) fun borrow_cap_registry(arg0: &Root) : &0x4f8d43678577326eccaf0ed68cb1f5e85e3cbcc6344d8c0fab5463304409e7b7::root_cap_registry::CapRegistry {
        0x2::dynamic_field::borrow<vector<u8>, 0x4f8d43678577326eccaf0ed68cb1f5e85e3cbcc6344d8c0fab5463304409e7b7::root_cap_registry::CapRegistry>(&arg0.id, b"CAP_REGISTRY")
    }

    public(friend) fun borrow_cap_registry_mut(arg0: &mut Root) : &mut 0x4f8d43678577326eccaf0ed68cb1f5e85e3cbcc6344d8c0fab5463304409e7b7::root_cap_registry::CapRegistry {
        0x2::dynamic_field::borrow_mut<vector<u8>, 0x4f8d43678577326eccaf0ed68cb1f5e85e3cbcc6344d8c0fab5463304409e7b7::root_cap_registry::CapRegistry>(&mut arg0.id, b"CAP_REGISTRY")
    }

    public(friend) fun borrow_receipt_registry(arg0: &Root) : &0x4f8d43678577326eccaf0ed68cb1f5e85e3cbcc6344d8c0fab5463304409e7b7::types_receipt_registry::ReceiptRegistry {
        0x2::dynamic_field::borrow<vector<u8>, 0x4f8d43678577326eccaf0ed68cb1f5e85e3cbcc6344d8c0fab5463304409e7b7::types_receipt_registry::ReceiptRegistry>(&arg0.id, b"RECEIPT_REGISTRY")
    }

    public(friend) fun borrow_receipt_registry_mut(arg0: &mut Root) : &mut 0x4f8d43678577326eccaf0ed68cb1f5e85e3cbcc6344d8c0fab5463304409e7b7::types_receipt_registry::ReceiptRegistry {
        0x2::dynamic_field::borrow_mut<vector<u8>, 0x4f8d43678577326eccaf0ed68cb1f5e85e3cbcc6344d8c0fab5463304409e7b7::types_receipt_registry::ReceiptRegistry>(&mut arg0.id, b"RECEIPT_REGISTRY")
    }

    public(friend) fun borrow_redemption_registry(arg0: &Root) : &0x4f8d43678577326eccaf0ed68cb1f5e85e3cbcc6344d8c0fab5463304409e7b7::types_redemption_registry::RedemptionRegistry {
        0x2::dynamic_field::borrow<vector<u8>, 0x4f8d43678577326eccaf0ed68cb1f5e85e3cbcc6344d8c0fab5463304409e7b7::types_redemption_registry::RedemptionRegistry>(&arg0.id, b"REDEMPTION_REGISTRY")
    }

    public(friend) fun borrow_redemption_registry_mut(arg0: &mut Root) : &mut 0x4f8d43678577326eccaf0ed68cb1f5e85e3cbcc6344d8c0fab5463304409e7b7::types_redemption_registry::RedemptionRegistry {
        0x2::dynamic_field::borrow_mut<vector<u8>, 0x4f8d43678577326eccaf0ed68cb1f5e85e3cbcc6344d8c0fab5463304409e7b7::types_redemption_registry::RedemptionRegistry>(&mut arg0.id, b"REDEMPTION_REGISTRY")
    }

    public(friend) fun get_version(arg0: &Root) : u32 {
        arg0.version
    }

    public(friend) fun new_root<T0: drop>(arg0: &mut 0x2::tx_context::TxContext, arg1: &0x2::coin::TreasuryCap<T0>, arg2: &0x4f8d43678577326eccaf0ed68cb1f5e85e3cbcc6344d8c0fab5463304409e7b7::cap_ylds_admin::YldsAdminCap, arg3: &0x4f8d43678577326eccaf0ed68cb1f5e85e3cbcc6344d8c0fab5463304409e7b7::cap_deny_list_manager::DenyListManagerCap, arg4: &0x2::coin::DenyCapV2<T0>) : Root {
        let v0 = Root{
            id      : 0x2::object::new(arg0),
            version : 0x4f8d43678577326eccaf0ed68cb1f5e85e3cbcc6344d8c0fab5463304409e7b7::root_version::get_root_version(),
        };
        0x2::dynamic_field::add<vector<u8>, 0x4f8d43678577326eccaf0ed68cb1f5e85e3cbcc6344d8c0fab5463304409e7b7::root_cap_registry::CapRegistry>(&mut v0.id, b"CAP_REGISTRY", 0x4f8d43678577326eccaf0ed68cb1f5e85e3cbcc6344d8c0fab5463304409e7b7::root_cap_registry::new_cap_registry<T0>(arg0, arg2, arg1, arg3, arg4));
        0x2::dynamic_field::add<vector<u8>, 0x4f8d43678577326eccaf0ed68cb1f5e85e3cbcc6344d8c0fab5463304409e7b7::types_receipt_registry::ReceiptRegistry>(&mut v0.id, b"RECEIPT_REGISTRY", 0x4f8d43678577326eccaf0ed68cb1f5e85e3cbcc6344d8c0fab5463304409e7b7::types_receipt_registry::new_receipt_registry(arg0));
        0x2::dynamic_field::add<vector<u8>, 0x4f8d43678577326eccaf0ed68cb1f5e85e3cbcc6344d8c0fab5463304409e7b7::types_redemption_registry::RedemptionRegistry>(&mut v0.id, b"REDEMPTION_REGISTRY", 0x4f8d43678577326eccaf0ed68cb1f5e85e3cbcc6344d8c0fab5463304409e7b7::types_redemption_registry::new_redemption_registry(arg0));
        v0
    }

    public(friend) fun set_version(arg0: &mut Root, arg1: u32) {
        arg0.version = arg1;
    }

    public(friend) fun share_root(arg0: Root) {
        0x2::transfer::share_object<Root>(arg0);
    }

    public(friend) fun verify_version(arg0: &Root) {
        assert!(arg0.version == 0x4f8d43678577326eccaf0ed68cb1f5e85e3cbcc6344d8c0fab5463304409e7b7::root_version::get_root_version(), 0x4f8d43678577326eccaf0ed68cb1f5e85e3cbcc6344d8c0fab5463304409e7b7::errors::e_invalid_root_version());
    }

    // decompiled from Move bytecode v6
}

