module 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data {
    struct CHARACTER_DATA has drop {
        dummy_field: bool,
    }

    struct Character has store, key {
        id: 0x2::object::UID,
        serial_number: u64,
        base_traits: 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::traits::BaseTraits,
        market: 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::marketplace::MarketplaceData,
        last_raid_time: u64,
        total_raids: u64,
        inventory: vector<0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::inventory_item::InventoryItem>,
        equipped_by_type: 0x2::vec_map::VecMap<u64, u64>,
        next_instance_id: u64,
        faction: 0x1::option::Option<u64>,
        type_history: vector<0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::traits::TypeWeight>,
        last_nonce: u64,
        image_url: 0x1::string::String,
        description: 0x1::string::String,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
        stats: 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::progression::CharacterStats,
        stamina: 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::progression::Stamina,
        wanted: 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::progression::WantedLevel,
        newbie_buff_end_time: u64,
    }

    public(friend) fun build_attributes_vecmap(arg0: &Character, arg1: &0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::game_data::GameData) : 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        let v0 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"Head"), *0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::traits::base_traits_head(&arg0.base_traits));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"Body"), *0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::traits::base_traits_body(&arg0.base_traits));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"Background"), *0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::traits::base_traits_background(&arg0.base_traits));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"Level"), 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::utils::u64_to_string(0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::progression::stats_level(&arg0.stats)));
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        let v5 = 0x2::vec_map::keys<u64, u64>(&arg0.equipped_by_type);
        let v6 = 0;
        while (v6 < 0x1::vector::length<u64>(&v5)) {
            let v7 = *0x1::vector::borrow<u64>(&v5, v6);
            let v8 = find_item_by_instance_id(&arg0.inventory, *0x2::vec_map::get<u64, u64>(&arg0.equipped_by_type, &v7));
            if (0x1::option::is_some<u64>(&v8)) {
                let v9 = 0x1::vector::borrow<0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::inventory_item::InventoryItem>(&arg0.inventory, *0x1::option::borrow<u64>(&v8));
                v1 = v1 + 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::inventory_item::agility_bonus(v9);
                v2 = v2 + 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::inventory_item::endurance_bonus(v9);
                v3 = v3 + 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::inventory_item::stealth_bonus(v9);
                v4 = v4 + 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::inventory_item::luck_bonus(v9);
            };
            v6 = v6 + 1;
        };
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"Agility"), 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::utils::u64_to_string(0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::progression::stats_agility(&arg0.stats) + v1));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"Endurance"), 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::utils::u64_to_string(0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::progression::stats_endurance(&arg0.stats) + v2));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"Stealth"), 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::utils::u64_to_string(0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::progression::stats_stealth(&arg0.stats) + v3));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"Luck"), 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::utils::u64_to_string(0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::progression::stats_luck(&arg0.stats) + v4));
        if (0x1::option::is_some<u64>(&arg0.faction)) {
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"Faction"), *0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::factions::faction_name(0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::game_data::get_faction_by_id(arg1, *0x1::option::borrow<u64>(&arg0.faction))));
        };
        let v10 = 0x2::vec_map::keys<u64, u64>(&arg0.equipped_by_type);
        let v11 = 0;
        while (v11 < 0x1::vector::length<u64>(&v10)) {
            let v12 = *0x1::vector::borrow<u64>(&v10, v11);
            let v13 = find_item_by_instance_id(&arg0.inventory, *0x2::vec_map::get<u64, u64>(&arg0.equipped_by_type, &v12));
            if (0x1::option::is_some<u64>(&v13)) {
                let v14 = 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::inventory_item::item_id(0x1::vector::borrow<0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::inventory_item::InventoryItem>(&arg0.inventory, *0x1::option::borrow<u64>(&v13)));
                let v15 = 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::game_data::find_item_by_id(arg1, v14);
                if (0x1::option::is_some<u64>(&v15)) {
                    let v16 = 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::game_data::get_item_by_id(arg1, v14);
                    let v17 = 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::game_data::find_type_by_id(arg1, v12);
                    if (0x1::option::is_some<u64>(&v17)) {
                        let v18 = 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::game_data::find_type_by_id(arg1, v12);
                        let v19 = *0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::item_types::item_type_name(0x1::vector::borrow<0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::item_types::ItemType>(0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::game_data::game_data_item_types(arg1), *0x1::option::borrow<u64>(&v18)));
                        if (0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&v0, &v19)) {
                            let (_, _) = 0x2::vec_map::remove<0x1::string::String, 0x1::string::String>(&mut v0, &v19);
                        };
                        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, v19, *0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::item_types::item_info_name(v16));
                    };
                };
            };
            v11 = v11 + 1;
        };
        v0
    }

    public(friend) fun build_render_url(arg0: &Character, arg1: &0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::render_config::RenderConfig) : 0x1::string::String {
        let v0 = *0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::render_config::base_url(arg1);
        0x1::string::append(&mut v0, 0x1::string::utf8(b"?"));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"head="));
        0x1::string::append(&mut v0, *0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::traits::base_traits_head(&arg0.base_traits));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"&body="));
        0x1::string::append(&mut v0, *0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::traits::base_traits_body(&arg0.base_traits));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"&background="));
        0x1::string::append(&mut v0, *0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::traits::base_traits_background(&arg0.base_traits));
        let v1 = 0x2::vec_map::keys<u64, u64>(&arg0.equipped_by_type);
        if (0x1::vector::length<u64>(&v1) > 0) {
            0x1::string::append(&mut v0, 0x1::string::utf8(b"&items="));
            let v2 = 0;
            while (v2 < 0x1::vector::length<u64>(&v1)) {
                if (v2 > 0) {
                    0x1::string::append(&mut v0, 0x1::string::utf8(b","));
                };
                let v3 = *0x1::vector::borrow<u64>(&v1, v2);
                let v4 = find_item_by_instance_id(&arg0.inventory, *0x2::vec_map::get<u64, u64>(&arg0.equipped_by_type, &v3));
                if (0x1::option::is_some<u64>(&v4)) {
                    0x1::string::append(&mut v0, 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::utils::u64_to_string(0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::inventory_item::item_id(0x1::vector::borrow<0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::inventory_item::InventoryItem>(&arg0.inventory, *0x1::option::borrow<u64>(&v4)))));
                };
                v2 = v2 + 1;
            };
        };
        v0
    }

    public(friend) fun character_id(arg0: &Character) : &0x2::object::UID {
        &arg0.id
    }

    public(friend) fun equipped_by_type(arg0: &Character) : &0x2::vec_map::VecMap<u64, u64> {
        &arg0.equipped_by_type
    }

    public(friend) fun equipped_by_type_mut(arg0: &mut Character) : &mut 0x2::vec_map::VecMap<u64, u64> {
        &mut arg0.equipped_by_type
    }

    public(friend) fun faction(arg0: &Character) : &0x1::option::Option<u64> {
        &arg0.faction
    }

    public(friend) fun faction_mut(arg0: &mut Character) : &mut 0x1::option::Option<u64> {
        &mut arg0.faction
    }

    fun find_item_by_instance_id(arg0: &vector<0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::inventory_item::InventoryItem>, arg1: u64) : 0x1::option::Option<u64> {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::inventory_item::InventoryItem>(arg0)) {
            if (0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::inventory_item::instance_id(0x1::vector::borrow<0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::inventory_item::InventoryItem>(arg0, v0)) == arg1) {
                return 0x1::option::some<u64>(v0)
            };
            v0 = v0 + 1;
        };
        0x1::option::none<u64>()
    }

    public(friend) fun generate_next_instance_id(arg0: &mut Character) : u64 {
        arg0.next_instance_id = arg0.next_instance_id + 1;
        arg0.next_instance_id
    }

    public(friend) fun get_faction(arg0: &Character) : &0x1::option::Option<u64> {
        &arg0.faction
    }

    public(friend) fun get_item_by_instance_id(arg0: &Character, arg1: u64) : &0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::inventory_item::InventoryItem {
        let v0 = &arg0.inventory;
        let v1 = find_item_by_instance_id(v0, arg1);
        assert!(0x1::option::is_some<u64>(&v1), 0);
        0x1::vector::borrow<0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::inventory_item::InventoryItem>(v0, *0x1::option::borrow<u64>(&v1))
    }

    public(friend) fun get_item_by_instance_id_mut(arg0: &mut Character, arg1: u64) : &mut 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::inventory_item::InventoryItem {
        let v0 = &mut arg0.inventory;
        let v1 = find_item_by_instance_id(v0, arg1);
        assert!(0x1::option::is_some<u64>(&v1), 0);
        0x1::vector::borrow_mut<0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::inventory_item::InventoryItem>(v0, *0x1::option::borrow<u64>(&v1))
    }

    fun init(arg0: CHARACTER_DATA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<CHARACTER_DATA>(arg0, arg1);
        let (v1, v2) = 0x2::transfer_policy::new<Character>(&v0, arg1);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Character>>(v1);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Character>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    public(friend) fun inventory(arg0: &Character) : &vector<0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::inventory_item::InventoryItem> {
        &arg0.inventory
    }

    public(friend) fun inventory_mut(arg0: &mut Character) : &mut vector<0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::inventory_item::InventoryItem> {
        &mut arg0.inventory
    }

    public(friend) fun last_nonce(arg0: &Character) : u64 {
        arg0.last_nonce
    }

    public(friend) fun new_character(arg0: u64, arg1: 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::traits::BaseTraits, arg2: 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::marketplace::MarketplaceData, arg3: &0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::game_data::GameData, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : Character {
        let v0 = Character{
            id                   : 0x2::object::new(arg5),
            serial_number        : arg0,
            base_traits          : arg1,
            market               : arg2,
            last_raid_time       : 0,
            total_raids          : 0,
            inventory            : 0x1::vector::empty<0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::inventory_item::InventoryItem>(),
            equipped_by_type     : 0x2::vec_map::empty<u64, u64>(),
            next_instance_id     : 1,
            faction              : 0x1::option::none<u64>(),
            type_history         : 0x1::vector::empty<0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::traits::TypeWeight>(),
            last_nonce           : 0,
            image_url            : 0x1::string::utf8(b""),
            description          : 0x1::string::utf8(0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::constants::default_description()),
            attributes           : 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>(),
            stats                : 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::progression::new_character_stats(1, 0, 0),
            stamina              : 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::progression::new_stamina(0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::constants::endurance_max_stamina_base(), 0x2::clock::timestamp_ms(arg4)),
            wanted               : 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::progression::new_wanted_level(0x2::clock::timestamp_ms(arg4)),
            newbie_buff_end_time : 0,
        };
        v0.attributes = build_attributes_vecmap(&v0, arg3);
        v0
    }

    public(friend) fun newbie_buff_end_time(arg0: &Character) : u64 {
        arg0.newbie_buff_end_time
    }

    public(friend) fun next_instance_id(arg0: &Character) : u64 {
        arg0.next_instance_id
    }

    public(friend) fun set_last_nonce(arg0: &mut Character, arg1: u64) {
        arg0.last_nonce = arg1;
    }

    public(friend) fun set_last_raid_time(arg0: &mut Character, arg1: u64) {
        arg0.last_raid_time = arg1;
    }

    public(friend) fun set_newbie_buff_end_time(arg0: &mut Character, arg1: u64) {
        arg0.newbie_buff_end_time = arg1;
    }

    public(friend) fun set_total_raids(arg0: &mut Character, arg1: u64) {
        arg0.total_raids = arg1;
    }

    public(friend) fun stamina(arg0: &Character) : &0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::progression::Stamina {
        &arg0.stamina
    }

    public(friend) fun stamina_mut(arg0: &mut Character) : &mut 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::progression::Stamina {
        &mut arg0.stamina
    }

    public(friend) fun stats(arg0: &Character) : &0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::progression::CharacterStats {
        &arg0.stats
    }

    public(friend) fun stats_mut(arg0: &mut Character) : &mut 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::progression::CharacterStats {
        &mut arg0.stats
    }

    public(friend) fun total_raids(arg0: &Character) : u64 {
        arg0.total_raids
    }

    public(friend) fun type_history(arg0: &Character) : &vector<0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::traits::TypeWeight> {
        &arg0.type_history
    }

    public(friend) fun type_history_mut(arg0: &mut Character) : &mut vector<0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::traits::TypeWeight> {
        &mut arg0.type_history
    }

    public(friend) fun update_attributes(arg0: &mut Character, arg1: &0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::game_data::GameData) {
        arg0.attributes = build_attributes_vecmap(arg0, arg1);
    }

    public(friend) fun update_image_url(arg0: &mut Character, arg1: &0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::render_config::RenderConfig, arg2: &0x1::option::Option<0x1::string::String>) {
        if (0x1::option::is_some<0x1::string::String>(arg2)) {
            arg0.image_url = *0x1::option::borrow<0x1::string::String>(arg2);
        } else {
            arg0.image_url = build_render_url(arg0, arg1);
        };
    }

    public(friend) fun update_render_url(arg0: &mut Character, arg1: &0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::render_config::RenderConfig) {
        arg0.image_url = build_render_url(arg0, arg1);
    }

    public(friend) fun wanted(arg0: &Character) : &0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::progression::WantedLevel {
        &arg0.wanted
    }

    public(friend) fun wanted_mut(arg0: &mut Character) : &mut 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::progression::WantedLevel {
        &mut arg0.wanted
    }

    // decompiled from Move bytecode v6
}

