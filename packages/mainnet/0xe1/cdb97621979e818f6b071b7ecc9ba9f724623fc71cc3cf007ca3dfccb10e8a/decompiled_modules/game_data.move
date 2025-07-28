module 0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::game_data {
    struct GameData has key {
        id: 0x2::object::UID,
        item_types: vector<0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::item_types::ItemType>,
        items_registry: vector<0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::item_types::ItemInfo>,
        factions: vector<0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::factions::Faction>,
    }

    public entry fun add_faction(arg0: &0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::admin_cap::AdminCap, arg1: &mut GameData, arg2: u64, arg3: 0x1::string::String, arg4: 0x1::string::String) {
        let v0 = find_faction_by_id(arg1, arg2);
        0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::errors::assert_duplicate_id(0x1::option::is_none<u64>(&v0));
        0x1::vector::push_back<0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::factions::Faction>(&mut arg1.factions, 0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::factions::new_faction(arg2, arg3, arg4));
    }

    public entry fun add_item(arg0: &0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::admin_cap::AdminCap, arg1: &mut GameData, arg2: u64, arg3: u64, arg4: 0x1::string::String, arg5: u64, arg6: u64, arg7: 0x1::option::Option<u64>) {
        let v0 = find_type_by_id(arg1, arg3);
        0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::errors::assert_invalid_type(0x1::option::is_some<u64>(&v0));
        let v1 = find_item_by_id(arg1, arg2);
        0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::errors::assert_duplicate_id(0x1::option::is_none<u64>(&v1));
        if (0x1::option::is_some<u64>(&arg7)) {
            let v2 = find_faction_by_id(arg1, *0x1::option::borrow<u64>(&arg7));
            0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::errors::assert_invalid_item(0x1::option::is_some<u64>(&v2));
        };
        0x1::vector::push_back<0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::item_types::ItemInfo>(&mut arg1.items_registry, 0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::item_types::new_item_info(arg2, arg3, arg4, arg5, arg6, 0, arg7));
    }

    public entry fun add_item_type(arg0: &0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::admin_cap::AdminCap, arg1: &mut GameData, arg2: u64, arg3: 0x1::string::String) {
        let v0 = find_type_by_id(arg1, arg2);
        0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::errors::assert_duplicate_id(0x1::option::is_none<u64>(&v0));
        0x1::vector::push_back<0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::item_types::ItemType>(&mut arg1.item_types, 0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::item_types::new_item_type(arg2, arg3));
    }

    fun create_initial_factions() : vector<0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::factions::Faction> {
        let v0 = 0x1::vector::empty<0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::factions::Faction>();
        0x1::vector::push_back<0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::factions::Faction>(&mut v0, 0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::factions::new_faction(1, 0x1::string::utf8(b"Banana Republic"), 0x1::string::utf8(b"The yellow warriors of the jungle")));
        0x1::vector::push_back<0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::factions::Faction>(&mut v0, 0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::factions::new_faction(2, 0x1::string::utf8(b"Coconut Clan"), 0x1::string::utf8(b"Masters of the tropical paradise")));
        0x1::vector::push_back<0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::factions::Faction>(&mut v0, 0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::factions::new_faction(3, 0x1::string::utf8(b"Vine Runners"), 0x1::string::utf8(b"Swift and agile tree climbers")));
        v0
    }

    fun create_initial_items() : vector<0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::item_types::ItemInfo> {
        let v0 = 0x1::vector::empty<0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::item_types::ItemInfo>();
        0x1::vector::push_back<0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::item_types::ItemInfo>(&mut v0, 0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::item_types::new_item_info(101, 0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::constants::item_type_hat(), 0x1::string::utf8(b"Basic Hat"), 3500, 1000, 0, 0x1::option::none<u64>()));
        0x1::vector::push_back<0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::item_types::ItemInfo>(&mut v0, 0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::item_types::new_item_info(102, 0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::constants::item_type_hat(), 0x1::string::utf8(b"Limited Hat"), 1400, 100, 0, 0x1::option::none<u64>()));
        0x1::vector::push_back<0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::item_types::ItemInfo>(&mut v0, 0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::item_types::new_item_info(103, 0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::constants::item_type_hat(), 0x1::string::utf8(b"Rare Hat"), 100, 10, 0, 0x1::option::none<u64>()));
        0x1::vector::push_back<0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::item_types::ItemInfo>(&mut v0, 0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::item_types::new_item_info(201, 0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::constants::item_type_shirt(), 0x1::string::utf8(b"Basic Shirt"), 2500, 0, 0, 0x1::option::none<u64>()));
        0x1::vector::push_back<0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::item_types::ItemInfo>(&mut v0, 0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::item_types::new_item_info(301, 0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::constants::item_type_pants(), 0x1::string::utf8(b"Basic Pants"), 2500, 0, 0, 0x1::option::none<u64>()));
        0x1::vector::push_back<0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::item_types::ItemInfo>(&mut v0, 0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::item_types::new_item_info(401, 0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::constants::item_type_accessory(), 0x1::string::utf8(b"Basic Accessory"), 1500, 0, 0, 0x1::option::none<u64>()));
        0x1::vector::push_back<0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::item_types::ItemInfo>(&mut v0, 0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::item_types::new_item_info(1001, 0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::constants::item_type_hat(), 0x1::string::utf8(b"Banana Crown"), 800, 50, 0, 0x1::option::some<u64>(1)));
        0x1::vector::push_back<0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::item_types::ItemInfo>(&mut v0, 0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::item_types::new_item_info(1002, 0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::constants::item_type_shirt(), 0x1::string::utf8(b"Banana Uniform"), 1200, 75, 0, 0x1::option::some<u64>(1)));
        0x1::vector::push_back<0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::item_types::ItemInfo>(&mut v0, 0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::item_types::new_item_info(2001, 0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::constants::item_type_hat(), 0x1::string::utf8(b"Coconut Helm"), 800, 50, 0, 0x1::option::some<u64>(2)));
        0x1::vector::push_back<0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::item_types::ItemInfo>(&mut v0, 0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::item_types::new_item_info(3001, 0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::constants::item_type_accessory(), 0x1::string::utf8(b"Vine Whip"), 600, 30, 0, 0x1::option::some<u64>(3)));
        v0
    }

    fun create_item_types() : vector<0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::item_types::ItemType> {
        let v0 = 0x1::vector::empty<0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::item_types::ItemType>();
        0x1::vector::push_back<0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::item_types::ItemType>(&mut v0, 0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::item_types::new_item_type(0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::constants::item_type_hat(), 0x1::string::utf8(b"Hat")));
        0x1::vector::push_back<0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::item_types::ItemType>(&mut v0, 0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::item_types::new_item_type(0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::constants::item_type_shirt(), 0x1::string::utf8(b"Shirt")));
        0x1::vector::push_back<0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::item_types::ItemType>(&mut v0, 0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::item_types::new_item_type(0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::constants::item_type_pants(), 0x1::string::utf8(b"Pants")));
        0x1::vector::push_back<0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::item_types::ItemType>(&mut v0, 0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::item_types::new_item_type(0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::constants::item_type_accessory(), 0x1::string::utf8(b"Accessory")));
        v0
    }

    public fun find_faction_by_id(arg0: &GameData, arg1: u64) : 0x1::option::Option<u64> {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::factions::Faction>(&arg0.factions)) {
            if (0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::factions::faction_id(0x1::vector::borrow<0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::factions::Faction>(&arg0.factions, v0)) == arg1) {
                return 0x1::option::some<u64>(v0)
            };
            v0 = v0 + 1;
        };
        0x1::option::none<u64>()
    }

    public fun find_item_by_id(arg0: &GameData, arg1: u64) : 0x1::option::Option<u64> {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::item_types::ItemInfo>(&arg0.items_registry)) {
            if (0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::item_types::item_info_id(0x1::vector::borrow<0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::item_types::ItemInfo>(&arg0.items_registry, v0)) == arg1) {
                return 0x1::option::some<u64>(v0)
            };
            v0 = v0 + 1;
        };
        0x1::option::none<u64>()
    }

    public fun find_type_by_id(arg0: &GameData, arg1: u64) : 0x1::option::Option<u64> {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::item_types::ItemType>(&arg0.item_types)) {
            if (0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::item_types::item_type_id(0x1::vector::borrow<0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::item_types::ItemType>(&arg0.item_types, v0)) == arg1) {
                return 0x1::option::some<u64>(v0)
            };
            v0 = v0 + 1;
        };
        0x1::option::none<u64>()
    }

    public fun game_data_factions(arg0: &GameData) : &vector<0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::factions::Faction> {
        &arg0.factions
    }

    public fun game_data_factions_mut(arg0: &mut GameData) : &mut vector<0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::factions::Faction> {
        &mut arg0.factions
    }

    public fun game_data_item_types(arg0: &GameData) : &vector<0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::item_types::ItemType> {
        &arg0.item_types
    }

    public fun game_data_item_types_mut(arg0: &mut GameData) : &mut vector<0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::item_types::ItemType> {
        &mut arg0.item_types
    }

    public fun game_data_items_registry(arg0: &GameData) : &vector<0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::item_types::ItemInfo> {
        &arg0.items_registry
    }

    public fun game_data_items_registry_mut(arg0: &mut GameData) : &mut vector<0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::item_types::ItemInfo> {
        &mut arg0.items_registry
    }

    public fun get_faction_by_id(arg0: &GameData, arg1: u64) : &0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::factions::Faction {
        let v0 = find_faction_by_id(arg0, arg1);
        0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::errors::assert_invalid_item(0x1::option::is_some<u64>(&v0));
        0x1::vector::borrow<0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::factions::Faction>(&arg0.factions, 0x1::option::extract<u64>(&mut v0))
    }

    public fun get_item_by_id(arg0: &GameData, arg1: u64) : &0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::item_types::ItemInfo {
        let v0 = find_item_by_id(arg0, arg1);
        0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::errors::assert_invalid_item(0x1::option::is_some<u64>(&v0));
        0x1::vector::borrow<0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::item_types::ItemInfo>(&arg0.items_registry, 0x1::option::extract<u64>(&mut v0))
    }

    public fun get_item_by_id_mut(arg0: &mut GameData, arg1: u64) : &mut 0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::item_types::ItemInfo {
        let v0 = find_item_by_id(arg0, arg1);
        0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::errors::assert_invalid_item(0x1::option::is_some<u64>(&v0));
        0x1::vector::borrow_mut<0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::item_types::ItemInfo>(&mut arg0.items_registry, 0x1::option::extract<u64>(&mut v0))
    }

    public fun init_game_data(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GameData{
            id             : 0x2::object::new(arg0),
            item_types     : create_item_types(),
            items_registry : create_initial_items(),
            factions       : create_initial_factions(),
        };
        0x2::transfer::share_object<GameData>(v0);
    }

    // decompiled from Move bytecode v6
}

