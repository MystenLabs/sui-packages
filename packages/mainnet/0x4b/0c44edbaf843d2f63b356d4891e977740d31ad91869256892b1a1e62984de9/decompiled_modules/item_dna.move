module 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::item_dna {
    struct ItemDnaKey has copy, drop, store {
        item_id: 0x2::object::ID,
    }

    struct ItemDnaAdded has copy, drop {
        item_id: 0x2::object::ID,
        collection_id: 0x2::object::ID,
        nft_number: u64,
    }

    struct ITEM_DNA has drop {
        dummy_field: bool,
    }

    public fun get_dna_values(arg0: &0x2::object::UID, arg1: 0x2::object::ID) : (vector<u8>, vector<u8>) {
        0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::dna::get_dna_values(get_dna(arg0, arg1))
    }

    public fun add_dna(arg0: &0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::RoleManager, arg1: &mut 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::collection::Collection, arg2: &0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::item::Item, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let (v1, v2, v3, _) = 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::item::get_item_info(arg2);
        let v5 = 0x2::object::id<0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::collection::Collection>(arg1);
        assert!(v0 == v3 || 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::has_role(arg0, v0, 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::factory_role()), 1);
        assert!(v2 == v5, 3);
        let v6 = 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::collection::borrow_collection_id_mut(arg1);
        add_dna_internal(v6, v1, v5, 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::item::get_nft_number(arg2), 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::dna::new(arg3, arg4));
    }

    public(friend) fun add_dna_internal(arg0: &mut 0x2::object::UID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u64, arg4: 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::dna::Dna) {
        let v0 = ItemDnaKey{item_id: arg1};
        assert!(!0x2::dynamic_field::exists_<ItemDnaKey>(arg0, v0), 2);
        0x2::dynamic_field::add<ItemDnaKey, 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::dna::Dna>(arg0, v0, arg4);
        let v1 = ItemDnaAdded{
            item_id       : arg1,
            collection_id : arg2,
            nft_number    : arg3,
        };
        0x2::event::emit<ItemDnaAdded>(v1);
    }

    public fun add_dna_with_fee(arg0: &0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::RoleManager, arg1: &mut 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::fee_manager::FeeManager, arg2: &mut 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::collection::Collection, arg3: &0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::item::Item, arg4: vector<u8>, arg5: vector<u8>, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        let (v1, v2, v3, _) = 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::item::get_item_info(arg3);
        let v5 = v1;
        let v6 = 0x2::object::id<0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::collection::Collection>(arg2);
        assert!(v0 == v3 || 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::has_role(arg0, v0, 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::factory_role()), 1);
        assert!(v2 == v6, 3);
        0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::fee_manager::deposit_dna_creation_fee(arg1, arg6, 0x2::object::id_to_address(&v6), 0x1::option::some<address>(0x2::object::id_to_address(&v5)), arg7);
        let v7 = 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::collection::borrow_collection_id_mut(arg2);
        add_dna_internal(v7, v5, v6, 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::item::get_nft_number(arg3), 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::dna::new(arg4, arg5));
    }

    public fun get_dna(arg0: &0x2::object::UID, arg1: 0x2::object::ID) : &0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::dna::Dna {
        let v0 = ItemDnaKey{item_id: arg1};
        0x2::dynamic_field::borrow<ItemDnaKey, 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::dna::Dna>(arg0, v0)
    }

    public fun has_dna(arg0: &0x2::object::UID, arg1: 0x2::object::ID) : bool {
        let v0 = ItemDnaKey{item_id: arg1};
        0x2::dynamic_field::exists_<ItemDnaKey>(arg0, v0)
    }

    fun init(arg0: ITEM_DNA, arg1: &mut 0x2::tx_context::TxContext) {
    }

    // decompiled from Move bytecode v6
}

