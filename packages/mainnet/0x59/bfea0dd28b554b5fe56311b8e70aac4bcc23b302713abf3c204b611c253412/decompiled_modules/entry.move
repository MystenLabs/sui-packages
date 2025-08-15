module 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::entry {
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

    public entry fun set_billing_enabled(arg0: &0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::admin_cap::AdminCap, arg1: &mut 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::billing::BillingConfig, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::billing::set_billing_enabled(arg0, arg1, arg2, arg3);
    }

    public fun can_raid(arg0: &0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::character_data::Character) : bool {
        0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::character_data::can_raid(arg0)
    }

    public entry fun add_global_buff(arg0: &0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::admin_cap::AdminCap, arg1: &mut 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::global_buffs::GlobalBuffs, arg2: u8, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock) {
        0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::global_buffs::add_buff(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun allocate_stats(arg0: &mut 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::character_data::Character, arg1: &0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::game_data::GameData, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::progression_logic::allocate_stat_points_character(arg0, arg2, arg3, arg4, arg5);
        0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::character_data::update_attributes(arg0, arg1);
    }

    public entry fun bribe_police_paid(arg0: &mut 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::character_data::Character, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::billing::BillingConfig, arg3: &mut 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::billing::Treasury, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::paid_services::bribe_police_paid(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun clear_all_global_buffs(arg0: &0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::admin_cap::AdminCap, arg1: &mut 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::global_buffs::GlobalBuffs) {
        0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::global_buffs::clear_all_buffs(arg0, arg1);
    }

    public entry fun create_kiosk(arg0: &mut 0x2::tx_context::TxContext) {
        0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::kiosk_integration::create_kiosk(arg0);
    }

    public entry fun delist_character(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID) {
        0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::kiosk_integration::delist_character(arg0, arg1, arg2);
    }

    public fun get_available_item_types(arg0: &0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::game_data::GameData) : vector<u64> {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::game_data::game_data_item_types(arg0);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::item_types::ItemType>(v1)) {
            0x1::vector::push_back<u64>(&mut v0, 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::item_types::item_type_id(0x1::vector::borrow<0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::item_types::ItemType>(v1, v2)));
            v2 = v2 + 1;
        };
        v0
    }

    public fun get_character_progression(arg0: &0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::character_data::Character) : (u64, u64, u64, u64, u64, u64, u64) {
        let v0 = 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::character_data::stats(arg0);
        (0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::progression::stats_level(v0), 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::progression::stats_experience(v0), 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::progression::stats_stat_points(v0), 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::progression::stats_agility(v0), 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::progression::stats_endurance(v0), 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::progression::stats_stealth(v0), 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::progression::stats_luck(v0))
    }

    public fun get_character_status(arg0: &0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::character_data::Character) : (u64, u64, u64, bool) {
        let v0 = 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::character_data::stamina(arg0);
        let v1 = 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::character_data::wanted(arg0);
        (0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::progression::stamina_current(v0), 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::progression::stamina_max(v0), 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::progression::wanted_level(v1), 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::progression::is_arrested(v1))
    }

    public fun get_global_buff_strength(arg0: &0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::global_buffs::GlobalBuffs, arg1: u8, arg2: &0x2::clock::Clock) : u64 {
        0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::global_buffs::get_buff_strength(arg0, arg1, arg2)
    }

    public fun get_luck_info(arg0: &0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::raid_result::RaidResult) : (bool, 0x1::option::Option<u64>, 0x1::option::Option<u64>) {
        (0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::raid_result::luck_triggered(arg0), *0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::raid_result::original_item_id(arg0), *0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::raid_result::luck_item_id(arg0))
    }

    public fun get_police_bribe_cost(arg0: &0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::billing::BillingConfig) : u64 {
        0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::paid_services::calculate_police_bribe_cost(arg0)
    }

    public fun get_raid_result_info(arg0: &0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::raid_result::RaidResult) : (0x1::option::Option<u64>, bool, bool, bool, bool, 0x1::option::Option<u8>, bool, 0x1::option::Option<u64>, 0x1::option::Option<u64>, u64, u64) {
        (*0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::raid_result::attempted_item_id(arg0), 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::raid_result::item_obtained(arg0), 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::raid_result::item_confiscated(arg0), 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::raid_result::arrest_attempted(arg0), 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::raid_result::avoided_arrest(arg0), *0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::raid_result::save_reason(arg0), 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::raid_result::luck_triggered(arg0), *0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::raid_result::original_item_id(arg0), *0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::raid_result::luck_item_id(arg0), 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::raid_result::stamina_consumed(arg0), 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::raid_result::wanted_gained(arg0))
    }

    public fun get_stamina_restore_cost(arg0: &0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::billing::BillingConfig) : u64 {
        0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::paid_services::calculate_stamina_restore_cost(arg0)
    }

    fun init(arg0: ENTRY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::admin_cap::init_admin_cap(arg1);
        0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::game_data::init_game_data(arg1);
        0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::render_config::init_render_config(arg1);
        0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::billing::init_billing(&v1, arg1);
        0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::global_buffs::init_global_buffs(arg1);
        let v2 = 0x2::package::claim<ENTRY>(arg0, arg1);
        let v3 = 0x2::display::new<0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::character_data::Character>(&v2, arg1);
        0x2::display::add<0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::character_data::Character>(&mut v3, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{market.name}"));
        0x2::display::add<0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::character_data::Character>(&mut v3, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::character_data::Character>(&mut v3, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::character_data::Character>(&mut v3, 0x1::string::utf8(b"attributes"), 0x1::string::utf8(b"{attributes}"));
        0x2::display::add<0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::character_data::Character>(&mut v3, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://megawavesmakers.com"));
        0x2::display::add<0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::character_data::Character>(&mut v3, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"Jungle Labs"));
        0x2::display::update_version<0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::character_data::Character>(&mut v3);
        let (v4, v5) = 0x2::transfer_policy::new<0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::character_data::Character>(&v2, arg1);
        let v6 = v5;
        let v7 = v4;
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::add<0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::character_data::Character>(&mut v7, &v6, 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::constants::royalty_bp(), 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::constants::min_royalty_amount());
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::add<0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::character_data::Character>(&mut v7, &v6);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::character_data::Character>>(v7);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::character_data::Character>>(v6, v0);
        0x2::transfer::public_transfer<0x2::display::Display<0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::character_data::Character>>(v3, v0);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v2, v0);
        0x2::transfer::public_transfer<0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::admin_cap::AdminCap>(v1, v0);
    }

    public entry fun init_billing_system(arg0: &0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::admin_cap::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::billing::init_billing(arg0, arg1);
    }

    public fun is_global_buff_active(arg0: &0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::global_buffs::GlobalBuffs, arg1: u8, arg2: &0x2::clock::Clock) : bool {
        0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::global_buffs::is_buff_active(arg0, arg1, arg2)
    }

    public entry fun join_faction(arg0: &mut 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::character_data::Character, arg1: &0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::game_data::GameData, arg2: u64) {
        0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::faction_selection::set_faction(arg0, arg1, arg2);
    }

    public entry fun list_character(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: u64) {
        0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::kiosk_integration::list_character(arg0, arg1, arg2, arg3);
    }

    public entry fun lock_character_in_kiosk(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: &0x2::transfer_policy::TransferPolicy<0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::character_data::Character>, arg3: 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::character_data::Character) {
        0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::kiosk_integration::place_and_lock_character(arg0, arg1, arg2, arg3);
    }

    public entry fun mint(arg0: &mut 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::admin_cap::AdminCap, arg1: &0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::game_data::GameData, arg2: &0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::render_config::RenderConfig, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::character_data::new_character(0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::admin_cap::next_serial(arg0), 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::traits::new_base_traits(arg3, arg4, arg5), 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::marketplace::new_marketplace_data(arg6), arg1, arg7, arg8);
        0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::character_data::update_render_url(&mut v0, arg2);
        0x2::transfer::public_transfer<0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::character_data::Character>(v0, 0x2::tx_context::sender(arg8));
    }

    public entry fun purchase_character(arg0: &mut 0x2::kiosk::Kiosk, arg1: &mut 0x2::transfer_policy::TransferPolicy<0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::character_data::Character>, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) {
        0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::kiosk_integration::purchase_character(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun raid_and_emit_details(arg0: &mut 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::character_data::Character, arg1: &mut 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::game_data::GameData, arg2: &0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::global_buffs::GlobalBuffs, arg3: &0x2::random::Random, arg4: &0x2::clock::Clock, arg5: bool, arg6: 0x1::option::Option<u64>, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::character::go_raid_with_result(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        let v1 = RaidResolved{
            sender            : 0x2::tx_context::sender(arg7),
            attempted_item_id : *0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::raid_result::attempted_item_id(&v0),
            item_obtained     : 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::raid_result::item_obtained(&v0),
            item_confiscated  : 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::raid_result::item_confiscated(&v0),
            arrest_attempted  : 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::raid_result::arrest_attempted(&v0),
            avoided_arrest    : 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::raid_result::avoided_arrest(&v0),
            save_reason       : *0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::raid_result::save_reason(&v0),
            luck_triggered    : 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::raid_result::luck_triggered(&v0),
            original_item_id  : *0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::raid_result::original_item_id(&v0),
            luck_item_id      : *0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::raid_result::luck_item_id(&v0),
            stamina_consumed  : 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::raid_result::stamina_consumed(&v0),
            wanted_gained     : 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::raid_result::wanted_gained(&v0),
        };
        0x2::event::emit<RaidResolved>(v1);
    }

    public fun raid_random_type(arg0: &mut 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::character_data::Character, arg1: &mut 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::game_data::GameData, arg2: &0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::global_buffs::GlobalBuffs, arg3: &0x2::random::Random, arg4: &0x2::clock::Clock, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) : 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::raid_result::RaidResult {
        raid_with_result(arg0, arg1, arg2, arg3, arg4, arg5, 0x1::option::none<u64>(), arg6)
    }

    public fun raid_with_result(arg0: &mut 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::character_data::Character, arg1: &mut 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::game_data::GameData, arg2: &0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::global_buffs::GlobalBuffs, arg3: &0x2::random::Random, arg4: &0x2::clock::Clock, arg5: bool, arg6: 0x1::option::Option<u64>, arg7: &mut 0x2::tx_context::TxContext) : 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::raid_result::RaidResult {
        0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::character::go_raid_with_result(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    }

    public entry fun remove_global_buff(arg0: &0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::admin_cap::AdminCap, arg1: &mut 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::global_buffs::GlobalBuffs, arg2: u8, arg3: &0x2::clock::Clock) {
        0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::global_buffs::remove_buff(arg0, arg1, arg2, arg3);
    }

    public entry fun restore_stamina_paid(arg0: &mut 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::character_data::Character, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::billing::BillingConfig, arg3: &mut 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::billing::Treasury, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::paid_services::restore_stamina_paid(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun set_character_image(arg0: &mut 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::character_data::Character, arg1: vector<u8>) {
        0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::errors::assert_image_too_large(0x1::vector::length<u8>(&arg1) < 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::constants::max_image_size());
        0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::character_data::set_image_bytes(arg0, arg1);
    }

    public entry fun update_billing_admin(arg0: &0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::admin_cap::AdminCap, arg1: &mut 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::billing::BillingConfig, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::billing::update_admin(arg0, arg1, arg2, arg3);
    }

    public entry fun update_billing_price_multiplier(arg0: &0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::admin_cap::AdminCap, arg1: &mut 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::billing::BillingConfig, arg2: u16, arg3: &mut 0x2::tx_context::TxContext) {
        0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::billing::update_price_multiplier(arg0, arg1, arg2, arg3);
    }

    public entry fun update_character_image_url(arg0: &mut 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::character_data::Character, arg1: &0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::render_config::RenderConfig) {
        0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::character_data::update_render_url(arg0, arg1);
    }

    public entry fun update_render_config(arg0: &0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::admin_cap::AdminCap, arg1: &mut 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::render_config::RenderConfig, arg2: vector<u8>, arg3: 0x1::string::String) {
        0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::render_config::update_render_config(arg0, arg1, arg2, arg3);
    }

    public entry fun withdraw_from_billing_treasury(arg0: &0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::admin_cap::AdminCap, arg1: &mut 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::billing::Treasury, arg2: &0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::billing::BillingConfig, arg3: 0x1::option::Option<u64>, arg4: &mut 0x2::tx_context::TxContext) {
        0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::billing::withdraw_from_treasury(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun withdraw_profits(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x1::option::Option<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::kiosk_integration::withdraw_profits(arg0, arg1, arg2, arg3);
    }

    public entry fun withdraw_royalty(arg0: &0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::admin_cap::AdminCap, arg1: &mut 0x2::transfer_policy::TransferPolicy<0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::character_data::Character>, arg2: &0x2::transfer_policy::TransferPolicyCap<0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::character_data::Character>, arg3: 0x1::option::Option<u64>, arg4: &mut 0x2::tx_context::TxContext) {
        0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::kiosk_integration::withdraw_royalty(arg0, arg1, arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v6
}

