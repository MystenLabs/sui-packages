module 0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::character_system {
    struct GlobalCharacterUpgradeState has key {
        id: 0x2::object::UID,
        version: u64,
        ssr_5star_counts: 0x2::table::Table<u64, u64>,
        sr_5star_counts: 0x2::table::Table<u64, u64>,
        alb_cost_star_up_duplicate: u64,
        alb_cost_star_up_crown: u64,
        alb_cost_star_up_fragment: u64,
        alb_cost_star_up_wildcard: u64,
    }

    struct CHARACTER_SYSTEM has drop {
        dummy_field: bool,
    }

    struct Character has store, key {
        id: 0x2::object::UID,
        character_id: u64,
        game_id: u64,
        name: 0x1::string::String,
        rarity: u8,
        rarity_text: 0x1::string::String,
        image_url: 0x2::url::Url,
        timeline: u64,
        star_rating: u8,
        base_star_rating: u8,
        is_awakened: bool,
    }

    struct StarRatingChanged has copy, drop {
        character_id: u64,
        old_star_rating: u8,
        new_star_rating: u8,
        upgrade_method: u8,
        owner: address,
        timestamp: u64,
    }

    struct Crown has key {
        id: 0x2::object::UID,
        material_id: u64,
        crown_type: u8,
        crown_type_text: 0x1::string::String,
        image_url: 0x2::url::Url,
        created_timestamp: u64,
    }

    struct CrownMinted has copy, drop {
        material_id: u64,
        crown_type: u8,
        recipient: address,
        timestamp: u64,
    }

    struct CrownConsumed has copy, drop {
        material_id: u64,
        crown_type: u8,
        character_id: u64,
        old_star: u8,
        new_star: u8,
        owner: address,
        timestamp: u64,
    }

    struct DuplicateCharacterConsumed has copy, drop {
        consumed_character_id: u64,
        target_character_id: u64,
        game_id: u64,
        old_star: u8,
        new_star: u8,
        owner: address,
        timestamp: u64,
    }

    struct StarUpWithWildcardEvent has copy, drop {
        owner: address,
        character_game_id: u64,
        wildcard_rarity: u8,
        new_star_rating: u8,
        character_id: 0x2::object::ID,
    }

    struct CharacterBurnedEvent has copy, drop {
        owner: address,
        character_game_id: u64,
        rarity: u8,
        character_id: 0x2::object::ID,
    }

    public fun admin_mint_character(arg0: &0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::game_core::CharacterAdminCap, arg1: &mut 0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::game_core::GlobalGameState, arg2: u64, arg3: u8, arg4: vector<u8>, arg5: vector<u8>, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 >= 0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::game_core::rarity_r() && arg3 <= 0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::game_core::rarity_ssr(), 7);
        0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::game_core::validate_url_bytes(&arg5);
        let v0 = 0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::game_core::get_next_character_id(arg1);
        0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::game_core::update_character_stats(arg1, arg3);
        let v1 = if (arg3 == 0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::game_core::rarity_r()) {
            0x1::string::utf8(b"R")
        } else if (arg3 == 0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::game_core::rarity_sr()) {
            0x1::string::utf8(b"SR")
        } else {
            0x1::string::utf8(b"SSR")
        };
        let v2 = Character{
            id               : 0x2::object::new(arg7),
            character_id     : v0,
            game_id          : arg2,
            name             : 0x1::string::utf8(arg4),
            rarity           : arg3,
            rarity_text      : v1,
            image_url        : 0x2::url::new_unsafe_from_bytes(arg5),
            timeline         : 0x2::tx_context::epoch_timestamp_ms(arg7),
            star_rating      : get_starting_star_for_rarity(arg3),
            base_star_rating : get_starting_star_for_rarity(arg3),
            is_awakened      : false,
        };
        0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::game_core::emit_item_minted(0x1::string::utf8(b"Character"), v0, arg3, v2.name, arg6, v2.timeline);
        0x2::transfer::public_transfer<Character>(v2, arg6);
    }

    public fun admin_mint_crown(arg0: &0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::game_core::CharacterAdminCap, arg1: &mut 0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::game_core::GlobalGameState, arg2: u8, arg3: vector<u8>, arg4: address, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 == 1 || arg2 == 2, 2);
        0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::game_core::validate_url_bytes(&arg3);
        let v0 = 0x2::tx_context::epoch_timestamp_ms(arg6);
        let v1 = if (arg2 == 1) {
            0x1::string::utf8(b"Alpha")
        } else {
            0x1::string::utf8(b"Beta")
        };
        let v2 = 0;
        while (v2 < arg5) {
            let v3 = 0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::game_core::get_next_crown_id(arg1);
            let v4 = Crown{
                id                : 0x2::object::new(arg6),
                material_id       : v3,
                crown_type        : arg2,
                crown_type_text   : v1,
                image_url         : 0x2::url::new_unsafe_from_bytes(arg3),
                created_timestamp : v0,
            };
            let v5 = CrownMinted{
                material_id : v3,
                crown_type  : arg2,
                recipient   : arg4,
                timestamp   : v0,
            };
            0x2::event::emit<CrownMinted>(v5);
            0x2::transfer::transfer<Crown>(v4, arg4);
            v2 = v2 + 1;
        };
    }

    fun assert_upgrade_state_version(arg0: &GlobalCharacterUpgradeState) {
        assert!(arg0.version == 1, 8);
    }

    public(friend) fun burn_awakened_for_star_up(arg0: Character, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.is_awakened, 10);
        let Character {
            id               : v0,
            character_id     : _,
            game_id          : _,
            name             : _,
            rarity           : _,
            rarity_text      : _,
            image_url        : _,
            timeline         : _,
            star_rating      : _,
            base_star_rating : _,
            is_awakened      : _,
        } = arg0;
        0x2::object::delete(v0);
        let v11 = CharacterBurnedEvent{
            owner             : 0x2::tx_context::sender(arg1),
            character_game_id : arg0.game_id,
            rarity            : arg0.rarity,
            character_id      : 0x2::object::id<Character>(&arg0),
        };
        0x2::event::emit<CharacterBurnedEvent>(v11);
    }

    public(friend) fun burn_character(arg0: Character, arg1: &0x2::tx_context::TxContext) : (u64, u8) {
        assert!(!arg0.is_awakened, 10);
        let v0 = arg0.game_id;
        let v1 = arg0.rarity;
        let Character {
            id               : v2,
            character_id     : _,
            game_id          : _,
            name             : _,
            rarity           : _,
            rarity_text      : _,
            image_url        : _,
            timeline         : _,
            star_rating      : _,
            base_star_rating : _,
            is_awakened      : _,
        } = arg0;
        0x2::object::delete(v2);
        let v13 = CharacterBurnedEvent{
            owner             : 0x2::tx_context::sender(arg1),
            character_game_id : v0,
            rarity            : v1,
            character_id      : 0x2::object::id<Character>(&arg0),
        };
        0x2::event::emit<CharacterBurnedEvent>(v13);
        (v0, v1)
    }

    public fun can_upgrade_stars(arg0: &Character) : bool {
        arg0.star_rating < 5
    }

    public(friend) fun check_and_increment_5star_cap(arg0: &mut GlobalCharacterUpgradeState, arg1: u64, arg2: u8) {
        assert_upgrade_state_version(arg0);
        let (v0, v1) = if (arg2 == 0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::game_core::rarity_ssr()) {
            let v0 = &mut arg0.ssr_5star_counts;
            (v0, 777)
        } else {
            let v0 = &mut arg0.sr_5star_counts;
            (v0, 5555)
        };
        let v2 = if (0x2::table::contains<u64, u64>(v0, arg1)) {
            *0x2::table::borrow<u64, u64>(v0, arg1)
        } else {
            0
        };
        assert!(v2 < v1, 4);
        if (0x2::table::contains<u64, u64>(v0, arg1)) {
            let v3 = 0x2::table::borrow_mut<u64, u64>(v0, arg1);
            *v3 = *v3 + 1;
        } else {
            0x2::table::add<u64, u64>(v0, arg1, 1);
        };
    }

    public(friend) fun create_awakened_character(arg0: &mut 0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::game_core::GlobalGameState, arg1: u64, arg2: 0x1::string::String, arg3: vector<u8>, arg4: u8, arg5: &mut 0x2::tx_context::TxContext) : Character {
        0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::game_core::validate_url_bytes(&arg3);
        let v0 = 0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::game_core::get_next_character_id(arg0);
        0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::game_core::update_character_stats(arg0, arg4);
        let v1 = if (arg4 == 0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::game_core::rarity_ssr()) {
            0x1::string::utf8(b"SSR")
        } else {
            0x1::string::utf8(b"SR")
        };
        let v2 = get_starting_star_for_rarity(arg4);
        let v3 = Character{
            id               : 0x2::object::new(arg5),
            character_id     : v0,
            game_id          : arg1,
            name             : arg2,
            rarity           : arg4,
            rarity_text      : v1,
            image_url        : 0x2::url::new_unsafe_from_bytes(arg3),
            timeline         : 0x2::tx_context::epoch_timestamp_ms(arg5),
            star_rating      : v2,
            base_star_rating : v2,
            is_awakened      : true,
        };
        0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::game_core::emit_item_minted(0x1::string::utf8(b"Character"), v0, arg4, v3.name, 0x2::tx_context::sender(arg5), v3.timeline);
        v3
    }

    public(friend) fun create_character_from_template(arg0: &mut 0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::game_core::GlobalGameState, arg1: 0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::game_core::CharacterTemplate, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) : Character {
        let v0 = 0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::game_core::get_next_character_id(arg0);
        0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::game_core::update_character_stats(arg0, arg2);
        let (v1, v2, v3) = 0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::game_core::get_template_data(&arg1);
        let v4 = v3;
        let v5 = if (arg2 == 0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::game_core::rarity_r()) {
            0x1::string::utf8(b"R")
        } else if (arg2 == 0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::game_core::rarity_sr()) {
            0x1::string::utf8(b"SR")
        } else {
            0x1::string::utf8(b"SSR")
        };
        let v6 = Character{
            id               : 0x2::object::new(arg3),
            character_id     : v0,
            game_id          : v1,
            name             : v2,
            rarity           : arg2,
            rarity_text      : v5,
            image_url        : 0x2::url::new_unsafe_from_bytes(*0x1::string::as_bytes(&v4)),
            timeline         : 0x2::tx_context::epoch_timestamp_ms(arg3),
            star_rating      : get_starting_star_for_rarity(arg2),
            base_star_rating : get_starting_star_for_rarity(arg2),
            is_awakened      : false,
        };
        0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::game_core::emit_item_minted(0x1::string::utf8(b"Character"), v0, arg2, v6.name, 0x2::tx_context::sender(arg3), v6.timeline);
        v6
    }

    public fun crown_type_alpha() : u8 {
        1
    }

    public fun crown_type_beta() : u8 {
        2
    }

    public fun get_base_star_rating(arg0: &Character) : u8 {
        arg0.base_star_rating
    }

    public fun get_character_id(arg0: &Character) : u64 {
        arg0.character_id
    }

    public fun get_character_info(arg0: &Character) : (u64, 0x1::string::String, u8, 0x2::url::Url, u64) {
        (arg0.character_id, arg0.name, arg0.rarity, arg0.image_url, arg0.timeline)
    }

    public fun get_character_name(arg0: &Character) : 0x1::string::String {
        arg0.name
    }

    public fun get_character_rarity(arg0: &Character) : u8 {
        arg0.rarity
    }

    public fun get_crown_id(arg0: &Crown) : u64 {
        arg0.material_id
    }

    public fun get_crown_type(arg0: &Crown) : u8 {
        arg0.crown_type
    }

    public fun get_game_id(arg0: &Character) : u64 {
        arg0.game_id
    }

    public fun get_image_url(arg0: &Character) : 0x2::url::Url {
        arg0.image_url
    }

    public(friend) fun get_is_awakened(arg0: &Character) : bool {
        arg0.is_awakened
    }

    public(friend) fun get_rarity(arg0: &Character) : u8 {
        arg0.rarity
    }

    public fun get_sr_5star_count(arg0: &GlobalCharacterUpgradeState, arg1: u64) : u64 {
        if (0x2::table::contains<u64, u64>(&arg0.sr_5star_counts, arg1)) {
            *0x2::table::borrow<u64, u64>(&arg0.sr_5star_counts, arg1)
        } else {
            0
        }
    }

    public fun get_sr_5star_remaining(arg0: &GlobalCharacterUpgradeState, arg1: u64) : u64 {
        5555 - get_sr_5star_count(arg0, arg1)
    }

    public fun get_ssr_5star_count(arg0: &GlobalCharacterUpgradeState, arg1: u64) : u64 {
        if (0x2::table::contains<u64, u64>(&arg0.ssr_5star_counts, arg1)) {
            *0x2::table::borrow<u64, u64>(&arg0.ssr_5star_counts, arg1)
        } else {
            0
        }
    }

    public fun get_ssr_5star_remaining(arg0: &GlobalCharacterUpgradeState, arg1: u64) : u64 {
        777 - get_ssr_5star_count(arg0, arg1)
    }

    public fun get_star_rating(arg0: &Character) : u8 {
        arg0.star_rating
    }

    public fun get_star_up_cost_crown(arg0: &GlobalCharacterUpgradeState) : u64 {
        arg0.alb_cost_star_up_crown
    }

    public fun get_star_up_cost_duplicate(arg0: &GlobalCharacterUpgradeState) : u64 {
        arg0.alb_cost_star_up_duplicate
    }

    public fun get_star_up_cost_fragment(arg0: &GlobalCharacterUpgradeState) : u64 {
        arg0.alb_cost_star_up_fragment
    }

    public fun get_star_up_cost_wildcard(arg0: &GlobalCharacterUpgradeState) : u64 {
        arg0.alb_cost_star_up_wildcard
    }

    public fun get_star_up_fragment_requirement(arg0: u8) : u64 {
        if (arg0 == 0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::game_core::rarity_ssr()) {
            100
        } else {
            60
        }
    }

    fun get_starting_star_for_rarity(arg0: u8) : u8 {
        if (arg0 == 0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::game_core::rarity_ssr()) {
            3
        } else if (arg0 == 0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::game_core::rarity_sr()) {
            2
        } else {
            1
        }
    }

    public fun global_character_upgrade_state_version(arg0: &GlobalCharacterUpgradeState) : u64 {
        arg0.version
    }

    fun handle_alb_tax(arg0: &mut 0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::alb_token::TokenTreasury, arg1: 0x2::coin::Coin<0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::alb_token::ALB_TOKEN>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        if (arg2 == 0) {
            0x2::coin::destroy_zero<0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::alb_token::ALB_TOKEN>(arg1);
        } else {
            assert!(0x2::coin::value<0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::alb_token::ALB_TOKEN>(&arg1) >= arg2, 12);
            0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::alb_token::route_alb_tax(arg0, arg1, arg3);
        };
    }

    fun init(arg0: CHARACTER_SYSTEM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<CHARACTER_SYSTEM>(arg0, arg1);
        let v1 = 0x2::display::new<Character>(&v0, arg1);
        0x2::display::add<Character>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name} #{character_id}"));
        0x2::display::add<Character>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{rarity_text} Rarity | A powerful character in the Albus Paths universe"));
        0x2::display::add<Character>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<Character>(&mut v1, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://albuspaths.com"));
        0x2::display::add<Character>(&mut v1, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"Albus Paths"));
        0x2::display::add<Character>(&mut v1, 0x1::string::utf8(b"rarity"), 0x1::string::utf8(b"{rarity_text}"));
        0x2::display::update_version<Character>(&mut v1);
        let v2 = 0x2::display::new<Crown>(&v0, arg1);
        0x2::display::add<Crown>(&mut v2, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"Crown {crown_type_text}"));
        0x2::display::add<Crown>(&mut v2, 0x1::string::utf8(b"description"), 0x1::string::utf8(x"41207b63726f776e5f747970655f746578747d2043726f776e202d20746865206578636c7573697665206b657920746f20756e6c6f636b696e6720352d7374617220706f7765722e205573656420666f722034e29885e2869235e298852063686172616374657220757067726164652e"));
        0x2::display::add<Crown>(&mut v2, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<Crown>(&mut v2, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://albuspaths.com"));
        0x2::display::add<Crown>(&mut v2, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"Albus Paths"));
        0x2::display::add<Crown>(&mut v2, 0x1::string::utf8(b"type"), 0x1::string::utf8(b"{crown_type_text}"));
        0x2::display::update_version<Crown>(&mut v2);
        let (v3, v4) = 0x2::transfer_policy::new<Character>(&v0, arg1);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Character>>(v3);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Character>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Character>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Crown>>(v2, 0x2::tx_context::sender(arg1));
        let v5 = GlobalCharacterUpgradeState{
            id                         : 0x2::object::new(arg1),
            version                    : 1,
            ssr_5star_counts           : 0x2::table::new<u64, u64>(arg1),
            sr_5star_counts            : 0x2::table::new<u64, u64>(arg1),
            alb_cost_star_up_duplicate : 0,
            alb_cost_star_up_crown     : 0,
            alb_cost_star_up_fragment  : 0,
            alb_cost_star_up_wildcard  : 0,
        };
        0x2::transfer::share_object<GlobalCharacterUpgradeState>(v5);
    }

    public fun is_rarity(arg0: &Character, arg1: u8) : bool {
        arg0.rarity == arg1
    }

    public fun max_star_rating() : u8 {
        5
    }

    public fun migrate_global_character_upgrade_state(arg0: &0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::game_core::CharacterAdminCap, arg1: &mut GlobalCharacterUpgradeState) {
        assert!(arg1.version < 1, 9);
        arg1.version = 1;
    }

    public fun min_star_rating() : u8 {
        1
    }

    public fun set_star_up_alb_costs(arg0: &0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::game_core::CharacterAdminCap, arg1: &mut GlobalCharacterUpgradeState, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        assert_upgrade_state_version(arg1);
        arg1.alb_cost_star_up_duplicate = arg2;
        arg1.alb_cost_star_up_crown = arg3;
        arg1.alb_cost_star_up_fragment = arg4;
        arg1.alb_cost_star_up_wildcard = arg5;
    }

    public fun sr_5star_cap() : u64 {
        5555
    }

    public fun ssr_5star_cap() : u64 {
        777
    }

    public fun star_up_with_crown(arg0: &mut GlobalCharacterUpgradeState, arg1: &mut 0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::alb_token::TokenTreasury, arg2: &mut Character, arg3: Crown, arg4: 0x2::coin::Coin<0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::alb_token::ALB_TOKEN>, arg5: &mut 0x2::tx_context::TxContext) {
        assert_upgrade_state_version(arg0);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::tx_context::epoch_timestamp_ms(arg5);
        assert!(arg2.star_rating < 5, 0);
        assert!(arg2.star_rating == 5 - 1, 6);
        let v2 = if (arg3.crown_type == 1) {
            0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::game_core::rarity_ssr()
        } else {
            0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::game_core::rarity_sr()
        };
        assert!(arg2.rarity == v2, 3);
        handle_alb_tax(arg1, arg4, arg0.alb_cost_star_up_crown, arg5);
        let v3 = arg2.star_rating;
        let v4 = arg2.game_id;
        let (v5, v6) = if (arg2.rarity == 0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::game_core::rarity_ssr()) {
            let v5 = &mut arg0.ssr_5star_counts;
            (v5, 777)
        } else {
            let v5 = &mut arg0.sr_5star_counts;
            (v5, 5555)
        };
        let v7 = if (0x2::table::contains<u64, u64>(v5, v4)) {
            *0x2::table::borrow<u64, u64>(v5, v4)
        } else {
            0
        };
        assert!(v7 < v6, 4);
        if (0x2::table::contains<u64, u64>(v5, v4)) {
            let v8 = 0x2::table::borrow_mut<u64, u64>(v5, v4);
            *v8 = *v8 + 1;
        } else {
            0x2::table::add<u64, u64>(v5, v4, 1);
        };
        let v9 = arg2.character_id;
        let Crown {
            id                : v10,
            material_id       : _,
            crown_type        : _,
            crown_type_text   : _,
            image_url         : _,
            created_timestamp : _,
        } = arg3;
        0x2::object::delete(v10);
        arg2.star_rating = v3 + 1;
        let v16 = CrownConsumed{
            material_id  : arg3.material_id,
            crown_type   : arg3.crown_type,
            character_id : v9,
            old_star     : v3,
            new_star     : arg2.star_rating,
            owner        : v0,
            timestamp    : v1,
        };
        0x2::event::emit<CrownConsumed>(v16);
        let v17 = StarRatingChanged{
            character_id    : v9,
            old_star_rating : v3,
            new_star_rating : arg2.star_rating,
            upgrade_method  : 2,
            owner           : v0,
            timestamp       : v1,
        };
        0x2::event::emit<StarRatingChanged>(v17);
    }

    public fun star_up_with_duplicate(arg0: &GlobalCharacterUpgradeState, arg1: &mut 0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::alb_token::TokenTreasury, arg2: &mut Character, arg3: Character, arg4: 0x2::coin::Coin<0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::alb_token::ALB_TOKEN>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::tx_context::epoch_timestamp_ms(arg5);
        assert!(arg2.star_rating < 5, 0);
        if (arg2.rarity != 0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::game_core::rarity_r()) {
            assert!(arg2.star_rating < 5 - 1, 5);
        };
        assert!(arg2.game_id == arg3.game_id, 1);
        handle_alb_tax(arg1, arg4, arg0.alb_cost_star_up_duplicate, arg5);
        let v2 = arg2.star_rating;
        let v3 = arg2.character_id;
        let Character {
            id               : v4,
            character_id     : _,
            game_id          : _,
            name             : _,
            rarity           : _,
            rarity_text      : _,
            image_url        : _,
            timeline         : _,
            star_rating      : _,
            base_star_rating : _,
            is_awakened      : _,
        } = arg3;
        0x2::object::delete(v4);
        arg2.star_rating = v2 + 1;
        let v15 = DuplicateCharacterConsumed{
            consumed_character_id : arg3.character_id,
            target_character_id   : v3,
            game_id               : arg3.game_id,
            old_star              : v2,
            new_star              : arg2.star_rating,
            owner                 : v0,
            timestamp             : v1,
        };
        0x2::event::emit<DuplicateCharacterConsumed>(v15);
        let v16 = StarRatingChanged{
            character_id    : v3,
            old_star_rating : v2,
            new_star_rating : arg2.star_rating,
            upgrade_method  : 1,
            owner           : v0,
            timestamp       : v1,
        };
        0x2::event::emit<StarRatingChanged>(v16);
    }

    public fun stars_until_max(arg0: &Character) : u8 {
        5 - arg0.star_rating
    }

    public fun transfer_character(arg0: Character, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<Character>(arg0, arg1);
    }

    public(friend) fun upgrade_star_for_awakened_crown(arg0: &mut Character) {
        arg0.star_rating = 5;
    }

    public(friend) fun upgrade_star_for_awakened_duplicate(arg0: &mut Character) : (u8, u8) {
        assert!(arg0.star_rating < 5 - 1, 5);
        let v0 = arg0.star_rating;
        arg0.star_rating = v0 + 1;
        (v0, arg0.star_rating)
    }

    public(friend) fun upgrade_star_rating_from_fragments(arg0: &mut Character) : (u8, u8) {
        assert!(arg0.star_rating < 5, 0);
        assert!(arg0.star_rating < 5 - 1, 5);
        let v0 = arg0.star_rating;
        arg0.star_rating = v0 + 1;
        (v0, arg0.star_rating)
    }

    public(friend) fun upgrade_star_rating_from_wildcard(arg0: &mut Character, arg1: u8, arg2: address, arg3: u64) : (u8, u8) {
        assert!(arg0.star_rating < 5, 0);
        if (arg0.rarity != 0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::game_core::rarity_r()) {
            assert!(arg0.star_rating < 5 - 1, 5);
        };
        assert!(arg1 == arg0.rarity, 11);
        let v0 = arg0.star_rating;
        arg0.star_rating = v0 + 1;
        let v1 = StarUpWithWildcardEvent{
            owner             : arg2,
            character_game_id : arg0.game_id,
            wildcard_rarity   : arg1,
            new_star_rating   : arg0.star_rating,
            character_id      : 0x2::object::id<Character>(arg0),
        };
        0x2::event::emit<StarUpWithWildcardEvent>(v1);
        let v2 = StarRatingChanged{
            character_id    : arg0.character_id,
            old_star_rating : v0,
            new_star_rating : arg0.star_rating,
            upgrade_method  : 3,
            owner           : arg2,
            timestamp       : arg3,
        };
        0x2::event::emit<StarRatingChanged>(v2);
        (v0, arg0.star_rating)
    }

    public fun withdraw_character_royalties(arg0: &0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::game_core::CharacterAdminCap, arg1: &mut 0x2::transfer_policy::TransferPolicy<Character>, arg2: &0x2::transfer_policy::TransferPolicyCap<Character>, arg3: 0x1::option::Option<u64>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x2::transfer_policy::withdraw<Character>(arg1, arg2, arg3, arg4)
    }

    // decompiled from Move bytecode v6
}

