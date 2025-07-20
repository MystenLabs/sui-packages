module 0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::game_data {
    struct GameData has key {
        id: 0x2::object::UID,
        item_types: vector<0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::item_types::ItemType>,
        items_registry: vector<0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::item_types::ItemInfo>,
    }

    public entry fun add_item(arg0: &0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::admin_cap::AdminCap, arg1: &mut GameData, arg2: u64, arg3: u64, arg4: 0x1::string::String, arg5: u64, arg6: u64) {
        let v0 = find_type_by_id(arg1, arg3);
        0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::errors::assert_invalid_type(0x1::option::is_some<u64>(&v0));
        let v1 = find_item_by_id(arg1, arg2);
        0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::errors::assert_duplicate_id(0x1::option::is_none<u64>(&v1));
        0x1::vector::push_back<0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::item_types::ItemInfo>(&mut arg1.items_registry, 0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::item_types::new_item_info(arg2, arg3, arg4, arg5, arg6, 0));
    }

    public entry fun add_item_type(arg0: &0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::admin_cap::AdminCap, arg1: &mut GameData, arg2: u64, arg3: 0x1::string::String) {
        let v0 = find_type_by_id(arg1, arg2);
        0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::errors::assert_duplicate_id(0x1::option::is_none<u64>(&v0));
        0x1::vector::push_back<0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::item_types::ItemType>(&mut arg1.item_types, 0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::item_types::new_item_type(arg2, arg3));
    }

    fun create_initial_items() : vector<0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::item_types::ItemInfo> {
        let v0 = 0x1::vector::empty<0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::item_types::ItemInfo>();
        0x1::vector::push_back<0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::item_types::ItemInfo>(&mut v0, 0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::item_types::new_item_info(101, 0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::constants::item_type_hat(), 0x1::string::utf8(b"Basic Hat"), 3500, 1000, 0));
        0x1::vector::push_back<0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::item_types::ItemInfo>(&mut v0, 0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::item_types::new_item_info(102, 0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::constants::item_type_hat(), 0x1::string::utf8(b"Limited Hat"), 1400, 100, 0));
        0x1::vector::push_back<0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::item_types::ItemInfo>(&mut v0, 0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::item_types::new_item_info(103, 0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::constants::item_type_hat(), 0x1::string::utf8(b"Rare Hat"), 100, 10, 0));
        0x1::vector::push_back<0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::item_types::ItemInfo>(&mut v0, 0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::item_types::new_item_info(201, 0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::constants::item_type_shirt(), 0x1::string::utf8(b"Basic Shirt"), 2500, 0, 0));
        0x1::vector::push_back<0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::item_types::ItemInfo>(&mut v0, 0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::item_types::new_item_info(301, 0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::constants::item_type_pants(), 0x1::string::utf8(b"Basic Pants"), 2500, 0, 0));
        0x1::vector::push_back<0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::item_types::ItemInfo>(&mut v0, 0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::item_types::new_item_info(401, 0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::constants::item_type_accessory(), 0x1::string::utf8(b"Basic Accessory"), 1500, 0, 0));
        v0
    }

    fun create_item_types() : vector<0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::item_types::ItemType> {
        let v0 = 0x1::vector::empty<0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::item_types::ItemType>();
        0x1::vector::push_back<0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::item_types::ItemType>(&mut v0, 0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::item_types::new_item_type(0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::constants::item_type_hat(), 0x1::string::utf8(b"Hat")));
        0x1::vector::push_back<0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::item_types::ItemType>(&mut v0, 0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::item_types::new_item_type(0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::constants::item_type_shirt(), 0x1::string::utf8(b"Shirt")));
        0x1::vector::push_back<0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::item_types::ItemType>(&mut v0, 0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::item_types::new_item_type(0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::constants::item_type_pants(), 0x1::string::utf8(b"Pants")));
        0x1::vector::push_back<0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::item_types::ItemType>(&mut v0, 0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::item_types::new_item_type(0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::constants::item_type_accessory(), 0x1::string::utf8(b"Accessory")));
        v0
    }

    public fun find_item_by_id(arg0: &GameData, arg1: u64) : 0x1::option::Option<u64> {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::item_types::ItemInfo>(&arg0.items_registry)) {
            if (0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::item_types::item_info_id(0x1::vector::borrow<0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::item_types::ItemInfo>(&arg0.items_registry, v0)) == arg1) {
                return 0x1::option::some<u64>(v0)
            };
            v0 = v0 + 1;
        };
        0x1::option::none<u64>()
    }

    public fun find_type_by_id(arg0: &GameData, arg1: u64) : 0x1::option::Option<u64> {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::item_types::ItemType>(&arg0.item_types)) {
            if (0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::item_types::item_type_id(0x1::vector::borrow<0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::item_types::ItemType>(&arg0.item_types, v0)) == arg1) {
                return 0x1::option::some<u64>(v0)
            };
            v0 = v0 + 1;
        };
        0x1::option::none<u64>()
    }

    public fun game_data_item_types(arg0: &GameData) : &vector<0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::item_types::ItemType> {
        &arg0.item_types
    }

    public fun game_data_item_types_mut(arg0: &mut GameData) : &mut vector<0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::item_types::ItemType> {
        &mut arg0.item_types
    }

    public fun game_data_items_registry(arg0: &GameData) : &vector<0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::item_types::ItemInfo> {
        &arg0.items_registry
    }

    public fun game_data_items_registry_mut(arg0: &mut GameData) : &mut vector<0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::item_types::ItemInfo> {
        &mut arg0.items_registry
    }

    public fun get_item_by_id(arg0: &GameData, arg1: u64) : &0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::item_types::ItemInfo {
        let v0 = find_item_by_id(arg0, arg1);
        0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::errors::assert_invalid_item(0x1::option::is_some<u64>(&v0));
        0x1::vector::borrow<0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::item_types::ItemInfo>(&arg0.items_registry, 0x1::option::extract<u64>(&mut v0))
    }

    public fun get_item_by_id_mut(arg0: &mut GameData, arg1: u64) : &mut 0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::item_types::ItemInfo {
        let v0 = find_item_by_id(arg0, arg1);
        0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::errors::assert_invalid_item(0x1::option::is_some<u64>(&v0));
        0x1::vector::borrow_mut<0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::item_types::ItemInfo>(&mut arg0.items_registry, 0x1::option::extract<u64>(&mut v0))
    }

    public fun init_game_data(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GameData{
            id             : 0x2::object::new(arg0),
            item_types     : create_item_types(),
            items_registry : create_initial_items(),
        };
        0x2::transfer::share_object<GameData>(v0);
    }

    // decompiled from Move bytecode v6
}

