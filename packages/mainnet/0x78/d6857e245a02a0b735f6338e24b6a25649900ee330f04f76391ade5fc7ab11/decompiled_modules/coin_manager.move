module 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::coin_manager {
    struct ProtectedTreasuryCap<phantom T0> has store {
        cap: 0x2::coin::TreasuryCap<T0>,
    }

    struct CoinInfo<phantom T0> has store, key {
        id: 0x2::object::UID,
        version: u64,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
        creator: address,
        launch_time: u64,
        coin_type: 0x1::string::String,
        coin_metadata_id: address,
        token_decimals: u8,
        protected_cap: ProtectedTreasuryCap<T0>,
        supply: u64,
        bonding_curve_tokens: u64,
        amm_reserve_tokens: u64,
        total_token_supply: u64,
        real_token_reserves: 0x2::balance::Balance<T0>,
        amm_reserve_balance: 0x2::balance::Balance<T0>,
        real_sui_reserves: 0x2::balance::Balance<0x2::sui::SUI>,
        virtual_token_reserves: u64,
        virtual_sui_reserves: u64,
        graduated: bool,
        dex_name: 0x1::option::Option<0x1::string::String>,
        pool_id: 0x1::option::Option<address>,
        graduation_locked: bool,
        open_buy_at: 0x1::option::Option<u64>,
        open_sell_at: 0x1::option::Option<u64>,
        grace_period_ends_at: 0x1::option::Option<u64>,
    }

    struct CoinManagerRegistry has key {
        id: 0x2::object::UID,
        admin: address,
        managers: 0x2::table::Table<address, bool>,
    }

    struct CoinCreatedEvent has copy, drop {
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        image_url: 0x1::string::String,
        description: 0x1::string::String,
        website: 0x1::string::String,
        telegram: 0x1::string::String,
        twitter: 0x1::string::String,
        creator: address,
        coin_address: address,
        launch_time: u64,
        virtual_sui_reserves: u64,
        virtual_token_reserves: u64,
        real_sui_reserves: u64,
        real_token_reserves: u64,
        bonding_curve_tokens: u64,
        amm_reserve_tokens: u64,
        total_token_supply: u64,
        token_decimals: u8,
        coin_type: 0x1::string::String,
        coin_metadata_id: address,
        br_address: 0x1::option::Option<address>,
        grace_period_ends_at: 0x1::option::Option<u64>,
    }

    struct TradeEvent has copy, drop {
        is_buy: bool,
        coin_address: address,
        user_address: address,
        token_amount: u64,
        sui_amount: u64,
        platform_fee_amount: u64,
        battle_royale_fee_amount: u64,
        new_supply: u64,
        new_price: u64,
        new_virtual_sui_reserves: u64,
        new_virtual_token_reserves: u64,
        new_real_sui_reserves: u64,
        new_real_token_reserves: u64,
        market_cap: 0x1::option::Option<u64>,
        cetus_pool_sui_liquidity: 0x1::option::Option<u64>,
        cetus_pool_token_liquidity: 0x1::option::Option<u64>,
        is_graduated_trade: bool,
        is_eligible_for_graduation: 0x1::option::Option<bool>,
    }

    struct ManagerRegistryCreatedEvent has copy, drop {
        registry_address: address,
        admin: address,
    }

    struct ManagerGrantedEvent has copy, drop {
        registry_address: address,
        admin: address,
        manager: address,
    }

    struct ManagerRevokedEvent has copy, drop {
        registry_address: address,
        admin: address,
        manager: address,
    }

    struct TreasuryReleasedEvent has copy, drop {
        coin_address: address,
        creator: address,
        amount: u64,
        released_by: address,
    }

    struct EnhancedFeeProcessedEvent has copy, drop {
        coin_address: address,
        creator: address,
        is_buy: bool,
        fee_mode: u8,
        fee_amount: u64,
        tokens_burned: 0x1::option::Option<u64>,
    }

    public fun get_treasury_balance_for_creator<T0>(arg0: &CoinInfo<T0>, arg1: address) : u64 {
        0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::coin_fees::get_treasury_balance_for_creator(&arg0.id, arg1)
    }

    public entry fun buy_tokens<T0>(arg0: &mut 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::Launchpad, arg1: &mut CoinInfo<T0>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::is_emergency_paused(arg0), 15);
        assert!(arg3 >= 1000, 3);
        assert!(!arg1.graduation_locked, 11);
        assert!(!arg1.graduated, 4);
        if (0x1::option::is_some<u64>(&arg1.open_buy_at)) {
            assert!(*0x1::option::borrow<u64>(&arg1.open_buy_at) <= 0x2::clock::timestamp_ms(arg5), 13);
        };
        let v0 = calculate_net_amount_from_gross(arg3, 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::get_platform_fee_bps(arg0));
        assert!(0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::bonding_curve::calculate_tokens_to_mint(arg1.virtual_sui_reserves, arg1.virtual_token_reserves, v0) >= arg4, 6);
        if (would_trigger_graduation<T0>(arg0, arg1, v0)) {
            arg1.graduation_locked = true;
        };
        let (v1, v2) = buy_tokens_helper<T0>(arg0, arg1, arg2, arg3, arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.real_token_reserves, v1, arg6), 0x2::tx_context::sender(arg6));
        arg1.supply = arg1.supply + v1;
        let v3 = TradeEvent{
            is_buy                     : true,
            coin_address               : 0x2::object::uid_to_address(&arg1.id),
            user_address               : 0x2::tx_context::sender(arg6),
            token_amount               : v1,
            sui_amount                 : v0,
            platform_fee_amount        : v2,
            battle_royale_fee_amount   : 0,
            new_supply                 : arg1.supply,
            new_price                  : get_current_price<T0>(arg1),
            new_virtual_sui_reserves   : arg1.virtual_sui_reserves,
            new_virtual_token_reserves : arg1.virtual_token_reserves,
            new_real_sui_reserves      : 0x2::balance::value<0x2::sui::SUI>(&arg1.real_sui_reserves),
            new_real_token_reserves    : 0x2::balance::value<T0>(&arg1.real_token_reserves),
            market_cap                 : 0x1::option::some<u64>(calculate_fdv<T0>(arg1)),
            cetus_pool_sui_liquidity   : 0x1::option::none<u64>(),
            cetus_pool_token_liquidity : 0x1::option::none<u64>(),
            is_graduated_trade         : false,
            is_eligible_for_graduation : 0x1::option::some<bool>(check_graduation_eligibility<T0>(arg0, arg1)),
        };
        0x2::event::emit<TradeEvent>(v3);
    }

    fun buy_tokens_helper<T0>(arg0: &mut 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::Launchpad, arg1: &mut CoinInfo<T0>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        assert!(!arg1.graduated, 4);
        let v0 = 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::get_platform_fee_bps(arg0);
        let v1 = calculate_net_amount_from_gross(arg3, v0);
        let v2 = calculate_transaction_fee(v1, v0);
        let v3 = 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::bonding_curve::calculate_tokens_to_mint(arg1.virtual_sui_reserves, arg1.virtual_token_reserves, v1);
        let v4 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v4 >= arg3, 1);
        if (v4 > arg3) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, v4 - arg3, arg4), 0x2::tx_context::sender(arg4));
        };
        let v5 = 0x2::coin::into_balance<0x2::sui::SUI>(arg2);
        let v6 = &mut v5;
        process_enhanced_fee_logic_buy<T0>(arg1, arg0, v6, v2, arg4);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.real_sui_reserves, v5);
        arg1.virtual_sui_reserves = 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::as_u64(0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::add(0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::from_u64(arg1.virtual_sui_reserves), 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::from_u64(v1)));
        arg1.virtual_token_reserves = 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::as_u64(0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::sub(0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::from_u64(arg1.virtual_token_reserves), 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::from_u64(v3)));
        (v3, v2)
    }

    fun buy_tokens_initial_purchase<T0>(arg0: &mut 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::Launchpad, arg1: &mut CoinInfo<T0>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.graduated, 4);
        assert!(arg3 >= 1000, 3);
        let v0 = 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::get_platform_fee_bps(arg0);
        let v1 = calculate_net_amount_from_gross(arg3, v0);
        let v2 = calculate_transaction_fee(v1, v0);
        let v3 = 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::bonding_curve::calculate_tokens_to_mint(arg1.virtual_sui_reserves, arg1.virtual_token_reserves, v1);
        let v4 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v4 >= arg3, 1);
        if (v4 > arg3) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, v4 - arg3, arg4), 0x2::tx_context::sender(arg4));
        };
        let v5 = 0x2::coin::into_balance<0x2::sui::SUI>(arg2);
        if (would_trigger_graduation<T0>(arg0, arg1, v1)) {
            arg1.graduation_locked = true;
        };
        0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::add_to_treasury(arg0, 0x2::balance::split<0x2::sui::SUI>(&mut v5, v2));
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.real_sui_reserves, v5);
        arg1.virtual_sui_reserves = 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::as_u64(0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::add(0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::from_u64(arg1.virtual_sui_reserves), 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::from_u64(v1)));
        arg1.virtual_token_reserves = 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::as_u64(0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::sub(0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::from_u64(arg1.virtual_token_reserves), 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::from_u64(v3)));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.real_token_reserves, v3, arg4), 0x2::tx_context::sender(arg4));
        arg1.supply = arg1.supply + v3;
        let v6 = TradeEvent{
            is_buy                     : true,
            coin_address               : 0x2::object::uid_to_address(&arg1.id),
            user_address               : 0x2::tx_context::sender(arg4),
            token_amount               : v3,
            sui_amount                 : v1,
            platform_fee_amount        : v2,
            battle_royale_fee_amount   : 0,
            new_supply                 : arg1.supply,
            new_price                  : get_current_price<T0>(arg1),
            new_virtual_sui_reserves   : arg1.virtual_sui_reserves,
            new_virtual_token_reserves : arg1.virtual_token_reserves,
            new_real_sui_reserves      : 0x2::balance::value<0x2::sui::SUI>(&arg1.real_sui_reserves),
            new_real_token_reserves    : 0x2::balance::value<T0>(&arg1.real_token_reserves),
            market_cap                 : 0x1::option::some<u64>(calculate_fdv<T0>(arg1)),
            cetus_pool_sui_liquidity   : 0x1::option::none<u64>(),
            cetus_pool_token_liquidity : 0x1::option::none<u64>(),
            is_graduated_trade         : false,
            is_eligible_for_graduation : 0x1::option::some<bool>(check_graduation_eligibility<T0>(arg0, arg1)),
        };
        0x2::event::emit<TradeEvent>(v6);
    }

    fun buy_tokens_initial_purchase_with_br<T0>(arg0: &mut 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::Launchpad, arg1: &mut CoinInfo<T0>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &mut 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::battle_royale::BattleRoyale, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.graduated, 4);
        assert!(arg3 >= 1000, 3);
        let v0 = 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::get_platform_fee_bps(arg0);
        let v1 = calculate_net_amount_from_gross(arg3, v0);
        let v2 = calculate_transaction_fee(v1, v0);
        let v3 = 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::bonding_curve::calculate_tokens_to_mint(arg1.virtual_sui_reserves, arg1.virtual_token_reserves, v1);
        let v4 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v4 >= arg3, 1);
        if (v4 > arg3) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, v4 - arg3, arg6), 0x2::tx_context::sender(arg6));
        };
        let v5 = 0x2::coin::into_balance<0x2::sui::SUI>(arg2);
        let v6 = 0x2::object::uid_to_address(&arg1.id);
        let v7 = 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::as_u64(0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::percentage_of_round_up(0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::from_u64(v2), 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::battle_royale::get_br_fee_bps(arg4)));
        if (0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::battle_royale::is_coin_valid_for_battle_royale(arg4, v6, 0x2::clock::timestamp_ms(arg5)) && v7 > 0) {
            0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::battle_royale::contribute_trade_fee(arg0, arg4, v6, 0x2::balance::split<0x2::sui::SUI>(&mut v5, v7), arg5);
            0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::add_to_treasury(arg0, 0x2::balance::split<0x2::sui::SUI>(&mut v5, v2 - v7));
        } else {
            0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::add_to_treasury(arg0, 0x2::balance::split<0x2::sui::SUI>(&mut v5, v2));
        };
        if (would_trigger_graduation<T0>(arg0, arg1, v1)) {
            arg1.graduation_locked = true;
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.real_sui_reserves, v5);
        arg1.virtual_sui_reserves = 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::as_u64(0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::add(0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::from_u64(arg1.virtual_sui_reserves), 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::from_u64(v1)));
        arg1.virtual_token_reserves = 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::as_u64(0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::sub(0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::from_u64(arg1.virtual_token_reserves), 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::from_u64(v3)));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.real_token_reserves, v3, arg6), 0x2::tx_context::sender(arg6));
        arg1.supply = arg1.supply + v3;
        let v8 = if (v7 > 0) {
            v2 - v7
        } else {
            v2
        };
        let v9 = TradeEvent{
            is_buy                     : true,
            coin_address               : v6,
            user_address               : 0x2::tx_context::sender(arg6),
            token_amount               : v3,
            sui_amount                 : v1,
            platform_fee_amount        : v8,
            battle_royale_fee_amount   : v7,
            new_supply                 : arg1.supply,
            new_price                  : get_current_price<T0>(arg1),
            new_virtual_sui_reserves   : arg1.virtual_sui_reserves,
            new_virtual_token_reserves : arg1.virtual_token_reserves,
            new_real_sui_reserves      : 0x2::balance::value<0x2::sui::SUI>(&arg1.real_sui_reserves),
            new_real_token_reserves    : 0x2::balance::value<T0>(&arg1.real_token_reserves),
            market_cap                 : 0x1::option::some<u64>(calculate_fdv<T0>(arg1)),
            cetus_pool_sui_liquidity   : 0x1::option::none<u64>(),
            cetus_pool_token_liquidity : 0x1::option::none<u64>(),
            is_graduated_trade         : false,
            is_eligible_for_graduation : 0x1::option::some<bool>(check_graduation_eligibility<T0>(arg0, arg1)),
        };
        0x2::event::emit<TradeEvent>(v9);
    }

    public entry fun buy_tokens_with_br<T0>(arg0: &mut 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::Launchpad, arg1: &mut CoinInfo<T0>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::battle_royale::BattleRoyale, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg5);
        assert!(!0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::is_emergency_paused(arg0), 15);
        assert!(!arg1.graduation_locked, 11);
        if (0x1::option::is_some<u64>(&arg1.open_buy_at)) {
            assert!(*0x1::option::borrow<u64>(&arg1.open_buy_at) <= v0, 13);
        };
        let v1 = 0x2::object::uid_to_address(&arg1.id);
        let v2 = calculate_transaction_fee(arg3, 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::get_platform_fee_bps(arg0));
        let v3 = v2;
        let v4 = arg3 - v2;
        if (would_trigger_graduation<T0>(arg0, arg1, v4)) {
            arg1.graduation_locked = true;
        };
        assert!(0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::battle_royale::is_coin_valid_for_battle_royale(arg6, v1, v0), 5);
        assert!(arg3 >= 1000, 3);
        let v5 = 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::bonding_curve::calculate_tokens_to_mint(arg1.virtual_sui_reserves, arg1.virtual_token_reserves, v4);
        assert!(v5 >= arg4, 6);
        let v6 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v6 >= arg3, 1);
        if (v6 > arg3) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, v6 - arg3, arg7), 0x2::tx_context::sender(arg7));
        };
        let v7 = 0x2::coin::into_balance<0x2::sui::SUI>(arg2);
        let v8 = 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::as_u64(0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::percentage_of_round_up(0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::from_u64(v2), 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::battle_royale::get_br_fee_bps(arg6)));
        if (0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::battle_royale::is_coin_valid_for_battle_royale(arg6, v1, v0) && v8 > 0) {
            v3 = v2 - v8;
            0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::battle_royale::contribute_trade_fee(arg0, arg6, v1, 0x2::balance::split<0x2::sui::SUI>(&mut v7, v8), arg5);
        };
        let v9 = &mut v7;
        process_enhanced_fee_logic_buy<T0>(arg1, arg0, v9, v3, arg7);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.real_sui_reserves, v7);
        arg1.virtual_sui_reserves = 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::as_u64(0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::add(0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::from_u64(arg1.virtual_sui_reserves), 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::from_u64(v4)));
        arg1.virtual_token_reserves = 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::as_u64(0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::sub(0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::from_u64(arg1.virtual_token_reserves), 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::from_u64(v5)));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.real_token_reserves, v5, arg7), 0x2::tx_context::sender(arg7));
        arg1.supply = arg1.supply + v5;
        let v10 = TradeEvent{
            is_buy                     : true,
            coin_address               : v1,
            user_address               : 0x2::tx_context::sender(arg7),
            token_amount               : v5,
            sui_amount                 : v4,
            platform_fee_amount        : v3,
            battle_royale_fee_amount   : v8,
            new_supply                 : arg1.supply,
            new_price                  : get_current_price<T0>(arg1),
            new_virtual_sui_reserves   : arg1.virtual_sui_reserves,
            new_virtual_token_reserves : arg1.virtual_token_reserves,
            new_real_sui_reserves      : 0x2::balance::value<0x2::sui::SUI>(&arg1.real_sui_reserves),
            new_real_token_reserves    : 0x2::balance::value<T0>(&arg1.real_token_reserves),
            market_cap                 : 0x1::option::some<u64>(calculate_fdv<T0>(arg1)),
            cetus_pool_sui_liquidity   : 0x1::option::none<u64>(),
            cetus_pool_token_liquidity : 0x1::option::none<u64>(),
            is_graduated_trade         : false,
            is_eligible_for_graduation : 0x1::option::some<bool>(check_graduation_eligibility<T0>(arg0, arg1)),
        };
        0x2::event::emit<TradeEvent>(v10);
    }

    public fun calculate_fdv<T0>(arg0: &CoinInfo<T0>) : u64 {
        0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::as_u64(0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::mul(0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::from_u64(get_current_price<T0>(arg0)), 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::from_u64(0x2::coin::total_supply<T0>(&arg0.protected_cap.cap) / 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::as_u64(0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::pow(0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::from_u64(10), (arg0.token_decimals as u64))))))
    }

    fun calculate_graduated_market_cap<T0>(arg0: &CoinInfo<T0>, arg1: u64) : u64 {
        0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::as_u64(0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::div(0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::mul(0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::from_u64(arg1), 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::from_u64(0x2::coin::total_supply<T0>(&arg0.protected_cap.cap))), 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::from_u64(0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::as_u64(0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::pow(0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::from_u64(10), (arg0.token_decimals as u64))))))
    }

    public fun calculate_market_cap<T0>(arg0: &CoinInfo<T0>) : u64 {
        0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::as_u64(0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::mul(0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::from_u64(get_current_price<T0>(arg0)), 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::from_u64(arg0.supply / 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::as_u64(0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::pow(0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::from_u64(10), (arg0.token_decimals as u64))))))
    }

    fun calculate_net_amount_from_gross(arg0: u64, arg1: u64) : u64 {
        if (arg1 == 0) {
            return arg0
        };
        0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::as_u64(0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::div(0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::mul(0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::from_u64(arg0), 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::from_u64(10000)), 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::from_u64(10000 + arg1)))
    }

    fun calculate_transaction_fee(arg0: u64, arg1: u64) : u64 {
        0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::as_u64(0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::percentage_of_round_up(0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::from_u64(arg0), arg1))
    }

    public fun can_manage(arg0: &0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::Launchpad, arg1: &CoinManagerRegistry, arg2: address) : bool {
        arg2 == 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::get_admin(arg0) || is_manager(arg1, arg2)
    }

    public fun check_graduation_economics<T0>(arg0: &0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::Launchpad, arg1: &CoinInfo<T0>) : (bool, u64, u64) {
        if (arg1.graduated) {
            return (false, 0, 0)
        };
        0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::graduation::validate_graduation_economics(arg0, 0x2::balance::value<0x2::sui::SUI>(&arg1.real_sui_reserves), get_current_price<T0>(arg1), 0x2::balance::value<T0>(&arg1.amm_reserve_balance), arg1.token_decimals)
    }

    public fun check_graduation_eligibility<T0>(arg0: &0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::Launchpad, arg1: &CoinInfo<T0>) : bool {
        0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::graduation::check_graduation_eligibility(arg0, 0x2::balance::value<0x2::sui::SUI>(&arg1.real_sui_reserves), arg1.graduated)
    }

    public entry fun claim_creator_fee_treasury<T0>(arg0: &mut CoinInfo<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == arg0.creator, 19);
        let (v1, v2) = 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::coin_fees::release_treasury_to_creator(&mut arg0.id, arg1);
        if (v2 > 0) {
            let v3 = TreasuryReleasedEvent{
                coin_address : 0x2::object::uid_to_address(&arg0.id),
                creator      : v1,
                amount       : v2,
                released_by  : v0,
            };
            0x2::event::emit<TreasuryReleasedEvent>(v3);
        };
    }

    public entry fun create_coin<T0>(arg0: &mut 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::Launchpad, arg1: 0x2::coin::TreasuryCap<T0>, arg2: &mut 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::LaunchedCoinsRegistry, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: 0x1::string::String, arg12: address, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) : address {
        assert!(!0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::is_emergency_paused(arg0), 15);
        let (v0, v1) = create_coin_internal<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, 0x1::option::none<address>(), 0x1::option::none<u64>(), 0x1::option::none<u64>(), arg14);
        0x2::transfer::share_object<CoinInfo<T0>>(v1);
        v0
    }

    public entry fun create_coin_and_register_for_br<T0>(arg0: &mut 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::Launchpad, arg1: 0x2::coin::TreasuryCap<T0>, arg2: &mut 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::LaunchedCoinsRegistry, arg3: &mut 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::battle_royale::BattleRoyale, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: 0x1::string::String, arg12: 0x1::string::String, arg13: address, arg14: u64, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) : address {
        assert!(!0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::is_emergency_paused(arg0), 15);
        let v0 = 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::battle_royale::get_participation_fee(arg3);
        let v1 = 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::get_creation_fee(arg0);
        let v2 = v0 + v1 + arg14;
        let v3 = 0x2::coin::value<0x2::sui::SUI>(&arg4);
        assert!(v3 >= v2, 1);
        if (v3 > v2) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg4, v3 - v2, arg16), 0x2::tx_context::sender(arg16));
        };
        let (v4, v5) = 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::battle_royale::register_participant_and_split_payment(arg0, arg3, 0x2::coin::split<0x2::sui::SUI>(&mut arg4, v0 + v1, arg16), arg15, arg16);
        assert!(v5, 12);
        let (v6, v7) = create_coin_internal<T0>(arg0, arg1, arg2, v4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg15, 0x1::option::some<address>(0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::battle_royale::get_address(arg3)), 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::battle_royale::get_open_buy_at(arg3), 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::battle_royale::get_open_sell_at(arg3), arg16);
        let v8 = v7;
        let v9 = 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::battle_royale::get_coin_fee_config(arg3);
        0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::coin_fees::add_fee_config(&mut v8.id, v8.creator, 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::coin_fees::get_config_buy_fee_split_bps(&v9), 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::coin_fees::get_config_sell_fee_split_bps(&v9), 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::coin_fees::get_config_buy_fee_mode(&v9), 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::coin_fees::get_config_sell_fee_mode(&v9), true);
        if (arg14 > 0) {
            let v10 = &mut v8;
            buy_tokens_initial_purchase_with_br<T0>(arg0, v10, arg4, arg14, arg3, arg15, arg16);
        } else if (0x2::coin::value<0x2::sui::SUI>(&arg4) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg4, 0x2::tx_context::sender(arg16));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg4);
        };
        0x2::transfer::share_object<CoinInfo<T0>>(v8);
        0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::battle_royale::register_coin(arg3, v6, arg15, arg16);
        v6
    }

    public entry fun create_coin_for_br<T0>(arg0: &mut 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::Launchpad, arg1: 0x2::coin::TreasuryCap<T0>, arg2: &mut 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::LaunchedCoinsRegistry, arg3: &mut 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::battle_royale::BattleRoyale, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: 0x1::string::String, arg12: 0x1::string::String, arg13: address, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) : address {
        assert!(!0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::is_emergency_paused(arg0), 15);
        let (v0, v1) = create_coin_internal<T0>(arg0, arg1, arg2, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, 0x1::option::some<address>(0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::battle_royale::get_address(arg3)), 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::battle_royale::get_open_buy_at(arg3), 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::battle_royale::get_open_sell_at(arg3), arg15);
        0x2::transfer::share_object<CoinInfo<T0>>(v1);
        0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::battle_royale::register_coin(arg3, v0, arg14, arg15);
        v0
    }

    public entry fun create_coin_for_br_v2<T0>(arg0: &mut 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::Launchpad, arg1: 0x2::coin::TreasuryCap<T0>, arg2: &mut 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::LaunchedCoinsRegistry, arg3: &mut 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::battle_royale::BattleRoyale, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: 0x1::string::String, arg12: 0x1::string::String, arg13: address, arg14: u64, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) : address {
        assert!(!0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::is_emergency_paused(arg0), 15);
        let v0 = 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::get_creation_fee(arg0);
        let v1 = v0 + arg14;
        let v2 = 0x2::coin::value<0x2::sui::SUI>(&arg4);
        assert!(v2 >= v1, 1);
        let v3 = if (v2 > v1) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg4, v2 - v1, arg16), 0x2::tx_context::sender(arg16));
            0x2::coin::split<0x2::sui::SUI>(&mut arg4, v0, arg16)
        } else {
            0x2::coin::split<0x2::sui::SUI>(&mut arg4, v0, arg16)
        };
        let (v4, v5) = create_coin_internal<T0>(arg0, arg1, arg2, v3, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg15, 0x1::option::some<address>(0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::battle_royale::get_address(arg3)), 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::battle_royale::get_open_buy_at(arg3), 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::battle_royale::get_open_sell_at(arg3), arg16);
        let v6 = v5;
        let v7 = 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::battle_royale::get_coin_fee_config(arg3);
        0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::coin_fees::add_fee_config(&mut v6.id, v6.creator, 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::coin_fees::get_config_buy_fee_split_bps(&v7), 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::coin_fees::get_config_sell_fee_split_bps(&v7), 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::coin_fees::get_config_buy_fee_mode(&v7), 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::coin_fees::get_config_sell_fee_mode(&v7), true);
        if (arg14 > 0) {
            let v8 = &mut v6;
            buy_tokens_initial_purchase_with_br<T0>(arg0, v8, arg4, arg14, arg3, arg15, arg16);
        } else if (0x2::coin::value<0x2::sui::SUI>(&arg4) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg4, 0x2::tx_context::sender(arg16));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg4);
        };
        0x2::transfer::share_object<CoinInfo<T0>>(v6);
        0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::battle_royale::register_coin(arg3, v4, arg15, arg16);
        v4
    }

    fun create_coin_internal<T0>(arg0: &mut 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::Launchpad, arg1: 0x2::coin::TreasuryCap<T0>, arg2: &mut 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::LaunchedCoinsRegistry, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: 0x1::string::String, arg12: address, arg13: &0x2::clock::Clock, arg14: 0x1::option::Option<address>, arg15: 0x1::option::Option<u64>, arg16: 0x1::option::Option<u64>, arg17: &mut 0x2::tx_context::TxContext) : (address, CoinInfo<T0>) {
        let v0 = 0x2::clock::timestamp_ms(arg13);
        assert!(validate_inputs(arg4, arg5), 0);
        let v1 = 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::get_creation_fee(arg0);
        let v2 = 0x2::coin::value<0x2::sui::SUI>(&arg3);
        assert!(v2 >= v1, 1);
        if (v2 > v1) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg3, v2 - v1, arg17), 0x2::tx_context::sender(arg17));
        };
        0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::add_to_treasury(arg0, 0x2::coin::into_balance<0x2::sui::SUI>(arg3));
        let v3 = ProtectedTreasuryCap<T0>{cap: arg1};
        let v4 = 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::get_initial_virtual_tokens(arg0);
        let v5 = 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::get_token_decimals(arg0);
        let v6 = 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::calculate_bonding_curve_tokens(arg0);
        let v7 = 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::calculate_amm_reserve_tokens(arg0);
        let v8 = 0x2::coin::mint<T0>(&mut v3.cap, v4, arg17);
        let v9 = CoinInfo<T0>{
            id                     : 0x2::object::new(arg17),
            version                : 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::get_version(arg0),
            name                   : arg4,
            symbol                 : arg5,
            description            : arg6,
            image_url              : 0x2::url::new_unsafe_from_bytes(*0x1::string::as_bytes(&arg10)),
            creator                : 0x2::tx_context::sender(arg17),
            launch_time            : v0,
            coin_type              : arg11,
            coin_metadata_id       : arg12,
            token_decimals         : v5,
            protected_cap          : v3,
            supply                 : 0,
            bonding_curve_tokens   : v6,
            amm_reserve_tokens     : v7,
            total_token_supply     : v4,
            real_token_reserves    : 0x2::coin::into_balance<T0>(v8),
            amm_reserve_balance    : 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v8, v7, arg17)),
            real_sui_reserves      : 0x2::balance::zero<0x2::sui::SUI>(),
            virtual_token_reserves : v6,
            virtual_sui_reserves   : 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::get_initial_virtual_sui(arg0),
            graduated              : false,
            dex_name               : 0x1::option::none<0x1::string::String>(),
            pool_id                : 0x1::option::none<address>(),
            graduation_locked      : false,
            open_buy_at            : arg15,
            open_sell_at           : arg16,
            grace_period_ends_at   : 0x1::option::none<u64>(),
        };
        let v10 = 0x2::object::uid_to_address(&v9.id);
        let v11 = CoinCreatedEvent{
            name                   : arg4,
            symbol                 : arg5,
            image_url              : arg10,
            description            : arg6,
            website                : arg7,
            telegram               : arg8,
            twitter                : arg9,
            creator                : 0x2::tx_context::sender(arg17),
            coin_address           : v10,
            launch_time            : v0,
            virtual_sui_reserves   : v9.virtual_sui_reserves,
            virtual_token_reserves : v9.virtual_token_reserves,
            real_sui_reserves      : 0x2::balance::value<0x2::sui::SUI>(&v9.real_sui_reserves),
            real_token_reserves    : 0x2::balance::value<T0>(&v9.real_token_reserves),
            bonding_curve_tokens   : v9.bonding_curve_tokens,
            amm_reserve_tokens     : v9.amm_reserve_tokens,
            total_token_supply     : v9.total_token_supply,
            token_decimals         : v5,
            coin_type              : v9.coin_type,
            coin_metadata_id       : v9.coin_metadata_id,
            br_address             : arg14,
            grace_period_ends_at   : 0x1::option::none<u64>(),
        };
        0x2::event::emit<CoinCreatedEvent>(v11);
        0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::increment_coins_count(arg0);
        0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::add_to_registry(arg2, v10);
        (v10, v9)
    }

    public entry fun create_coin_v2<T0>(arg0: &mut 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::Launchpad, arg1: 0x2::coin::TreasuryCap<T0>, arg2: &mut 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::LaunchedCoinsRegistry, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: 0x1::string::String, arg12: address, arg13: u64, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) : address {
        assert!(!0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::is_emergency_paused(arg0), 15);
        let v0 = 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::get_creation_fee(arg0);
        let v1 = v0 + arg13;
        let v2 = 0x2::coin::value<0x2::sui::SUI>(&arg3);
        assert!(v2 >= v1, 1);
        let v3 = if (v2 > v1) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg3, v2 - v1, arg15), 0x2::tx_context::sender(arg15));
            0x2::coin::split<0x2::sui::SUI>(&mut arg3, v0, arg15)
        } else {
            0x2::coin::split<0x2::sui::SUI>(&mut arg3, v0, arg15)
        };
        let (v4, v5) = create_coin_internal<T0>(arg0, arg1, arg2, v3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg14, 0x1::option::none<address>(), 0x1::option::none<u64>(), 0x1::option::none<u64>(), arg15);
        let v6 = v5;
        if (arg13 > 0) {
            let v7 = &mut v6;
            buy_tokens_initial_purchase<T0>(arg0, v7, arg3, arg13, arg15);
        } else if (0x2::coin::value<0x2::sui::SUI>(&arg3) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, 0x2::tx_context::sender(arg15));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg3);
        };
        0x2::transfer::share_object<CoinInfo<T0>>(v6);
        v4
    }

    public entry fun create_manager_registry(arg0: &0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::Launchpad, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::get_admin(arg0), 16);
        let v0 = CoinManagerRegistry{
            id       : 0x2::object::new(arg1),
            admin    : 0x2::tx_context::sender(arg1),
            managers : 0x2::table::new<address, bool>(arg1),
        };
        let v1 = ManagerRegistryCreatedEvent{
            registry_address : 0x2::object::uid_to_address(&v0.id),
            admin            : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<ManagerRegistryCreatedEvent>(v1);
        0x2::transfer::share_object<CoinManagerRegistry>(v0);
    }

    public fun get_amm_reserve_balance<T0>(arg0: &CoinInfo<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.amm_reserve_balance)
    }

    public fun get_amm_reserve_tokens<T0>(arg0: &CoinInfo<T0>) : u64 {
        arg0.amm_reserve_tokens
    }

    public fun get_bonding_curve_tokens<T0>(arg0: &CoinInfo<T0>) : u64 {
        arg0.bonding_curve_tokens
    }

    public fun get_creator<T0>(arg0: &CoinInfo<T0>) : address {
        arg0.creator
    }

    public fun get_current_price<T0>(arg0: &CoinInfo<T0>) : u64 {
        0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::bonding_curve::calculate_price(arg0.virtual_sui_reserves, arg0.virtual_token_reserves)
    }

    public fun get_estimated_amm_liquidity<T0>(arg0: &CoinInfo<T0>) : (u64, u64) {
        0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::graduation::get_estimated_amm_liquidity(0x2::balance::value<0x2::sui::SUI>(&arg0.real_sui_reserves), 0x2::balance::value<T0>(&arg0.amm_reserve_balance))
    }

    fun get_graduated_steamm_token_liquidity_simple<T0, T1: drop>(arg0: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<0x2::sui::SUI, T0, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T1>) : (u64, u64) {
        let (v0, v1) = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::balance_amounts<0x2::sui::SUI, T0, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T1>(arg0);
        (v1, v0)
    }

    fun get_graduated_steamm_token_price_simple<T0, T1: drop>(arg0: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<0x2::sui::SUI, T0, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T1>, arg1: u8) : u64 {
        let (v0, v1) = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::balance_amounts<0x2::sui::SUI, T0, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T1>(arg0);
        if (v0 == 0 || v1 == 0) {
            return 0
        };
        let v2 = 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::mul(0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::from_u64(v0), 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::from_u64(0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::as_u64(0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::pow(0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::from_u64(10), (arg1 as u64)))));
        let v3 = 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::from_u64(v1);
        if (v2 < v3) {
            1
        } else {
            0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::as_u64(0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::div(v2, v3))
        }
    }

    public fun get_graduation_progress<T0>(arg0: &0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::Launchpad, arg1: &CoinInfo<T0>) : (u64, u64, u64) {
        0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::graduation::get_graduation_progress(arg0, 0x2::balance::value<0x2::sui::SUI>(&arg1.real_sui_reserves))
    }

    public fun get_graduation_readiness<T0>(arg0: &0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::Launchpad, arg1: &CoinInfo<T0>) : (bool, bool, u64, u64, u64) {
        let (v0, v1, v2) = check_graduation_economics<T0>(arg0, arg1);
        (check_graduation_eligibility<T0>(arg0, arg1), v0, v1, v2, get_current_price<T0>(arg1))
    }

    public fun get_launch_time<T0>(arg0: &CoinInfo<T0>) : u64 {
        arg0.launch_time
    }

    public fun get_name<T0>(arg0: &CoinInfo<T0>) : 0x1::string::String {
        arg0.name
    }

    public fun get_real_sui_reserves<T0>(arg0: &CoinInfo<T0>) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.real_sui_reserves)
    }

    public fun get_real_token_reserves<T0>(arg0: &CoinInfo<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.real_token_reserves)
    }

    public fun get_supply<T0>(arg0: &CoinInfo<T0>) : u64 {
        arg0.supply
    }

    public fun get_symbol<T0>(arg0: &CoinInfo<T0>) : 0x1::string::String {
        arg0.symbol
    }

    public fun get_token_decimals<T0>(arg0: &CoinInfo<T0>) : u8 {
        arg0.token_decimals
    }

    public fun get_virtual_sui_reserves<T0>(arg0: &CoinInfo<T0>) : u64 {
        arg0.virtual_sui_reserves
    }

    public fun get_virtual_token_reserves<T0>(arg0: &CoinInfo<T0>) : u64 {
        arg0.virtual_token_reserves
    }

    public entry fun graduate_to_steamm<T0, T1: drop>(arg0: &mut 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::Launchpad, arg1: &CoinManagerRegistry, arg2: &mut CoinInfo<T0>, arg3: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::registry::Registry, arg4: &0x2::coin::CoinMetadata<0x2::sui::SUI>, arg5: &0x2::coin::CoinMetadata<T0>, arg6: 0x2::coin::TreasuryCap<T1>, arg7: 0x2::coin::CoinMetadata<T1>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(can_manage(arg0, arg1, 0x2::tx_context::sender(arg9)), 17);
        assert!(!0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::is_emergency_paused(arg0), 15);
        assert!(!arg2.graduated, 4);
        assert!(arg2.graduation_locked, 11);
        assert!(check_graduation_eligibility<T0>(arg0, arg2), 8);
        let v0 = 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg2.real_sui_reserves);
        0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::add_to_treasury(arg0, 0x2::balance::split<0x2::sui::SUI>(&mut v0, 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::get_graduation_fee(arg0)));
        let (_, v2, v3) = 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::steamm_graduation::execute_graduation<T0, T1>(arg0, &mut arg2.protected_cap.cap, v0, 0x2::balance::withdraw_all<T0>(&mut arg2.amm_reserve_balance), arg2.amm_reserve_tokens, 0x2::object::uid_to_address(&arg2.id), arg2.coin_type, get_current_price<T0>(arg2), arg2.supply, arg2.graduated, 0x2::balance::value<0x2::sui::SUI>(&arg2.real_sui_reserves), arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        arg2.supply = arg2.supply + v2;
        arg2.graduated = true;
        arg2.dex_name = 0x1::option::some<0x1::string::String>(0x1::string::utf8(b"steamm"));
        arg2.pool_id = 0x1::option::some<address>(v3);
    }

    public entry fun graduate_token<T0>(arg0: &mut 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::Launchpad, arg1: &mut CoinInfo<T0>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg4: &0x2::coin::CoinMetadata<0x2::sui::SUI>, arg5: &0x2::coin::CoinMetadata<T0>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        abort 18
    }

    public entry fun grant_manager_role(arg0: &0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::Launchpad, arg1: &mut CoinManagerRegistry, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::get_admin(arg0) || 0x2::tx_context::sender(arg3) == arg1.admin, 16);
        if (0x2::table::contains<address, bool>(&arg1.managers, arg2)) {
            *0x2::table::borrow_mut<address, bool>(&mut arg1.managers, arg2) = true;
        } else {
            0x2::table::add<address, bool>(&mut arg1.managers, arg2, true);
        };
        let v0 = ManagerGrantedEvent{
            registry_address : 0x2::object::uid_to_address(&arg1.id),
            admin            : 0x2::tx_context::sender(arg3),
            manager          : arg2,
        };
        0x2::event::emit<ManagerGrantedEvent>(v0);
    }

    public fun has_graduated<T0>(arg0: &CoinInfo<T0>) : bool {
        arg0.graduated
    }

    public fun is_graduation_locked<T0>(arg0: &CoinInfo<T0>) : bool {
        arg0.graduation_locked
    }

    public fun is_manager(arg0: &CoinManagerRegistry, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.managers, arg1) && *0x2::table::borrow<address, bool>(&arg0.managers, arg1)
    }

    fun process_enhanced_fee_logic_buy<T0>(arg0: &mut CoinInfo<T0>, arg1: &mut 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::Launchpad, arg2: &mut 0x2::balance::Balance<0x2::sui::SUI>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::coin_fees::get_buy_fee_split_bps(&arg0.id);
        if (v0 > 0) {
            let v1 = 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::as_u64(0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::div(0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::mul(0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::from_u64(arg3), 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::from_u64(v0)), 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::from_u64(10000)));
            let v2 = 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::coin_fees::get_buy_fee_mode(&arg0.id);
            if (v2 == 1) {
                let v3 = 0x2::balance::split<0x2::sui::SUI>(arg2, v1);
                let v4 = 0x2::balance::value<0x2::sui::SUI>(&v3);
                let v5 = 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::bonding_curve::calculate_tokens_to_mint(arg0.virtual_sui_reserves, arg0.virtual_token_reserves, v4);
                assert!(0x2::balance::value<T0>(&arg0.real_token_reserves) >= v5, 2);
                0x2::balance::join<0x2::sui::SUI>(&mut arg0.real_sui_reserves, v3);
                arg0.virtual_sui_reserves = 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::as_u64(0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::add(0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::from_u64(arg0.virtual_sui_reserves), 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::from_u64(v4)));
                arg0.virtual_token_reserves = 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::as_u64(0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::sub(0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::from_u64(arg0.virtual_token_reserves), 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::from_u64(v5)));
                0x2::coin::burn<T0>(&mut arg0.protected_cap.cap, 0x2::coin::take<T0>(&mut arg0.real_token_reserves, v5, arg4));
                let v6 = EnhancedFeeProcessedEvent{
                    coin_address  : 0x2::object::uid_to_address(&arg0.id),
                    creator       : arg0.creator,
                    is_buy        : true,
                    fee_mode      : v2,
                    fee_amount    : v1,
                    tokens_burned : 0x1::option::some<u64>(v5),
                };
                0x2::event::emit<EnhancedFeeProcessedEvent>(v6);
            } else {
                0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::coin_fees::collect_coin_fee(&mut arg0.id, 0x2::balance::split<0x2::sui::SUI>(arg2, v1));
                let v7 = EnhancedFeeProcessedEvent{
                    coin_address  : 0x2::object::uid_to_address(&arg0.id),
                    creator       : arg0.creator,
                    is_buy        : true,
                    fee_mode      : v2,
                    fee_amount    : v1,
                    tokens_burned : 0x1::option::none<u64>(),
                };
                0x2::event::emit<EnhancedFeeProcessedEvent>(v7);
            };
            0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::add_to_treasury(arg1, 0x2::balance::split<0x2::sui::SUI>(arg2, arg3 - v1));
        } else {
            0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::add_to_treasury(arg1, 0x2::balance::split<0x2::sui::SUI>(arg2, arg3));
        };
    }

    fun process_enhanced_fee_logic_sell<T0>(arg0: &mut CoinInfo<T0>, arg1: 0x2::balance::Balance<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        if (arg2 == 0) {
            return arg1
        };
        let v0 = 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::coin_fees::get_sell_fee_split_bps(&arg0.id);
        if (v0 > 0) {
            let v2 = 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::as_u64(0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::div(0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::mul(0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::from_u64(arg2), 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::from_u64(v0)), 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::from_u64(10000)));
            let v3 = 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::coin_fees::get_sell_fee_mode(&arg0.id);
            let v4 = 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg1);
            0x2::balance::destroy_zero<0x2::sui::SUI>(arg1);
            if (v3 == 1) {
                let v5 = 0x2::balance::value<0x2::sui::SUI>(&v4);
                let v6 = 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::bonding_curve::calculate_tokens_to_mint(arg0.virtual_sui_reserves, arg0.virtual_token_reserves, v5);
                assert!(0x2::balance::value<T0>(&arg0.real_token_reserves) >= v6, 2);
                0x2::balance::join<0x2::sui::SUI>(&mut arg0.real_sui_reserves, v4);
                arg0.virtual_sui_reserves = 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::as_u64(0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::add(0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::from_u64(arg0.virtual_sui_reserves), 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::from_u64(v5)));
                arg0.virtual_token_reserves = 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::as_u64(0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::sub(0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::from_u64(arg0.virtual_token_reserves), 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::from_u64(v6)));
                0x2::coin::burn<T0>(&mut arg0.protected_cap.cap, 0x2::coin::take<T0>(&mut arg0.real_token_reserves, v6, arg3));
                let v7 = EnhancedFeeProcessedEvent{
                    coin_address  : 0x2::object::uid_to_address(&arg0.id),
                    creator       : arg0.creator,
                    is_buy        : false,
                    fee_mode      : v3,
                    fee_amount    : v2,
                    tokens_burned : 0x1::option::some<u64>(v6),
                };
                0x2::event::emit<EnhancedFeeProcessedEvent>(v7);
            } else {
                0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::coin_fees::collect_coin_fee(&mut arg0.id, v4);
                let v8 = EnhancedFeeProcessedEvent{
                    coin_address  : 0x2::object::uid_to_address(&arg0.id),
                    creator       : arg0.creator,
                    is_buy        : false,
                    fee_mode      : v3,
                    fee_amount    : v2,
                    tokens_burned : 0x1::option::none<u64>(),
                };
                0x2::event::emit<EnhancedFeeProcessedEvent>(v8);
            };
            0x2::balance::split<0x2::sui::SUI>(&mut arg1, arg2 - v2)
        } else {
            arg1
        }
    }

    public fun quote_graduated_steamm_sui_to_token<T0, T1: drop>(arg0: &0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::Launchpad, arg1: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<0x2::sui::SUI, T0, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T1>, arg2: u64) : (u64, u64) {
        let v0 = calculate_transaction_fee(arg2, 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::get_graduated_swap_fee_bps(arg0));
        let v1 = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::quote_swap<0x2::sui::SUI, T0, T1>(arg1, arg2 - v0, true);
        (0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::quote::amount_out(&v1), v0)
    }

    public fun quote_graduated_steamm_token_to_sui<T0, T1: drop>(arg0: &0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::Launchpad, arg1: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<0x2::sui::SUI, T0, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T1>, arg2: u64) : (u64, u64) {
        let v0 = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::quote_swap<0x2::sui::SUI, T0, T1>(arg1, arg2, false);
        let v1 = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::quote::amount_out(&v0);
        let v2 = calculate_transaction_fee(v1, 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::get_graduated_swap_fee_bps(arg0));
        (v1 - v2, v2)
    }

    public entry fun release_coin_fee_treasury<T0>(arg0: &0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::Launchpad, arg1: &CoinManagerRegistry, arg2: &mut CoinInfo<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(can_manage(arg0, arg1, 0x2::tx_context::sender(arg3)), 16);
        let (v0, v1) = 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::coin_fees::release_treasury_to_creator(&mut arg2.id, arg3);
        if (v1 > 0) {
            let v2 = TreasuryReleasedEvent{
                coin_address : 0x2::object::uid_to_address(&arg2.id),
                creator      : v0,
                amount       : v1,
                released_by  : 0x2::tx_context::sender(arg3),
            };
            0x2::event::emit<TreasuryReleasedEvent>(v2);
        };
    }

    public entry fun revoke_manager_role(arg0: &0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::Launchpad, arg1: &mut CoinManagerRegistry, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::get_admin(arg0) || 0x2::tx_context::sender(arg3) == arg1.admin, 16);
        if (0x2::table::contains<address, bool>(&arg1.managers, arg2)) {
            *0x2::table::borrow_mut<address, bool>(&mut arg1.managers, arg2) = false;
        };
        let v0 = ManagerRevokedEvent{
            registry_address : 0x2::object::uid_to_address(&arg1.id),
            admin            : 0x2::tx_context::sender(arg3),
            manager          : arg2,
        };
        0x2::event::emit<ManagerRevokedEvent>(v0);
    }

    public entry fun sell_tokens<T0>(arg0: &mut 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::Launchpad, arg1: &mut CoinInfo<T0>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::is_emergency_paused(arg0), 15);
        assert!(!arg1.graduation_locked, 11);
        assert!(!arg1.graduated, 11);
        if (0x1::option::is_some<u64>(&arg1.open_sell_at)) {
            assert!(*0x1::option::borrow<u64>(&arg1.open_sell_at) <= 0x2::clock::timestamp_ms(arg4), 14);
        };
        let v0 = 0x2::coin::value<T0>(&arg2);
        let v1 = 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::bonding_curve::calculate_sale_return(arg1.virtual_sui_reserves, arg1.virtual_token_reserves, v0);
        assert!(v1 - calculate_transaction_fee(v1, 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::get_platform_fee_bps(arg0)) >= arg3, 7);
        let (v2, v3, v4) = sell_tokens_helper<T0>(arg0, arg1, v0, arg5);
        if (would_trigger_graduation<T0>(arg0, arg1, v2)) {
            arg1.graduation_locked = true;
        };
        arg1.supply = arg1.supply - v0;
        0x2::coin::burn<T0>(&mut arg1.protected_cap.cap, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v3, 0x2::tx_context::sender(arg5));
        let v5 = TradeEvent{
            is_buy                     : false,
            coin_address               : 0x2::object::uid_to_address(&arg1.id),
            user_address               : 0x2::tx_context::sender(arg5),
            token_amount               : v0,
            sui_amount                 : v2,
            platform_fee_amount        : v4,
            battle_royale_fee_amount   : 0,
            new_supply                 : arg1.supply,
            new_price                  : get_current_price<T0>(arg1),
            new_virtual_sui_reserves   : arg1.virtual_sui_reserves,
            new_virtual_token_reserves : arg1.virtual_token_reserves,
            new_real_sui_reserves      : 0x2::balance::value<0x2::sui::SUI>(&arg1.real_sui_reserves),
            new_real_token_reserves    : 0x2::balance::value<T0>(&arg1.real_token_reserves),
            market_cap                 : 0x1::option::some<u64>(calculate_fdv<T0>(arg1)),
            cetus_pool_sui_liquidity   : 0x1::option::none<u64>(),
            cetus_pool_token_liquidity : 0x1::option::none<u64>(),
            is_graduated_trade         : false,
            is_eligible_for_graduation : 0x1::option::some<bool>(check_graduation_eligibility<T0>(arg0, arg1)),
        };
        0x2::event::emit<TradeEvent>(v5);
    }

    fun sell_tokens_helper<T0>(arg0: &mut 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::Launchpad, arg1: &mut CoinInfo<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (u64, 0x2::coin::Coin<0x2::sui::SUI>, u64) {
        assert!(!arg1.graduated, 4);
        let v0 = 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::bonding_curve::calculate_sale_return(arg1.virtual_sui_reserves, arg1.virtual_token_reserves, arg2);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg1.real_sui_reserves) >= v0, 2);
        let v1 = calculate_transaction_fee(v0, 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::get_platform_fee_bps(arg0));
        arg1.virtual_sui_reserves = 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::as_u64(0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::sub(0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::from_u64(arg1.virtual_sui_reserves), 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::from_u64(v0)));
        arg1.virtual_token_reserves = 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::as_u64(0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::add(0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::from_u64(arg1.virtual_token_reserves), 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::from_u64(arg2)));
        let v2 = 0x2::balance::split<0x2::sui::SUI>(&mut arg1.real_sui_reserves, v0 - v1);
        let v3 = 0x2::balance::split<0x2::sui::SUI>(&mut arg1.real_sui_reserves, v1);
        let v4 = process_enhanced_fee_logic_sell<T0>(arg1, v3, v1, arg3);
        0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::add_to_treasury(arg0, v4);
        (v0, 0x2::coin::from_balance<0x2::sui::SUI>(v2, arg3), v1)
    }

    public entry fun sell_tokens_with_br<T0>(arg0: &mut 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::Launchpad, arg1: &mut CoinInfo<T0>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::battle_royale::BattleRoyale, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::is_emergency_paused(arg0), 15);
        assert!(!arg1.graduation_locked, 11);
        assert!(!arg1.graduated, 11);
        if (0x1::option::is_some<u64>(&arg1.open_sell_at)) {
            assert!(*0x1::option::borrow<u64>(&arg1.open_sell_at) <= 0x2::clock::timestamp_ms(arg4), 14);
        };
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = 0x2::object::uid_to_address(&arg1.id);
        let v2 = 0x2::coin::value<T0>(&arg2);
        assert!(0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::battle_royale::is_battle_royale_active(arg5, v0), 5);
        let v3 = 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::bonding_curve::calculate_sale_return(arg1.virtual_sui_reserves, arg1.virtual_token_reserves, v2);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg1.real_sui_reserves) >= v3, 2);
        let v4 = calculate_transaction_fee(v3, 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::get_platform_fee_bps(arg0));
        let v5 = v3 - v4;
        assert!(v5 >= arg3, 7);
        arg1.virtual_sui_reserves = 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::as_u64(0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::sub(0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::from_u64(arg1.virtual_sui_reserves), 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::from_u64(v3)));
        arg1.virtual_token_reserves = 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::as_u64(0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::add(0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::from_u64(arg1.virtual_token_reserves), 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::from_u64(v2)));
        let v6 = 0x2::balance::split<0x2::sui::SUI>(&mut arg1.real_sui_reserves, v5);
        let v7 = 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::as_u64(0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::percentage_of_round_up(0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::from_u64(v4), 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::battle_royale::get_br_fee_bps(arg5)));
        let v8 = v4 - v7;
        if (0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::battle_royale::is_coin_valid_for_battle_royale(arg5, v1, v0) && v7 > 0) {
            0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::battle_royale::contribute_trade_fee(arg0, arg5, v1, 0x2::balance::split<0x2::sui::SUI>(&mut arg1.real_sui_reserves, v7), arg4);
        };
        let v9 = 0x2::balance::split<0x2::sui::SUI>(&mut arg1.real_sui_reserves, v8);
        let v10 = process_enhanced_fee_logic_sell<T0>(arg1, v9, v8, arg6);
        0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::add_to_treasury(arg0, v10);
        arg1.supply = arg1.supply - v2;
        0x2::coin::burn<T0>(&mut arg1.protected_cap.cap, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v6, arg6), 0x2::tx_context::sender(arg6));
        let v11 = TradeEvent{
            is_buy                     : false,
            coin_address               : v1,
            user_address               : 0x2::tx_context::sender(arg6),
            token_amount               : v2,
            sui_amount                 : v3,
            platform_fee_amount        : v4,
            battle_royale_fee_amount   : v7,
            new_supply                 : arg1.supply,
            new_price                  : get_current_price<T0>(arg1),
            new_virtual_sui_reserves   : arg1.virtual_sui_reserves,
            new_virtual_token_reserves : arg1.virtual_token_reserves,
            new_real_sui_reserves      : 0x2::balance::value<0x2::sui::SUI>(&arg1.real_sui_reserves),
            new_real_token_reserves    : 0x2::balance::value<T0>(&arg1.real_token_reserves),
            market_cap                 : 0x1::option::some<u64>(calculate_fdv<T0>(arg1)),
            cetus_pool_sui_liquidity   : 0x1::option::none<u64>(),
            cetus_pool_token_liquidity : 0x1::option::none<u64>(),
            is_graduated_trade         : false,
            is_eligible_for_graduation : 0x1::option::none<bool>(),
        };
        0x2::event::emit<TradeEvent>(v11);
    }

    public entry fun swap_graduated_steamm_sui_to_token<T0, T1: drop>(arg0: &mut 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::Launchpad, arg1: &CoinInfo<T0>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: u64, arg5: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<0x2::sui::SUI, T0, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T1>, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.graduated, 9);
        assert!(0x1::option::is_some<address>(&arg1.pool_id), 10);
        assert!(arg3 >= 1000, 3);
        let v0 = calculate_transaction_fee(arg3, 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::get_graduated_swap_fee_bps(arg0));
        let v1 = arg3 - v0;
        0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::add_to_treasury(arg0, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, v0, arg6)));
        let v2 = 0x2::coin::zero<T0>(arg6);
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::swap<0x2::sui::SUI, T0, T1>(arg5, &mut arg2, &mut v2, true, v1, arg4, arg6);
        if (0x2::coin::value<0x2::sui::SUI>(&arg2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, 0x2::tx_context::sender(arg6));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg2);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg6));
        let v3 = get_graduated_steamm_token_price_simple<T0, T1>(arg5, arg1.token_decimals);
        let (v4, v5) = get_graduated_steamm_token_liquidity_simple<T0, T1>(arg5);
        let v6 = TradeEvent{
            is_buy                     : true,
            coin_address               : 0x2::object::uid_to_address(&arg1.id),
            user_address               : 0x2::tx_context::sender(arg6),
            token_amount               : 0x2::coin::value<T0>(&v2),
            sui_amount                 : v1,
            platform_fee_amount        : v0,
            battle_royale_fee_amount   : 0,
            new_supply                 : arg1.supply,
            new_price                  : v3,
            new_virtual_sui_reserves   : 0,
            new_virtual_token_reserves : 0,
            new_real_sui_reserves      : 0,
            new_real_token_reserves    : 0,
            market_cap                 : 0x1::option::some<u64>(calculate_graduated_market_cap<T0>(arg1, v3)),
            cetus_pool_sui_liquidity   : 0x1::option::some<u64>(v5),
            cetus_pool_token_liquidity : 0x1::option::some<u64>(v4),
            is_graduated_trade         : true,
            is_eligible_for_graduation : 0x1::option::none<bool>(),
        };
        0x2::event::emit<TradeEvent>(v6);
    }

    public entry fun swap_graduated_steamm_sui_to_token_v2<T0, T1: drop>(arg0: &mut 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::Launchpad, arg1: &mut CoinInfo<T0>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: u64, arg5: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<0x2::sui::SUI, T0, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T1>, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.graduated, 9);
        assert!(0x1::option::is_some<address>(&arg1.pool_id), 10);
        assert!(arg3 >= 1000, 3);
        let v0 = calculate_transaction_fee(arg3, 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::get_graduated_swap_fee_bps(arg0));
        let v1 = arg3 - v0;
        let v2 = 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, v0, arg6));
        let v3 = &mut v2;
        process_enhanced_fee_logic_buy<T0>(arg1, arg0, v3, v0, arg6);
        0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::add_to_treasury(arg0, v2);
        let v4 = 0x2::coin::zero<T0>(arg6);
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::swap<0x2::sui::SUI, T0, T1>(arg5, &mut arg2, &mut v4, true, v1, arg4, arg6);
        if (0x2::coin::value<0x2::sui::SUI>(&arg2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, 0x2::tx_context::sender(arg6));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg2);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg6));
        let v5 = get_graduated_steamm_token_price_simple<T0, T1>(arg5, arg1.token_decimals);
        let (v6, v7) = get_graduated_steamm_token_liquidity_simple<T0, T1>(arg5);
        let v8 = TradeEvent{
            is_buy                     : true,
            coin_address               : 0x2::object::uid_to_address(&arg1.id),
            user_address               : 0x2::tx_context::sender(arg6),
            token_amount               : 0x2::coin::value<T0>(&v4),
            sui_amount                 : v1,
            platform_fee_amount        : v0,
            battle_royale_fee_amount   : 0,
            new_supply                 : arg1.supply,
            new_price                  : v5,
            new_virtual_sui_reserves   : 0,
            new_virtual_token_reserves : 0,
            new_real_sui_reserves      : 0,
            new_real_token_reserves    : 0,
            market_cap                 : 0x1::option::some<u64>(calculate_graduated_market_cap<T0>(arg1, v5)),
            cetus_pool_sui_liquidity   : 0x1::option::some<u64>(v7),
            cetus_pool_token_liquidity : 0x1::option::some<u64>(v6),
            is_graduated_trade         : true,
            is_eligible_for_graduation : 0x1::option::none<bool>(),
        };
        0x2::event::emit<TradeEvent>(v8);
    }

    public entry fun swap_graduated_steamm_token_to_sui<T0, T1: drop>(arg0: &mut 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::Launchpad, arg1: &CoinInfo<T0>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<0x2::sui::SUI, T0, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T1>, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.graduated, 9);
        assert!(0x1::option::is_some<address>(&arg1.pool_id), 10);
        assert!(arg3 >= 1000, 3);
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 >= arg3, 2);
        let arg2 = if (v0 == arg3) {
            arg2
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg2, v0 - arg3, arg6), 0x2::tx_context::sender(arg6));
            arg2
        };
        let v1 = 0x2::coin::zero<0x2::sui::SUI>(arg6);
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::swap<0x2::sui::SUI, T0, T1>(arg5, &mut v1, &mut arg2, false, arg3, arg4, arg6);
        let v2 = 0x2::coin::value<0x2::sui::SUI>(&v1);
        0x2::coin::destroy_zero<T0>(arg2);
        let v3 = calculate_transaction_fee(v2, 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::get_graduated_swap_fee_bps(arg0));
        0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::add_to_treasury(arg0, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v1, v3, arg6)));
        let v4 = v2 - v3;
        assert!(v4 >= arg4, 7);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v1, 0x2::tx_context::sender(arg6));
        let v5 = get_graduated_steamm_token_price_simple<T0, T1>(arg5, arg1.token_decimals);
        let (v6, v7) = get_graduated_steamm_token_liquidity_simple<T0, T1>(arg5);
        let v8 = TradeEvent{
            is_buy                     : false,
            coin_address               : 0x2::object::uid_to_address(&arg1.id),
            user_address               : 0x2::tx_context::sender(arg6),
            token_amount               : arg3,
            sui_amount                 : v4,
            platform_fee_amount        : v3,
            battle_royale_fee_amount   : 0,
            new_supply                 : arg1.supply,
            new_price                  : v5,
            new_virtual_sui_reserves   : 0,
            new_virtual_token_reserves : 0,
            new_real_sui_reserves      : 0,
            new_real_token_reserves    : 0,
            market_cap                 : 0x1::option::some<u64>(calculate_graduated_market_cap<T0>(arg1, v5)),
            cetus_pool_sui_liquidity   : 0x1::option::some<u64>(v7),
            cetus_pool_token_liquidity : 0x1::option::some<u64>(v6),
            is_graduated_trade         : true,
            is_eligible_for_graduation : 0x1::option::none<bool>(),
        };
        0x2::event::emit<TradeEvent>(v8);
    }

    public entry fun swap_graduated_steamm_token_to_sui_v2<T0, T1: drop>(arg0: &mut 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::Launchpad, arg1: &mut CoinInfo<T0>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<0x2::sui::SUI, T0, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T1>, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.graduated, 9);
        assert!(0x1::option::is_some<address>(&arg1.pool_id), 10);
        assert!(arg3 >= 1000, 3);
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 >= arg3, 2);
        let arg2 = if (v0 == arg3) {
            arg2
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg2, v0 - arg3, arg6), 0x2::tx_context::sender(arg6));
            arg2
        };
        let v1 = 0x2::coin::zero<0x2::sui::SUI>(arg6);
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::swap<0x2::sui::SUI, T0, T1>(arg5, &mut v1, &mut arg2, false, arg3, arg4, arg6);
        let v2 = 0x2::coin::value<0x2::sui::SUI>(&v1);
        0x2::coin::destroy_zero<T0>(arg2);
        let v3 = calculate_transaction_fee(v2, 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::get_graduated_swap_fee_bps(arg0));
        let v4 = 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v1, v3, arg6));
        let v5 = process_enhanced_fee_logic_sell<T0>(arg1, v4, v3, arg6);
        0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::add_to_treasury(arg0, v5);
        let v6 = v2 - v3;
        assert!(v6 >= arg4, 7);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v1, 0x2::tx_context::sender(arg6));
        let v7 = get_graduated_steamm_token_price_simple<T0, T1>(arg5, arg1.token_decimals);
        let (v8, v9) = get_graduated_steamm_token_liquidity_simple<T0, T1>(arg5);
        let v10 = TradeEvent{
            is_buy                     : false,
            coin_address               : 0x2::object::uid_to_address(&arg1.id),
            user_address               : 0x2::tx_context::sender(arg6),
            token_amount               : arg3,
            sui_amount                 : v6,
            platform_fee_amount        : v3,
            battle_royale_fee_amount   : 0,
            new_supply                 : arg1.supply,
            new_price                  : v7,
            new_virtual_sui_reserves   : 0,
            new_virtual_token_reserves : 0,
            new_real_sui_reserves      : 0,
            new_real_token_reserves    : 0,
            market_cap                 : 0x1::option::some<u64>(calculate_graduated_market_cap<T0>(arg1, v7)),
            cetus_pool_sui_liquidity   : 0x1::option::some<u64>(v9),
            cetus_pool_token_liquidity : 0x1::option::some<u64>(v8),
            is_graduated_trade         : true,
            is_eligible_for_graduation : 0x1::option::none<bool>(),
        };
        0x2::event::emit<TradeEvent>(v10);
    }

    public entry fun swap_graduated_sui_to_token<T0>(arg0: &mut 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::Launchpad, arg1: &CoinInfo<T0>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: u64, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        abort 18
    }

    public entry fun swap_graduated_token_to_sui<T0>(arg0: &mut 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::Launchpad, arg1: &CoinInfo<T0>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        abort 18
    }

    fun validate_inputs(arg0: 0x1::string::String, arg1: 0x1::string::String) : bool {
        if (0x1::string::length(&arg0) > 0) {
            if (0x1::string::length(&arg0) <= 32) {
                if (0x1::string::length(&arg1) > 0) {
                    0x1::string::length(&arg1) <= 10
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        }
    }

    fun would_trigger_graduation<T0>(arg0: &0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::Launchpad, arg1: &CoinInfo<T0>, arg2: u64) : bool {
        if (arg1.graduated) {
            return false
        };
        0x2::balance::value<0x2::sui::SUI>(&arg1.real_sui_reserves) + arg2 >= 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::get_graduation_threshold(arg0)
    }

    // decompiled from Move bytecode v6
}

