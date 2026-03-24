module 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::character_system {
    struct GlobalCharacterUpgradeState has key {
        id: 0x2::object::UID,
        version: u64,
        ssr_5star_counts: 0x2::table::Table<u64, u64>,
        sr_5star_counts: 0x2::table::Table<u64, u64>,
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
    }

    struct StarRatingChanged has copy, drop {
        character_id: u64,
        old_star_rating: u8,
        new_star_rating: u8,
        upgrade_method: u8,
        owner: address,
        timestamp: u64,
    }

    struct Crown has store, key {
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

    public fun admin_mint_character(arg0: &0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::CharacterAdminCap, arg1: &mut 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::GlobalGameState, arg2: u64, arg3: u8, arg4: vector<u8>, arg5: vector<u8>, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 >= 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::rarity_r() && arg3 <= 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::rarity_ssr(), 7);
        0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::validate_url_bytes(&arg5);
        let v0 = 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::get_next_character_id(arg1);
        0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::update_character_stats(arg1, arg3);
        let v1 = if (arg3 == 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::rarity_r()) {
            0x1::string::utf8(b"R")
        } else if (arg3 == 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::rarity_sr()) {
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
        };
        0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::emit_item_minted(0x1::string::utf8(b"Character"), v0, arg3, v2.name, arg6, v2.timeline);
        0x2::transfer::public_transfer<Character>(v2, arg6);
    }

    public fun admin_mint_crown(arg0: &0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::CharacterAdminCap, arg1: &mut 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::GlobalGameState, arg2: u8, arg3: vector<u8>, arg4: address, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 == 1 || arg2 == 2, 2);
        0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::validate_url_bytes(&arg3);
        let v0 = 0x2::tx_context::epoch_timestamp_ms(arg6);
        let v1 = if (arg2 == 1) {
            0x1::string::utf8(b"Alpha")
        } else {
            0x1::string::utf8(b"Beta")
        };
        let v2 = 0;
        while (v2 < arg5) {
            let v3 = 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::get_next_crown_id(arg1);
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
            0x2::transfer::public_transfer<Crown>(v4, arg4);
            v2 = v2 + 1;
        };
    }

    public fun can_upgrade_stars(arg0: &Character) : bool {
        arg0.star_rating < 5
    }

    public(friend) fun create_character_from_template(arg0: &mut 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::GlobalGameState, arg1: 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::CharacterTemplate, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) : Character {
        let v0 = 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::get_next_character_id(arg0);
        0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::update_character_stats(arg0, arg2);
        let (v1, v2, v3) = 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::get_template_data(&arg1);
        let v4 = v3;
        let v5 = if (arg2 == 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::rarity_r()) {
            0x1::string::utf8(b"R")
        } else if (arg2 == 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::rarity_sr()) {
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
        };
        0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::emit_item_minted(0x1::string::utf8(b"Character"), v0, arg2, v6.name, 0x2::tx_context::sender(arg3), v6.timeline);
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

    public fun get_star_up_fragment_requirement(arg0: u8) : u64 {
        if (arg0 == 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::rarity_ssr()) {
            100
        } else {
            60
        }
    }

    fun get_starting_star_for_rarity(arg0: u8) : u8 {
        if (arg0 == 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::rarity_ssr()) {
            3
        } else if (arg0 == 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::rarity_sr()) {
            2
        } else {
            1
        }
    }

    public fun global_character_upgrade_state_version(arg0: &GlobalCharacterUpgradeState) : u64 {
        arg0.version
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
        let (v5, v6) = 0x2::transfer_policy::new<Crown>(&v0, arg1);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Crown>>(v5);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Crown>>(v6, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Character>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Crown>>(v2, 0x2::tx_context::sender(arg1));
        let v7 = GlobalCharacterUpgradeState{
            id               : 0x2::object::new(arg1),
            version          : 1,
            ssr_5star_counts : 0x2::table::new<u64, u64>(arg1),
            sr_5star_counts  : 0x2::table::new<u64, u64>(arg1),
        };
        0x2::transfer::share_object<GlobalCharacterUpgradeState>(v7);
    }

    public fun is_rarity(arg0: &Character, arg1: u8) : bool {
        arg0.rarity == arg1
    }

    public fun max_star_rating() : u8 {
        5
    }

    public fun migrate_global_character_upgrade_state(arg0: &0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::CharacterAdminCap, arg1: &mut GlobalCharacterUpgradeState) {
        assert!(arg1.version < 1, 9);
        arg1.version = 1;
    }

    public fun min_star_rating() : u8 {
        1
    }

    public fun sr_5star_cap() : u64 {
        5555
    }

    public fun ssr_5star_cap() : u64 {
        777
    }

    public fun star_up_with_crown(arg0: &mut GlobalCharacterUpgradeState, arg1: &mut Character, arg2: Crown, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::tx_context::epoch_timestamp_ms(arg3);
        assert!(arg1.star_rating < 5, 0);
        assert!(arg1.star_rating == 5 - 1, 6);
        let v2 = if (arg2.crown_type == 1) {
            0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::rarity_ssr()
        } else {
            0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::rarity_sr()
        };
        assert!(arg1.rarity == v2, 3);
        let v3 = arg1.star_rating;
        let v4 = arg1.game_id;
        let (v5, v6) = if (arg1.rarity == 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::rarity_ssr()) {
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
        let v9 = arg1.character_id;
        let Crown {
            id                : v10,
            material_id       : _,
            crown_type        : _,
            crown_type_text   : _,
            image_url         : _,
            created_timestamp : _,
        } = arg2;
        0x2::object::delete(v10);
        arg1.star_rating = v3 + 1;
        let v16 = CrownConsumed{
            material_id  : arg2.material_id,
            crown_type   : arg2.crown_type,
            character_id : v9,
            old_star     : v3,
            new_star     : arg1.star_rating,
            owner        : v0,
            timestamp    : v1,
        };
        0x2::event::emit<CrownConsumed>(v16);
        let v17 = StarRatingChanged{
            character_id    : v9,
            old_star_rating : v3,
            new_star_rating : arg1.star_rating,
            upgrade_method  : 2,
            owner           : v0,
            timestamp       : v1,
        };
        0x2::event::emit<StarRatingChanged>(v17);
    }

    public fun star_up_with_duplicate(arg0: &mut Character, arg1: Character, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::tx_context::epoch_timestamp_ms(arg2);
        assert!(arg0.star_rating < 5, 0);
        if (arg0.rarity != 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::rarity_r()) {
            assert!(arg0.star_rating < 5 - 1, 5);
        };
        assert!(arg0.game_id == arg1.game_id, 1);
        let v2 = arg0.star_rating;
        let v3 = arg0.character_id;
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
        } = arg1;
        0x2::object::delete(v4);
        arg0.star_rating = v2 + 1;
        let v14 = DuplicateCharacterConsumed{
            consumed_character_id : arg1.character_id,
            target_character_id   : v3,
            game_id               : arg1.game_id,
            old_star              : v2,
            new_star              : arg0.star_rating,
            owner                 : v0,
            timestamp             : v1,
        };
        0x2::event::emit<DuplicateCharacterConsumed>(v14);
        let v15 = StarRatingChanged{
            character_id    : v3,
            old_star_rating : v2,
            new_star_rating : arg0.star_rating,
            upgrade_method  : 1,
            owner           : v0,
            timestamp       : v1,
        };
        0x2::event::emit<StarRatingChanged>(v15);
    }

    public fun stars_until_max(arg0: &Character) : u8 {
        5 - arg0.star_rating
    }

    public fun transfer_character(arg0: Character, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<Character>(arg0, arg1);
    }

    public(friend) fun upgrade_star_rating_from_fragments(arg0: &mut Character) : (u8, u8) {
        assert!(arg0.star_rating < 5, 0);
        assert!(arg0.star_rating < 5 - 1, 5);
        let v0 = arg0.star_rating;
        arg0.star_rating = v0 + 1;
        (v0, arg0.star_rating)
    }

    public fun withdraw_character_royalties(arg0: &0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::CharacterAdminCap, arg1: &mut 0x2::transfer_policy::TransferPolicy<Character>, arg2: &0x2::transfer_policy::TransferPolicyCap<Character>, arg3: 0x1::option::Option<u64>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x2::transfer_policy::withdraw<Character>(arg1, arg2, arg3, arg4)
    }

    public fun withdraw_crown_royalties(arg0: &0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::CharacterAdminCap, arg1: &mut 0x2::transfer_policy::TransferPolicy<Crown>, arg2: &0x2::transfer_policy::TransferPolicyCap<Crown>, arg3: 0x1::option::Option<u64>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x2::transfer_policy::withdraw<Crown>(arg1, arg2, arg3, arg4)
    }

    // decompiled from Move bytecode v6
}

