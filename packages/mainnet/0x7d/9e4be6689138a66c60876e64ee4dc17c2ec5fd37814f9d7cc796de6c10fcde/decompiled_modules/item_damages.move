module 0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item_damages {
    struct DamagesKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ItemDamages has copy, drop, store {
        from: u16,
        to: u16,
        damage_type: 0x1::string::String,
        element: 0x1::string::String,
    }

    public fun admin_augment_with_damages(arg0: &0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::admin::AdminCap, arg1: &mut 0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item::Item, arg2: vector<ItemDamages>, arg3: &0x2::tx_context::TxContext) {
        0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::admin::verify(arg0, arg3);
        augment_with_damages(arg1, arg2);
    }

    public fun admin_new(arg0: &0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::admin::AdminCap, arg1: u16, arg2: u16, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &0x2::tx_context::TxContext) : ItemDamages {
        0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::admin::verify(arg0, arg5);
        new(arg1, arg2, arg3, arg4)
    }

    public(friend) fun augment_with_damages(arg0: &mut 0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item::Item, arg1: vector<ItemDamages>) {
        assert!(!0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item::stackable(arg0), 1);
        let v0 = DamagesKey{dummy_field: false};
        0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item::add_field<DamagesKey, vector<ItemDamages>>(arg0, v0, arg1);
    }

    public(friend) fun new(arg0: u16, arg1: u16, arg2: 0x1::string::String, arg3: 0x1::string::String) : ItemDamages {
        ItemDamages{
            from        : arg0,
            to          : arg1,
            damage_type : arg2,
            element     : arg3,
        }
    }

    // decompiled from Move bytecode v6
}

