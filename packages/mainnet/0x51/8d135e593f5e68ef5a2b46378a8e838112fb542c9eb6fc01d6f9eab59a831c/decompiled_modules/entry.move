module 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::entry {
    struct ENTRY has drop {
        dummy_field: bool,
    }

    struct RaidResolved has copy, drop {
        sender: address,
        attempted_item_id: 0x1::option::Option<u64>,
        item_obtained: bool,
        item_confiscated: bool,
        arrest_attempted: bool,
        avoided_arrest: bool,
        save_reason: 0x1::option::Option<u8>,
        luck_triggered: bool,
        original_item_id: 0x1::option::Option<u64>,
        luck_item_id: 0x1::option::Option<u64>,
        stamina_consumed: u64,
        wanted_gained: u64,
    }

    struct ItemEnchanted has copy, drop {
        sender: address,
        character_id: 0x2::object::ID,
        item_id: u64,
        rarity: u8,
        budget: u64,
        agility_bonus: u64,
        endurance_bonus: u64,
        stealth_bonus: u64,
        luck_bonus: u64,
        was_reroll: bool,
    }

    entry fun set_billing_enabled(arg0: &0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::admin_cap::AdminCap, arg1: &mut 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::billing::BillingConfig, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::billing::set_billing_enabled(arg0, arg1, arg2, arg3);
    }

    entry fun customise(arg0: &mut 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::Character, arg1: &0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::game_data::GameData, arg2: &0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::render_config::RenderConfig, arg3: u64, arg4: 0x1::option::Option<0x1::string::String>, arg5: u64, arg6: vector<u8>, arg7: &0x2::clock::Clock) {
        0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::customization::customise(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    entry fun add_faction(arg0: &0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::admin_cap::AdminCap, arg1: &mut 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::game_data::GameData, arg2: u64, arg3: 0x1::string::String, arg4: 0x1::string::String) {
        0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::game_data::add_faction(arg0, arg1, arg2, arg3, arg4);
    }

    entry fun add_global_buff(arg0: &0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::admin_cap::AdminCap, arg1: &mut 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::global_buffs::GlobalBuffs, arg2: u8, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock) {
        0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::global_buffs::add_buff(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    entry fun add_item(arg0: &0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::admin_cap::AdminCap, arg1: &mut 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::game_data::GameData, arg2: u64, arg3: u64, arg4: 0x1::string::String, arg5: u64, arg6: u64, arg7: 0x1::option::Option<u64>) {
        0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::game_data::add_item(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    entry fun add_item_type(arg0: &0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::admin_cap::AdminCap, arg1: &mut 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::game_data::GameData, arg2: u64, arg3: 0x1::string::String) {
        0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::game_data::add_item_type(arg0, arg1, arg2, arg3);
    }

    entry fun allocate_stats(arg0: &mut 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::Character, arg1: &0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::game_data::GameData, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock) {
        0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::progression_logic::auto_release_if_time_passed(0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::wanted_mut(arg0), arg6);
        0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::progression_logic::allocate_stat_points_character(arg0, arg2, arg3, arg4, arg5);
        0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::update_attributes(arg0, arg1);
    }

    entry fun bribe_police_paid(arg0: &mut 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::Character, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::billing::BillingConfig, arg3: &mut 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::billing::Treasury, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::paid_services::bribe_police_paid(arg0, arg1, arg2, arg3, arg4, arg5);
        if (0x1::option::is_some<0x2::coin::Coin<0x2::sui::SUI>>(&v0)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x1::option::extract<0x2::coin::Coin<0x2::sui::SUI>>(&mut v0), 0x2::tx_context::sender(arg5));
        };
        0x1::option::destroy_none<0x2::coin::Coin<0x2::sui::SUI>>(v0);
    }

    entry fun clear_all_global_buffs(arg0: &0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::admin_cap::AdminCap, arg1: &mut 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::global_buffs::GlobalBuffs) {
        0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::global_buffs::clear_all_buffs(arg0, arg1);
    }

    public(friend) fun emit_item_enchanted_event(arg0: address, arg1: 0x2::object::ID, arg2: u64, arg3: u8, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: bool, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = ItemEnchanted{
            sender          : arg0,
            character_id    : arg1,
            item_id         : arg2,
            rarity          : arg3,
            budget          : arg4,
            agility_bonus   : arg5,
            endurance_bonus : arg6,
            stealth_bonus   : arg7,
            luck_bonus      : arg8,
            was_reroll      : arg9,
        };
        0x2::event::emit<ItemEnchanted>(v0);
    }

    public(friend) fun emit_raid_resolved_event(arg0: address, arg1: 0x1::option::Option<u64>, arg2: bool, arg3: bool, arg4: bool, arg5: bool, arg6: 0x1::option::Option<u8>, arg7: bool, arg8: 0x1::option::Option<u64>, arg9: 0x1::option::Option<u64>, arg10: u64, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = RaidResolved{
            sender            : arg0,
            attempted_item_id : arg1,
            item_obtained     : arg2,
            item_confiscated  : arg3,
            arrest_attempted  : arg4,
            avoided_arrest    : arg5,
            save_reason       : arg6,
            luck_triggered    : arg7,
            original_item_id  : arg8,
            luck_item_id      : arg9,
            stamina_consumed  : arg10,
            wanted_gained     : arg11,
        };
        0x2::event::emit<RaidResolved>(v0);
    }

    entry fun enchant_item(arg0: &mut 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::Character, arg1: &0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::game_data::GameData, arg2: u64, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::billing::BillingConfig, arg5: &mut 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::billing::Treasury, arg6: &0x2::random::Random, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::paid_services::enchant_item_paid(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        let v2 = v1;
        let v3 = v0;
        if (0x1::option::is_some<0x2::coin::Coin<0x2::sui::SUI>>(&v2)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x1::option::extract<0x2::coin::Coin<0x2::sui::SUI>>(&mut v2), 0x2::tx_context::sender(arg7));
        };
        0x1::option::destroy_none<0x2::coin::Coin<0x2::sui::SUI>>(v2);
        let v4 = 0x2::tx_context::sender(arg7);
        emit_item_enchanted_event(v4, 0x2::object::id<0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::Character>(arg0), 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::enchantment_logic::result_item_id(&v3), 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::enchantment_logic::result_rarity(&v3), 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::enchantment_logic::result_budget(&v3), 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::enchantment_logic::result_agility_bonus(&v3), 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::enchantment_logic::result_endurance_bonus(&v3), 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::enchantment_logic::result_stealth_bonus(&v3), 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::enchantment_logic::result_luck_bonus(&v3), 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::enchantment_logic::result_was_reroll(&v3), arg7);
    }

    public fun get_global_buff_strength(arg0: &0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::global_buffs::GlobalBuffs, arg1: u8, arg2: &0x2::clock::Clock) : u64 {
        0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::global_buffs::get_buff_strength(arg0, arg1, arg2)
    }

    fun init(arg0: ENTRY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::admin_cap::init_admin_cap(arg1);
        0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::game_data::init_game_data(&v1, arg1);
        0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::render_config::init_render_config(&v1, arg1);
        0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::billing::init_billing(&v1, arg1);
        0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::global_buffs::init_global_buffs(&v1, arg1);
        let v2 = 0x2::package::claim<ENTRY>(arg0, arg1);
        let v3 = 0x2::display::new<0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::Character>(&v2, arg1);
        0x2::display::add<0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::Character>(&mut v3, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{market.name}"));
        0x2::display::add<0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::Character>(&mut v3, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::Character>(&mut v3, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::Character>(&mut v3, 0x1::string::utf8(b"attributes"), 0x1::string::utf8(b"{attributes}"));
        0x2::display::add<0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::Character>(&mut v3, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::constants::project_url()));
        0x2::display::add<0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::Character>(&mut v3, 0x1::string::utf8(b"creator"), 0x1::string::utf8(0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::constants::creator()));
        0x2::display::update_version<0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::Character>(&mut v3);
        let (v4, v5) = 0x2::transfer_policy::new<0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::Character>(&v2, arg1);
        let v6 = v5;
        let v7 = v4;
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::add<0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::Character>(&mut v7, &v6, 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::constants::royalty_bp(), 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::constants::min_royalty_amount());
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::add<0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::Character>(&mut v7, &v6);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::Character>>(v7);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::Character>>(v6, v0);
        0x2::transfer::public_transfer<0x2::display::Display<0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::Character>>(v3, v0);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v2, v0);
        0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::admin_cap::transfer_to(v1, v0);
    }

    public fun is_global_buff_active(arg0: &0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::global_buffs::GlobalBuffs, arg1: u8, arg2: &0x2::clock::Clock) : bool {
        0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::global_buffs::is_buff_active(arg0, arg1, arg2)
    }

    entry fun join_faction(arg0: &mut 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::Character, arg1: &0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::game_data::GameData, arg2: u64) {
        0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::faction_selection::set_faction(arg0, arg1, arg2);
    }

    entry fun mint_to(arg0: &mut 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::admin_cap::AdminCap, arg1: &0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::game_data::GameData, arg2: &0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::render_config::RenderConfig, arg3: address, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::admin_cap::next_serial(arg0);
        0x1::string::append(&mut arg7, 0x1::string::utf8(b" #"));
        0x1::string::append(&mut arg7, 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::utils::u64_to_string(v0));
        let v1 = 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::new_character(v0, 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::traits::new_base_traits(arg4, arg5, arg6), 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::marketplace::new_marketplace_data(arg7), arg1, arg8, arg9);
        0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::update_render_url(&mut v1, arg2);
        0x2::transfer::public_transfer<0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::Character>(v1, arg3);
    }

    entry fun purchase_character(arg0: &mut 0x2::kiosk::Kiosk, arg1: &mut 0x2::transfer_policy::TransferPolicy<0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::Character>, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::Character>(0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::kiosk_integration::purchase_character(arg0, arg1, arg2, arg3, arg4, arg5), 0x2::tx_context::sender(arg5));
    }

    entry fun raid_and_emit_details(arg0: &mut 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::Character, arg1: &mut 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::game_data::GameData, arg2: &0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::global_buffs::GlobalBuffs, arg3: &0x2::random::Random, arg4: &0x2::clock::Clock, arg5: 0x1::option::Option<u64>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character::go_raid_with_result(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        let v1 = 0x2::tx_context::sender(arg6);
        emit_raid_resolved_event(v1, *0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::raid_result::attempted_item_id(&v0), 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::raid_result::item_obtained(&v0), 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::raid_result::item_confiscated(&v0), 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::raid_result::arrest_attempted(&v0), 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::raid_result::avoided_arrest(&v0), *0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::raid_result::save_reason(&v0), 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::raid_result::luck_triggered(&v0), *0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::raid_result::original_item_id(&v0), *0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::raid_result::luck_item_id(&v0), 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::raid_result::stamina_consumed(&v0), 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::raid_result::wanted_gained(&v0), arg6);
    }

    entry fun remove_global_buff(arg0: &0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::admin_cap::AdminCap, arg1: &mut 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::global_buffs::GlobalBuffs, arg2: u8, arg3: &0x2::clock::Clock) {
        0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::global_buffs::remove_buff(arg0, arg1, arg2, arg3);
    }

    entry fun remove_item(arg0: &mut 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::Character, arg1: &mut 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::game_data::GameData, arg2: u64) {
        0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::inventory_management::remove_item_by_instance_id(arg0, arg1, arg2);
    }

    entry fun reset_stats_paid(arg0: &mut 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::Character, arg1: &0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::game_data::GameData, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::billing::BillingConfig, arg4: &mut 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::billing::Treasury, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::paid_services::reset_stats_paid(arg0, arg1, arg2, arg3, arg4, arg5);
        if (0x1::option::is_some<0x2::coin::Coin<0x2::sui::SUI>>(&v0)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x1::option::extract<0x2::coin::Coin<0x2::sui::SUI>>(&mut v0), 0x2::tx_context::sender(arg5));
        };
        0x1::option::destroy_none<0x2::coin::Coin<0x2::sui::SUI>>(v0);
    }

    entry fun restore_stamina_paid(arg0: &mut 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::Character, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::billing::BillingConfig, arg3: &mut 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::billing::Treasury, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::paid_services::restore_stamina_paid(arg0, arg1, arg2, arg3, arg4, arg5);
        if (0x1::option::is_some<0x2::coin::Coin<0x2::sui::SUI>>(&v0)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x1::option::extract<0x2::coin::Coin<0x2::sui::SUI>>(&mut v0), 0x2::tx_context::sender(arg5));
        };
        0x1::option::destroy_none<0x2::coin::Coin<0x2::sui::SUI>>(v0);
    }

    entry fun update_billing_admin(arg0: &0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::admin_cap::AdminCap, arg1: &mut 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::billing::BillingConfig, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::billing::update_admin(arg0, arg1, arg2, arg3);
    }

    entry fun update_billing_price_multiplier(arg0: &0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::admin_cap::AdminCap, arg1: &mut 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::billing::BillingConfig, arg2: u16, arg3: &mut 0x2::tx_context::TxContext) {
        0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::billing::update_price_multiplier(arg0, arg1, arg2, arg3);
    }

    entry fun update_render_config(arg0: &0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::admin_cap::AdminCap, arg1: &mut 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::render_config::RenderConfig, arg2: vector<u8>, arg3: 0x1::string::String) {
        0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::render_config::update_render_config(arg0, arg1, arg2, arg3);
    }

    entry fun withdraw_from_billing_treasury(arg0: &0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::admin_cap::AdminCap, arg1: &mut 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::billing::Treasury, arg2: &0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::billing::BillingConfig, arg3: 0x1::option::Option<u64>, arg4: &mut 0x2::tx_context::TxContext) {
        0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::billing::withdraw_from_treasury(arg0, arg1, arg2, arg3, arg4);
    }

    entry fun withdraw_royalty(arg0: &0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::admin_cap::AdminCap, arg1: &mut 0x2::transfer_policy::TransferPolicy<0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::Character>, arg2: &0x2::transfer_policy::TransferPolicyCap<0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::Character>, arg3: 0x1::option::Option<u64>, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::kiosk_integration::withdraw_royalty(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    // decompiled from Move bytecode v6
}

