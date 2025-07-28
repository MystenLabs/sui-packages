module 0xd4f31112b5f252358b682a34a2a9096b9c3d6d30f6558bea864f1b6d6af33431::character_data {
    struct CHARACTER_DATA has drop {
        dummy_field: bool,
    }

    struct Character has store, key {
        id: 0x2::object::UID,
        serial_number: u64,
        character_name: 0x1::string::String,
        base_traits: 0xd4f31112b5f252358b682a34a2a9096b9c3d6d30f6558bea864f1b6d6af33431::traits::BaseTraits,
        market: 0xd4f31112b5f252358b682a34a2a9096b9c3d6d30f6558bea864f1b6d6af33431::marketplace::MarketplaceData,
        last_raid_time: u64,
        total_raids: u64,
        equipped_items: vector<u64>,
        pending_item: 0x1::option::Option<u64>,
        faction: 0x1::option::Option<u64>,
        type_history: vector<0xd4f31112b5f252358b682a34a2a9096b9c3d6d30f6558bea864f1b6d6af33431::traits::TypeWeight>,
        image_bytes: vector<u8>,
        authority_pubkey: vector<u8>,
        last_nonce: u64,
        image_url: 0x1::string::String,
        description: 0x1::string::String,
        attributes: 0xd4f31112b5f252358b682a34a2a9096b9c3d6d30f6558bea864f1b6d6af33431::attributes::Attributes,
    }

    public fun attributes(arg0: &Character) : &0xd4f31112b5f252358b682a34a2a9096b9c3d6d30f6558bea864f1b6d6af33431::attributes::Attributes {
        &arg0.attributes
    }

    public(friend) fun set_total_raids(arg0: &mut Character, arg1: u64) {
        arg0.total_raids = arg1;
    }

    public(friend) fun attributes_mut(arg0: &mut Character) : &mut 0xd4f31112b5f252358b682a34a2a9096b9c3d6d30f6558bea864f1b6d6af33431::attributes::Attributes {
        &mut arg0.attributes
    }

    public fun authority_pubkey(arg0: &Character) : &vector<u8> {
        &arg0.authority_pubkey
    }

    public(friend) fun authority_pubkey_mut(arg0: &mut Character) : &mut vector<u8> {
        &mut arg0.authority_pubkey
    }

    public fun base_traits(arg0: &Character) : &0xd4f31112b5f252358b682a34a2a9096b9c3d6d30f6558bea864f1b6d6af33431::traits::BaseTraits {
        &arg0.base_traits
    }

    public(friend) fun base_traits_mut(arg0: &mut Character) : &mut 0xd4f31112b5f252358b682a34a2a9096b9c3d6d30f6558bea864f1b6d6af33431::traits::BaseTraits {
        &mut arg0.base_traits
    }

    public(friend) fun build_and_update_attributes(arg0: &mut Character, arg1: &0xd4f31112b5f252358b682a34a2a9096b9c3d6d30f6558bea864f1b6d6af33431::game_data::GameData) {
        let v0 = 0xd4f31112b5f252358b682a34a2a9096b9c3d6d30f6558bea864f1b6d6af33431::attributes::new_attributes(0x1::string::utf8(b"Monkey Battle Collection"), *0xd4f31112b5f252358b682a34a2a9096b9c3d6d30f6558bea864f1b6d6af33431::traits::base_traits_head(&arg0.base_traits), *0xd4f31112b5f252358b682a34a2a9096b9c3d6d30f6558bea864f1b6d6af33431::traits::base_traits_body(&arg0.base_traits), *0xd4f31112b5f252358b682a34a2a9096b9c3d6d30f6558bea864f1b6d6af33431::traits::base_traits_background(&arg0.base_traits), arg0.serial_number);
        if (0x1::option::is_some<u64>(&arg0.faction)) {
            0xd4f31112b5f252358b682a34a2a9096b9c3d6d30f6558bea864f1b6d6af33431::attributes::set_faction(&mut v0, 0x1::option::some<0x1::string::String>(*0xd4f31112b5f252358b682a34a2a9096b9c3d6d30f6558bea864f1b6d6af33431::factions::faction_name(0xd4f31112b5f252358b682a34a2a9096b9c3d6d30f6558bea864f1b6d6af33431::game_data::get_faction_by_id(arg1, *0x1::option::borrow<u64>(&arg0.faction)))));
        };
        0xd4f31112b5f252358b682a34a2a9096b9c3d6d30f6558bea864f1b6d6af33431::attributes::clear_equipped_items(&mut v0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg0.equipped_items)) {
            let v2 = *0x1::vector::borrow<u64>(&arg0.equipped_items, v1);
            let v3 = 0xd4f31112b5f252358b682a34a2a9096b9c3d6d30f6558bea864f1b6d6af33431::game_data::find_item_by_id(arg1, v2);
            if (0x1::option::is_some<u64>(&v3)) {
                let v4 = 0xd4f31112b5f252358b682a34a2a9096b9c3d6d30f6558bea864f1b6d6af33431::game_data::get_item_by_id(arg1, v2);
                let v5 = 0xd4f31112b5f252358b682a34a2a9096b9c3d6d30f6558bea864f1b6d6af33431::item_types::item_info_type_id(v4);
                let v6 = *0xd4f31112b5f252358b682a34a2a9096b9c3d6d30f6558bea864f1b6d6af33431::item_types::item_info_name(v4);
                let v7 = 0xd4f31112b5f252358b682a34a2a9096b9c3d6d30f6558bea864f1b6d6af33431::game_data::find_type_by_id(arg1, v5);
                if (0x1::option::is_some<u64>(&v7)) {
                    let v8 = 0xd4f31112b5f252358b682a34a2a9096b9c3d6d30f6558bea864f1b6d6af33431::game_data::find_type_by_id(arg1, v5);
                    let v9 = 0xd4f31112b5f252358b682a34a2a9096b9c3d6d30f6558bea864f1b6d6af33431::item_types::item_type_name(0x1::vector::borrow<0xd4f31112b5f252358b682a34a2a9096b9c3d6d30f6558bea864f1b6d6af33431::item_types::ItemType>(0xd4f31112b5f252358b682a34a2a9096b9c3d6d30f6558bea864f1b6d6af33431::game_data::game_data_item_types(arg1), *0x1::option::borrow<u64>(&v8)));
                    let v10 = 0x1::string::utf8(b"Hat");
                    if (v9 == &v10) {
                        0xd4f31112b5f252358b682a34a2a9096b9c3d6d30f6558bea864f1b6d6af33431::attributes::set_equipped_hat(&mut v0, 0x1::option::some<0x1::string::String>(v6));
                    } else {
                        let v11 = 0x1::string::utf8(b"Shirt");
                        if (v9 == &v11) {
                            0xd4f31112b5f252358b682a34a2a9096b9c3d6d30f6558bea864f1b6d6af33431::attributes::set_equipped_shirt(&mut v0, 0x1::option::some<0x1::string::String>(v6));
                        } else {
                            let v12 = 0x1::string::utf8(b"Pants");
                            if (v9 == &v12) {
                                0xd4f31112b5f252358b682a34a2a9096b9c3d6d30f6558bea864f1b6d6af33431::attributes::set_equipped_pants(&mut v0, 0x1::option::some<0x1::string::String>(v6));
                            } else {
                                let v13 = 0x1::string::utf8(b"Accessory");
                                if (v9 == &v13) {
                                    0xd4f31112b5f252358b682a34a2a9096b9c3d6d30f6558bea864f1b6d6af33431::attributes::set_equipped_accessory(&mut v0, 0x1::option::some<0x1::string::String>(v6));
                                };
                            };
                        };
                    };
                };
            };
            v1 = v1 + 1;
        };
        0xd4f31112b5f252358b682a34a2a9096b9c3d6d30f6558bea864f1b6d6af33431::attributes::set_total_raids(&mut v0, arg0.total_raids);
        arg0.attributes = v0;
    }

    public(friend) fun build_render_url(arg0: &Character, arg1: &0xd4f31112b5f252358b682a34a2a9096b9c3d6d30f6558bea864f1b6d6af33431::render_config::RenderConfig) : 0x1::string::String {
        let v0 = *0xd4f31112b5f252358b682a34a2a9096b9c3d6d30f6558bea864f1b6d6af33431::render_config::base_url(arg1);
        0x1::string::append(&mut v0, 0x1::string::utf8(b"?"));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"head="));
        0x1::string::append(&mut v0, *0xd4f31112b5f252358b682a34a2a9096b9c3d6d30f6558bea864f1b6d6af33431::traits::base_traits_head(&arg0.base_traits));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"&body="));
        0x1::string::append(&mut v0, *0xd4f31112b5f252358b682a34a2a9096b9c3d6d30f6558bea864f1b6d6af33431::traits::base_traits_body(&arg0.base_traits));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"&background="));
        0x1::string::append(&mut v0, *0xd4f31112b5f252358b682a34a2a9096b9c3d6d30f6558bea864f1b6d6af33431::traits::base_traits_background(&arg0.base_traits));
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

    public fun can_raid(arg0: &Character, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) >= arg0.last_raid_time + 0xd4f31112b5f252358b682a34a2a9096b9c3d6d30f6558bea864f1b6d6af33431::constants::raid_cooldown_ms()
    }

    public fun character_id(arg0: &Character) : &0x2::object::UID {
        &arg0.id
    }

    public(friend) fun character_id_mut(arg0: &mut Character) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public fun character_name(arg0: &Character) : &0x1::string::String {
        &arg0.character_name
    }

    public(friend) fun character_name_mut(arg0: &mut Character) : &mut 0x1::string::String {
        &mut arg0.character_name
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

    public fun market(arg0: &Character) : &0xd4f31112b5f252358b682a34a2a9096b9c3d6d30f6558bea864f1b6d6af33431::marketplace::MarketplaceData {
        &arg0.market
    }

    public(friend) fun market_mut(arg0: &mut Character) : &mut 0xd4f31112b5f252358b682a34a2a9096b9c3d6d30f6558bea864f1b6d6af33431::marketplace::MarketplaceData {
        &mut arg0.market
    }

    public(friend) fun new_character(arg0: u64, arg1: 0x1::string::String, arg2: 0xd4f31112b5f252358b682a34a2a9096b9c3d6d30f6558bea864f1b6d6af33431::traits::BaseTraits, arg3: 0xd4f31112b5f252358b682a34a2a9096b9c3d6d30f6558bea864f1b6d6af33431::marketplace::MarketplaceData, arg4: &0xd4f31112b5f252358b682a34a2a9096b9c3d6d30f6558bea864f1b6d6af33431::render_config::RenderConfig, arg5: &0xd4f31112b5f252358b682a34a2a9096b9c3d6d30f6558bea864f1b6d6af33431::game_data::GameData, arg6: &mut 0x2::tx_context::TxContext) : Character {
        let v0 = Character{
            id               : 0x2::object::new(arg6),
            serial_number    : arg0,
            character_name   : arg1,
            base_traits      : arg2,
            market           : arg3,
            last_raid_time   : 0,
            total_raids      : 0,
            equipped_items   : 0x1::vector::empty<u64>(),
            pending_item     : 0x1::option::none<u64>(),
            faction          : 0x1::option::none<u64>(),
            type_history     : 0x1::vector::empty<0xd4f31112b5f252358b682a34a2a9096b9c3d6d30f6558bea864f1b6d6af33431::traits::TypeWeight>(),
            image_bytes      : 0x1::vector::empty<u8>(),
            authority_pubkey : *0xd4f31112b5f252358b682a34a2a9096b9c3d6d30f6558bea864f1b6d6af33431::render_config::authority_pubkey(arg4),
            last_nonce       : 0,
            image_url        : 0x1::string::utf8(b""),
            description      : 0x1::string::utf8(0xd4f31112b5f252358b682a34a2a9096b9c3d6d30f6558bea864f1b6d6af33431::constants::default_description()),
            attributes       : 0xd4f31112b5f252358b682a34a2a9096b9c3d6d30f6558bea864f1b6d6af33431::attributes::new_attributes(0x1::string::utf8(b"Monkey Battle Collection"), *0xd4f31112b5f252358b682a34a2a9096b9c3d6d30f6558bea864f1b6d6af33431::traits::base_traits_head(&arg2), *0xd4f31112b5f252358b682a34a2a9096b9c3d6d30f6558bea864f1b6d6af33431::traits::base_traits_body(&arg2), *0xd4f31112b5f252358b682a34a2a9096b9c3d6d30f6558bea864f1b6d6af33431::traits::base_traits_background(&arg2), arg0),
        };
        v0.image_url = build_render_url(&v0, arg4);
        let v1 = &mut v0;
        build_and_update_attributes(v1, arg5);
        v0
    }

    public(friend) fun pending_item_mut(arg0: &mut Character) : &mut 0x1::option::Option<u64> {
        &mut arg0.pending_item
    }

    public fun serial_number(arg0: &Character) : u64 {
        arg0.serial_number
    }

    public(friend) fun set_character_name(arg0: &mut Character, arg1: 0x1::string::String) {
        arg0.character_name = arg1;
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

    public(friend) fun set_serial_number(arg0: &mut Character, arg1: u64) {
        arg0.serial_number = arg1;
    }

    public fun total_raids(arg0: &Character) : u64 {
        arg0.total_raids
    }

    public(friend) fun total_raids_mut(arg0: &mut Character) : &mut u64 {
        &mut arg0.total_raids
    }

    public fun type_history(arg0: &Character) : &vector<0xd4f31112b5f252358b682a34a2a9096b9c3d6d30f6558bea864f1b6d6af33431::traits::TypeWeight> {
        &arg0.type_history
    }

    public(friend) fun type_history_mut(arg0: &mut Character) : &mut vector<0xd4f31112b5f252358b682a34a2a9096b9c3d6d30f6558bea864f1b6d6af33431::traits::TypeWeight> {
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

    public(friend) fun update_render_url(arg0: &mut Character, arg1: &0xd4f31112b5f252358b682a34a2a9096b9c3d6d30f6558bea864f1b6d6af33431::render_config::RenderConfig) {
        arg0.image_url = build_render_url(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

