module 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::character_data {
    struct CHARACTER_DATA has drop {
        dummy_field: bool,
    }

    struct Character has store, key {
        id: 0x2::object::UID,
        serial_number: u64,
        base_traits: 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::traits::BaseTraits,
        market: 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::marketplace::MarketplaceData,
        last_raid_time: u64,
        total_raids: u64,
        equipped_items: vector<u64>,
        pending_item: 0x1::option::Option<u64>,
        faction: 0x1::option::Option<u64>,
        type_history: vector<0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::traits::TypeWeight>,
        image_bytes: vector<u8>,
        last_nonce: u64,
        image_url: 0x1::string::String,
        description: 0x1::string::String,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
        stats: 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::progression::CharacterStats,
        stamina: 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::progression::Stamina,
        wanted: 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::progression::WantedLevel,
        newbie_buff_end_time: u64,
    }

    public fun attributes(arg0: &Character) : &0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        &arg0.attributes
    }

    public(friend) fun attributes_mut(arg0: &mut Character) : &mut 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        &mut arg0.attributes
    }

    public fun base_traits(arg0: &Character) : &0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::traits::BaseTraits {
        &arg0.base_traits
    }

    public(friend) fun base_traits_mut(arg0: &mut Character) : &mut 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::traits::BaseTraits {
        &mut arg0.base_traits
    }

    public(friend) fun build_attributes_vecmap(arg0: &Character, arg1: &0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::game_data::GameData) : 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        let v0 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"Head"), *0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::traits::base_traits_head(&arg0.base_traits));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"Body"), *0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::traits::base_traits_body(&arg0.base_traits));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"Background"), *0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::traits::base_traits_background(&arg0.base_traits));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"Serial Number"), u64_to_string(arg0.serial_number));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"Level"), u64_to_string(0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::progression::stats_level(&arg0.stats)));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"Collection"), 0x1::string::utf8(b"Monkey Battle Collection"));
        if (0x1::option::is_some<u64>(&arg0.faction)) {
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"Faction"), *0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::factions::faction_name(0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::game_data::get_faction_by_id(arg1, *0x1::option::borrow<u64>(&arg0.faction))));
        };
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg0.equipped_items)) {
            let v2 = *0x1::vector::borrow<u64>(&arg0.equipped_items, v1);
            let v3 = 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::game_data::find_item_by_id(arg1, v2);
            if (0x1::option::is_some<u64>(&v3)) {
                let v4 = 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::game_data::get_item_by_id(arg1, v2);
                let v5 = 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::item_types::item_info_type_id(v4);
                let v6 = 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::game_data::find_type_by_id(arg1, v5);
                if (0x1::option::is_some<u64>(&v6)) {
                    let v7 = 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::game_data::find_type_by_id(arg1, v5);
                    let v8 = *0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::item_types::item_type_name(0x1::vector::borrow<0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::item_types::ItemType>(0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::game_data::game_data_item_types(arg1), *0x1::option::borrow<u64>(&v7)));
                    if (0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&v0, &v8)) {
                        let (_, _) = 0x2::vec_map::remove<0x1::string::String, 0x1::string::String>(&mut v0, &v8);
                    };
                    0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, v8, *0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::item_types::item_info_name(v4));
                };
            };
            v1 = v1 + 1;
        };
        v0
    }

    public(friend) fun build_render_url(arg0: &Character, arg1: &0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::render_config::RenderConfig) : 0x1::string::String {
        let v0 = *0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::render_config::base_url(arg1);
        0x1::string::append(&mut v0, 0x1::string::utf8(b"?"));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"head="));
        0x1::string::append(&mut v0, *0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::traits::base_traits_head(&arg0.base_traits));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"&body="));
        0x1::string::append(&mut v0, *0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::traits::base_traits_body(&arg0.base_traits));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"&background="));
        0x1::string::append(&mut v0, *0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::traits::base_traits_background(&arg0.base_traits));
        if (0x1::vector::length<u64>(&arg0.equipped_items) > 0) {
            0x1::string::append(&mut v0, 0x1::string::utf8(b"&items="));
            let v1 = 0;
            while (v1 < 0x1::vector::length<u64>(&arg0.equipped_items)) {
                if (v1 > 0) {
                    0x1::string::append(&mut v0, 0x1::string::utf8(b","));
                };
                0x1::string::append(&mut v0, u64_to_string(*0x1::vector::borrow<u64>(&arg0.equipped_items, v1)));
                v1 = v1 + 1;
            };
        };
        v0
    }

    public fun can_raid(arg0: &Character) : bool {
        if (0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::progression::is_arrested(&arg0.wanted)) {
            return false
        };
        if (!0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::progression::has_sufficient_stamina(&arg0.stamina, 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::constants::raid_stamina_cost())) {
            return false
        };
        if (0x1::option::is_some<u64>(&arg0.pending_item)) {
            return false
        };
        true
    }

    public fun character_id(arg0: &Character) : &0x2::object::UID {
        &arg0.id
    }

    public(friend) fun character_id_mut(arg0: &mut Character) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public fun description(arg0: &Character) : &0x1::string::String {
        &arg0.description
    }

    public(friend) fun description_mut(arg0: &mut Character) : &mut 0x1::string::String {
        &mut arg0.description
    }

    public fun equipped_items(arg0: &Character) : &vector<u64> {
        &arg0.equipped_items
    }

    public(friend) fun equipped_items_mut(arg0: &mut Character) : &mut vector<u64> {
        &mut arg0.equipped_items
    }

    public fun faction(arg0: &Character) : &0x1::option::Option<u64> {
        &arg0.faction
    }

    public(friend) fun faction_mut(arg0: &mut Character) : &mut 0x1::option::Option<u64> {
        &mut arg0.faction
    }

    public fun get_faction(arg0: &Character) : &0x1::option::Option<u64> {
        &arg0.faction
    }

    public fun get_pending(arg0: &Character) : &0x1::option::Option<u64> {
        &arg0.pending_item
    }

    public fun image_bytes(arg0: &Character) : &vector<u8> {
        &arg0.image_bytes
    }

    public(friend) fun image_bytes_mut(arg0: &mut Character) : &mut vector<u8> {
        &mut arg0.image_bytes
    }

    public fun image_url(arg0: &Character) : &0x1::string::String {
        &arg0.image_url
    }

    public(friend) fun image_url_mut(arg0: &mut Character) : &mut 0x1::string::String {
        &mut arg0.image_url
    }

    fun init(arg0: CHARACTER_DATA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<CHARACTER_DATA>(arg0, arg1);
        let (v1, v2) = 0x2::transfer_policy::new<Character>(&v0, arg1);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Character>>(v1);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Character>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun last_nonce(arg0: &Character) : u64 {
        arg0.last_nonce
    }

    public(friend) fun last_nonce_mut(arg0: &mut Character) : &mut u64 {
        &mut arg0.last_nonce
    }

    public fun last_raid_time(arg0: &Character) : u64 {
        arg0.last_raid_time
    }

    public(friend) fun last_raid_time_mut(arg0: &mut Character) : &mut u64 {
        &mut arg0.last_raid_time
    }

    public fun market(arg0: &Character) : &0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::marketplace::MarketplaceData {
        &arg0.market
    }

    public(friend) fun market_mut(arg0: &mut Character) : &mut 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::marketplace::MarketplaceData {
        &mut arg0.market
    }

    public(friend) fun new_character(arg0: u64, arg1: 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::traits::BaseTraits, arg2: 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::marketplace::MarketplaceData, arg3: &0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::game_data::GameData, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : Character {
        let v0 = Character{
            id                   : 0x2::object::new(arg5),
            serial_number        : arg0,
            base_traits          : arg1,
            market               : arg2,
            last_raid_time       : 0,
            total_raids          : 0,
            equipped_items       : 0x1::vector::empty<u64>(),
            pending_item         : 0x1::option::none<u64>(),
            faction              : 0x1::option::none<u64>(),
            type_history         : 0x1::vector::empty<0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::traits::TypeWeight>(),
            image_bytes          : 0x1::vector::empty<u8>(),
            last_nonce           : 0,
            image_url            : 0x1::string::utf8(b""),
            description          : 0x1::string::utf8(0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::constants::default_description()),
            attributes           : 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>(),
            stats                : 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::progression::new_character_stats(1, 0, 0),
            stamina              : 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::progression::new_stamina(0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::constants::endurance_max_stamina_base(), 0x2::clock::timestamp_ms(arg4)),
            wanted               : 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::progression::new_wanted_level(0x2::clock::timestamp_ms(arg4)),
            newbie_buff_end_time : 0,
        };
        v0.attributes = build_attributes_vecmap(&v0, arg3);
        v0
    }

    public fun newbie_buff_end_time(arg0: &Character) : u64 {
        arg0.newbie_buff_end_time
    }

    public(friend) fun pending_item_mut(arg0: &mut Character) : &mut 0x1::option::Option<u64> {
        &mut arg0.pending_item
    }

    public fun serial_number(arg0: &Character) : u64 {
        arg0.serial_number
    }

    public(friend) fun set_image_bytes(arg0: &mut Character, arg1: vector<u8>) {
        arg0.image_bytes = arg1;
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

    public(friend) fun set_serial_number(arg0: &mut Character, arg1: u64) {
        arg0.serial_number = arg1;
    }

    public(friend) fun set_total_raids(arg0: &mut Character, arg1: u64) {
        arg0.total_raids = arg1;
    }

    public fun stamina(arg0: &Character) : &0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::progression::Stamina {
        &arg0.stamina
    }

    public(friend) fun stamina_mut(arg0: &mut Character) : &mut 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::progression::Stamina {
        &mut arg0.stamina
    }

    public fun stats(arg0: &Character) : &0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::progression::CharacterStats {
        &arg0.stats
    }

    public(friend) fun stats_mut(arg0: &mut Character) : &mut 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::progression::CharacterStats {
        &mut arg0.stats
    }

    public fun total_raids(arg0: &Character) : u64 {
        arg0.total_raids
    }

    public(friend) fun total_raids_mut(arg0: &mut Character) : &mut u64 {
        &mut arg0.total_raids
    }

    public fun type_history(arg0: &Character) : &vector<0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::traits::TypeWeight> {
        &arg0.type_history
    }

    public(friend) fun type_history_mut(arg0: &mut Character) : &mut vector<0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::traits::TypeWeight> {
        &mut arg0.type_history
    }

    fun u64_to_string(arg0: u64) : 0x1::string::String {
        if (arg0 == 0) {
            return 0x1::string::utf8(b"0")
        };
        let v0 = 0x1::vector::empty<u8>();
        while (arg0 > 0) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 % 10) as u8) + 48);
            arg0 = arg0 / 10;
        };
        0x1::vector::reverse<u8>(&mut v0);
        0x1::string::utf8(v0)
    }

    public(friend) fun update_attributes(arg0: &mut Character, arg1: &0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::game_data::GameData) {
        arg0.attributes = build_attributes_vecmap(arg0, arg1);
    }

    public(friend) fun update_render_url(arg0: &mut Character, arg1: &0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::render_config::RenderConfig) {
        arg0.image_url = build_render_url(arg0, arg1);
    }

    public fun wanted(arg0: &Character) : &0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::progression::WantedLevel {
        &arg0.wanted
    }

    public(friend) fun wanted_mut(arg0: &mut Character) : &mut 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::progression::WantedLevel {
        &mut arg0.wanted
    }

    // decompiled from Move bytecode v6
}

