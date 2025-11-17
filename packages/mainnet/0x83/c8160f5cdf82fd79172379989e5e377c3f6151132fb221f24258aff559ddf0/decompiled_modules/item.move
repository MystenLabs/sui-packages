module 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::item {
    struct Item has store, key {
        id: 0x2::object::UID,
        owner: address,
        nft_number: u64,
        collection_id: 0x2::object::ID,
        collection_owner: address,
    }

    struct ItemMetadataKey has copy, drop, store {
        item_id: 0x2::object::ID,
    }

    struct ItemMetadata has copy, drop, store {
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::option::Option<0x1::string::String>,
        animation_url: 0x1::option::Option<0x1::string::String>,
        quantity: u64,
        attributes: vector<Attribute>,
    }

    struct Attribute has copy, drop, store {
        name: 0x1::string::String,
        value: 0x1::string::String,
    }

    struct ItemMinted has copy, drop {
        item_id: 0x2::object::ID,
        collection_id: 0x2::object::ID,
        nft_number: u64,
        owner: address,
        collection_owner: address,
    }

    struct ItemMetadataUpdated has copy, drop {
        item_id: 0x2::object::ID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::option::Option<0x1::string::String>,
        animation_url: 0x1::option::Option<0x1::string::String>,
        attributes: vector<Attribute>,
    }

    struct ItemMetadataAttributesUpdated has copy, drop {
        item_id: 0x2::object::ID,
        attributes: vector<Attribute>,
    }

    struct ItemBurned has copy, drop {
        item_id: 0x2::object::ID,
    }

    struct ItemTransferred has copy, drop {
        item_id: 0x2::object::ID,
        from: address,
        to: address,
    }

    struct ITEM has drop {
        dummy_field: bool,
    }

    public fun batch_burn_collection_items(arg0: &0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::RoleManager, arg1: &mut 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::collection::Collection, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::has_role(arg0, 0x2::tx_context::sender(arg2), 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::factory_role()), 1);
        while (!0x1::vector::is_empty<0x2::object::ID>(0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::collection::get_burnable_items_ids(arg1))) {
            let v0 = 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::collection::pop_burnable_item(arg1);
            let v1 = ItemMetadataKey{item_id: v0};
            let v2 = 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::collection::borrow_collection_id_mut(arg1);
            if (0x2::dynamic_field::exists_<ItemMetadataKey>(v2, v1)) {
                0x2::dynamic_field::remove<ItemMetadataKey, ItemMetadata>(v2, v1);
            };
            let Item {
                id               : v3,
                owner            : _,
                nft_number       : _,
                collection_id    : _,
                collection_owner : _,
            } = 0x2::dynamic_field::remove<0x2::object::ID, Item>(0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::collection::borrow_collection_id_mut(arg1), v0);
            0x2::object::delete(v3);
            let v8 = ItemBurned{item_id: v0};
            0x2::event::emit<ItemBurned>(v8);
        };
        0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::collection::decrement_items_count(arg1, 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::collection::get_burnable_count_value(arg1));
        0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::collection::reset_burnable_count(arg1);
    }

    public fun batch_confirm_collection_items_for_burn(arg0: &0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::RoleManager, arg1: &mut 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::collection::Collection, arg2: vector<0x2::object::ID>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::has_role(arg0, 0x2::tx_context::sender(arg3), 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::factory_role()), 1);
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::object::ID>(&arg2)) {
            let v1 = *0x1::vector::borrow<0x2::object::ID>(&arg2, v0);
            if (0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::collection::remove_pending_burn_item(arg1, v1)) {
                0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::collection::add_burnable_item(arg1, v1);
            };
            v0 = v0 + 1;
        };
    }

    public fun batch_recovery_collection_items_by_burn(arg0: &0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::RoleManager, arg1: &mut 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::collection::Collection, arg2: vector<0x2::object::ID>, arg3: vector<address>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::has_role(arg0, 0x2::tx_context::sender(arg4), 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::factory_role()), 1);
        let v0 = 0x1::vector::length<0x2::object::ID>(&arg2);
        assert!(v0 == 0x1::vector::length<address>(&arg3), 5);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = *0x1::vector::borrow<0x2::object::ID>(&arg2, v1);
            let v3 = *0x1::vector::borrow<address>(&arg3, v1);
            let v4 = 0x2::dynamic_field::remove<0x2::object::ID, Item>(0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::collection::borrow_collection_id_mut(arg1), v2);
            assert!(v4.owner == v3, 2);
            0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::collection::remove_pending_burn_item(arg1, v2);
            0x2::transfer::public_transfer<Item>(v4, v3);
            v1 = v1 + 1;
        };
    }

    public fun convert_attribute(arg0: 0x1::string::String, arg1: 0x1::string::String) : Attribute {
        Attribute{
            name  : arg0,
            value : arg1,
        }
    }

    public fun convert_attributes(arg0: vector<0x1::string::String>, arg1: vector<0x1::string::String>) : vector<Attribute> {
        assert!(0x1::vector::length<0x1::string::String>(&arg0) == 0x1::vector::length<0x1::string::String>(&arg1), 4);
        let v0 = 0x1::vector::empty<Attribute>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::string::String>(&arg0)) {
            0x1::vector::push_back<Attribute>(&mut v0, convert_attribute(*0x1::vector::borrow<0x1::string::String>(&arg0, v1), *0x1::vector::borrow<0x1::string::String>(&arg1, v1)));
            v1 = v1 + 1;
        };
        v0
    }

    public fun directly_burn_collection_item(arg0: &mut 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::collection::Collection, arg1: Item, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.owner == 0x2::tx_context::sender(arg2), 2);
        assert!(arg1.collection_id == 0x2::object::id<0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::collection::Collection>(arg0), 3);
        let v0 = 0x2::object::id<Item>(&arg1);
        let v1 = ItemMetadataKey{item_id: v0};
        let v2 = 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::collection::borrow_collection_id_mut(arg0);
        if (0x2::dynamic_field::exists_<ItemMetadataKey>(v2, v1)) {
            0x2::dynamic_field::remove<ItemMetadataKey, ItemMetadata>(v2, v1);
        };
        let Item {
            id               : v3,
            owner            : _,
            nft_number       : _,
            collection_id    : _,
            collection_owner : _,
        } = arg1;
        0x2::object::delete(v3);
        0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::collection::decrement_items_count(arg0, 1);
        let v8 = ItemBurned{item_id: v0};
        0x2::event::emit<ItemBurned>(v8);
    }

    public fun get_item_collection_id(arg0: &Item) : 0x2::object::ID {
        arg0.collection_id
    }

    public fun get_item_id(arg0: &Item) : 0x2::object::ID {
        0x2::object::id<Item>(arg0)
    }

    public fun get_item_info(arg0: &Item) : (0x2::object::ID, 0x2::object::ID, address, address) {
        (0x2::object::id<Item>(arg0), arg0.collection_id, arg0.owner, arg0.collection_owner)
    }

    public fun get_item_metadata(arg0: &0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::collection::Collection, arg1: 0x2::object::ID) : (0x1::string::String, 0x1::string::String, 0x1::option::Option<0x1::string::String>, 0x1::option::Option<0x1::string::String>, u64, vector<Attribute>) {
        let v0 = ItemMetadataKey{item_id: arg1};
        let v1 = 0x2::dynamic_field::borrow<ItemMetadataKey, ItemMetadata>(0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::collection::borrow_collection_id(arg0), v0);
        (v1.name, v1.description, v1.image_url, v1.animation_url, v1.quantity, v1.attributes)
    }

    public fun get_item_owner(arg0: &Item) : address {
        arg0.owner
    }

    fun init(arg0: ITEM, arg1: &mut 0x2::tx_context::TxContext) {
    }

    public fun mint_collection_item(arg0: &0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::RoleManager, arg1: &mut 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::collection::Collection, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::option::Option<0x1::string::String>, arg5: 0x1::option::Option<0x1::string::String>, arg6: u64, arg7: vector<Attribute>, arg8: address, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg9);
        assert!(0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::has_role(arg0, v0, 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::factory_role()) || v0 == 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::collection::get_owner(arg1), 1);
        let v1 = 0x2::object::id<0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::collection::Collection>(arg1);
        let v2 = 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::collection::increment_cumulative_items_count(arg1);
        let v3 = Item{
            id               : 0x2::object::new(arg9),
            owner            : arg8,
            nft_number       : v2,
            collection_id    : v1,
            collection_owner : 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::collection::get_owner(arg1),
        };
        let v4 = 0x2::object::id<Item>(&v3);
        0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::collection::increment_items_count(arg1);
        let v5 = ItemMetadata{
            name          : arg2,
            description   : arg3,
            image_url     : arg4,
            animation_url : arg5,
            quantity      : arg6,
            attributes    : arg7,
        };
        let v6 = ItemMetadataKey{item_id: v4};
        0x2::dynamic_field::add<ItemMetadataKey, ItemMetadata>(0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::collection::borrow_collection_id_mut(arg1), v6, v5);
        let v7 = ItemMinted{
            item_id          : v4,
            collection_id    : v1,
            nft_number       : v2,
            owner            : v0,
            collection_owner : 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::collection::get_owner(arg1),
        };
        0x2::event::emit<ItemMinted>(v7);
        0x2::transfer::public_transfer<Item>(v3, arg8);
    }

    public fun register_collection_item_for_burn(arg0: &mut 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::collection::Collection, arg1: Item, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.owner == 0x2::tx_context::sender(arg2), 2);
        assert!(arg1.collection_id == 0x2::object::id<0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::collection::Collection>(arg0), 3);
        let v0 = 0x2::object::id<Item>(&arg1);
        0x2::dynamic_field::add<0x2::object::ID, Item>(0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::collection::borrow_collection_id_mut(arg0), v0, arg1);
        0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::collection::add_pending_burn_item(arg0, v0);
    }

    public fun set_collection_item_metadata(arg0: &0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::RoleManager, arg1: &mut 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::collection::Collection, arg2: 0x2::object::ID, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::option::Option<0x1::string::String>, arg6: 0x1::option::Option<0x1::string::String>, arg7: vector<Attribute>, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        assert!(0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::has_role(arg0, v0, 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::factory_role()) || v0 == 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::collection::get_owner(arg1), 1);
        let v1 = ItemMetadataKey{item_id: arg2};
        let v2 = 0x2::dynamic_field::borrow_mut<ItemMetadataKey, ItemMetadata>(0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::collection::borrow_collection_id_mut(arg1), v1);
        v2.name = arg3;
        v2.description = arg4;
        v2.image_url = arg5;
        v2.animation_url = arg6;
        v2.attributes = arg7;
        let v3 = ItemMetadataUpdated{
            item_id       : arg2,
            name          : v2.name,
            description   : v2.description,
            image_url     : v2.image_url,
            animation_url : v2.animation_url,
            attributes    : v2.attributes,
        };
        0x2::event::emit<ItemMetadataUpdated>(v3);
    }

    public fun set_collection_item_metadata_attributes(arg0: &0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::RoleManager, arg1: &mut 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::collection::Collection, arg2: 0x2::object::ID, arg3: vector<Attribute>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::has_role(arg0, v0, 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::factory_role()) || v0 == 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::collection::get_owner(arg1), 1);
        let v1 = ItemMetadataKey{item_id: arg2};
        let v2 = 0x2::dynamic_field::borrow_mut<ItemMetadataKey, ItemMetadata>(0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::collection::borrow_collection_id_mut(arg1), v1);
        v2.attributes = arg3;
        let v3 = ItemMetadataAttributesUpdated{
            item_id    : arg2,
            attributes : v2.attributes,
        };
        0x2::event::emit<ItemMetadataAttributesUpdated>(v3);
    }

    public fun transfer_collection_item(arg0: Item, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(arg0.owner == v0, 2);
        let v1 = ItemTransferred{
            item_id : 0x2::object::id<Item>(&arg0),
            from    : v0,
            to      : arg1,
        };
        0x2::event::emit<ItemTransferred>(v1);
        0x2::transfer::public_transfer<Item>(arg0, arg1);
    }

    public(friend) fun update_item_owner(arg0: &mut Item, arg1: address) {
        arg0.owner = arg1;
    }

    // decompiled from Move bytecode v6
}

