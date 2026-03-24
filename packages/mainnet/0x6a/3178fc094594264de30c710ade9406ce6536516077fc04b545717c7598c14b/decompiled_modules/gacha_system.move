module 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::gacha_system {
    struct UserGachaState has store, key {
        id: 0x2::object::UID,
        user: address,
        pulls_since_ssr_card: u16,
        pulls_since_sr_plus: u8,
        total_pulls: u64,
        last_pull_timestamp: u64,
        target_ssr_game_id: 0x1::option::Option<u64>,
        lifetime_ssr_cards: u64,
        lifetime_ssr_frags: u64,
        lifetime_sr_cards: u64,
        lifetime_sr_frags: u64,
        lifetime_r_cards: u64,
        total_alb_spent: u64,
    }

    struct GachaConfig has store, key {
        id: 0x2::object::UID,
        version: u64,
        gacha_enabled: bool,
        maintenance_mode: bool,
        emergency_pause: bool,
        featured_ssr_game_id: 0x1::option::Option<u64>,
        discount_mode: u8,
        discount_epoch: u64,
    }

    struct GachaStats has key {
        id: 0x2::object::UID,
        version: u64,
        total_ssr_cards_minted: u64,
        total_ssr_frags_minted: u64,
        total_sr_cards_minted: u64,
        total_sr_frags_minted: u64,
        total_r_cards_minted: u64,
        discount_used_epoch: 0x2::table::Table<address, u64>,
        last_pull_by_address: 0x2::table::Table<address, u64>,
    }

    struct GachaPullEvent has copy, drop {
        user: address,
        pull_number: u64,
        outcome_type: u8,
        game_id: u64,
        character_name: 0x1::string::String,
        rarity: u8,
        fragment_amount: u64,
        was_pity: bool,
        is_rate_up: bool,
        pulls_since_ssr: u16,
        timestamp: u64,
    }

    struct MultipullCompleted has copy, drop {
        user: address,
        pull_count: u8,
        ssr_cards: u8,
        ssr_frags: u8,
        sr_cards: u8,
        sr_frags: u8,
        r_cards: u8,
        total_cost: u64,
        timestamp: u64,
    }

    struct SSRPityTriggered has copy, drop {
        user: address,
        pulls_count: u16,
        timestamp: u64,
    }

    struct SRPityTriggered has copy, drop {
        user: address,
        pulls_count: u8,
        timestamp: u64,
    }

    struct GachaPullWithStablecoin has copy, drop {
        user: address,
        coin_type: 0x1::string::String,
        coin_amount: u64,
        pull_count: u8,
        timestamp: u64,
    }

    struct ReferralPurchaseEvent has copy, drop {
        user: address,
        coin_type: 0x1::string::String,
        coin_amount: u64,
        discount_amount: u64,
        timestamp: u64,
    }

    public fun advance_discount_epoch(arg0: &0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::CharacterAdminCap, arg1: &mut GachaConfig, arg2: &mut 0x2::tx_context::TxContext) {
        arg1.discount_epoch = arg1.discount_epoch + 1;
    }

    public fun can_use_discount(arg0: &GachaConfig, arg1: &GachaStats, arg2: address) : bool {
        if (arg0.discount_mode == 0) {
            return false
        };
        if (arg0.discount_mode == 2) {
            return true
        };
        0x2::table::contains<address, u64>(&arg1.discount_used_epoch, arg2) && *0x2::table::borrow<address, u64>(&arg1.discount_used_epoch, arg2) < arg0.discount_epoch || true
    }

    public fun can_user_pull(arg0: &GachaStats, arg1: address, arg2: u8, arg3: &0x2::clock::Clock) : bool {
        if (0x2::table::contains<address, u64>(&arg0.last_pull_by_address, arg1)) {
            let v1 = *0x2::table::borrow<address, u64>(&arg0.last_pull_by_address, arg1);
            if (v1 == 0) {
                return true
            };
            0x2::clock::timestamp_ms(arg3) >= v1 + 1000
        } else {
            true
        }
    }

    public fun clear_target_ssr(arg0: &mut UserGachaState, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.user == 0x2::tx_context::sender(arg1), 6);
        arg0.target_ssr_game_id = 0x1::option::none<u64>();
    }

    entry fun create_user_gacha_state(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = UserGachaState{
            id                   : 0x2::object::new(arg0),
            user                 : 0x2::tx_context::sender(arg0),
            pulls_since_ssr_card : 0,
            pulls_since_sr_plus  : 0,
            total_pulls          : 0,
            last_pull_timestamp  : 0,
            target_ssr_game_id   : 0x1::option::none<u64>(),
            lifetime_ssr_cards   : 0,
            lifetime_ssr_frags   : 0,
            lifetime_sr_cards    : 0,
            lifetime_sr_frags    : 0,
            lifetime_r_cards     : 0,
            total_alb_spent      : 0,
        };
        0x2::transfer::transfer<UserGachaState>(v0, 0x2::tx_context::sender(arg0));
    }

    fun determine_outcome_from_roll(arg0: u16) : u8 {
        if (arg0 <= 50) {
            1
        } else if (arg0 <= 200) {
            2
        } else if (arg0 <= 900) {
            3
        } else if (arg0 <= 1300) {
            4
        } else if (arg0 <= 2500) {
            5
        } else {
            6
        }
    }

    fun determine_outcome_with_pity_values(arg0: u16, arg1: u8, arg2: &0x2::random::Random, arg3: &mut 0x2::tx_context::TxContext) : (u8, bool) {
        if (arg0 >= 200 - 1) {
            return (1, true)
        };
        if (arg1 >= 10 - 1) {
            let v0 = 0x2::random::new_generator(arg2, arg3);
            let v1 = 0x2::random::generate_u16_in_range(&mut v0, 1, 2500);
            let v2 = if (v1 <= 50) {
                1
            } else if (v1 <= 200) {
                2
            } else if (v1 <= 900) {
                3
            } else if (v1 <= 1300) {
                4
            } else {
                5
            };
            return (v2, true)
        };
        let v3 = 0x2::random::new_generator(arg2, arg3);
        (determine_outcome_from_roll(0x2::random::generate_u16_in_range(&mut v3, 1, 10000)), false)
    }

    public fun emergency_pause(arg0: &0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::CharacterAdminCap, arg1: &mut GachaConfig, arg2: &mut 0x2::tx_context::TxContext) {
        arg1.emergency_pause = true;
    }

    public fun emergency_unpause(arg0: &0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::CharacterAdminCap, arg1: &mut GachaConfig, arg2: &mut 0x2::tx_context::TxContext) {
        arg1.emergency_pause = false;
    }

    fun execute_outcome(arg0: u8, arg1: 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::CharacterTemplate, arg2: u8, arg3: &GachaConfig, arg4: &mut 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::GlobalGameState, arg5: &mut 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::fragment_system::GlobalFragmentState, arg6: &0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::TemplateRegistry, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = if (arg0 == 1) {
            true
        } else if (arg0 == 4) {
            true
        } else {
            arg0 == 6
        };
        if (v0) {
            0x2::transfer::public_transfer<0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::character_system::Character>(0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::character_system::create_character_from_template(arg4, arg1, arg2, arg8), 0x2::tx_context::sender(arg8));
            0
        } else {
            let (v2, _, _) = 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::get_template_data(&arg1);
            let v5 = if (arg0 == 2) {
                20
            } else if (arg0 == 3) {
                5
            } else {
                30
            };
            0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::fragment_system::mint_gacha_fragments(arg5, arg6, v2, arg2, v5, 0x2::tx_context::sender(arg8), arg7, arg8);
            v5
        }
    }

    fun execute_single_pull(arg0: &mut UserGachaState, arg1: &GachaConfig, arg2: &mut GachaStats, arg3: &mut 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::GlobalGameState, arg4: &mut 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::fragment_system::GlobalFragmentState, arg5: &0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::TemplateRegistry, arg6: u64, arg7: &0x2::random::Random, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : u8 {
        let v0 = 0x2::tx_context::sender(arg9);
        let v1 = arg0.pulls_since_ssr_card;
        let v2 = arg0.pulls_since_sr_plus;
        let v3 = arg0.target_ssr_game_id;
        let (v4, v5) = determine_outcome_with_pity_values(v1, v2, arg7, arg9);
        let v6 = get_rarity_from_outcome(v4);
        let v7 = false;
        let v8 = v4 == 2 || v4 == 3;
        let v9 = if (0x1::option::is_some<u64>(&v3)) {
            v3
        } else if (0x1::option::is_some<u64>(&arg1.featured_ssr_game_id)) {
            arg1.featured_ssr_game_id
        } else if (v6 == 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::rarity_ssr()) {
            let v10 = 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::get_active_game_ids(arg5, 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::rarity_ssr());
            if (!0x1::vector::is_empty<u64>(&v10)) {
                0x1::option::some<u64>(*0x1::vector::borrow<u64>(&v10, 0))
            } else {
                0x1::option::none<u64>()
            }
        } else {
            0x1::option::none<u64>()
        };
        let v11 = v9;
        let v12 = if (v6 == 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::rarity_ssr() && 0x1::option::is_some<u64>(&v11)) {
            if (v8) {
                v7 = true;
                *0x1::option::borrow<u64>(&v11)
            } else {
                let v13 = 0x2::random::new_generator(arg7, arg9);
                if (0x2::random::generate_bool(&mut v13)) {
                    v7 = true;
                    *0x1::option::borrow<u64>(&v11)
                } else {
                    let v14 = 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::select_character_template_from_registry(arg5, v6, arg7, arg9);
                    let (v15, _, _) = 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::get_template_data(&v14);
                    v15
                }
            }
        } else {
            let v18 = 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::select_character_template_from_registry(arg5, v6, arg7, arg9);
            let (v19, _, _) = 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::get_template_data(&v18);
            v19
        };
        let v22 = 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::get_template_by_id(arg5, v12);
        let (_, v24, _) = 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::get_template_data(&v22);
        update_user_state_after_pull(arg0, v4, arg6, arg8);
        update_global_stats(arg2, v4);
        if (0x2::table::contains<address, u64>(&arg2.last_pull_by_address, v0)) {
            *0x2::table::borrow_mut<address, u64>(&mut arg2.last_pull_by_address, v0) = 0x2::clock::timestamp_ms(arg8);
        } else {
            0x2::table::add<address, u64>(&mut arg2.last_pull_by_address, v0, 0x2::clock::timestamp_ms(arg8));
        };
        let v26 = GachaPullEvent{
            user            : v0,
            pull_number     : arg0.total_pulls,
            outcome_type    : v4,
            game_id         : v12,
            character_name  : v24,
            rarity          : v6,
            fragment_amount : execute_outcome(v4, v22, v6, arg1, arg3, arg4, arg5, arg8, arg9),
            was_pity        : v5,
            is_rate_up      : v7,
            pulls_since_ssr : arg0.pulls_since_ssr_card,
            timestamp       : 0x2::clock::timestamp_ms(arg8),
        };
        0x2::event::emit<GachaPullEvent>(v26);
        if (v5) {
            if (v4 == 1 && v1 >= 200 - 1) {
                let v27 = SSRPityTriggered{
                    user        : v0,
                    pulls_count : v1 + 1,
                    timestamp   : 0x2::clock::timestamp_ms(arg8),
                };
                0x2::event::emit<SSRPityTriggered>(v27);
            } else {
                let v28 = SRPityTriggered{
                    user        : v0,
                    pulls_count : v2 + 1,
                    timestamp   : 0x2::clock::timestamp_ms(arg8),
                };
                0x2::event::emit<SRPityTriggered>(v28);
            };
        };
        v4
    }

    public fun gacha_config_version(arg0: &GachaConfig) : u64 {
        arg0.version
    }

    public fun gacha_stats_version(arg0: &GachaStats) : u64 {
        arg0.version
    }

    public fun get_discount_config(arg0: &GachaConfig) : (u8, u64) {
        (arg0.discount_mode, arg0.discount_epoch)
    }

    public fun get_featured_ssr(arg0: &GachaConfig) : 0x1::option::Option<u64> {
        arg0.featured_ssr_game_id
    }

    public fun get_global_stats(arg0: &GachaConfig, arg1: &GachaStats) : (u64, u64, u64, u64, u64, bool) {
        (arg1.total_ssr_cards_minted, arg1.total_ssr_frags_minted, arg1.total_sr_cards_minted, arg1.total_sr_frags_minted, arg1.total_r_cards_minted, arg0.emergency_pause)
    }

    public fun get_pity_progress(arg0: &UserGachaState) : (u16, u8, u16, u8) {
        (arg0.pulls_since_ssr_card, arg0.pulls_since_sr_plus, 200, 10)
    }

    fun get_rarity_from_outcome(arg0: u8) : u8 {
        let v0 = if (arg0 == 1) {
            true
        } else if (arg0 == 2) {
            true
        } else {
            arg0 == 3
        };
        if (v0) {
            0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::rarity_ssr()
        } else if (arg0 == 4 || arg0 == 5) {
            0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::rarity_sr()
        } else {
            0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::rarity_r()
        }
    }

    public fun get_user_pull_stats(arg0: &UserGachaState) : (u64, u16, u8, u64, u64, u64, u64, u64) {
        (arg0.total_pulls, arg0.pulls_since_ssr_card, arg0.pulls_since_sr_plus, arg0.lifetime_ssr_cards, arg0.lifetime_ssr_frags, arg0.lifetime_sr_cards, arg0.lifetime_sr_frags, arg0.lifetime_r_cards)
    }

    public fun get_user_target_ssr(arg0: &UserGachaState) : 0x1::option::Option<u64> {
        arg0.target_ssr_game_id
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GachaConfig{
            id                   : 0x2::object::new(arg0),
            version              : 1,
            gacha_enabled        : true,
            maintenance_mode     : false,
            emergency_pause      : false,
            featured_ssr_game_id : 0x1::option::none<u64>(),
            discount_mode        : 1,
            discount_epoch       : 1,
        };
        let v1 = GachaStats{
            id                     : 0x2::object::new(arg0),
            version                : 1,
            total_ssr_cards_minted : 0,
            total_ssr_frags_minted : 0,
            total_sr_cards_minted  : 0,
            total_sr_frags_minted  : 0,
            total_r_cards_minted   : 0,
            discount_used_epoch    : 0x2::table::new<address, u64>(arg0),
            last_pull_by_address   : 0x2::table::new<address, u64>(arg0),
        };
        0x2::transfer::share_object<GachaConfig>(v0);
        0x2::transfer::share_object<GachaStats>(v1);
    }

    public fun migrate_gacha_config(arg0: &0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::CharacterAdminCap, arg1: &mut GachaConfig) {
        assert!(arg1.version < 1, 11);
        arg1.version = 1;
    }

    public fun migrate_gacha_stats(arg0: &0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::CharacterAdminCap, arg1: &mut GachaStats) {
        assert!(arg1.version < 1, 11);
        arg1.version = 1;
    }

    entry fun pull_unified_single_with_alb(arg0: &mut UserGachaState, arg1: &GachaConfig, arg2: &mut GachaStats, arg3: &mut 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::GlobalGameState, arg4: &mut 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::fragment_system::GlobalFragmentState, arg5: &0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::TemplateRegistry, arg6: &mut 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::alb_token::TokenTreasury, arg7: &mut 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::alb_token::GlobalTokenStates, arg8: 0x2::coin::Coin<0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::alb_token::ALB_TOKEN>, arg9: &0x2::random::Random, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.user == 0x2::tx_context::sender(arg11), 6);
        assert!(!arg1.emergency_pause && arg1.gacha_enabled, 3);
        0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::alb_token::assert_twap_fresh(arg6, arg10);
        let v0 = 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::alb_token::get_gacha_costs_alb(arg6);
        assert!(0x2::coin::value<0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::alb_token::ALB_TOKEN>(&arg8) >= v0, 0);
        verify_pull_limits(arg2, 0x2::tx_context::sender(arg11), 1, arg10);
        if (0x2::coin::value<0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::alb_token::ALB_TOKEN>(&arg8) > v0) {
            0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::alb_token::process_gacha_payment(arg6, arg7, 0x2::coin::split<0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::alb_token::ALB_TOKEN>(&mut arg8, v0, arg11), 0x2::tx_context::sender(arg11), 1, arg11);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::alb_token::ALB_TOKEN>>(arg8, 0x2::tx_context::sender(arg11));
        } else {
            0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::alb_token::process_gacha_payment(arg6, arg7, arg8, 0x2::tx_context::sender(arg11), 1, arg11);
        };
        execute_single_pull(arg0, arg1, arg2, arg3, arg4, arg5, v0, arg9, arg10, arg11);
    }

    entry fun pull_unified_single_with_stable<T0>(arg0: &mut UserGachaState, arg1: &GachaConfig, arg2: &mut GachaStats, arg3: &mut 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::GlobalGameState, arg4: &mut 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::fragment_system::GlobalFragmentState, arg5: &0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::TemplateRegistry, arg6: &mut 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::alb_token::TokenTreasury, arg7: 0x2::coin::Coin<T0>, arg8: &0x2::random::Random, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.user == 0x2::tx_context::sender(arg10), 6);
        assert!(!arg1.emergency_pause && arg1.gacha_enabled, 3);
        assert!(0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::alb_token::is_stablecoin_accepted<T0>(arg6), 5);
        assert!(0x2::coin::value<T0>(&arg7) >= 9900000, 0);
        verify_pull_limits(arg2, 0x2::tx_context::sender(arg10), 1, arg9);
        if (0x2::coin::value<T0>(&arg7) > 9900000) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg7, 9900000, arg10), 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::alb_token::get_stablecoin_recipient(arg6));
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg7, 0x2::tx_context::sender(arg10));
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg7, 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::alb_token::get_stablecoin_recipient(arg6));
        };
        let v0 = GachaPullWithStablecoin{
            user        : 0x2::tx_context::sender(arg10),
            coin_type   : 0x1::string::utf8(b"Stablecoin"),
            coin_amount : 9900000,
            pull_count  : 1,
            timestamp   : 0x2::clock::timestamp_ms(arg9),
        };
        0x2::event::emit<GachaPullWithStablecoin>(v0);
        execute_single_pull(arg0, arg1, arg2, arg3, arg4, arg5, 9900000, arg8, arg9, arg10);
    }

    entry fun pull_unified_ten_with_alb(arg0: &mut UserGachaState, arg1: &GachaConfig, arg2: &mut GachaStats, arg3: &mut 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::GlobalGameState, arg4: &mut 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::fragment_system::GlobalFragmentState, arg5: &0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::TemplateRegistry, arg6: &mut 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::alb_token::TokenTreasury, arg7: &mut 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::alb_token::GlobalTokenStates, arg8: 0x2::coin::Coin<0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::alb_token::ALB_TOKEN>, arg9: &0x2::random::Random, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.user == 0x2::tx_context::sender(arg11), 6);
        assert!(!arg1.emergency_pause && arg1.gacha_enabled, 3);
        0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::alb_token::assert_twap_fresh(arg6, arg10);
        let v0 = 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::alb_token::get_gacha_costs_alb(arg6);
        let v1 = v0 * 10;
        assert!(0x2::coin::value<0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::alb_token::ALB_TOKEN>(&arg8) >= v1, 0);
        verify_pull_limits(arg2, 0x2::tx_context::sender(arg11), 10, arg10);
        if (0x2::coin::value<0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::alb_token::ALB_TOKEN>(&arg8) > v1) {
            0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::alb_token::process_gacha_payment(arg6, arg7, 0x2::coin::split<0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::alb_token::ALB_TOKEN>(&mut arg8, v1, arg11), 0x2::tx_context::sender(arg11), 10, arg11);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::alb_token::ALB_TOKEN>>(arg8, 0x2::tx_context::sender(arg11));
        } else {
            0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::alb_token::process_gacha_payment(arg6, arg7, arg8, 0x2::tx_context::sender(arg11), 10, arg11);
        };
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        let v5 = 0;
        let v6 = 0;
        let v7 = 0;
        while (v7 < 10) {
            let v8 = execute_single_pull(arg0, arg1, arg2, arg3, arg4, arg5, v0, arg9, arg10, arg11);
            if (v8 == 1) {
                v2 = v2 + 1;
            } else if (v8 == 2 || v8 == 3) {
                v3 = v3 + 1;
            } else if (v8 == 4) {
                v4 = v4 + 1;
            } else if (v8 == 5) {
                v5 = v5 + 1;
            } else {
                v6 = v6 + 1;
            };
            v7 = v7 + 1;
        };
        let v9 = MultipullCompleted{
            user       : 0x2::tx_context::sender(arg11),
            pull_count : 10,
            ssr_cards  : v2,
            ssr_frags  : v3,
            sr_cards   : v4,
            sr_frags   : v5,
            r_cards    : v6,
            total_cost : v1,
            timestamp  : 0x2::clock::timestamp_ms(arg10),
        };
        0x2::event::emit<MultipullCompleted>(v9);
    }

    entry fun pull_unified_ten_with_stable<T0>(arg0: &mut UserGachaState, arg1: &GachaConfig, arg2: &mut GachaStats, arg3: &mut 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::GlobalGameState, arg4: &mut 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::fragment_system::GlobalFragmentState, arg5: &0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::TemplateRegistry, arg6: &mut 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::alb_token::TokenTreasury, arg7: 0x2::coin::Coin<T0>, arg8: &0x2::random::Random, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.user == 0x2::tx_context::sender(arg10), 6);
        assert!(!arg1.emergency_pause && arg1.gacha_enabled, 3);
        assert!(0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::alb_token::is_stablecoin_accepted<T0>(arg6), 5);
        assert!(0x2::coin::value<T0>(&arg7) >= 99000000, 0);
        verify_pull_limits(arg2, 0x2::tx_context::sender(arg10), 10, arg9);
        if (0x2::coin::value<T0>(&arg7) > 99000000) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg7, 99000000, arg10), 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::alb_token::get_stablecoin_recipient(arg6));
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg7, 0x2::tx_context::sender(arg10));
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg7, 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::alb_token::get_stablecoin_recipient(arg6));
        };
        let v0 = GachaPullWithStablecoin{
            user        : 0x2::tx_context::sender(arg10),
            coin_type   : 0x1::string::utf8(b"Stablecoin"),
            coin_amount : 99000000,
            pull_count  : 10,
            timestamp   : 0x2::clock::timestamp_ms(arg9),
        };
        0x2::event::emit<GachaPullWithStablecoin>(v0);
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        let v5 = 0;
        let v6 = 0;
        while (v6 < 10) {
            let v7 = execute_single_pull(arg0, arg1, arg2, arg3, arg4, arg5, 99000000 / 10, arg8, arg9, arg10);
            if (v7 == 1) {
                v1 = v1 + 1;
            } else if (v7 == 2 || v7 == 3) {
                v2 = v2 + 1;
            } else if (v7 == 4) {
                v3 = v3 + 1;
            } else if (v7 == 5) {
                v4 = v4 + 1;
            } else {
                v5 = v5 + 1;
            };
            v6 = v6 + 1;
        };
        let v8 = MultipullCompleted{
            user       : 0x2::tx_context::sender(arg10),
            pull_count : 10,
            ssr_cards  : v1,
            ssr_frags  : v2,
            sr_cards   : v3,
            sr_frags   : v4,
            r_cards    : v5,
            total_cost : 99000000,
            timestamp  : 0x2::clock::timestamp_ms(arg9),
        };
        0x2::event::emit<MultipullCompleted>(v8);
    }

    entry fun pull_unified_ten_with_stable_referral<T0>(arg0: &mut UserGachaState, arg1: &GachaConfig, arg2: &mut GachaStats, arg3: &mut 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::GlobalGameState, arg4: &mut 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::fragment_system::GlobalFragmentState, arg5: &0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::TemplateRegistry, arg6: &mut 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::alb_token::TokenTreasury, arg7: 0x2::coin::Coin<T0>, arg8: &0x2::random::Random, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.user == 0x2::tx_context::sender(arg10), 6);
        assert!(!arg1.emergency_pause && arg1.gacha_enabled, 3);
        assert!(0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::alb_token::is_stablecoin_accepted<T0>(arg6), 5);
        assert!(arg1.discount_mode != 0, 7);
        if (arg1.discount_mode == 1) {
            let v0 = 0x2::tx_context::sender(arg10);
            let v1 = 0x2::table::contains<address, u64>(&arg2.discount_used_epoch, v0) && *0x2::table::borrow<address, u64>(&arg2.discount_used_epoch, v0) >= arg1.discount_epoch;
            assert!(!v1, 8);
            if (0x2::table::contains<address, u64>(&arg2.discount_used_epoch, v0)) {
                *0x2::table::borrow_mut<address, u64>(&mut arg2.discount_used_epoch, v0) = arg1.discount_epoch;
            } else {
                0x2::table::add<address, u64>(&mut arg2.discount_used_epoch, v0, arg1.discount_epoch);
            };
        };
        verify_pull_limits(arg2, 0x2::tx_context::sender(arg10), 10, arg9);
        assert!(0x2::coin::value<T0>(&arg7) >= 89100000, 0);
        if (0x2::coin::value<T0>(&arg7) > 89100000) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg7, 89100000, arg10), 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::alb_token::get_stablecoin_recipient(arg6));
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg7, 0x2::tx_context::sender(arg10));
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg7, 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::alb_token::get_stablecoin_recipient(arg6));
        };
        let v2 = ReferralPurchaseEvent{
            user            : 0x2::tx_context::sender(arg10),
            coin_type       : 0x1::string::utf8(b"Stablecoin"),
            coin_amount     : 89100000,
            discount_amount : 99000000 - 89100000,
            timestamp       : 0x2::clock::timestamp_ms(arg9),
        };
        0x2::event::emit<ReferralPurchaseEvent>(v2);
        let v3 = GachaPullWithStablecoin{
            user        : 0x2::tx_context::sender(arg10),
            coin_type   : 0x1::string::utf8(b"Stablecoin"),
            coin_amount : 89100000,
            pull_count  : 10,
            timestamp   : 0x2::clock::timestamp_ms(arg9),
        };
        0x2::event::emit<GachaPullWithStablecoin>(v3);
        let v4 = 0;
        let v5 = 0;
        let v6 = 0;
        let v7 = 0;
        let v8 = 0;
        let v9 = 0;
        while (v9 < 10) {
            let v10 = execute_single_pull(arg0, arg1, arg2, arg3, arg4, arg5, 89100000 / 10, arg8, arg9, arg10);
            if (v10 == 1) {
                v4 = v4 + 1;
            } else if (v10 == 2 || v10 == 3) {
                v5 = v5 + 1;
            } else if (v10 == 4) {
                v6 = v6 + 1;
            } else if (v10 == 5) {
                v7 = v7 + 1;
            } else {
                v8 = v8 + 1;
            };
            v9 = v9 + 1;
        };
        let v11 = MultipullCompleted{
            user       : 0x2::tx_context::sender(arg10),
            pull_count : 10,
            ssr_cards  : v4,
            ssr_frags  : v5,
            sr_cards   : v6,
            sr_frags   : v7,
            r_cards    : v8,
            total_cost : 89100000,
            timestamp  : 0x2::clock::timestamp_ms(arg9),
        };
        0x2::event::emit<MultipullCompleted>(v11);
    }

    public fun set_discount_mode(arg0: &0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::CharacterAdminCap, arg1: &mut GachaConfig, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 <= 2, 9);
        arg1.discount_mode = arg2;
    }

    public fun set_featured_ssr(arg0: &0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::CharacterAdminCap, arg1: &mut GachaConfig, arg2: &0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::TemplateRegistry, arg3: 0x1::option::Option<u64>, arg4: &mut 0x2::tx_context::TxContext) {
        if (0x1::option::is_some<u64>(&arg3)) {
            assert!(0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::template_exists(arg2, *0x1::option::borrow<u64>(&arg3), 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::rarity_ssr()), 4);
        };
        arg1.featured_ssr_game_id = arg3;
    }

    public fun set_target_ssr(arg0: &mut UserGachaState, arg1: &0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::TemplateRegistry, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.user == 0x2::tx_context::sender(arg3), 6);
        assert!(0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::template_exists(arg1, arg2, 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::rarity_ssr()), 4);
        arg0.target_ssr_game_id = 0x1::option::some<u64>(arg2);
    }

    public fun toggle_gacha_system(arg0: &0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::CharacterAdminCap, arg1: &mut GachaConfig, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.gacha_enabled = arg2;
    }

    fun update_global_stats(arg0: &mut GachaStats, arg1: u8) {
        if (arg1 == 1) {
            arg0.total_ssr_cards_minted = arg0.total_ssr_cards_minted + 1;
        } else if (arg1 == 2 || arg1 == 3) {
            arg0.total_ssr_frags_minted = arg0.total_ssr_frags_minted + 1;
        } else if (arg1 == 4) {
            arg0.total_sr_cards_minted = arg0.total_sr_cards_minted + 1;
        } else if (arg1 == 5) {
            arg0.total_sr_frags_minted = arg0.total_sr_frags_minted + 1;
        } else {
            arg0.total_r_cards_minted = arg0.total_r_cards_minted + 1;
        };
    }

    fun update_user_state_after_pull(arg0: &mut UserGachaState, arg1: u8, arg2: u64, arg3: &0x2::clock::Clock) {
        if (arg1 == 1) {
            arg0.pulls_since_ssr_card = 0;
        } else {
            arg0.pulls_since_ssr_card = arg0.pulls_since_ssr_card + 1;
        };
        if (arg1 != 6) {
            arg0.pulls_since_sr_plus = 0;
        } else {
            arg0.pulls_since_sr_plus = arg0.pulls_since_sr_plus + 1;
        };
        if (arg1 == 1) {
            arg0.lifetime_ssr_cards = arg0.lifetime_ssr_cards + 1;
        } else if (arg1 == 2 || arg1 == 3) {
            arg0.lifetime_ssr_frags = arg0.lifetime_ssr_frags + 1;
        } else if (arg1 == 4) {
            arg0.lifetime_sr_cards = arg0.lifetime_sr_cards + 1;
        } else if (arg1 == 5) {
            arg0.lifetime_sr_frags = arg0.lifetime_sr_frags + 1;
        } else {
            arg0.lifetime_r_cards = arg0.lifetime_r_cards + 1;
        };
        arg0.total_pulls = arg0.total_pulls + 1;
        arg0.last_pull_timestamp = 0x2::clock::timestamp_ms(arg3);
        arg0.total_alb_spent = arg0.total_alb_spent + arg2;
    }

    fun verify_pull_limits(arg0: &GachaStats, arg1: address, arg2: u8, arg3: &0x2::clock::Clock) {
        assert!(arg2 <= (10 as u8), 1);
        if (0x2::table::contains<address, u64>(&arg0.last_pull_by_address, arg1)) {
            let v0 = *0x2::table::borrow<address, u64>(&arg0.last_pull_by_address, arg1);
            if (v0 > 0) {
                assert!(0x2::clock::timestamp_ms(arg3) >= v0 + 1000, 2);
            };
        };
    }

    // decompiled from Move bytecode v6
}

