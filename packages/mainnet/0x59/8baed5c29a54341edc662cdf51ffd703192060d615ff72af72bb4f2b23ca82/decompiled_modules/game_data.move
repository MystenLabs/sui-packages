module 0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::game_data {
    struct GameData has key {
        id: 0x2::object::UID,
        item_types: vector<0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::item_types::ItemType>,
        items_registry: vector<0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::item_types::ItemInfo>,
        factions: vector<0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::factions::Faction>,
    }

    public(friend) fun add_faction(arg0: &0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::admin_cap::AdminCap, arg1: &mut GameData, arg2: u64, arg3: 0x1::string::String, arg4: 0x1::string::String) {
        let v0 = find_faction_by_id(arg1, arg2);
        0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::errors::assert_duplicate_id(0x1::option::is_none<u64>(&v0));
        0x1::vector::push_back<0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::factions::Faction>(&mut arg1.factions, 0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::factions::new_faction(arg2, arg3, arg4));
    }

    public(friend) fun add_item(arg0: &0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::admin_cap::AdminCap, arg1: &mut GameData, arg2: u64, arg3: u64, arg4: 0x1::string::String, arg5: u64, arg6: u64, arg7: 0x1::option::Option<u64>) {
        let v0 = find_type_by_id(arg1, arg3);
        0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::errors::assert_invalid_type(0x1::option::is_some<u64>(&v0));
        let v1 = find_item_by_id(arg1, arg2);
        0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::errors::assert_duplicate_id(0x1::option::is_none<u64>(&v1));
        if (0x1::option::is_some<u64>(&arg7)) {
            let v2 = find_faction_by_id(arg1, *0x1::option::borrow<u64>(&arg7));
            0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::errors::assert_invalid_item(0x1::option::is_some<u64>(&v2));
        };
        0x1::vector::push_back<0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::item_types::ItemInfo>(&mut arg1.items_registry, 0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::item_types::new_item_info(arg2, arg3, arg4, arg5, arg6, 0, arg7));
    }

    public(friend) fun add_item_type(arg0: &0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::admin_cap::AdminCap, arg1: &mut GameData, arg2: u64, arg3: 0x1::string::String) {
        let v0 = find_type_by_id(arg1, arg2);
        0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::errors::assert_duplicate_id(0x1::option::is_none<u64>(&v0));
        0x1::vector::push_back<0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::item_types::ItemType>(&mut arg1.item_types, 0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::item_types::new_item_type(arg2, arg3));
    }

    fun create_initial_factions() : vector<0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::factions::Faction> {
        0x1::vector::empty<0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::factions::Faction>()
    }

    fun create_initial_items() : vector<0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::item_types::ItemInfo> {
        0x1::vector::empty<0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::item_types::ItemInfo>()
    }

    fun create_item_types() : vector<0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::item_types::ItemType> {
        let v0 = 0x1::vector::empty<0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::item_types::ItemType>();
        0x1::vector::push_back<0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::item_types::ItemType>(&mut v0, 0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::item_types::new_item_type(0, 0x1::string::utf8(b"Hat")));
        0x1::vector::push_back<0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::item_types::ItemType>(&mut v0, 0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::item_types::new_item_type(1, 0x1::string::utf8(b"Shirt")));
        0x1::vector::push_back<0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::item_types::ItemType>(&mut v0, 0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::item_types::new_item_type(2, 0x1::string::utf8(b"Glasses")));
        v0
    }

    public(friend) fun find_faction_by_id(arg0: &GameData, arg1: u64) : 0x1::option::Option<u64> {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::factions::Faction>(&arg0.factions)) {
            if (0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::factions::faction_id(0x1::vector::borrow<0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::factions::Faction>(&arg0.factions, v0)) == arg1) {
                return 0x1::option::some<u64>(v0)
            };
            v0 = v0 + 1;
        };
        0x1::option::none<u64>()
    }

    public(friend) fun find_item_by_id(arg0: &GameData, arg1: u64) : 0x1::option::Option<u64> {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::item_types::ItemInfo>(&arg0.items_registry)) {
            if (0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::item_types::item_info_id(0x1::vector::borrow<0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::item_types::ItemInfo>(&arg0.items_registry, v0)) == arg1) {
                return 0x1::option::some<u64>(v0)
            };
            v0 = v0 + 1;
        };
        0x1::option::none<u64>()
    }

    public(friend) fun find_type_by_id(arg0: &GameData, arg1: u64) : 0x1::option::Option<u64> {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::item_types::ItemType>(&arg0.item_types)) {
            if (0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::item_types::item_type_id(0x1::vector::borrow<0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::item_types::ItemType>(&arg0.item_types, v0)) == arg1) {
                return 0x1::option::some<u64>(v0)
            };
            v0 = v0 + 1;
        };
        0x1::option::none<u64>()
    }

    public(friend) fun game_data_item_types(arg0: &GameData) : &vector<0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::item_types::ItemType> {
        &arg0.item_types
    }

    public(friend) fun game_data_items_registry(arg0: &GameData) : &vector<0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::item_types::ItemInfo> {
        &arg0.items_registry
    }

    public(friend) fun get_faction_by_id(arg0: &GameData, arg1: u64) : &0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::factions::Faction {
        let v0 = find_faction_by_id(arg0, arg1);
        0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::errors::assert_invalid_item(0x1::option::is_some<u64>(&v0));
        0x1::vector::borrow<0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::factions::Faction>(&arg0.factions, 0x1::option::extract<u64>(&mut v0))
    }

    public(friend) fun get_item_by_id(arg0: &GameData, arg1: u64) : &0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::item_types::ItemInfo {
        let v0 = find_item_by_id(arg0, arg1);
        0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::errors::assert_invalid_item(0x1::option::is_some<u64>(&v0));
        0x1::vector::borrow<0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::item_types::ItemInfo>(&arg0.items_registry, 0x1::option::extract<u64>(&mut v0))
    }

    public(friend) fun get_item_by_id_mut(arg0: &mut GameData, arg1: u64) : &mut 0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::item_types::ItemInfo {
        let v0 = find_item_by_id(arg0, arg1);
        0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::errors::assert_invalid_item(0x1::option::is_some<u64>(&v0));
        0x1::vector::borrow_mut<0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::item_types::ItemInfo>(&mut arg0.items_registry, 0x1::option::extract<u64>(&mut v0))
    }

    public(friend) fun init_game_data(arg0: &0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::admin_cap::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = GameData{
            id             : 0x2::object::new(arg1),
            item_types     : create_item_types(),
            items_registry : create_initial_items(),
            factions       : create_initial_factions(),
        };
        0x2::transfer::share_object<GameData>(v0);
    }

    // decompiled from Move bytecode v6
}

