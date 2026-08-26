module 0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::gacha_system {
    struct UserGachaState has key {
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
        total_spent: u64,
    }

    struct GachaConfig has key {
        id: 0x2::object::UID,
        version: u64,
        gacha_enabled: bool,
        emergency_pause: bool,
        featured_ssr_game_id: 0x1::option::Option<u64>,
        discount_mode: u8,
        discount_epoch: u64,
        ssr_up_numerator: u64,
        pull_reward_enabled: bool,
        ten_pull_alb_reward: u64,
        first_ten_pull_bonus: u64,
        single_pull_cents: u64,
        discount_bps: u64,
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
        first_ten_pull_bonus_claimed: 0x2::table::Table<address, bool>,
    }

    struct WhitelistVoucher has key {
        id: 0x2::object::UID,
        owner: address,
        pulls_granted: u8,
    }

    struct VoucherPullEvent has copy, drop {
        user: address,
        voucher_id: 0x2::object::ID,
        pulls_granted: u8,
        timestamp: u64,
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

    struct TenPullRewardMinted has copy, drop {
        user: address,
        base_reward: u64,
        bonus_reward: u64,
        total_reward: u64,
        is_first_ten_pull: bool,
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

    struct GachaPricingUpdated has copy, drop {
        single_pull_cents: u64,
        discount_bps: u64,
        timestamp_ms: u64,
    }

    struct GachaRevenueSplit has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        gross: u64,
        edition_cut: u64,
        ops_amount: u64,
        ops_recipient: address,
        team_amount: u64,
        team_recipient: address,
        reserve_amount: u64,
        reserve_recipient: address,
        sender: address,
    }

    public fun advance_discount_epoch(arg0: &0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::game_core::CharacterAdminCap, arg1: &mut GachaConfig, arg2: &mut 0x2::tx_context::TxContext) {
        assert_config_version(arg1);
        arg1.discount_epoch = arg1.discount_epoch + 1;
    }

    fun assert_config_version(arg0: &GachaConfig) {
        assert!(arg0.version == 1, 10);
    }

    fun assert_stats_version(arg0: &GachaStats) {
        assert!(arg0.version == 1, 10);
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
            total_spent          : 0,
        };
        0x2::transfer::transfer<UserGachaState>(v0, 0x2::tx_context::sender(arg0));
    }

    fun derive_referral_price(arg0: &GachaConfig) : u64 {
        derive_ten_price(arg0) * (10000 - arg0.discount_bps) / 10000
    }

    fun derive_single_price(arg0: &GachaConfig) : u64 {
        arg0.single_pull_cents * 10000
    }

    fun derive_ten_price(arg0: &GachaConfig) : u64 {
        derive_single_price(arg0) * 10
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
            let v1 = if (0x2::random::generate_u16_in_range(&mut v0, 1, 1600) <= 400) {
                4
            } else {
                5
            };
            return (v1, true)
        };
        let v2 = 0x2::random::new_generator(arg2, arg3);
        (determine_outcome_from_roll(0x2::random::generate_u16_in_range(&mut v2, 1, 10000)), false)
    }

    public fun discount_bps(arg0: &GachaConfig) : u64 {
        arg0.discount_bps
    }

    fun distribute_stable_revenue<T0>(arg0: &mut 0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::edition::EditionVault, arg1: 0x2::coin::Coin<T0>, arg2: address, arg3: address, arg4: address, arg5: u64, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(arg5 >= 0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::edition::share_bps(), 27);
        0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::edition::accrue<T0>(arg0, &mut arg1, arg8);
        let v1 = v0 * arg6 / 10000;
        let v2 = v0 * arg7 / 10000;
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg1, v1, arg8), arg3);
        };
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg1, v2, arg8), arg4);
        };
        let v3 = 0x2::coin::value<T0>(&arg1);
        if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, arg2);
        } else {
            0x2::coin::destroy_zero<T0>(arg1);
        };
        let v4 = GachaRevenueSplit{
            coin_type         : 0x1::type_name::with_original_ids<T0>(),
            gross             : v0,
            edition_cut       : v0 - 0x2::coin::value<T0>(&arg1),
            ops_amount        : v3,
            ops_recipient     : arg2,
            team_amount       : v1,
            team_recipient    : arg3,
            reserve_amount    : v2,
            reserve_recipient : arg4,
            sender            : 0x2::tx_context::sender(arg8),
        };
        0x2::event::emit<GachaRevenueSplit>(v4);
    }

    public fun emergency_pause(arg0: &0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::game_core::CharacterAdminCap, arg1: &mut GachaConfig, arg2: &mut 0x2::tx_context::TxContext) {
        assert_config_version(arg1);
        arg1.emergency_pause = true;
    }

    public fun emergency_unpause(arg0: &0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::game_core::CharacterAdminCap, arg1: &mut GachaConfig, arg2: &mut 0x2::tx_context::TxContext) {
        assert_config_version(arg1);
        arg1.emergency_pause = false;
    }

    fun execute_outcome(arg0: u8, arg1: 0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::game_core::CharacterTemplate, arg2: u8, arg3: &GachaConfig, arg4: &mut 0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::game_core::GlobalGameState, arg5: &mut 0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::fragment_system::GlobalFragmentState, arg6: &0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::game_core::TemplateRegistry, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = if (arg0 == 1) {
            true
        } else if (arg0 == 4) {
            true
        } else {
            arg0 == 6
        };
        if (v0) {
            0x2::transfer::public_transfer<0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::character_system::Character>(0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::character_system::create_character_from_template(arg4, arg1, arg2, arg8), 0x2::tx_context::sender(arg8));
            0
        } else {
            let (v2, _, _) = 0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::game_core::get_template_data(&arg1);
            let v5 = if (arg0 == 2) {
                20
            } else if (arg0 == 3) {
                5
            } else {
                20
            };
            0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::fragment_system::mint_gacha_fragments(arg5, arg6, v2, arg2, v5, 0x2::tx_context::sender(arg8), arg7, arg8);
            v5
        }
    }

    fun execute_single_pull(arg0: &mut UserGachaState, arg1: &GachaConfig, arg2: &mut GachaStats, arg3: &mut 0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::game_core::GlobalGameState, arg4: &mut 0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::fragment_system::GlobalFragmentState, arg5: &0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::game_core::TemplateRegistry, arg6: u64, arg7: &0x2::random::Random, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : u8 {
        let v0 = 0x2::tx_context::sender(arg9);
        let v1 = arg0.pulls_since_ssr_card;
        let v2 = arg0.pulls_since_sr_plus;
        let v3 = arg0.target_ssr_game_id;
        let (v4, v5) = determine_outcome_with_pity_values(v1, v2, arg7, arg9);
        let v6 = get_rarity_from_outcome(v4);
        let v7 = false;
        let v8 = if (0x1::option::is_some<u64>(&v3)) {
            v3
        } else if (0x1::option::is_some<u64>(&arg1.featured_ssr_game_id)) {
            arg1.featured_ssr_game_id
        } else {
            0x1::option::none<u64>()
        };
        let v9 = v8;
        let v10 = if (v6 == 0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::game_core::rarity_ssr() && 0x1::option::is_some<u64>(&v9)) {
            let v11 = 0x2::random::new_generator(arg7, arg9);
            if (0x2::random::generate_u64_in_range(&mut v11, 0, 99) < arg1.ssr_up_numerator) {
                v7 = true;
                *0x1::option::borrow<u64>(&v9)
            } else {
                let v12 = 0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::game_core::select_character_template_from_registry(arg5, v6, arg7, arg9);
                let (v13, _, _) = 0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::game_core::get_template_data(&v12);
                v13
            }
        } else {
            let v16 = 0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::game_core::select_character_template_from_registry(arg5, v6, arg7, arg9);
            let (v17, _, _) = 0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::game_core::get_template_data(&v16);
            v17
        };
        let v20 = 0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::game_core::get_template_by_id(arg5, v10);
        let (_, v22, _) = 0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::game_core::get_template_data(&v20);
        update_user_state_after_pull(arg0, v4, arg6, arg8);
        update_global_stats(arg2, v4);
        if (0x2::table::contains<address, u64>(&arg2.last_pull_by_address, v0)) {
            *0x2::table::borrow_mut<address, u64>(&mut arg2.last_pull_by_address, v0) = 0x2::clock::timestamp_ms(arg8);
        } else {
            0x2::table::add<address, u64>(&mut arg2.last_pull_by_address, v0, 0x2::clock::timestamp_ms(arg8));
        };
        let v24 = GachaPullEvent{
            user            : v0,
            pull_number     : arg0.total_pulls,
            outcome_type    : v4,
            game_id         : v10,
            character_name  : v22,
            rarity          : v6,
            fragment_amount : execute_outcome(v4, v20, v6, arg1, arg3, arg4, arg5, arg8, arg9),
            was_pity        : v5,
            is_rate_up      : v7,
            pulls_since_ssr : arg0.pulls_since_ssr_card,
            timestamp       : 0x2::clock::timestamp_ms(arg8),
        };
        0x2::event::emit<GachaPullEvent>(v24);
        if (v5) {
            if (v4 == 1 && v1 >= 200 - 1) {
                let v25 = SSRPityTriggered{
                    user        : v0,
                    pulls_count : v1 + 1,
                    timestamp   : 0x2::clock::timestamp_ms(arg8),
                };
                0x2::event::emit<SSRPityTriggered>(v25);
            } else {
                let v26 = SRPityTriggered{
                    user        : v0,
                    pulls_count : v2 + 1,
                    timestamp   : 0x2::clock::timestamp_ms(arg8),
                };
                0x2::event::emit<SRPityTriggered>(v26);
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

    public fun get_pull_reward_config(arg0: &GachaConfig) : (bool, u64, u64) {
        (arg0.pull_reward_enabled, arg0.ten_pull_alb_reward, arg0.first_ten_pull_bonus)
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
            0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::game_core::rarity_ssr()
        } else if (arg0 == 4 || arg0 == 5) {
            0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::game_core::rarity_sr()
        } else {
            0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::game_core::rarity_r()
        }
    }

    public fun get_ssr_up_numerator(arg0: &GachaConfig) : u64 {
        arg0.ssr_up_numerator
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
            emergency_pause      : false,
            featured_ssr_game_id : 0x1::option::none<u64>(),
            discount_mode        : 1,
            discount_epoch       : 1,
            ssr_up_numerator     : 70,
            pull_reward_enabled  : true,
            ten_pull_alb_reward  : 5000000000,
            first_ten_pull_bonus : 15000000000,
            single_pull_cents    : 990,
            discount_bps         : 1000,
        };
        let v1 = GachaStats{
            id                           : 0x2::object::new(arg0),
            version                      : 1,
            total_ssr_cards_minted       : 0,
            total_ssr_frags_minted       : 0,
            total_sr_cards_minted        : 0,
            total_sr_frags_minted        : 0,
            total_r_cards_minted         : 0,
            discount_used_epoch          : 0x2::table::new<address, u64>(arg0),
            last_pull_by_address         : 0x2::table::new<address, u64>(arg0),
            first_ten_pull_bonus_claimed : 0x2::table::new<address, bool>(arg0),
        };
        0x2::transfer::share_object<GachaConfig>(v0);
        0x2::transfer::share_object<GachaStats>(v1);
    }

    public fun migrate_gacha_config(arg0: &0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::game_core::CharacterAdminCap, arg1: &mut GachaConfig) {
        assert!(arg1.version < 1, 11);
        arg1.version = 1;
    }

    public fun migrate_gacha_stats(arg0: &0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::game_core::CharacterAdminCap, arg1: &mut GachaStats) {
        assert!(arg1.version < 1, 11);
        arg1.version = 1;
    }

    fun mint_ten_pull_reward(arg0: &GachaConfig, arg1: &mut GachaStats, arg2: &mut 0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::alb_token::TokenTreasury, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        if (!arg0.pull_reward_enabled) {
            return
        };
        if (arg0.ten_pull_alb_reward == 0) {
            return
        };
        let v0 = arg0.ten_pull_alb_reward;
        let v1 = 0x2::tx_context::sender(arg5);
        let v2 = arg3 == 0 && !0x2::table::contains<address, bool>(&arg1.first_ten_pull_bonus_claimed, v1);
        let v3 = if (v2) {
            arg0.first_ten_pull_bonus
        } else {
            0
        };
        if (v3 > 0) {
            0x2::table::add<address, bool>(&mut arg1.first_ten_pull_bonus_claimed, v1, true);
        };
        let v4 = v0 + v3;
        if (v4 == 0) {
            return
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::alb_token::ALB_TOKEN>>(0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::alb_token::mint_pull_reward(arg2, v4, arg5), 0x2::tx_context::sender(arg5));
        let v5 = TenPullRewardMinted{
            user              : 0x2::tx_context::sender(arg5),
            base_reward       : v0,
            bonus_reward      : v3,
            total_reward      : v4,
            is_first_ten_pull : v2,
            timestamp         : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<TenPullRewardMinted>(v5);
    }

    public fun mint_whitelist_voucher(arg0: &0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::game_core::CharacterAdminCap, arg1: address, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 == 1, 12);
        let v0 = WhitelistVoucher{
            id            : 0x2::object::new(arg3),
            owner         : arg1,
            pulls_granted : arg2,
        };
        0x2::transfer::transfer<WhitelistVoucher>(v0, arg1);
    }

    entry fun pull_unified_single_with_alb(arg0: &mut UserGachaState, arg1: &GachaConfig, arg2: &mut GachaStats, arg3: &mut 0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::game_core::GlobalGameState, arg4: &mut 0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::fragment_system::GlobalFragmentState, arg5: &0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::game_core::TemplateRegistry, arg6: &mut 0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::alb_token::TokenTreasury, arg7: &mut 0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::alb_token::GlobalTokenStates, arg8: 0x2::coin::Coin<0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::alb_token::ALB_TOKEN>, arg9: &0x2::random::Random, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.user == 0x2::tx_context::sender(arg11), 6);
        assert!(!arg1.emergency_pause && arg1.gacha_enabled, 3);
        0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::alb_token::assert_twap_fresh(arg6, arg10);
        let v0 = 0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::alb_token::usd_to_alb(arg6, arg1.single_pull_cents);
        assert!(0x2::coin::value<0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::alb_token::ALB_TOKEN>(&arg8) >= v0, 0);
        verify_pull_limits(arg2, 0x2::tx_context::sender(arg11), 1, arg10);
        if (0x2::coin::value<0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::alb_token::ALB_TOKEN>(&arg8) > v0) {
            0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::alb_token::process_gacha_payment(arg6, arg7, 0x2::coin::split<0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::alb_token::ALB_TOKEN>(&mut arg8, v0, arg11), 0x2::tx_context::sender(arg11), 1, arg1.single_pull_cents, arg11);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::alb_token::ALB_TOKEN>>(arg8, 0x2::tx_context::sender(arg11));
        } else {
            0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::alb_token::process_gacha_payment(arg6, arg7, arg8, 0x2::tx_context::sender(arg11), 1, arg1.single_pull_cents, arg11);
        };
        execute_single_pull(arg0, arg1, arg2, arg3, arg4, arg5, v0, arg9, arg10, arg11);
    }

    entry fun pull_unified_single_with_stable<T0>(arg0: &mut UserGachaState, arg1: &GachaConfig, arg2: &mut GachaStats, arg3: &mut 0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::game_core::GlobalGameState, arg4: &mut 0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::fragment_system::GlobalFragmentState, arg5: &0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::game_core::TemplateRegistry, arg6: &mut 0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::alb_token::TokenTreasury, arg7: &mut 0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::edition::EditionVault, arg8: 0x2::coin::Coin<T0>, arg9: &0x2::random::Random, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.user == 0x2::tx_context::sender(arg11), 6);
        assert!(!arg1.emergency_pause && arg1.gacha_enabled, 3);
        assert!(0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::alb_token::is_stablecoin_accepted<T0>(arg6), 5);
        let v0 = derive_single_price(arg1);
        assert!(0x2::coin::value<T0>(&arg8) >= v0, 0);
        verify_pull_limits(arg2, 0x2::tx_context::sender(arg11), 1, arg10);
        let (v1, v2, v3, v4, v5, v6) = 0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::alb_token::get_revenue_split(arg6);
        settle_stable_payment<T0>(arg7, arg8, v0, v1, v2, v3, v4, v5, v6, arg11);
        let v7 = GachaPullWithStablecoin{
            user        : 0x2::tx_context::sender(arg11),
            coin_type   : 0x1::string::utf8(b"Stablecoin"),
            coin_amount : v0,
            pull_count  : 1,
            timestamp   : 0x2::clock::timestamp_ms(arg10),
        };
        0x2::event::emit<GachaPullWithStablecoin>(v7);
        execute_single_pull(arg0, arg1, arg2, arg3, arg4, arg5, v0, arg9, arg10, arg11);
    }

    entry fun pull_unified_ten_with_alb(arg0: &mut UserGachaState, arg1: &GachaConfig, arg2: &mut GachaStats, arg3: &mut 0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::game_core::GlobalGameState, arg4: &mut 0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::fragment_system::GlobalFragmentState, arg5: &0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::game_core::TemplateRegistry, arg6: &mut 0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::alb_token::TokenTreasury, arg7: &mut 0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::alb_token::GlobalTokenStates, arg8: 0x2::coin::Coin<0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::alb_token::ALB_TOKEN>, arg9: &0x2::random::Random, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.user == 0x2::tx_context::sender(arg11), 6);
        assert!(!arg1.emergency_pause && arg1.gacha_enabled, 3);
        0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::alb_token::assert_twap_fresh(arg6, arg10);
        let v0 = arg0.total_pulls;
        let v1 = 0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::alb_token::usd_to_alb(arg6, arg1.single_pull_cents);
        let v2 = v1 * 10;
        assert!(0x2::coin::value<0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::alb_token::ALB_TOKEN>(&arg8) >= v2, 0);
        verify_pull_limits(arg2, 0x2::tx_context::sender(arg11), 10, arg10);
        if (0x2::coin::value<0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::alb_token::ALB_TOKEN>(&arg8) > v2) {
            0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::alb_token::process_gacha_payment(arg6, arg7, 0x2::coin::split<0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::alb_token::ALB_TOKEN>(&mut arg8, v2, arg11), 0x2::tx_context::sender(arg11), 10, arg1.single_pull_cents, arg11);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::alb_token::ALB_TOKEN>>(arg8, 0x2::tx_context::sender(arg11));
        } else {
            0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::alb_token::process_gacha_payment(arg6, arg7, arg8, 0x2::tx_context::sender(arg11), 10, arg1.single_pull_cents, arg11);
        };
        let v3 = 0;
        let v4 = 0;
        let v5 = 0;
        let v6 = 0;
        let v7 = 0;
        let v8 = 0;
        while (v8 < 10) {
            let v9 = execute_single_pull(arg0, arg1, arg2, arg3, arg4, arg5, v1, arg9, arg10, arg11);
            if (v9 == 1) {
                v3 = v3 + 1;
            } else if (v9 == 2 || v9 == 3) {
                v4 = v4 + 1;
            } else if (v9 == 4) {
                v5 = v5 + 1;
            } else if (v9 == 5) {
                v6 = v6 + 1;
            } else {
                v7 = v7 + 1;
            };
            v8 = v8 + 1;
        };
        let v10 = MultipullCompleted{
            user       : 0x2::tx_context::sender(arg11),
            pull_count : 10,
            ssr_cards  : v3,
            ssr_frags  : v4,
            sr_cards   : v5,
            sr_frags   : v6,
            r_cards    : v7,
            total_cost : v2,
            timestamp  : 0x2::clock::timestamp_ms(arg10),
        };
        0x2::event::emit<MultipullCompleted>(v10);
        mint_ten_pull_reward(arg1, arg2, arg6, v0, arg10, arg11);
    }

    entry fun pull_unified_ten_with_stable<T0>(arg0: &mut UserGachaState, arg1: &GachaConfig, arg2: &mut GachaStats, arg3: &mut 0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::game_core::GlobalGameState, arg4: &mut 0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::fragment_system::GlobalFragmentState, arg5: &0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::game_core::TemplateRegistry, arg6: &mut 0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::alb_token::TokenTreasury, arg7: &mut 0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::edition::EditionVault, arg8: 0x2::coin::Coin<T0>, arg9: &0x2::random::Random, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.user == 0x2::tx_context::sender(arg11), 6);
        assert!(!arg1.emergency_pause && arg1.gacha_enabled, 3);
        let v0 = arg0.total_pulls;
        assert!(0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::alb_token::is_stablecoin_accepted<T0>(arg6), 5);
        let v1 = derive_ten_price(arg1);
        assert!(0x2::coin::value<T0>(&arg8) >= v1, 0);
        verify_pull_limits(arg2, 0x2::tx_context::sender(arg11), 10, arg10);
        let (v2, v3, v4, v5, v6, v7) = 0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::alb_token::get_revenue_split(arg6);
        settle_stable_payment<T0>(arg7, arg8, v1, v2, v3, v4, v5, v6, v7, arg11);
        let v8 = GachaPullWithStablecoin{
            user        : 0x2::tx_context::sender(arg11),
            coin_type   : 0x1::string::utf8(b"Stablecoin"),
            coin_amount : v1,
            pull_count  : 10,
            timestamp   : 0x2::clock::timestamp_ms(arg10),
        };
        0x2::event::emit<GachaPullWithStablecoin>(v8);
        let v9 = 0;
        let v10 = 0;
        let v11 = 0;
        let v12 = 0;
        let v13 = 0;
        let v14 = 0;
        while (v14 < 10) {
            let v15 = execute_single_pull(arg0, arg1, arg2, arg3, arg4, arg5, v1 / 10, arg9, arg10, arg11);
            if (v15 == 1) {
                v9 = v9 + 1;
            } else if (v15 == 2 || v15 == 3) {
                v10 = v10 + 1;
            } else if (v15 == 4) {
                v11 = v11 + 1;
            } else if (v15 == 5) {
                v12 = v12 + 1;
            } else {
                v13 = v13 + 1;
            };
            v14 = v14 + 1;
        };
        let v16 = MultipullCompleted{
            user       : 0x2::tx_context::sender(arg11),
            pull_count : 10,
            ssr_cards  : v9,
            ssr_frags  : v10,
            sr_cards   : v11,
            sr_frags   : v12,
            r_cards    : v13,
            total_cost : v1,
            timestamp  : 0x2::clock::timestamp_ms(arg10),
        };
        0x2::event::emit<MultipullCompleted>(v16);
        mint_ten_pull_reward(arg1, arg2, arg6, v0, arg10, arg11);
    }

    entry fun pull_unified_ten_with_stable_referral<T0>(arg0: &mut UserGachaState, arg1: &GachaConfig, arg2: &mut GachaStats, arg3: &mut 0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::game_core::GlobalGameState, arg4: &mut 0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::fragment_system::GlobalFragmentState, arg5: &0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::game_core::TemplateRegistry, arg6: &mut 0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::alb_token::TokenTreasury, arg7: &mut 0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::edition::EditionVault, arg8: 0x2::coin::Coin<T0>, arg9: &0x2::random::Random, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.user == 0x2::tx_context::sender(arg11), 6);
        assert!(!arg1.emergency_pause && arg1.gacha_enabled, 3);
        let v0 = arg0.total_pulls;
        assert!(0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::alb_token::is_stablecoin_accepted<T0>(arg6), 5);
        assert!(arg1.discount_mode != 0, 7);
        if (arg1.discount_mode == 1) {
            let v1 = 0x2::tx_context::sender(arg11);
            let v2 = 0x2::table::contains<address, u64>(&arg2.discount_used_epoch, v1) && *0x2::table::borrow<address, u64>(&arg2.discount_used_epoch, v1) >= arg1.discount_epoch;
            assert!(!v2, 8);
            if (0x2::table::contains<address, u64>(&arg2.discount_used_epoch, v1)) {
                *0x2::table::borrow_mut<address, u64>(&mut arg2.discount_used_epoch, v1) = arg1.discount_epoch;
            } else {
                0x2::table::add<address, u64>(&mut arg2.discount_used_epoch, v1, arg1.discount_epoch);
            };
        };
        verify_pull_limits(arg2, 0x2::tx_context::sender(arg11), 10, arg10);
        let v3 = derive_referral_price(arg1);
        assert!(0x2::coin::value<T0>(&arg8) >= v3, 0);
        let (v4, v5, v6, v7, v8, v9) = 0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::alb_token::get_revenue_split(arg6);
        settle_stable_payment<T0>(arg7, arg8, v3, v4, v5, v6, v7, v8, v9, arg11);
        let v10 = ReferralPurchaseEvent{
            user            : 0x2::tx_context::sender(arg11),
            coin_type       : 0x1::string::utf8(b"Stablecoin"),
            coin_amount     : v3,
            discount_amount : derive_ten_price(arg1) - v3,
            timestamp       : 0x2::clock::timestamp_ms(arg10),
        };
        0x2::event::emit<ReferralPurchaseEvent>(v10);
        let v11 = GachaPullWithStablecoin{
            user        : 0x2::tx_context::sender(arg11),
            coin_type   : 0x1::string::utf8(b"Stablecoin"),
            coin_amount : v3,
            pull_count  : 10,
            timestamp   : 0x2::clock::timestamp_ms(arg10),
        };
        0x2::event::emit<GachaPullWithStablecoin>(v11);
        let v12 = 0;
        let v13 = 0;
        let v14 = 0;
        let v15 = 0;
        let v16 = 0;
        let v17 = 0;
        while (v17 < 10) {
            let v18 = execute_single_pull(arg0, arg1, arg2, arg3, arg4, arg5, v3 / 10, arg9, arg10, arg11);
            if (v18 == 1) {
                v12 = v12 + 1;
            } else if (v18 == 2 || v18 == 3) {
                v13 = v13 + 1;
            } else if (v18 == 4) {
                v14 = v14 + 1;
            } else if (v18 == 5) {
                v15 = v15 + 1;
            } else {
                v16 = v16 + 1;
            };
            v17 = v17 + 1;
        };
        let v19 = MultipullCompleted{
            user       : 0x2::tx_context::sender(arg11),
            pull_count : 10,
            ssr_cards  : v12,
            ssr_frags  : v13,
            sr_cards   : v14,
            sr_frags   : v15,
            r_cards    : v16,
            total_cost : v3,
            timestamp  : 0x2::clock::timestamp_ms(arg10),
        };
        0x2::event::emit<MultipullCompleted>(v19);
        mint_ten_pull_reward(arg1, arg2, arg6, v0, arg10, arg11);
    }

    entry fun pull_with_voucher_single(arg0: WhitelistVoucher, arg1: &mut UserGachaState, arg2: &GachaConfig, arg3: &mut GachaStats, arg4: &mut 0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::game_core::GlobalGameState, arg5: &mut 0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::fragment_system::GlobalFragmentState, arg6: &0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::game_core::TemplateRegistry, arg7: &0x2::random::Random, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg9), 6);
        assert!(arg1.user == 0x2::tx_context::sender(arg9), 6);
        assert!(!arg2.emergency_pause && arg2.gacha_enabled, 3);
        let WhitelistVoucher {
            id            : v0,
            owner         : _,
            pulls_granted : _,
        } = arg0;
        0x2::object::delete(v0);
        let v3 = VoucherPullEvent{
            user          : 0x2::tx_context::sender(arg9),
            voucher_id    : 0x2::object::id<WhitelistVoucher>(&arg0),
            pulls_granted : arg0.pulls_granted,
            timestamp     : 0x2::clock::timestamp_ms(arg8),
        };
        0x2::event::emit<VoucherPullEvent>(v3);
        verify_pull_limits(arg3, 0x2::tx_context::sender(arg9), 1, arg8);
        execute_single_pull(arg1, arg2, arg3, arg4, arg5, arg6, 0, arg7, arg8, arg9);
    }

    public fun set_discount_mode(arg0: &0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::game_core::CharacterAdminCap, arg1: &mut GachaConfig, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        assert_config_version(arg1);
        assert!(arg2 <= 2, 9);
        arg1.discount_mode = arg2;
    }

    public fun set_featured_ssr(arg0: &0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::game_core::CharacterAdminCap, arg1: &mut GachaConfig, arg2: &0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::game_core::TemplateRegistry, arg3: 0x1::option::Option<u64>, arg4: &mut 0x2::tx_context::TxContext) {
        assert_config_version(arg1);
        if (0x1::option::is_some<u64>(&arg3)) {
            assert!(0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::game_core::template_exists(arg2, *0x1::option::borrow<u64>(&arg3), 0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::game_core::rarity_ssr()), 4);
            assert!(0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::game_core::is_template_active(arg2, *0x1::option::borrow<u64>(&arg3), 0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::game_core::rarity_ssr()), 15);
        };
        arg1.featured_ssr_game_id = arg3;
    }

    public fun set_gacha_params(arg0: &0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::game_core::CharacterAdminCap, arg1: &mut GachaConfig, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert_config_version(arg1);
        assert!(arg2 <= 100, 13);
        arg1.ssr_up_numerator = arg2;
    }

    public fun set_gacha_pricing(arg0: &0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::game_core::CharacterAdminCap, arg1: &mut GachaConfig, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) {
        assert_config_version(arg1);
        assert!(arg2 >= 100 && arg2 <= 5000, 14);
        assert!(arg3 <= 3000, 14);
        arg1.single_pull_cents = arg2;
        arg1.discount_bps = arg3;
        let v0 = GachaPricingUpdated{
            single_pull_cents : arg2,
            discount_bps      : arg3,
            timestamp_ms      : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<GachaPricingUpdated>(v0);
    }

    public fun set_pull_reward_config(arg0: &0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::game_core::CharacterAdminCap, arg1: &mut GachaConfig, arg2: bool, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert_config_version(arg1);
        assert!(arg3 <= 1000000000000, 16);
        assert!(arg4 <= 1000000000000, 16);
        arg1.pull_reward_enabled = arg2;
        arg1.ten_pull_alb_reward = arg3;
        arg1.first_ten_pull_bonus = arg4;
    }

    public fun set_target_ssr(arg0: &mut UserGachaState, arg1: &0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::game_core::TemplateRegistry, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.user == 0x2::tx_context::sender(arg3), 6);
        assert!(0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::game_core::template_exists(arg1, arg2, 0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::game_core::rarity_ssr()), 4);
        assert!(0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::game_core::is_template_active(arg1, arg2, 0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::game_core::rarity_ssr()), 15);
        arg0.target_ssr_game_id = 0x1::option::some<u64>(arg2);
    }

    fun settle_stable_payment<T0>(arg0: &mut 0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::edition::EditionVault, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: address, arg4: address, arg5: address, arg6: u64, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg1) > arg2) {
            let v0 = 0x2::coin::split<T0>(&mut arg1, arg2, arg9);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg9));
            distribute_stable_revenue<T0>(arg0, v0, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        } else {
            distribute_stable_revenue<T0>(arg0, arg1, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        };
    }

    public fun single_pull_cents(arg0: &GachaConfig) : u64 {
        arg0.single_pull_cents
    }

    public fun toggle_gacha_system(arg0: &0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::game_core::CharacterAdminCap, arg1: &mut GachaConfig, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert_config_version(arg1);
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
        arg0.total_spent = arg0.total_spent + arg2;
    }

    public(friend) fun user_address(arg0: &UserGachaState) : address {
        arg0.user
    }

    fun verify_pull_limits(arg0: &GachaStats, arg1: address, arg2: u8, arg3: &0x2::clock::Clock) {
        assert_stats_version(arg0);
        assert!(arg2 <= (10 as u8), 1);
        if (0x2::table::contains<address, u64>(&arg0.last_pull_by_address, arg1)) {
            let v0 = *0x2::table::borrow<address, u64>(&arg0.last_pull_by_address, arg1);
            if (v0 > 0) {
                assert!(0x2::clock::timestamp_ms(arg3) >= v0 + 1000, 2);
            };
        };
    }

    // decompiled from Move bytecode v7
}

