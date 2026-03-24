module 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::fragment_system {
    struct FRAGMENT_SYSTEM has drop {
        dummy_field: bool,
    }

    struct BoundFragment has key {
        id: 0x2::object::UID,
        character_game_id: u64,
        character_name: 0x1::string::String,
        rarity: u8,
        rarity_text: 0x1::string::String,
        required_fragments: u64,
        fragment_amount: u64,
        source: 0x1::string::String,
        image_url: 0x1::string::String,
        mint_timestamp: u64,
    }

    struct TradableFragment has store, key {
        id: 0x2::object::UID,
        character_game_id: u64,
        character_name: 0x1::string::String,
        rarity: u8,
        rarity_text: 0x1::string::String,
        required_fragments: u64,
        fragment_amount: u64,
        source: 0x1::string::String,
        image_url: 0x1::string::String,
        mint_timestamp: u64,
    }

    struct GlobalFragmentState has key {
        id: 0x2::object::UID,
        version: u64,
        total_bound_fragments_minted: u64,
        total_tradable_fragments_minted: u64,
        total_sr_characters_synthesized: u64,
        total_ssr_characters_synthesized: u64,
    }

    struct BoundFragmentMinted has copy, drop {
        game_id: u64,
        character_name: 0x1::string::String,
        rarity: u8,
        amount: u64,
        source: 0x1::string::String,
        recipient: address,
        timestamp: u64,
    }

    struct TradableFragmentMinted has copy, drop {
        game_id: u64,
        character_name: 0x1::string::String,
        rarity: u8,
        amount: u64,
        source: 0x1::string::String,
        recipient: address,
        timestamp: u64,
    }

    struct CharacterSynthesized has copy, drop {
        synthesizer: address,
        character_id: u64,
        game_id: u64,
        character_name: 0x1::string::String,
        rarity: u8,
        bound_fragments_consumed: u64,
        tradable_fragments_consumed: u64,
        timestamp: u64,
    }

    struct FragmentStarUpCompleted has copy, drop {
        character_id: u64,
        game_id: u64,
        rarity: u8,
        fragments_consumed: u64,
        old_star: u8,
        new_star: u8,
        upgrade_method: u8,
        owner: address,
        timestamp: u64,
    }

    public fun admin_batch_mint_tradable_fragments(arg0: &0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::CharacterAdminCap, arg1: &mut GlobalFragmentState, arg2: &0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::TemplateRegistry, arg3: u64, arg4: u8, arg5: vector<address>, arg6: vector<u64>, arg7: 0x1::string::String, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<address>(&arg5);
        assert!(v0 == 0x1::vector::length<u64>(&arg6), 0);
        let v1 = 0;
        while (v1 < v0) {
            admin_mint_tradable_fragment(arg0, arg1, arg2, arg3, arg4, *0x1::vector::borrow<u64>(&arg6, v1), arg7, *0x1::vector::borrow<address>(&arg5, v1), arg8);
            v1 = v1 + 1;
        };
    }

    public fun admin_mint_tradable_fragment(arg0: &0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::CharacterAdminCap, arg1: &mut GlobalFragmentState, arg2: &0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::TemplateRegistry, arg3: u64, arg4: u8, arg5: u64, arg6: 0x1::string::String, arg7: address, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::get_template_by_id(arg2, arg3);
        let (_, v2, v3) = 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::get_template_data(&v0);
        assert!(arg4 == 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::rarity_sr() || arg4 == 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::rarity_ssr(), 2);
        let v4 = if (arg4 == 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::rarity_sr()) {
            0x1::string::utf8(b"SR")
        } else {
            0x1::string::utf8(b"SSR")
        };
        let v5 = if (arg4 == 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::rarity_sr()) {
            60
        } else {
            100
        };
        let v6 = TradableFragment{
            id                 : 0x2::object::new(arg8),
            character_game_id  : arg3,
            character_name     : v2,
            rarity             : arg4,
            rarity_text        : v4,
            required_fragments : v5,
            fragment_amount    : arg5,
            source             : arg6,
            image_url          : v3,
            mint_timestamp     : 0x2::tx_context::epoch_timestamp_ms(arg8),
        };
        arg1.total_tradable_fragments_minted = arg1.total_tradable_fragments_minted + arg5;
        let v7 = TradableFragmentMinted{
            game_id        : arg3,
            character_name : v2,
            rarity         : arg4,
            amount         : arg5,
            source         : arg6,
            recipient      : arg7,
            timestamp      : 0x2::tx_context::epoch_timestamp_ms(arg8),
        };
        0x2::event::emit<TradableFragmentMinted>(v7);
        0x2::transfer::public_transfer<TradableFragment>(v6, arg7);
    }

    fun burn_bound_fragments(arg0: vector<BoundFragment>) {
        while (!0x1::vector::is_empty<BoundFragment>(&arg0)) {
            let BoundFragment {
                id                 : v0,
                character_game_id  : _,
                character_name     : _,
                rarity             : _,
                rarity_text        : _,
                required_fragments : _,
                fragment_amount    : _,
                source             : _,
                image_url          : _,
                mint_timestamp     : _,
            } = 0x1::vector::pop_back<BoundFragment>(&mut arg0);
            0x2::object::delete(v0);
        };
        0x1::vector::destroy_empty<BoundFragment>(arg0);
    }

    fun burn_tradable_fragments(arg0: vector<TradableFragment>) {
        while (!0x1::vector::is_empty<TradableFragment>(&arg0)) {
            let TradableFragment {
                id                 : v0,
                character_game_id  : _,
                character_name     : _,
                rarity             : _,
                rarity_text        : _,
                required_fragments : _,
                fragment_amount    : _,
                source             : _,
                image_url          : _,
                mint_timestamp     : _,
            } = 0x1::vector::pop_back<TradableFragment>(&mut arg0);
            0x2::object::delete(v0);
        };
        0x1::vector::destroy_empty<TradableFragment>(arg0);
    }

    public(friend) fun consume_bound_fragments_for_star_up(arg0: vector<BoundFragment>, arg1: u64, arg2: u8, arg3: u64) : u64 {
        let (v0, _) = validate_and_burn_bound_fragments(&arg0, arg1, arg2);
        assert!(v0 >= arg3, 0);
        burn_bound_fragments(arg0);
        v0
    }

    public(friend) fun consume_mixed_fragments_for_star_up(arg0: vector<BoundFragment>, arg1: vector<TradableFragment>, arg2: u64, arg3: u8, arg4: u64) : (u64, u64) {
        let (v0, _) = validate_and_burn_bound_fragments(&arg0, arg2, arg3);
        let (v2, _) = validate_and_burn_tradable_fragments(&arg1, arg2, arg3);
        assert!(v0 + v2 >= arg4, 0);
        burn_bound_fragments(arg0);
        burn_tradable_fragments(arg1);
        (v0, v2)
    }

    public(friend) fun consume_tradable_fragments_for_star_up(arg0: vector<TradableFragment>, arg1: u64, arg2: u8, arg3: u64) : u64 {
        let (v0, _) = validate_and_burn_tradable_fragments(&arg0, arg1, arg2);
        assert!(v0 >= arg3, 0);
        burn_tradable_fragments(arg0);
        v0
    }

    fun create_synthesized_character(arg0: &mut GlobalFragmentState, arg1: &mut 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::GlobalGameState, arg2: &0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::TemplateRegistry, arg3: u64, arg4: u8, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::character_system::Character {
        let v0 = 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::get_template_by_id(arg2, arg3);
        let (_, v2, _) = 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::get_template_data(&v0);
        let v4 = 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::character_system::create_character_from_template(arg1, v0, arg4, arg8);
        if (arg4 == 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::rarity_sr()) {
            arg0.total_sr_characters_synthesized = arg0.total_sr_characters_synthesized + 1;
        } else {
            arg0.total_ssr_characters_synthesized = arg0.total_ssr_characters_synthesized + 1;
        };
        let v5 = CharacterSynthesized{
            synthesizer                 : 0x2::tx_context::sender(arg8),
            character_id                : 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::character_system::get_character_id(&v4),
            game_id                     : arg3,
            character_name              : v2,
            rarity                      : arg4,
            bound_fragments_consumed    : arg5,
            tradable_fragments_consumed : arg6,
            timestamp                   : 0x2::clock::timestamp_ms(arg7),
        };
        0x2::event::emit<CharacterSynthesized>(v5);
        v4
    }

    public fun get_bound_amount(arg0: &BoundFragment) : u64 {
        arg0.fragment_amount
    }

    public fun get_bound_game_id(arg0: &BoundFragment) : u64 {
        arg0.character_game_id
    }

    public fun get_bound_rarity(arg0: &BoundFragment) : u8 {
        arg0.rarity
    }

    public fun get_bound_source(arg0: &BoundFragment) : 0x1::string::String {
        arg0.source
    }

    public fun get_global_stats(arg0: &GlobalFragmentState) : (u64, u64, u64, u64) {
        (arg0.total_bound_fragments_minted, arg0.total_tradable_fragments_minted, arg0.total_sr_characters_synthesized, arg0.total_ssr_characters_synthesized)
    }

    public fun get_synthesis_requirements() : (u64, u64) {
        (60, 100)
    }

    public fun get_tradable_amount(arg0: &TradableFragment) : u64 {
        arg0.fragment_amount
    }

    public fun get_tradable_game_id(arg0: &TradableFragment) : u64 {
        arg0.character_game_id
    }

    public fun get_tradable_rarity(arg0: &TradableFragment) : u8 {
        arg0.rarity
    }

    public fun get_tradable_source(arg0: &TradableFragment) : 0x1::string::String {
        arg0.source
    }

    public fun global_fragment_state_version(arg0: &GlobalFragmentState) : u64 {
        arg0.version
    }

    fun init(arg0: FRAGMENT_SYSTEM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<FRAGMENT_SYSTEM>(arg0, arg1);
        let v1 = 0x2::display::new<BoundFragment>(&v0, arg1);
        0x2::display::add<BoundFragment>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{character_name} Fragment (Bound)"));
        0x2::display::add<BoundFragment>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"Account-bound fragment for {character_name} ({rarity_text}). Collect {required_fragments} to synthesize. Amount: {fragment_amount}"));
        0x2::display::add<BoundFragment>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<BoundFragment>(&mut v1, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://albuspaths.com"));
        0x2::display::add<BoundFragment>(&mut v1, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"Albus Paths"));
        0x2::display::add<BoundFragment>(&mut v1, 0x1::string::utf8(b"tradeable"), 0x1::string::utf8(b"false"));
        0x2::display::update_version<BoundFragment>(&mut v1);
        let v2 = 0x2::display::new<TradableFragment>(&v0, arg1);
        0x2::display::add<TradableFragment>(&mut v2, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{character_name} Fragment"));
        0x2::display::add<TradableFragment>(&mut v2, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"Tradeable fragment for {character_name} ({rarity_text}). Collect {required_fragments} to synthesize. Amount: {fragment_amount}"));
        0x2::display::add<TradableFragment>(&mut v2, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<TradableFragment>(&mut v2, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://albuspaths.com"));
        0x2::display::add<TradableFragment>(&mut v2, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"Albus Paths"));
        0x2::display::add<TradableFragment>(&mut v2, 0x1::string::utf8(b"tradeable"), 0x1::string::utf8(b"true"));
        0x2::display::update_version<TradableFragment>(&mut v2);
        let (v3, v4) = 0x2::transfer_policy::new<TradableFragment>(&v0, arg1);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<TradableFragment>>(v3);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<TradableFragment>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<BoundFragment>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<TradableFragment>>(v2, 0x2::tx_context::sender(arg1));
        let v5 = GlobalFragmentState{
            id                               : 0x2::object::new(arg1),
            version                          : 1,
            total_bound_fragments_minted     : 0,
            total_tradable_fragments_minted  : 0,
            total_sr_characters_synthesized  : 0,
            total_ssr_characters_synthesized : 0,
        };
        0x2::transfer::share_object<GlobalFragmentState>(v5);
    }

    public fun migrate_global_fragment_state(arg0: &0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::CharacterAdminCap, arg1: &mut GlobalFragmentState) {
        assert!(arg1.version < 1, 4);
        arg1.version = 1;
    }

    public(friend) fun mint_gacha_fragments(arg0: &mut GlobalFragmentState, arg1: &0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::TemplateRegistry, arg2: u64, arg3: u8, arg4: u64, arg5: address, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::get_template_by_id(arg1, arg2);
        let (_, v2, v3) = 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::get_template_data(&v0);
        assert!(arg3 == 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::rarity_sr() || arg3 == 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::rarity_ssr(), 2);
        let v4 = if (arg3 == 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::rarity_sr()) {
            0x1::string::utf8(b"SR")
        } else {
            0x1::string::utf8(b"SSR")
        };
        let v5 = if (arg3 == 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::rarity_sr()) {
            60
        } else {
            100
        };
        let v6 = BoundFragment{
            id                 : 0x2::object::new(arg7),
            character_game_id  : arg2,
            character_name     : v2,
            rarity             : arg3,
            rarity_text        : v4,
            required_fragments : v5,
            fragment_amount    : arg4,
            source             : 0x1::string::utf8(b"unified_gacha"),
            image_url          : v3,
            mint_timestamp     : 0x2::clock::timestamp_ms(arg6),
        };
        arg0.total_bound_fragments_minted = arg0.total_bound_fragments_minted + arg4;
        let v7 = BoundFragmentMinted{
            game_id        : arg2,
            character_name : v2,
            rarity         : arg3,
            amount         : arg4,
            source         : 0x1::string::utf8(b"unified_gacha"),
            recipient      : arg5,
            timestamp      : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::event::emit<BoundFragmentMinted>(v7);
        0x2::transfer::transfer<BoundFragment>(v6, arg5);
    }

    public fun star_up_with_bound_fragments(arg0: &mut 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::character_system::Character, arg1: vector<BoundFragment>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::character_system::get_game_id(arg0);
        let v1 = 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::character_system::get_character_rarity(arg0);
        let (v2, v3) = 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::character_system::upgrade_star_rating_from_fragments(arg0);
        let v4 = FragmentStarUpCompleted{
            character_id       : 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::character_system::get_character_id(arg0),
            game_id            : v0,
            rarity             : v1,
            fragments_consumed : consume_bound_fragments_for_star_up(arg1, v0, v1, 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::character_system::get_star_up_fragment_requirement(v1)),
            old_star           : v2,
            new_star           : v3,
            upgrade_method     : 3,
            owner              : 0x2::tx_context::sender(arg2),
            timestamp          : 0x2::tx_context::epoch_timestamp_ms(arg2),
        };
        0x2::event::emit<FragmentStarUpCompleted>(v4);
    }

    public fun star_up_with_mixed_fragments(arg0: &mut 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::character_system::Character, arg1: vector<BoundFragment>, arg2: vector<TradableFragment>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::character_system::get_game_id(arg0);
        let v1 = 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::character_system::get_character_rarity(arg0);
        let (v2, v3) = consume_mixed_fragments_for_star_up(arg1, arg2, v0, v1, 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::character_system::get_star_up_fragment_requirement(v1));
        let (v4, v5) = 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::character_system::upgrade_star_rating_from_fragments(arg0);
        let v6 = FragmentStarUpCompleted{
            character_id       : 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::character_system::get_character_id(arg0),
            game_id            : v0,
            rarity             : v1,
            fragments_consumed : v2 + v3,
            old_star           : v4,
            new_star           : v5,
            upgrade_method     : 5,
            owner              : 0x2::tx_context::sender(arg3),
            timestamp          : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x2::event::emit<FragmentStarUpCompleted>(v6);
    }

    public fun star_up_with_tradable_fragments(arg0: &mut 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::character_system::Character, arg1: vector<TradableFragment>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::character_system::get_game_id(arg0);
        let v1 = 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::character_system::get_character_rarity(arg0);
        let (v2, v3) = 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::character_system::upgrade_star_rating_from_fragments(arg0);
        let v4 = FragmentStarUpCompleted{
            character_id       : 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::character_system::get_character_id(arg0),
            game_id            : v0,
            rarity             : v1,
            fragments_consumed : consume_tradable_fragments_for_star_up(arg1, v0, v1, 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::character_system::get_star_up_fragment_requirement(v1)),
            old_star           : v2,
            new_star           : v3,
            upgrade_method     : 4,
            owner              : 0x2::tx_context::sender(arg2),
            timestamp          : 0x2::tx_context::epoch_timestamp_ms(arg2),
        };
        0x2::event::emit<FragmentStarUpCompleted>(v4);
    }

    public fun synthesize_sr_from_bound(arg0: &mut GlobalFragmentState, arg1: &mut 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::GlobalGameState, arg2: &0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::TemplateRegistry, arg3: u64, arg4: vector<BoundFragment>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::character_system::Character {
        let (v0, _) = validate_and_burn_bound_fragments(&arg4, arg3, 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::rarity_sr());
        assert!(v0 >= 60, 0);
        burn_bound_fragments(arg4);
        create_synthesized_character(arg0, arg1, arg2, arg3, 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::rarity_sr(), v0, 0, arg5, arg6)
    }

    public fun synthesize_sr_from_tradable(arg0: &mut GlobalFragmentState, arg1: &mut 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::GlobalGameState, arg2: &0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::TemplateRegistry, arg3: u64, arg4: vector<TradableFragment>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::character_system::Character {
        let (v0, _) = validate_and_burn_tradable_fragments(&arg4, arg3, 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::rarity_sr());
        assert!(v0 >= 60, 0);
        burn_tradable_fragments(arg4);
        create_synthesized_character(arg0, arg1, arg2, arg3, 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::rarity_sr(), 0, v0, arg5, arg6)
    }

    public fun synthesize_sr_mixed(arg0: &mut GlobalFragmentState, arg1: &mut 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::GlobalGameState, arg2: &0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::TemplateRegistry, arg3: u64, arg4: vector<BoundFragment>, arg5: vector<TradableFragment>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::character_system::Character {
        let (v0, _) = validate_and_burn_bound_fragments(&arg4, arg3, 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::rarity_sr());
        let (v2, _) = validate_and_burn_tradable_fragments(&arg5, arg3, 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::rarity_sr());
        assert!(v0 + v2 >= 60, 0);
        burn_bound_fragments(arg4);
        burn_tradable_fragments(arg5);
        create_synthesized_character(arg0, arg1, arg2, arg3, 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::rarity_sr(), v0, v2, arg6, arg7)
    }

    public fun synthesize_ssr_from_bound(arg0: &mut GlobalFragmentState, arg1: &mut 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::GlobalGameState, arg2: &0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::TemplateRegistry, arg3: u64, arg4: vector<BoundFragment>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::character_system::Character {
        let (v0, _) = validate_and_burn_bound_fragments(&arg4, arg3, 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::rarity_ssr());
        assert!(v0 >= 100, 0);
        burn_bound_fragments(arg4);
        create_synthesized_character(arg0, arg1, arg2, arg3, 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::rarity_ssr(), v0, 0, arg5, arg6)
    }

    public fun synthesize_ssr_from_tradable(arg0: &mut GlobalFragmentState, arg1: &mut 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::GlobalGameState, arg2: &0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::TemplateRegistry, arg3: u64, arg4: vector<TradableFragment>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::character_system::Character {
        let (v0, _) = validate_and_burn_tradable_fragments(&arg4, arg3, 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::rarity_ssr());
        assert!(v0 >= 100, 0);
        burn_tradable_fragments(arg4);
        create_synthesized_character(arg0, arg1, arg2, arg3, 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::rarity_ssr(), 0, v0, arg5, arg6)
    }

    public fun synthesize_ssr_mixed(arg0: &mut GlobalFragmentState, arg1: &mut 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::GlobalGameState, arg2: &0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::TemplateRegistry, arg3: u64, arg4: vector<BoundFragment>, arg5: vector<TradableFragment>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::character_system::Character {
        let (v0, _) = validate_and_burn_bound_fragments(&arg4, arg3, 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::rarity_ssr());
        let (v2, _) = validate_and_burn_tradable_fragments(&arg5, arg3, 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::rarity_ssr());
        assert!(v0 + v2 >= 100, 0);
        burn_bound_fragments(arg4);
        burn_tradable_fragments(arg5);
        create_synthesized_character(arg0, arg1, arg2, arg3, 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::rarity_ssr(), v0, v2, arg6, arg7)
    }

    public fun transfer_tradable_fragment(arg0: TradableFragment, arg1: address) {
        0x2::transfer::public_transfer<TradableFragment>(arg0, arg1);
    }

    fun validate_and_burn_bound_fragments(arg0: &vector<BoundFragment>, arg1: u64, arg2: u8) : (u64, u64) {
        let v0 = 0x1::vector::length<BoundFragment>(arg0);
        let v1 = 0;
        let v2 = 0;
        while (v2 < v0) {
            let v3 = 0x1::vector::borrow<BoundFragment>(arg0, v2);
            assert!(v3.character_game_id == arg1, 1);
            assert!(v3.rarity == arg2, 2);
            v1 = v1 + v3.fragment_amount;
            v2 = v2 + 1;
        };
        (v1, v0)
    }

    fun validate_and_burn_tradable_fragments(arg0: &vector<TradableFragment>, arg1: u64, arg2: u8) : (u64, u64) {
        let v0 = 0x1::vector::length<TradableFragment>(arg0);
        let v1 = 0;
        let v2 = 0;
        while (v2 < v0) {
            let v3 = 0x1::vector::borrow<TradableFragment>(arg0, v2);
            assert!(v3.character_game_id == arg1, 1);
            assert!(v3.rarity == arg2, 2);
            v1 = v1 + v3.fragment_amount;
            v2 = v2 + 1;
        };
        (v1, v0)
    }

    public fun withdraw_fragment_royalties(arg0: &0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::CharacterAdminCap, arg1: &mut 0x2::transfer_policy::TransferPolicy<TradableFragment>, arg2: &0x2::transfer_policy::TransferPolicyCap<TradableFragment>, arg3: 0x1::option::Option<u64>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x2::transfer_policy::withdraw<TradableFragment>(arg1, arg2, arg3, arg4)
    }

    // decompiled from Move bytecode v6
}

