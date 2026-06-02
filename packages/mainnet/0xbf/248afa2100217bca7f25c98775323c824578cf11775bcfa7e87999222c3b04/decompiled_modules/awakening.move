module 0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::awakening {
    struct AWAKENING has drop {
        dummy_field: bool,
    }

    struct AwakeningConfig has key {
        id: 0x2::object::UID,
        version: u64,
        crown_price_sr: u64,
        crown_price_ssr: u64,
        crown_monthly_limit_sr: u64,
        crown_monthly_limit_ssr: u64,
        awaken_alb_cost: u64,
        is_paused: bool,
    }

    struct CrownCounters has store {
        crown_sr_month: u64,
        crown_ssr_month: u64,
        current_month: u64,
    }

    struct CrownRegistry has key {
        id: 0x2::object::UID,
        version: u64,
        counters: 0x2::table::Table<address, CrownCounters>,
    }

    struct AwakenedCrown has key {
        id: 0x2::object::UID,
        wallet: address,
        rarity: u8,
    }

    struct AwakenedCharacterMinted has copy, drop {
        wallet: address,
        source_game_id: u64,
        awakened_game_id: u64,
        star_rating: u8,
        timestamp_ms: u64,
    }

    struct AwakenedCrownMinted has copy, drop {
        wallet: address,
        rarity: u8,
        crystals_spent: u64,
        timestamp_ms: u64,
    }

    struct AwakenedStarUpEvent has copy, drop {
        wallet: address,
        awakened_game_id: u64,
        old_star: u8,
        new_star: u8,
        method: u8,
        timestamp_ms: u64,
    }

    fun assert_config_version(arg0: &AwakeningConfig) {
        assert!(arg0.version == 1, 13);
    }

    fun assert_registry_version(arg0: &CrownRegistry) {
        assert!(arg0.version == 1, 13);
    }

    public fun awaken_r_to_sr(arg0: 0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::character_system::Character, arg1: &AwakeningConfig, arg2: &mut 0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::game_core::GlobalGameState, arg3: &mut 0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::alb_token::TokenTreasury, arg4: 0x2::coin::Coin<0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::alb_token::ALB_TOKEN>, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert_config_version(arg1);
        assert!(!arg1.is_paused, 1);
        assert!(0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::character_system::get_character_rarity(&arg0) == 0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::game_core::rarity_r(), 2);
        assert!(0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::character_system::get_star_rating(&arg0) == 0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::character_system::max_star_rating(), 3);
        assert!(!0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::character_system::get_is_awakened(&arg0), 4);
        let v0 = 0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::character_system::get_game_id(&arg0);
        handle_alb_payment(arg3, arg4, arg1.awaken_alb_cost, arg7);
        let (_, _) = 0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::character_system::burn_character(arg0, arg7);
        let v3 = v0 + 10000;
        let v4 = 0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::character_system::create_awakened_character(arg2, v3, 0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::character_system::get_character_name(&arg0), arg5, 0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::game_core::rarity_sr(), arg7);
        let v5 = 0x2::tx_context::sender(arg7);
        let v6 = AwakenedCharacterMinted{
            wallet           : v5,
            source_game_id   : v0,
            awakened_game_id : v3,
            star_rating      : 0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::character_system::get_star_rating(&v4),
            timestamp_ms     : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::event::emit<AwakenedCharacterMinted>(v6);
        0x2::transfer::public_transfer<0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::character_system::Character>(v4, v5);
    }

    public fun awakened_star_up_with_crown(arg0: &mut 0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::character_system::GlobalCharacterUpgradeState, arg1: &mut 0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::character_system::Character, arg2: AwakenedCrown, arg3: &mut 0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::alb_token::TokenTreasury, arg4: 0x2::coin::Coin<0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::alb_token::ALB_TOKEN>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::character_system::get_is_awakened(arg1), 9);
        assert!(0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::character_system::get_star_rating(arg1) == 0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::character_system::max_star_rating() - 1, 12);
        assert!(arg2.wallet == 0x2::tx_context::sender(arg5), 6);
        assert!(arg2.rarity == 0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::character_system::get_character_rarity(arg1), 11);
        handle_alb_payment(arg3, arg4, 0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::character_system::get_star_up_cost_crown(arg0), arg5);
        let v0 = 0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::character_system::get_game_id(arg1);
        0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::character_system::check_and_increment_5star_cap(arg0, v0, 0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::character_system::get_character_rarity(arg1));
        let AwakenedCrown {
            id     : v1,
            wallet : _,
            rarity : _,
        } = arg2;
        0x2::object::delete(v1);
        0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::character_system::upgrade_star_for_awakened_crown(arg1);
        let v4 = AwakenedStarUpEvent{
            wallet           : 0x2::tx_context::sender(arg5),
            awakened_game_id : v0,
            old_star         : 0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::character_system::get_star_rating(arg1),
            new_star         : 0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::character_system::get_star_rating(arg1),
            method           : 2,
            timestamp_ms     : 0x2::tx_context::epoch_timestamp_ms(arg5),
        };
        0x2::event::emit<AwakenedStarUpEvent>(v4);
    }

    public fun awakened_star_up_with_duplicate(arg0: &0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::character_system::GlobalCharacterUpgradeState, arg1: &mut 0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::character_system::Character, arg2: 0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::character_system::Character, arg3: &mut 0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::alb_token::TokenTreasury, arg4: 0x2::coin::Coin<0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::alb_token::ALB_TOKEN>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::character_system::get_is_awakened(arg1), 9);
        assert!(0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::character_system::get_is_awakened(&arg2), 9);
        assert!(0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::character_system::get_game_id(arg1) == 0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::character_system::get_game_id(&arg2), 10);
        handle_alb_payment(arg3, arg4, 0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::character_system::get_star_up_cost_duplicate(arg0), arg5);
        0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::character_system::burn_awakened_for_star_up(arg2, arg5);
        let (v0, v1) = 0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::character_system::upgrade_star_for_awakened_duplicate(arg1);
        let v2 = AwakenedStarUpEvent{
            wallet           : 0x2::tx_context::sender(arg5),
            awakened_game_id : 0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::character_system::get_game_id(arg1),
            old_star         : v0,
            new_star         : v1,
            method           : 1,
            timestamp_ms     : 0x2::tx_context::epoch_timestamp_ms(arg5),
        };
        0x2::event::emit<AwakenedStarUpEvent>(v2);
    }

    public fun awakening_config_version(arg0: &AwakeningConfig) : u64 {
        arg0.version
    }

    public fun crown_registry_version(arg0: &CrownRegistry) : u64 {
        arg0.version
    }

    public fun get_awaken_alb_cost(arg0: &AwakeningConfig) : u64 {
        arg0.awaken_alb_cost
    }

    public fun get_crown_monthly_limit(arg0: &AwakeningConfig, arg1: u8) : u64 {
        if (arg1 == 0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::game_core::rarity_sr()) {
            arg0.crown_monthly_limit_sr
        } else {
            arg0.crown_monthly_limit_ssr
        }
    }

    public fun get_crown_price(arg0: &AwakeningConfig, arg1: u8) : u64 {
        if (arg1 == 0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::game_core::rarity_sr()) {
            arg0.crown_price_sr
        } else {
            arg0.crown_price_ssr
        }
    }

    fun handle_alb_payment(arg0: &mut 0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::alb_token::TokenTreasury, arg1: 0x2::coin::Coin<0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::alb_token::ALB_TOKEN>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        if (arg2 == 0) {
            0x2::coin::destroy_zero<0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::alb_token::ALB_TOKEN>(arg1);
        } else {
            assert!(0x2::coin::value<0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::alb_token::ALB_TOKEN>(&arg1) >= arg2, 5);
            0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::alb_token::route_alb_tax(arg0, arg1, arg3);
        };
    }

    fun init(arg0: AWAKENING, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AwakeningConfig{
            id                      : 0x2::object::new(arg1),
            version                 : 1,
            crown_price_sr          : 500,
            crown_price_ssr         : 500,
            crown_monthly_limit_sr  : 2,
            crown_monthly_limit_ssr : 1,
            awaken_alb_cost         : 50000000000,
            is_paused               : false,
        };
        0x2::transfer::share_object<AwakeningConfig>(v0);
        let v1 = CrownRegistry{
            id       : 0x2::object::new(arg1),
            version  : 1,
            counters : 0x2::table::new<address, CrownCounters>(arg1),
        };
        0x2::transfer::share_object<CrownRegistry>(v1);
    }

    fun maybe_reset_monthly(arg0: &mut CrownCounters, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg1) / 1000 / 86400;
        let v1 = v0 % 365 / 30 + 1;
        let v2 = if (v1 > 12) {
            12
        } else {
            v1
        };
        let v3 = (1970 + v0 / 365) * 100 + v2;
        if (v3 != arg0.current_month) {
            arg0.crown_sr_month = 0;
            arg0.crown_ssr_month = 0;
            arg0.current_month = v3;
        };
    }

    public fun migrate_awakening_config(arg0: &0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::game_core::CharacterAdminCap, arg1: &mut AwakeningConfig) {
        assert!(arg1.version < 1, 14);
        arg1.version = 1;
    }

    public fun migrate_crown_registry(arg0: &0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::game_core::CharacterAdminCap, arg1: &mut CrownRegistry) {
        assert!(arg1.version < 1, 14);
        arg1.version = 1;
    }

    public fun pause_awakening(arg0: &0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::game_core::CharacterAdminCap, arg1: &mut AwakeningConfig) {
        assert_config_version(arg1);
        arg1.is_paused = true;
    }

    public fun purchase_awakened_crown(arg0: &mut 0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::furnace_system::CrystalBalance, arg1: &AwakeningConfig, arg2: &mut CrownRegistry, arg3: u8, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_config_version(arg1);
        assert_registry_version(arg2);
        assert!(!arg1.is_paused, 1);
        assert!(0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::furnace_system::crystal_balance_owner(arg0) == 0x2::tx_context::sender(arg5), 6);
        assert!(arg3 == 0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::game_core::rarity_sr() || arg3 == 0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::game_core::rarity_ssr(), 8);
        let v0 = 0x2::tx_context::sender(arg5);
        if (!0x2::table::contains<address, CrownCounters>(&arg2.counters, v0)) {
            let v1 = CrownCounters{
                crown_sr_month  : 0,
                crown_ssr_month : 0,
                current_month   : 0,
            };
            0x2::table::add<address, CrownCounters>(&mut arg2.counters, v0, v1);
        };
        let v2 = 0x2::table::borrow_mut<address, CrownCounters>(&mut arg2.counters, v0);
        maybe_reset_monthly(v2, arg4);
        let (v3, v4, v5) = if (arg3 == 0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::game_core::rarity_sr()) {
            (v2.crown_sr_month, arg1.crown_monthly_limit_sr, arg1.crown_price_sr)
        } else {
            (v2.crown_ssr_month, arg1.crown_monthly_limit_ssr, arg1.crown_price_ssr)
        };
        assert!(v3 < v4, 7);
        0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::furnace_system::spend_crystals(arg0, v5);
        if (arg3 == 0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::game_core::rarity_sr()) {
            v2.crown_sr_month = v2.crown_sr_month + 1;
        } else {
            v2.crown_ssr_month = v2.crown_ssr_month + 1;
        };
        let v6 = AwakenedCrown{
            id     : 0x2::object::new(arg5),
            wallet : v0,
            rarity : arg3,
        };
        let v7 = AwakenedCrownMinted{
            wallet         : v0,
            rarity         : arg3,
            crystals_spent : v5,
            timestamp_ms   : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<AwakenedCrownMinted>(v7);
        0x2::transfer::transfer<AwakenedCrown>(v6, v0);
    }

    public fun set_awakening_config(arg0: &0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::game_core::CharacterAdminCap, arg1: &mut AwakeningConfig, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        assert_config_version(arg1);
        arg1.crown_price_sr = arg2;
        arg1.crown_price_ssr = arg3;
        arg1.crown_monthly_limit_sr = arg4;
        arg1.crown_monthly_limit_ssr = arg5;
        arg1.awaken_alb_cost = arg6;
    }

    public fun unpause_awakening(arg0: &0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::game_core::CharacterAdminCap, arg1: &mut AwakeningConfig) {
        assert_config_version(arg1);
        arg1.is_paused = false;
    }

    // decompiled from Move bytecode v6
}

