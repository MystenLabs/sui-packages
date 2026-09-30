module 0xec46c2bdc383b5eeaa8df812c9a98b8b5e1ff97cb7b85cc54709d173ff23272f::launchpad {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Config has key {
        id: 0x2::object::UID,
        admin: address,
        platform: address,
        migrator: address,
        fee_bps: u64,
        creator_fee_bps: u64,
        virtual_sui: u64,
        graduation_sui: u64,
        paused: bool,
    }

    struct BondingCurve<phantom T0> has key {
        id: 0x2::object::UID,
        creator: address,
        sui: 0x2::balance::Balance<0x2::sui::SUI>,
        tokens: 0x2::balance::Balance<T0>,
        treasury: 0x2::coin::TreasuryCap<T0>,
        virtual_sui: u64,
        virtual_token: u64,
        curve_supply: u64,
        lp_reserve: 0x2::balance::Balance<T0>,
        token_supply: u64,
        real_sui_collected: u64,
        graduation_sui: u64,
        migrated: bool,
        first_trade_done: bool,
        dev_bought_first: bool,
        created_at_ms: u64,
        volume_sui: u64,
    }

    struct LaunchEvent has copy, drop {
        curve_id: 0x2::object::ID,
        creator: address,
        symbol: 0x1::string::String,
        name: 0x1::string::String,
        decimals: u8,
        token_supply: u64,
        virtual_sui: u64,
        graduation_sui: u64,
        created_at_ms: u64,
    }

    struct TradeEvent has copy, drop {
        curve_id: 0x2::object::ID,
        trader: address,
        is_buy: bool,
        sui_amount: u64,
        token_amount: u64,
        creator_fee: u64,
        platform_fee: u64,
        new_real_sui: u64,
        new_token_reserve: u64,
        price_x64: u128,
        timestamp_ms: u64,
    }

    struct MigrateEvent has copy, drop {
        curve_id: 0x2::object::ID,
        migrator: address,
        sui_liquidity: u64,
        token_liquidity: u64,
        timestamp_ms: u64,
    }

    public entry fun buy<T0>(arg0: &Config, arg1: &mut BondingCurve<T0>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 5);
        assert!(!arg1.migrated, 1);
        let v0 = 0x2::balance::value<T0>(&arg1.tokens);
        assert!(v0 > 0, 8);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v1 > 0, 2);
        let v2 = arg1.virtual_sui + arg1.real_sui_collected;
        let v3 = 0xec46c2bdc383b5eeaa8df812c9a98b8b5e1ff97cb7b85cc54709d173ff23272f::bonding_math::k(arg1.virtual_sui, arg1.virtual_token);
        let v4 = math_tokens<T0>(arg1);
        let v5 = 0x2::tx_context::sender(arg5);
        let (v6, _, _) = split_fee(arg0, v1);
        let v9 = 0xec46c2bdc383b5eeaa8df812c9a98b8b5e1ff97cb7b85cc54709d173ff23272f::bonding_math::tokens_out(v2, v4, v1 - v6, v3);
        let v10 = v9;
        let v11 = v1;
        if (v9 >= v0) {
            v10 = v0;
            let v12 = gross_for_net(arg0, 0xec46c2bdc383b5eeaa8df812c9a98b8b5e1ff97cb7b85cc54709d173ff23272f::bonding_math::sui_in_for_tokens(v2, v4, v0, v3));
            v11 = v12;
            if (v12 > v1) {
                v11 = v1;
            };
            let v13 = v1 - v11;
            if (v13 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, v13, arg5), v5);
            };
        };
        assert!(v10 >= arg3, 3);
        let (v14, v15, v16) = split_fee(arg0, v11);
        if (v14 > 0) {
            let v17 = 0x2::coin::split<0x2::sui::SUI>(&mut arg2, v14, arg5);
            if (v15 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v17, v15, arg5), arg1.creator);
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v17, arg0.platform);
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.sui, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        arg1.real_sui_collected = arg1.real_sui_collected + 0x2::coin::value<0x2::sui::SUI>(&arg2);
        arg1.volume_sui = arg1.volume_sui + v11;
        if (!arg1.first_trade_done) {
            arg1.first_trade_done = true;
            arg1.dev_bought_first = v5 == arg1.creator;
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.tokens, v10), arg5), v5);
        emit_trade<T0>(arg1, v5, true, v11, v10, v15, v16, arg4);
    }

    public entry fun create_curve<T0>(arg0: &Config, arg1: 0x2::coin::TreasuryCap<T0>, arg2: &0x2::coin::CoinMetadata<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 >= 15, 2);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        let v2 = 0x2::coin::into_balance<T0>(0x2::coin::mint<T0>(&mut arg1, arg3, arg5));
        let v3 = arg3 / 4 * 3;
        let v4 = BondingCurve<T0>{
            id                 : 0x2::object::new(arg5),
            creator            : v0,
            sui                : 0x2::balance::zero<0x2::sui::SUI>(),
            tokens             : v2,
            treasury           : arg1,
            virtual_sui        : arg0.virtual_sui,
            virtual_token      : (((arg3 as u128) * 9 / 8) as u64),
            curve_supply       : v3,
            lp_reserve         : 0x2::balance::split<T0>(&mut v2, arg3 - v3),
            token_supply       : arg3,
            real_sui_collected : 0,
            graduation_sui     : arg0.graduation_sui,
            migrated           : false,
            first_trade_done   : false,
            dev_bought_first   : false,
            created_at_ms      : v1,
            volume_sui         : 0,
        };
        let v5 = LaunchEvent{
            curve_id       : 0x2::object::id<BondingCurve<T0>>(&v4),
            creator        : v0,
            symbol         : 0x1::string::from_ascii(0x2::coin::get_symbol<T0>(arg2)),
            name           : 0x2::coin::get_name<T0>(arg2),
            decimals       : 0x2::coin::get_decimals<T0>(arg2),
            token_supply   : arg3,
            virtual_sui    : v4.virtual_sui,
            graduation_sui : v4.graduation_sui,
            created_at_ms  : v1,
        };
        0x2::event::emit<LaunchEvent>(v5);
        0x2::transfer::share_object<BondingCurve<T0>>(v4);
    }

    public fun creator<T0>(arg0: &BondingCurve<T0>) : address {
        arg0.creator
    }

    fun emit_trade<T0>(arg0: &BondingCurve<T0>, arg1: address, arg2: bool, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock) {
        let v0 = TradeEvent{
            curve_id          : 0x2::object::id<BondingCurve<T0>>(arg0),
            trader            : arg1,
            is_buy            : arg2,
            sui_amount        : arg3,
            token_amount      : arg4,
            creator_fee       : arg5,
            platform_fee      : arg6,
            new_real_sui      : arg0.real_sui_collected,
            new_token_reserve : 0x2::balance::value<T0>(&arg0.tokens),
            price_x64         : price_x64_internal<T0>(arg0),
            timestamp_ms      : 0x2::clock::timestamp_ms(arg7),
        };
        0x2::event::emit<TradeEvent>(v0);
    }

    public fun get_buy_quote<T0>(arg0: &Config, arg1: &BondingCurve<T0>, arg2: u64) : (u64, u64, u64, u64) {
        let (v0, v1, v2) = split_fee(arg0, arg2);
        (0xec46c2bdc383b5eeaa8df812c9a98b8b5e1ff97cb7b85cc54709d173ff23272f::bonding_math::tokens_out(arg1.virtual_sui + arg1.real_sui_collected, math_tokens<T0>(arg1), arg2 - v0, 0xec46c2bdc383b5eeaa8df812c9a98b8b5e1ff97cb7b85cc54709d173ff23272f::bonding_math::k(arg1.virtual_sui, arg1.virtual_token)), v0, v1, v2)
    }

    public fun get_price_x64<T0>(arg0: &BondingCurve<T0>) : u128 {
        price_x64_internal<T0>(arg0)
    }

    public fun get_sell_quote<T0>(arg0: &Config, arg1: &BondingCurve<T0>, arg2: u64) : (u64, u64, u64, u64) {
        let v0 = 0xec46c2bdc383b5eeaa8df812c9a98b8b5e1ff97cb7b85cc54709d173ff23272f::bonding_math::sui_out(arg1.virtual_sui + arg1.real_sui_collected, math_tokens<T0>(arg1), arg2, 0xec46c2bdc383b5eeaa8df812c9a98b8b5e1ff97cb7b85cc54709d173ff23272f::bonding_math::k(arg1.virtual_sui, arg1.virtual_token));
        let (v1, v2, v3) = split_fee(arg0, v0);
        (v0 - v1, v1, v2, v3)
    }

    public fun get_state<T0>(arg0: &BondingCurve<T0>) : (u64, u64, u64, u64, bool, bool, u64) {
        (arg0.real_sui_collected, 0x2::balance::value<T0>(&arg0.tokens), arg0.token_supply, arg0.graduation_sui, arg0.migrated, arg0.dev_bought_first, arg0.volume_sui)
    }

    fun gross_for_net(arg0: &Config, arg1: u64) : u64 {
        let v0 = ((10000 - arg0.fee_bps) as u128);
        ((((arg1 as u128) * (10000 as u128) + v0 - 1) / v0) as u64)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, v0);
        let v2 = Config{
            id              : 0x2::object::new(arg0),
            admin           : v0,
            platform        : v0,
            migrator        : v0,
            fee_bps         : 100,
            creator_fee_bps : 7000,
            virtual_sui     : 1500000000,
            graduation_sui  : 3000000000,
            paused          : false,
        };
        0x2::transfer::share_object<Config>(v2);
    }

    public fun is_graduated<T0>(arg0: &BondingCurve<T0>) : bool {
        arg0.migrated
    }

    fun math_tokens<T0>(arg0: &BondingCurve<T0>) : u64 {
        arg0.virtual_token - arg0.curve_supply - 0x2::balance::value<T0>(&arg0.tokens)
    }

    public entry fun migrate<T0>(arg0: &Config, arg1: &mut BondingCurve<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.migrated, 1);
        assert!(0x2::balance::value<T0>(&arg1.tokens) == 0, 4);
        arg1.migrated = true;
        let v0 = 0x2::balance::withdraw_all<T0>(&mut arg1.lp_reserve);
        0x2::balance::join<T0>(&mut v0, 0x2::balance::withdraw_all<T0>(&mut arg1.tokens));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg1.sui), arg3), arg0.migrator);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v0, arg3), arg0.migrator);
        let v1 = MigrateEvent{
            curve_id        : 0x2::object::id<BondingCurve<T0>>(arg1),
            migrator        : arg0.migrator,
            sui_liquidity   : 0x2::balance::value<0x2::sui::SUI>(&arg1.sui),
            token_liquidity : 0x2::balance::value<T0>(&v0),
            timestamp_ms    : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<MigrateEvent>(v1);
    }

    fun price_x64_internal<T0>(arg0: &BondingCurve<T0>) : u128 {
        let v0 = (math_tokens<T0>(arg0) as u128);
        if (v0 == 0) {
            return 0
        };
        ((arg0.virtual_sui as u128) + (arg0.real_sui_collected as u128) << 64) / v0
    }

    public entry fun sell<T0>(arg0: &Config, arg1: &mut BondingCurve<T0>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 5);
        assert!(!arg1.migrated, 1);
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 2);
        let v1 = 0xec46c2bdc383b5eeaa8df812c9a98b8b5e1ff97cb7b85cc54709d173ff23272f::bonding_math::sui_out(arg1.virtual_sui + arg1.real_sui_collected, math_tokens<T0>(arg1), v0, 0xec46c2bdc383b5eeaa8df812c9a98b8b5e1ff97cb7b85cc54709d173ff23272f::bonding_math::k(arg1.virtual_sui, arg1.virtual_token));
        assert!(v1 <= arg1.real_sui_collected, 8);
        let (v2, v3, v4) = split_fee(arg0, v1);
        let v5 = v1 - v2;
        assert!(v5 >= arg3, 3);
        0x2::balance::join<T0>(&mut arg1.tokens, 0x2::coin::into_balance<T0>(arg2));
        arg1.real_sui_collected = arg1.real_sui_collected - v1;
        arg1.volume_sui = arg1.volume_sui + v1;
        if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.sui, v3), arg5), arg1.creator);
        };
        if (v4 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.sui, v4), arg5), arg0.platform);
        };
        let v6 = 0x2::tx_context::sender(arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.sui, v5), arg5), v6);
        emit_trade<T0>(arg1, v6, false, v5, v0, v3, v4, arg4);
    }

    public entry fun set_curve_params(arg0: &AdminCap, arg1: &mut Config, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0 && arg3 > 0, 7);
        arg1.virtual_sui = arg2;
        arg1.graduation_sui = arg3;
    }

    public entry fun set_fees(arg0: &AdminCap, arg1: &mut Config, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 <= 1000, 7);
        assert!(arg3 <= 10000, 7);
        arg1.fee_bps = arg2;
        arg1.creator_fee_bps = arg3;
    }

    public entry fun set_paused(arg0: &AdminCap, arg1: &mut Config, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.paused = arg2;
    }

    public entry fun set_payout_addresses(arg0: &AdminCap, arg1: &mut Config, arg2: address, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        arg1.platform = arg2;
        arg1.migrator = arg3;
    }

    fun split_fee(arg0: &Config, arg1: u64) : (u64, u64, u64) {
        let v0 = 0xec46c2bdc383b5eeaa8df812c9a98b8b5e1ff97cb7b85cc54709d173ff23272f::bonding_math::mul_div(arg1, arg0.fee_bps, 10000);
        let v1 = 0xec46c2bdc383b5eeaa8df812c9a98b8b5e1ff97cb7b85cc54709d173ff23272f::bonding_math::mul_div(v0, arg0.creator_fee_bps, 10000);
        (v0, v1, v0 - v1)
    }

    // decompiled from Move bytecode v7
}

