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

    public entry fun buy_tokens<T0>(arg0: &mut 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::Launchpad, arg1: &mut CoinInfo<T0>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg5);
        assert!(!0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::is_emergency_paused(arg0), 15);
        assert!(arg3 >= 1, 3);
        assert!(!arg1.graduation_locked, 11);
        assert!(!arg1.graduated, 4);
        if (0x1::option::is_some<u64>(&arg1.open_buy_at)) {
            assert!(*0x1::option::borrow<u64>(&arg1.open_buy_at) <= v0, 13);
        };
        let v1 = arg3 - calculate_transaction_fee(arg3, 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::get_platform_fee_bps(arg0));
        assert!(0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::bonding_curve::calculate_tokens_to_mint(arg1.virtual_sui_reserves, arg1.virtual_token_reserves, v1) >= arg4, 6);
        let v2 = would_trigger_graduation<T0>(arg0, arg1, v1, v0);
        let (v3, v4) = buy_tokens_helper<T0>(arg0, arg1, arg2, arg3, arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.real_token_reserves, v3, arg6), 0x2::tx_context::sender(arg6));
        arg1.supply = arg1.supply + v3;
        if (v2) {
            arg1.graduation_locked = true;
        };
        let v5 = TradeEvent{
            is_buy                     : true,
            coin_address               : 0x2::object::uid_to_address(&arg1.id),
            user_address               : 0x2::tx_context::sender(arg6),
            token_amount               : v3,
            sui_amount                 : v1,
            platform_fee_amount        : v4,
            battle_royale_fee_amount   : 0,
            new_supply                 : arg1.supply,
            new_price                  : get_current_price<T0>(arg1),
            new_virtual_sui_reserves   : arg1.virtual_sui_reserves,
            new_virtual_token_reserves : arg1.virtual_token_reserves,
            new_real_sui_reserves      : 0x2::balance::value<0x2::sui::SUI>(&arg1.real_sui_reserves),
            new_real_token_reserves    : 0x2::balance::value<T0>(&arg1.real_token_reserves),
            market_cap                 : 0x1::option::none<u64>(),
            cetus_pool_sui_liquidity   : 0x1::option::none<u64>(),
            cetus_pool_token_liquidity : 0x1::option::none<u64>(),
            is_graduated_trade         : false,
            is_eligible_for_graduation : 0x1::option::some<bool>(check_graduation_eligibility<T0>(arg0, arg1)),
        };
        0x2::event::emit<TradeEvent>(v5);
    }

    fun buy_tokens_helper<T0>(arg0: &mut 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::Launchpad, arg1: &mut CoinInfo<T0>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        assert!(!arg1.graduated, 4);
        let v0 = calculate_transaction_fee(arg3, 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::get_platform_fee_bps(arg0));
        let v1 = arg3 - v0;
        let v2 = 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::bonding_curve::calculate_tokens_to_mint(arg1.virtual_sui_reserves, arg1.virtual_token_reserves, v1);
        let v3 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v3 >= arg3, 1);
        if (v3 > arg3) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, v3 - arg3, arg4), 0x2::tx_context::sender(arg4));
        };
        let v4 = 0x2::coin::into_balance<0x2::sui::SUI>(arg2);
        0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::add_to_treasury(arg0, 0x2::balance::split<0x2::sui::SUI>(&mut v4, v0));
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.real_sui_reserves, v4);
        arg1.virtual_sui_reserves = arg1.virtual_sui_reserves + v1;
        arg1.virtual_token_reserves = arg1.virtual_token_reserves - v2;
        (v2, v0)
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
        if (would_trigger_graduation<T0>(arg0, arg1, v4, v0)) {
            arg1.graduation_locked = true;
        };
        assert!(0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::battle_royale::is_coin_valid_for_battle_royale(arg6, v1, v0), 5);
        assert!(arg3 >= 1, 3);
        let v5 = 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::bonding_curve::calculate_tokens_to_mint(arg1.virtual_sui_reserves, arg1.virtual_token_reserves, v4);
        assert!(v5 >= arg4, 6);
        let v6 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v6 >= arg3, 1);
        if (v6 > arg3) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, v6 - arg3, arg7), 0x2::tx_context::sender(arg7));
        };
        let v7 = 0x2::coin::into_balance<0x2::sui::SUI>(arg2);
        let v8 = 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::as_u64(0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::percentage_of(0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::from_u64(v2), 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::battle_royale::get_br_fee_bps(arg6)));
        if (0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::battle_royale::is_coin_valid_for_battle_royale(arg6, v1, v0) && v8 > 0) {
            v3 = v2 - v8;
            0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::battle_royale::contribute_trade_fee(arg0, arg6, v1, 0x2::balance::split<0x2::sui::SUI>(&mut v7, v8), arg5);
        };
        0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::add_to_treasury(arg0, 0x2::balance::split<0x2::sui::SUI>(&mut v7, v3));
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.real_sui_reserves, v7);
        arg1.virtual_sui_reserves = arg1.virtual_sui_reserves + v4;
        arg1.virtual_token_reserves = arg1.virtual_token_reserves - v5;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.real_token_reserves, v5, arg7), 0x2::tx_context::sender(arg7));
        arg1.supply = arg1.supply + v5;
        let v9 = TradeEvent{
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
            market_cap                 : 0x1::option::none<u64>(),
            cetus_pool_sui_liquidity   : 0x1::option::none<u64>(),
            cetus_pool_token_liquidity : 0x1::option::none<u64>(),
            is_graduated_trade         : false,
            is_eligible_for_graduation : 0x1::option::some<bool>(check_graduation_eligibility<T0>(arg0, arg1)),
        };
        0x2::event::emit<TradeEvent>(v9);
    }

    fun calculate_graduated_market_cap<T0>(arg0: &CoinInfo<T0>, arg1: u64) : u64 {
        0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::as_u64(0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::div(0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::mul(0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::from_u64(arg1), 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::from_u64(arg0.supply)), 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::from_u64(0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::as_u64(0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::pow(0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::from_u64(10), (arg0.token_decimals as u64))))))
    }

    public fun calculate_market_cap<T0>(arg0: &CoinInfo<T0>) : u64 {
        0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::as_u64(0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::mul(0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::from_u64(get_current_price<T0>(arg0)), 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::from_u64(arg0.supply)))
    }

    fun calculate_transaction_fee(arg0: u64, arg1: u64) : u64 {
        0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::as_u64(0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::percentage_of(0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::from_u64(arg0), arg1))
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

    public entry fun create_coin<T0>(arg0: &mut 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::Launchpad, arg1: 0x2::coin::TreasuryCap<T0>, arg2: &mut 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::LaunchedCoinsRegistry, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: 0x1::string::String, arg12: address, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) : address {
        assert!(!0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::is_emergency_paused(arg0), 15);
        create_coin_internal<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, 0x1::option::none<address>(), 0x1::option::none<u64>(), 0x1::option::none<u64>(), 0x1::option::none<u64>(), arg14)
    }

    public entry fun create_coin_for_br<T0>(arg0: &mut 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::Launchpad, arg1: 0x2::coin::TreasuryCap<T0>, arg2: &mut 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::LaunchedCoinsRegistry, arg3: &mut 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::battle_royale::BattleRoyale, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: 0x1::string::String, arg12: 0x1::string::String, arg13: address, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) : address {
        assert!(!0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::is_emergency_paused(arg0), 15);
        let (v0, v1) = 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::battle_royale::register_participant_and_split_payment(arg0, arg3, arg4, arg14, arg15);
        assert!(v1, 12);
        let v2 = create_coin_internal<T0>(arg0, arg1, arg2, v0, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, 0x1::option::some<address>(0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::battle_royale::get_address(arg3)), 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::battle_royale::get_open_buy_at(arg3), 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::battle_royale::get_open_sell_at(arg3), 0x1::option::some<u64>(0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::battle_royale::get_end_time(arg3) + 1800000), arg15);
        0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::battle_royale::register_coin(arg3, v2, arg14, arg15);
        v2
    }

    fun create_coin_internal<T0>(arg0: &mut 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::Launchpad, arg1: 0x2::coin::TreasuryCap<T0>, arg2: &mut 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::LaunchedCoinsRegistry, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: 0x1::string::String, arg12: address, arg13: &0x2::clock::Clock, arg14: 0x1::option::Option<address>, arg15: 0x1::option::Option<u64>, arg16: 0x1::option::Option<u64>, arg17: 0x1::option::Option<u64>, arg18: &mut 0x2::tx_context::TxContext) : address {
        let v0 = 0x2::clock::timestamp_ms(arg13);
        assert!(validate_inputs(arg4, arg5), 0);
        let v1 = 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::get_creation_fee(arg0);
        let v2 = 0x2::coin::value<0x2::sui::SUI>(&arg3);
        assert!(v2 >= v1, 1);
        if (v2 > v1) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg3, v2 - v1, arg18), 0x2::tx_context::sender(arg18));
        };
        0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::add_to_treasury(arg0, 0x2::coin::into_balance<0x2::sui::SUI>(arg3));
        let v3 = ProtectedTreasuryCap<T0>{cap: arg1};
        let v4 = 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::get_initial_virtual_tokens(arg0);
        let v5 = 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::get_token_decimals(arg0);
        let v6 = 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::calculate_bonding_curve_tokens(arg0);
        let v7 = 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::calculate_amm_reserve_tokens(arg0);
        let v8 = 0x2::coin::mint<T0>(&mut v3.cap, v4, arg18);
        let v9 = CoinInfo<T0>{
            id                     : 0x2::object::new(arg18),
            version                : 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::get_version(arg0),
            name                   : arg4,
            symbol                 : arg5,
            description            : arg6,
            image_url              : 0x2::url::new_unsafe_from_bytes(*0x1::string::as_bytes(&arg10)),
            creator                : 0x2::tx_context::sender(arg18),
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
            amm_reserve_balance    : 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v8, v7, arg18)),
            real_sui_reserves      : 0x2::balance::zero<0x2::sui::SUI>(),
            virtual_token_reserves : v6,
            virtual_sui_reserves   : 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::get_initial_virtual_sui(arg0),
            graduated              : false,
            dex_name               : 0x1::option::none<0x1::string::String>(),
            pool_id                : 0x1::option::none<address>(),
            graduation_locked      : false,
            open_buy_at            : arg15,
            open_sell_at           : arg16,
            grace_period_ends_at   : arg17,
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
            creator                : 0x2::tx_context::sender(arg18),
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
            grace_period_ends_at   : arg17,
        };
        0x2::event::emit<CoinCreatedEvent>(v11);
        0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::increment_coins_count(arg0);
        0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::add_to_registry(arg2, v10);
        0x2::transfer::share_object<CoinInfo<T0>>(v9);
        v10
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

    fun get_graduated_token_liquidity<T0>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>) : (u64, u64) {
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::balances<T0, 0x2::sui::SUI>(arg0);
        (0x2::balance::value<T0>(v0), 0x2::balance::value<0x2::sui::SUI>(v1))
    }

    fun get_graduated_token_price_from_reserves<T0>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg1: u8) : u64 {
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::balances<T0, 0x2::sui::SUI>(arg0);
        let v2 = 0x2::balance::value<T0>(v0);
        let v3 = 0x2::balance::value<0x2::sui::SUI>(v1);
        if (v2 == 0 || v3 == 0) {
            return 0
        };
        let v4 = 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::mul(0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::from_u64(v3), 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::from_u64(0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::as_u64(0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::pow(0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::from_u64(10), (arg1 as u64)))));
        let v5 = 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::from_u64(v2);
        if (v4 < v5) {
            1
        } else {
            0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::as_u64(0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::div(v4, v5))
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

    public entry fun graduate_token<T0>(arg0: &mut 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::Launchpad, arg1: &mut CoinInfo<T0>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg4: &0x2::coin::CoinMetadata<0x2::sui::SUI>, arg5: &0x2::coin::CoinMetadata<T0>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(!0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::is_emergency_paused(arg0), 15);
        assert!(!arg1.graduated, 4);
        assert!(arg1.graduation_locked, 11);
        assert!(check_graduation_eligibility<T0>(arg0, arg1), 8);
        let (v0, _, _) = check_graduation_economics<T0>(arg0, arg1);
        assert!(v0, 8);
        let (_, v4, v5) = 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::graduation::execute_graduation<T0>(arg0, &mut arg1.protected_cap.cap, 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg1.real_sui_reserves), 0x2::balance::withdraw_all<T0>(&mut arg1.amm_reserve_balance), arg1.amm_reserve_tokens, 0x2::object::uid_to_address(&arg1.id), arg1.coin_type, get_current_price<T0>(arg1), arg1.supply, arg1.graduated, 0x2::balance::value<0x2::sui::SUI>(&arg1.real_sui_reserves), arg2, arg3, arg4, arg5, arg6, arg7);
        arg1.supply = arg1.supply + v4;
        arg1.graduated = true;
        arg1.dex_name = 0x1::option::some<0x1::string::String>(0x1::string::utf8(b"cetus"));
        arg1.pool_id = 0x1::option::some<address>(v5);
    }

    public fun has_graduated<T0>(arg0: &CoinInfo<T0>) : bool {
        arg0.graduated
    }

    fun internal_swap<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x2::coin::Coin<T0>, arg3: &mut 0x2::coin::Coin<T1>, arg4: bool, arg5: bool, arg6: u64, arg7: u128, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, arg4, arg5, arg6, arg7, arg8);
        let v3 = v2;
        let v4 = v1;
        let v5 = v0;
        let v6 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3);
        let v7 = if (arg4) {
            0x2::balance::value<T1>(&v4)
        } else {
            0x2::balance::value<T0>(&v5)
        };
        let (v8, v9) = if (arg4) {
            (0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg2, v6, arg9)), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(arg3, v6, arg9)))
        };
        0x2::coin::join<T1>(arg3, 0x2::coin::from_balance<T1>(v4, arg9));
        0x2::coin::join<T0>(arg2, 0x2::coin::from_balance<T0>(v5, arg9));
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, v8, v9, v3);
        (v6, v7)
    }

    public fun is_graduation_locked<T0>(arg0: &CoinInfo<T0>) : bool {
        arg0.graduation_locked
    }

    public entry fun sell_tokens<T0>(arg0: &mut 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::Launchpad, arg1: &mut CoinInfo<T0>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg4);
        assert!(!0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::is_emergency_paused(arg0), 15);
        assert!(!arg1.graduation_locked, 11);
        assert!(!arg1.graduated, 11);
        if (0x1::option::is_some<u64>(&arg1.open_sell_at)) {
            assert!(*0x1::option::borrow<u64>(&arg1.open_sell_at) <= v0, 14);
        };
        let v1 = 0x2::coin::value<T0>(&arg2);
        let v2 = 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::bonding_curve::calculate_sale_return(arg1.virtual_sui_reserves, arg1.virtual_token_reserves, v1);
        assert!(v2 - calculate_transaction_fee(v2, 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::get_platform_fee_bps(arg0)) >= arg3, 7);
        let (v3, v4, v5) = sell_tokens_helper<T0>(arg0, arg1, v1, arg5);
        if (would_trigger_graduation<T0>(arg0, arg1, v3, v0)) {
            arg1.graduation_locked = true;
        };
        arg1.supply = arg1.supply - v1;
        0x2::coin::burn<T0>(&mut arg1.protected_cap.cap, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v4, 0x2::tx_context::sender(arg5));
        let v6 = TradeEvent{
            is_buy                     : false,
            coin_address               : 0x2::object::uid_to_address(&arg1.id),
            user_address               : 0x2::tx_context::sender(arg5),
            token_amount               : v1,
            sui_amount                 : v3,
            platform_fee_amount        : v5,
            battle_royale_fee_amount   : 0,
            new_supply                 : arg1.supply,
            new_price                  : get_current_price<T0>(arg1),
            new_virtual_sui_reserves   : arg1.virtual_sui_reserves,
            new_virtual_token_reserves : arg1.virtual_token_reserves,
            new_real_sui_reserves      : 0x2::balance::value<0x2::sui::SUI>(&arg1.real_sui_reserves),
            new_real_token_reserves    : 0x2::balance::value<T0>(&arg1.real_token_reserves),
            market_cap                 : 0x1::option::none<u64>(),
            cetus_pool_sui_liquidity   : 0x1::option::none<u64>(),
            cetus_pool_token_liquidity : 0x1::option::none<u64>(),
            is_graduated_trade         : false,
            is_eligible_for_graduation : 0x1::option::some<bool>(check_graduation_eligibility<T0>(arg0, arg1)),
        };
        0x2::event::emit<TradeEvent>(v6);
    }

    fun sell_tokens_helper<T0>(arg0: &mut 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::Launchpad, arg1: &mut CoinInfo<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (u64, 0x2::coin::Coin<0x2::sui::SUI>, u64) {
        assert!(!arg1.graduated, 4);
        let v0 = 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::bonding_curve::calculate_sale_return(arg1.virtual_sui_reserves, arg1.virtual_token_reserves, arg2);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg1.real_sui_reserves) >= v0, 2);
        let v1 = calculate_transaction_fee(v0, 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::get_platform_fee_bps(arg0));
        arg1.virtual_sui_reserves = arg1.virtual_sui_reserves - v0;
        arg1.virtual_token_reserves = arg1.virtual_token_reserves + arg2;
        0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::add_to_treasury(arg0, 0x2::balance::split<0x2::sui::SUI>(&mut arg1.real_sui_reserves, v1));
        (v0, 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.real_sui_reserves, v0 - v1), arg3), v1)
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
        arg1.virtual_sui_reserves = arg1.virtual_sui_reserves - v3;
        arg1.virtual_token_reserves = arg1.virtual_token_reserves + v2;
        let v6 = 0x2::balance::split<0x2::sui::SUI>(&mut arg1.real_sui_reserves, v4);
        let v7 = 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::as_u64(0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::percentage_of(0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::from_u64(v4), 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::battle_royale::get_br_fee_bps(arg5)));
        if (0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::battle_royale::is_coin_valid_for_battle_royale(arg5, v1, v0) && v7 > 0) {
            0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::battle_royale::contribute_trade_fee(arg0, arg5, v1, 0x2::balance::split<0x2::sui::SUI>(&mut v6, v7), arg4);
        };
        0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::add_to_treasury(arg0, v6);
        arg1.supply = arg1.supply - v2;
        0x2::coin::burn<T0>(&mut arg1.protected_cap.cap, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.real_sui_reserves, v5), arg6), 0x2::tx_context::sender(arg6));
        let v8 = TradeEvent{
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
            market_cap                 : 0x1::option::none<u64>(),
            cetus_pool_sui_liquidity   : 0x1::option::none<u64>(),
            cetus_pool_token_liquidity : 0x1::option::none<u64>(),
            is_graduated_trade         : false,
            is_eligible_for_graduation : 0x1::option::none<bool>(),
        };
        0x2::event::emit<TradeEvent>(v8);
    }

    public entry fun swap_graduated_sui_to_token<T0>(arg0: &mut 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::Launchpad, arg1: &CoinInfo<T0>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: u64, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.graduated, 9);
        assert!(0x1::option::is_some<address>(&arg1.pool_id), 10);
        assert!(arg3 >= 1, 3);
        let v0 = calculate_transaction_fee(arg3, 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::get_graduated_swap_fee_bps(arg0));
        let v1 = arg3 - v0;
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, 0x2::sui::SUI>(arg6, false, true, v1);
        assert!(!0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_is_exceed(&v2), 6);
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v2) >= arg4, 6);
        0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::add_to_treasury(arg0, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, v0, arg8)));
        let v3 = 0x2::coin::zero<T0>(arg8);
        let v4 = &mut v3;
        let v5 = &mut arg2;
        let (v6, v7) = internal_swap<T0, 0x2::sui::SUI>(arg5, arg6, v4, v5, false, true, v1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price(), arg7, arg8);
        assert!(v6 == v1, 1);
        assert!(v7 >= arg4, 6);
        if (0x2::coin::value<0x2::sui::SUI>(&arg2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, 0x2::tx_context::sender(arg8));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg2);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg8));
        let v8 = get_graduated_token_price_from_reserves<T0>(arg6, arg1.token_decimals);
        let (v9, v10) = get_graduated_token_liquidity<T0>(arg6);
        let v11 = TradeEvent{
            is_buy                     : true,
            coin_address               : 0x2::object::uid_to_address(&arg1.id),
            user_address               : 0x2::tx_context::sender(arg8),
            token_amount               : v7,
            sui_amount                 : v6,
            platform_fee_amount        : v0,
            battle_royale_fee_amount   : 0,
            new_supply                 : arg1.supply,
            new_price                  : v8,
            new_virtual_sui_reserves   : 0,
            new_virtual_token_reserves : 0,
            new_real_sui_reserves      : 0,
            new_real_token_reserves    : 0,
            market_cap                 : 0x1::option::some<u64>(calculate_graduated_market_cap<T0>(arg1, v8)),
            cetus_pool_sui_liquidity   : 0x1::option::some<u64>(v10),
            cetus_pool_token_liquidity : 0x1::option::some<u64>(v9),
            is_graduated_trade         : true,
            is_eligible_for_graduation : 0x1::option::none<bool>(),
        };
        0x2::event::emit<TradeEvent>(v11);
    }

    public entry fun swap_graduated_token_to_sui<T0>(arg0: &mut 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::Launchpad, arg1: &CoinInfo<T0>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.graduated, 9);
        assert!(0x1::option::is_some<address>(&arg1.pool_id), 10);
        assert!(arg3 >= 1, 3);
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 >= arg3, 2);
        let arg2 = if (v0 == arg3) {
            arg2
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg2, v0 - arg3, arg8), 0x2::tx_context::sender(arg8));
            arg2
        };
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, 0x2::sui::SUI>(arg6, true, true, arg3);
        assert!(!0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_is_exceed(&v1), 7);
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v1);
        let v3 = 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::get_graduated_swap_fee_bps(arg0);
        assert!(v2 - calculate_transaction_fee(v2, v3) >= arg4, 7);
        let v4 = 0x2::coin::zero<0x2::sui::SUI>(arg8);
        let v5 = &mut arg2;
        let v6 = &mut v4;
        let (v7, v8) = internal_swap<T0, 0x2::sui::SUI>(arg5, arg6, v5, v6, true, true, arg3, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price(), arg7, arg8);
        assert!(v7 == arg3, 2);
        assert!(v8 == v2, 7);
        0x2::coin::destroy_zero<T0>(arg2);
        let v9 = calculate_transaction_fee(v8, v3);
        0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::add_to_treasury(arg0, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v4, v9, arg8)));
        let v10 = v8 - v9;
        assert!(v10 >= arg4, 7);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v4, 0x2::tx_context::sender(arg8));
        let v11 = get_graduated_token_price_from_reserves<T0>(arg6, arg1.token_decimals);
        let (v12, v13) = get_graduated_token_liquidity<T0>(arg6);
        let v14 = TradeEvent{
            is_buy                     : false,
            coin_address               : 0x2::object::uid_to_address(&arg1.id),
            user_address               : 0x2::tx_context::sender(arg8),
            token_amount               : v7,
            sui_amount                 : v10,
            platform_fee_amount        : v9,
            battle_royale_fee_amount   : 0,
            new_supply                 : arg1.supply,
            new_price                  : v11,
            new_virtual_sui_reserves   : 0,
            new_virtual_token_reserves : 0,
            new_real_sui_reserves      : 0,
            new_real_token_reserves    : 0,
            market_cap                 : 0x1::option::some<u64>(calculate_graduated_market_cap<T0>(arg1, v11)),
            cetus_pool_sui_liquidity   : 0x1::option::some<u64>(v13),
            cetus_pool_token_liquidity : 0x1::option::some<u64>(v12),
            is_graduated_trade         : true,
            is_eligible_for_graduation : 0x1::option::none<bool>(),
        };
        0x2::event::emit<TradeEvent>(v14);
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

    fun would_trigger_graduation<T0>(arg0: &0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::Launchpad, arg1: &CoinInfo<T0>, arg2: u64, arg3: u64) : bool {
        if (arg1.graduated) {
            return false
        };
        if (0x1::option::is_some<u64>(&arg1.grace_period_ends_at)) {
            if (arg3 < *0x1::option::borrow<u64>(&arg1.grace_period_ends_at)) {
                return false
            };
        };
        0x2::balance::value<0x2::sui::SUI>(&arg1.real_sui_reserves) + arg2 >= 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::get_graduation_threshold(arg0)
    }

    // decompiled from Move bytecode v6
}

