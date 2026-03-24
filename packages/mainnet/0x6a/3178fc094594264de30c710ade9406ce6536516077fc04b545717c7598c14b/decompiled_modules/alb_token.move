module 0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::alb_token {
    struct ALB_TOKEN has drop {
        dummy_field: bool,
    }

    struct TokenTreasury has key {
        id: 0x2::object::UID,
        version: u64,
        treasury_cap: 0x2::coin::TreasuryCap<ALB_TOKEN>,
        total_minted: u64,
        total_burned: u64,
        floor_protection_fund: 0x2::balance::Balance<ALB_TOKEN>,
        starfall_main_pool: 0x2::balance::Balance<ALB_TOKEN>,
        miracle_pool: 0x2::balance::Balance<ALB_TOKEN>,
        current_season: u8,
        weekly_twap: u64,
        last_twap_update: u64,
        sui_price_cents: u64,
        last_sui_price_update: u64,
        emission_sink_ratio: u64,
        seven_day_median_price: u64,
        adjustment_active: bool,
        is_minting_paused: bool,
        sui_reserve: 0x2::balance::Balance<0x2::sui::SUI>,
        stablecoin_recipient: address,
        accepted_stablecoins: vector<0x1::type_name::TypeName>,
        total_referral_emitted: u64,
    }

    struct UserTokenState has store, key {
        id: 0x2::object::UID,
        lifetime_earned: u64,
        lifetime_spent: u64,
        total_gacha_pulls: u64,
    }

    struct GlobalTokenStates has key {
        id: 0x2::object::UID,
        version: u64,
        user_states: 0x2::table::Table<address, UserTokenState>,
    }

    struct TokensMinted has copy, drop {
        recipient: address,
        amount: u64,
        reason: 0x1::string::String,
        season: u8,
        timestamp: u64,
    }

    struct TokensBurned has copy, drop {
        amount: u64,
        reason: 0x1::string::String,
        burn_mechanism: 0x1::string::String,
        timestamp: u64,
    }

    struct SeasonalReset has copy, drop {
        season: u8,
        total_users_reset: u64,
        timestamp: u64,
    }

    struct EmissionAdjustment has copy, drop {
        reason: 0x1::string::String,
        old_emission_rate: u64,
        new_emission_rate: u64,
        old_fee_rate: u64,
        new_fee_rate: u64,
        timestamp: u64,
    }

    struct ReferralRewardVested has copy, drop {
        kol_address: address,
        amount: u64,
        period: vector<u8>,
        timestamp: u64,
    }

    struct TokensSpent has copy, drop {
        user: address,
        amount: u64,
        purpose: 0x1::string::String,
        timestamp: u64,
    }

    struct ALBPurchased has copy, drop {
        buyer: address,
        coin_type: 0x1::string::String,
        coin_amount: u64,
        alb_amount: u64,
        sui_price_used: u64,
        timestamp: u64,
    }

    struct SUIPriceUpdated has copy, drop {
        old_price: u64,
        new_price: u64,
        source: 0x1::string::String,
        timestamp: u64,
    }

    struct TwapUpdated has copy, drop {
        old_twap: u64,
        new_twap: u64,
        timestamp: u64,
    }

    public fun add_accepted_stablecoin<T0>(arg0: &0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::MasterAdminCap, arg1: &mut TokenTreasury) {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        if (!0x1::vector::contains<0x1::type_name::TypeName>(&arg1.accepted_stablecoins, &v0)) {
            0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg1.accepted_stablecoins, v0);
        };
    }

    public fun add_floor_protection_funds(arg0: &0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::MasterAdminCap, arg1: &mut TokenTreasury, arg2: 0x2::coin::Coin<ALB_TOKEN>) {
        0x2::balance::join<ALB_TOKEN>(&mut arg1.floor_protection_fund, 0x2::coin::into_balance<ALB_TOKEN>(arg2));
    }

    public fun advance_season(arg0: &0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::MasterAdminCap, arg1: &mut TokenTreasury, arg2: &mut GlobalTokenStates, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 == arg1.current_season + 1, 2);
        arg1.current_season = arg3;
        let v0 = SeasonalReset{
            season            : arg3,
            total_users_reset : 0,
            timestamp         : 0x2::tx_context::epoch_timestamp_ms(arg4),
        };
        0x2::event::emit<SeasonalReset>(v0);
    }

    public fun assert_twap_fresh(arg0: &TokenTreasury, arg1: &0x2::clock::Clock) {
        assert!(0x2::clock::timestamp_ms(arg1) - arg0.last_twap_update <= 604800000, 12);
    }

    public fun buy_alb_with_stable<T0>(arg0: &mut TokenTreasury, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<ALB_TOKEN> {
        assert!(!arg0.is_minting_paused, 5);
        assert!(0x2::clock::timestamp_ms(arg2) - arg0.last_twap_update <= 604800000, 12);
        let v0 = 0x1::type_name::with_original_ids<T0>();
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&arg0.accepted_stablecoins, &v0), 8);
        let v1 = 0x2::coin::value<T0>(&arg1);
        let v2 = v1 / 10000;
        assert!(v2 > 0, 11);
        let v3 = usd_to_alb(arg0, v2);
        assert!(arg0.total_minted + v3 <= 1000000000000000000, 1);
        arg0.total_minted = arg0.total_minted + v3;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, arg0.stablecoin_recipient);
        let v4 = ALBPurchased{
            buyer          : 0x2::tx_context::sender(arg3),
            coin_type      : 0x1::string::utf8(b"Stablecoin"),
            coin_amount    : v1,
            alb_amount     : v3,
            sui_price_used : arg0.sui_price_cents,
            timestamp      : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<ALBPurchased>(v4);
        0x2::coin::mint<ALB_TOKEN>(&mut arg0.treasury_cap, v3, arg3)
    }

    public fun buy_alb_with_sui(arg0: &mut TokenTreasury, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<ALB_TOKEN> {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(!arg0.is_minting_paused, 5);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        assert!(v1 - arg0.last_sui_price_update <= 60 * 1000, 4);
        assert!(v1 - arg0.last_twap_update <= 604800000, 12);
        let v2 = sui_to_alb(arg0, v0);
        assert!(v2 > 0, 11);
        assert!(v2 >= arg2, 13);
        assert!(arg0.total_minted + v2 <= 1000000000000000000, 1);
        arg0.total_minted = arg0.total_minted + v2;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_reserve, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v3 = ALBPurchased{
            buyer          : 0x2::tx_context::sender(arg4),
            coin_type      : 0x1::string::utf8(b"SUI"),
            coin_amount    : v0,
            alb_amount     : v2,
            sui_price_used : arg0.sui_price_cents,
            timestamp      : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<ALBPurchased>(v3);
        0x2::coin::mint<ALB_TOKEN>(&mut arg0.treasury_cap, v2, arg4)
    }

    public fun check_auto_adjustment(arg0: &0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::MasterAdminCap, arg1: &mut TokenTreasury, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg3 > 0) {
            arg2 * 100 / arg3
        } else {
            200
        };
        let v1 = if (arg1.seven_day_median_price > arg4) {
            (arg1.seven_day_median_price - arg4) * 100 / arg1.seven_day_median_price
        } else {
            0
        };
        let v2 = v0 > 120 || v1 > 15;
        if (v2 && !arg1.adjustment_active) {
            arg1.adjustment_active = true;
            let v3 = if (v0 > 120) {
                0x1::string::utf8(b"emission_sink_ratio")
            } else {
                0x1::string::utf8(b"price_drop")
            };
            let v4 = EmissionAdjustment{
                reason            : v3,
                old_emission_rate : 100,
                new_emission_rate : 100 - 12,
                old_fee_rate      : 100,
                new_fee_rate      : 100 + 12,
                timestamp         : 0x2::clock::timestamp_ms(arg5),
            };
            0x2::event::emit<EmissionAdjustment>(v4);
        } else if (!v2 && arg1.adjustment_active) {
            arg1.adjustment_active = false;
            let v5 = EmissionAdjustment{
                reason            : 0x1::string::utf8(b"conditions_normalized"),
                old_emission_rate : 100 - 12,
                new_emission_rate : 100,
                old_fee_rate      : 100 + 12,
                new_fee_rate      : 100,
                timestamp         : 0x2::clock::timestamp_ms(arg5),
            };
            0x2::event::emit<EmissionAdjustment>(v5);
        };
        arg1.emission_sink_ratio = v0;
        arg1.seven_day_median_price = arg4;
    }

    public fun create_tokens_from_treasury(arg0: &0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::MasterAdminCap, arg1: &mut TokenTreasury, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<ALB_TOKEN> {
        assert!(0x2::balance::value<ALB_TOKEN>(&arg1.floor_protection_fund) >= arg2, 0);
        0x2::coin::from_balance<ALB_TOKEN>(0x2::balance::split<ALB_TOKEN>(&mut arg1.floor_protection_fund, arg2), arg3)
    }

    public fun disburse_vested_referral_reward(arg0: &0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::MasterAdminCap, arg1: &mut TokenTreasury, arg2: address, arg3: u64, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.total_referral_emitted + arg3 <= 100000000000000000, 10);
        assert!(arg1.total_minted + arg3 <= 1000000000000000000, 1);
        arg1.total_minted = arg1.total_minted + arg3;
        arg1.total_referral_emitted = arg1.total_referral_emitted + arg3;
        0x2::transfer::public_transfer<0x2::coin::Coin<ALB_TOKEN>>(0x2::coin::mint<ALB_TOKEN>(&mut arg1.treasury_cap, arg3, arg6), arg2);
        let v0 = ReferralRewardVested{
            kol_address : arg2,
            amount      : arg3,
            period      : arg4,
            timestamp   : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<ReferralRewardVested>(v0);
    }

    public fun estimate_alb_for_sui(arg0: &TokenTreasury, arg1: u64) : u64 {
        sui_to_alb(arg0, arg1)
    }

    public fun estimate_sui_for_alb(arg0: &TokenTreasury, arg1: u64) : u64 {
        if (arg0.sui_price_cents == 0 || arg0.weekly_twap == 0) {
            return 0
        };
        (((arg1 as u128) * 1000000000 * 100 / (arg0.sui_price_cents as u128) * (arg0.weekly_twap as u128)) as u64)
    }

    public fun get_alb_twap(arg0: &TokenTreasury) : u64 {
        arg0.weekly_twap
    }

    public fun get_complete_user_info(arg0: &GlobalTokenStates, arg1: address) : (u64, u64) {
        if (0x2::table::contains<address, UserTokenState>(&arg0.user_states, arg1)) {
            let v2 = 0x2::table::borrow<address, UserTokenState>(&arg0.user_states, arg1);
            (v2.lifetime_earned, v2.lifetime_spent)
        } else {
            (0, 0)
        }
    }

    public fun get_exchange_rates(arg0: &TokenTreasury) : (u64, u64, u64, u64) {
        (arg0.sui_price_cents, arg0.last_sui_price_update, arg0.weekly_twap, arg0.last_twap_update)
    }

    public fun get_floor_protection_funds(arg0: &TokenTreasury) : u64 {
        0x2::balance::value<ALB_TOKEN>(&arg0.floor_protection_fund)
    }

    public fun get_gacha_costs_alb(arg0: &TokenTreasury) : u64 {
        usd_to_alb(arg0, 990)
    }

    fun get_or_create_user_state(arg0: &mut GlobalTokenStates, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : &mut UserTokenState {
        if (!0x2::table::contains<address, UserTokenState>(&arg0.user_states, arg1)) {
            let v0 = UserTokenState{
                id                : 0x2::object::new(arg2),
                lifetime_earned   : 0,
                lifetime_spent    : 0,
                total_gacha_pulls : 0,
            };
            0x2::table::add<address, UserTokenState>(&mut arg0.user_states, arg1, v0);
        };
        0x2::table::borrow_mut<address, UserTokenState>(&mut arg0.user_states, arg1)
    }

    public fun get_stablecoin_recipient(arg0: &TokenTreasury) : address {
        arg0.stablecoin_recipient
    }

    public fun get_sui_price_cents(arg0: &TokenTreasury) : u64 {
        arg0.sui_price_cents
    }

    public fun get_sui_price_info(arg0: &TokenTreasury) : (u64, u64) {
        (arg0.sui_price_cents, arg0.last_sui_price_update)
    }

    public fun get_treasury_stats(arg0: &TokenTreasury) : (u64, u64, u8, u64, bool) {
        (arg0.total_minted, arg0.total_burned, arg0.current_season, arg0.emission_sink_ratio, arg0.adjustment_active)
    }

    public fun global_token_states_version(arg0: &GlobalTokenStates) : u64 {
        arg0.version
    }

    fun init(arg0: ALB_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALB_TOKEN>(arg0, 9, b"ALB", b"Albus Token", b"Utility token for Albus Paths - Web3 strategy card RPG on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://img.albuspaths.com/alb.png")), arg1);
        let v2 = TokenTreasury{
            id                     : 0x2::object::new(arg1),
            version                : 1,
            treasury_cap           : v0,
            total_minted           : 0,
            total_burned           : 0,
            floor_protection_fund  : 0x2::balance::zero<ALB_TOKEN>(),
            starfall_main_pool     : 0x2::balance::zero<ALB_TOKEN>(),
            miracle_pool           : 0x2::balance::zero<ALB_TOKEN>(),
            current_season         : 1,
            weekly_twap            : 10000000000,
            last_twap_update       : 0x2::tx_context::epoch_timestamp_ms(arg1),
            sui_price_cents        : 170,
            last_sui_price_update  : 0x2::tx_context::epoch_timestamp_ms(arg1),
            emission_sink_ratio    : 100,
            seven_day_median_price : 10000000000,
            adjustment_active      : false,
            is_minting_paused      : false,
            sui_reserve            : 0x2::balance::zero<0x2::sui::SUI>(),
            stablecoin_recipient   : 0x2::tx_context::sender(arg1),
            accepted_stablecoins   : 0x1::vector::empty<0x1::type_name::TypeName>(),
            total_referral_emitted : 0,
        };
        v2.total_minted = 110000000000000000;
        0x2::transfer::public_transfer<0x2::coin::Coin<ALB_TOKEN>>(0x2::coin::mint<ALB_TOKEN>(&mut v2.treasury_cap, 110000000000000000, arg1), 0x2::tx_context::sender(arg1));
        let v3 = GlobalTokenStates{
            id          : 0x2::object::new(arg1),
            version     : 1,
            user_states : 0x2::table::new<address, UserTokenState>(arg1),
        };
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ALB_TOKEN>>(v1);
        0x2::transfer::share_object<TokenTreasury>(v2);
        0x2::transfer::share_object<GlobalTokenStates>(v3);
    }

    public fun is_stablecoin_accepted<T0>(arg0: &TokenTreasury) : bool {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        0x1::vector::contains<0x1::type_name::TypeName>(&arg0.accepted_stablecoins, &v0)
    }

    public fun join_coins(arg0: &mut 0x2::coin::Coin<ALB_TOKEN>, arg1: 0x2::coin::Coin<ALB_TOKEN>) {
        0x2::coin::join<ALB_TOKEN>(arg0, arg1);
    }

    public fun migrate_global_token_states(arg0: &0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::CharacterAdminCap, arg1: &mut GlobalTokenStates) {
        assert!(arg1.version < 1, 6);
        arg1.version = 1;
    }

    public fun migrate_token_treasury(arg0: &0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::CharacterAdminCap, arg1: &mut TokenTreasury) {
        assert!(arg1.version < 1, 6);
        arg1.version = 1;
    }

    public fun mint_tokens_seasonal(arg0: &0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::MasterAdminCap, arg1: &mut TokenTreasury, arg2: u64, arg3: address, arg4: vector<u8>, arg5: 0x1::string::String, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg5 == 0x1::string::utf8(b"floor_protection")) {
            assert!(0x2::balance::value<ALB_TOKEN>(&arg1.floor_protection_fund) >= arg2, 0);
            0x2::coin::from_balance<ALB_TOKEN>(0x2::balance::split<ALB_TOKEN>(&mut arg1.floor_protection_fund, arg2), arg7)
        } else {
            assert!(arg5 == 0x1::string::utf8(b"new_mint"), 9);
            assert!(!arg1.is_minting_paused, 5);
            assert!(arg1.total_minted + arg2 <= 1000000000000000000, 1);
            let v1 = if (arg1.adjustment_active) {
                arg2 * (100 - 12) / 100
            } else {
                arg2
            };
            arg1.total_minted = arg1.total_minted + v1;
            0x2::coin::mint<ALB_TOKEN>(&mut arg1.treasury_cap, v1, arg7)
        };
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<ALB_TOKEN>>(v2, arg3);
        let v3 = TokensMinted{
            recipient : arg3,
            amount    : 0x2::coin::value<ALB_TOKEN>(&v2),
            reason    : 0x1::string::utf8(arg4),
            season    : arg1.current_season,
            timestamp : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::event::emit<TokensMinted>(v3);
    }

    fun pow10(arg0: u64) : u64 {
        assert!(arg0 <= 18, 3);
        let v0 = 1;
        let v1 = 0;
        while (v1 < arg0) {
            v0 = v0 * 10;
            v1 = v1 + 1;
        };
        v0
    }

    public fun process_gacha_payment(arg0: &mut TokenTreasury, arg1: &mut GlobalTokenStates, arg2: 0x2::coin::Coin<ALB_TOKEN>, arg3: address, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::coin::value<ALB_TOKEN>(&arg2);
        assert!(v0 >= usd_to_alb(arg0, 990) * arg4, 0);
        let v1 = 0x2::coin::into_balance<ALB_TOKEN>(arg2);
        0x2::balance::join<ALB_TOKEN>(&mut arg0.floor_protection_fund, 0x2::balance::split<ALB_TOKEN>(&mut v1, v0 / 10));
        let v2 = 0x2::balance::value<ALB_TOKEN>(&v1);
        0x2::coin::burn<ALB_TOKEN>(&mut arg0.treasury_cap, 0x2::coin::from_balance<ALB_TOKEN>(v1, arg5));
        arg0.total_burned = arg0.total_burned + v2;
        let v3 = TokensBurned{
            amount         : v2,
            reason         : 0x1::string::utf8(b"gacha_payment"),
            burn_mechanism : 0x1::string::utf8(b"primary_market_burn"),
            timestamp      : 0x2::tx_context::epoch_timestamp_ms(arg5),
        };
        0x2::event::emit<TokensBurned>(v3);
        let v4 = get_or_create_user_state(arg1, arg3, arg5);
        v4.lifetime_spent = v4.lifetime_spent + v0;
        v4.total_gacha_pulls = v4.total_gacha_pulls + arg4;
        let v5 = TokensSpent{
            user      : arg3,
            amount    : v0,
            purpose   : 0x1::string::utf8(b"gacha_pull"),
            timestamp : 0x2::tx_context::epoch_timestamp_ms(arg5),
        };
        0x2::event::emit<TokensSpent>(v5);
        v0
    }

    public fun remove_accepted_stablecoin<T0>(arg0: &0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::MasterAdminCap, arg1: &mut TokenTreasury) {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        let (v1, v2) = 0x1::vector::index_of<0x1::type_name::TypeName>(&arg1.accepted_stablecoins, &v0);
        if (v1) {
            0x1::vector::remove<0x1::type_name::TypeName>(&mut arg1.accepted_stablecoins, v2);
        };
    }

    public fun set_minting_paused(arg0: &0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::MasterAdminCap, arg1: &mut TokenTreasury, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.is_minting_paused = arg2;
    }

    public fun set_stablecoin_recipient(arg0: &0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::MasterAdminCap, arg1: &mut TokenTreasury, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.stablecoin_recipient = arg2;
    }

    public fun split_coin(arg0: &mut 0x2::coin::Coin<ALB_TOKEN>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<ALB_TOKEN> {
        0x2::coin::split<ALB_TOKEN>(arg0, arg1, arg2)
    }

    public fun sui_to_alb(arg0: &TokenTreasury, arg1: u64) : u64 {
        usd_to_alb(arg0, sui_to_usd_cents(arg0, arg1))
    }

    public fun sui_to_usd_cents(arg0: &TokenTreasury, arg1: u64) : u64 {
        (((arg1 as u128) * (arg0.sui_price_cents as u128) / 1000000000) as u64)
    }

    public fun token_treasury_version(arg0: &TokenTreasury) : u64 {
        arg0.version
    }

    public fun update_sui_price_from_pyth(arg0: &mut TokenTreasury, arg1: &0x2::clock::Clock, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_no_older_than(arg2, arg1, 60);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_info_from_price_info_object(arg2);
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_identifier(&v1);
        let v3 = if (true) {
            x"23d7315113f5b1d3ba7a83604c44b94d79f4fd69af77f804fc7f920a6dc65744"
        } else {
            x"50c67b3fd225db8912a424dd4baed60ffdde625ed2feaaf283724f9608fea266"
        };
        assert!(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::get_bytes(&v2) == v3, 3);
        let v4 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v0);
        let v5 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v0);
        let v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&v5);
        let v7 = if (v6 >= 2) {
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v4) / pow10(v6 - 2)
        } else {
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v4) * pow10(2 - v6)
        };
        arg0.sui_price_cents = v7;
        arg0.last_sui_price_update = 0x2::clock::timestamp_ms(arg1);
        let v8 = SUIPriceUpdated{
            old_price : arg0.sui_price_cents,
            new_price : v7,
            source    : 0x1::string::utf8(b"pyth_onchain"),
            timestamp : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<SUIPriceUpdated>(v8);
    }

    public fun update_twap(arg0: &0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::MasterAdminCap, arg1: &mut TokenTreasury, arg2: u64, arg3: &0x2::clock::Clock) {
        assert!(arg2 >= 1000000 && arg2 <= 100000000000000, 14);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        arg1.weekly_twap = arg2;
        arg1.last_twap_update = v0;
        let v1 = TwapUpdated{
            old_twap  : arg1.weekly_twap,
            new_twap  : arg2,
            timestamp : v0,
        };
        0x2::event::emit<TwapUpdated>(v1);
    }

    public fun usd_to_alb(arg0: &TokenTreasury, arg1: u64) : u64 {
        (((arg1 as u128) * (arg0.weekly_twap as u128) / 100) as u64)
    }

    public fun withdraw_sui_reserve(arg0: &0x6a3178fc094594264de30c710ade9406ce6536516077fc04b545717c7598c14b::game_core::MasterAdminCap, arg1: &mut TokenTreasury, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg1.sui_reserve) >= arg2, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.sui_reserve, arg2), arg4), arg3);
    }

    // decompiled from Move bytecode v6
}

