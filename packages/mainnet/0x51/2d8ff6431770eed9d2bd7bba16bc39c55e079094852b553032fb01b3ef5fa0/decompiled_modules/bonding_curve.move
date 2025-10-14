module 0x512d8ff6431770eed9d2bd7bba16bc39c55e079094852b553032fb01b3ef5fa0::bonding_curve {
    struct LaunchConfig has copy, drop, store {
        initial_market_cap: u64,
        migration_market_cap: u64,
        pre_migration_tax_bps: u64,
        post_migration_tax_bps: u64,
        creator_fee_share: u8,
        platform_fee_share: u8,
        platform_wallet: address,
        migration_percent: u8,
        remaining_action: u8,
    }

    struct TokenLaunch<phantom T0> has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
        creator: address,
        created_at: u64,
        treasury_cap: 0x2::coin::TreasuryCap<T0>,
        token_reserve: 0x2::balance::Balance<T0>,
        sui_reserve: 0x2::balance::Balance<0x2::sui::SUI>,
        tokens_sold: u64,
        sui_raised: u64,
        migrated: bool,
        migration_timestamp: 0x1::option::Option<u64>,
        creator_fees: 0x2::balance::Balance<0x2::sui::SUI>,
        platform_fees: 0x2::balance::Balance<0x2::sui::SUI>,
        config: LaunchConfig,
    }

    struct TokenCreated has copy, drop {
        launch_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        timestamp: u64,
    }

    struct TradeExecuted has copy, drop {
        launch_id: 0x2::object::ID,
        trader: address,
        is_buy: bool,
        tokens: u64,
        sui: u64,
        fee: u64,
        timestamp: u64,
    }

    struct MigrationCompleted has copy, drop {
        launch_id: 0x2::object::ID,
        pool_address: 0x1::option::Option<address>,
        liquidity_locked: bool,
        timestamp: u64,
    }

    struct FeesDistributed has copy, drop {
        launch_id: 0x2::object::ID,
        recipient: address,
        amount: u64,
        is_creator: bool,
    }

    public fun buy<T0>(arg0: &mut TokenLaunch<T0>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(!arg0.migrated, 3);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        let v1 = calculate_buy_amount<T0>(arg0, v0);
        assert!(v1 >= arg2, 2);
        assert!(v1 <= 0x2::balance::value<T0>(&arg0.token_reserve), 6);
        let v2 = if (arg0.migrated) {
            arg0.config.post_migration_tax_bps
        } else {
            arg0.config.pre_migration_tax_bps
        };
        let v3 = v0 * v2 / 10000;
        let v4 = v3 * (arg0.config.creator_fee_share as u64) / 100;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.creator_fees, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, v4, arg4)));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.platform_fees, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, v3 - v4, arg4)));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_reserve, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        arg0.tokens_sold = arg0.tokens_sold + v1;
        arg0.sui_raised = arg0.sui_raised + v0 - v3;
        let v5 = TradeExecuted{
            launch_id : 0x2::object::uid_to_inner(&arg0.id),
            trader    : 0x2::tx_context::sender(arg4),
            is_buy    : true,
            tokens    : v1,
            sui       : v0,
            fee       : v3,
            timestamp : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<TradeExecuted>(v5);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.token_reserve, v1), arg4)
    }

    public fun calculate_buy_amount<T0>(arg0: &TokenLaunch<T0>, arg1: u64) : u64 {
        let v0 = &arg0.config;
        let v1 = v0.initial_market_cap + (v0.migration_market_cap - v0.initial_market_cap) * arg0.tokens_sold / 1000000000000000000;
        if (v1 == 0) {
            return 0
        };
        arg1 * 1000000000 / v1
    }

    public fun calculate_sell_amount<T0>(arg0: &TokenLaunch<T0>, arg1: u64) : u64 {
        let v0 = &arg0.config;
        arg1 * (v0.initial_market_cap + (v0.migration_market_cap - v0.initial_market_cap) * arg0.tokens_sold / 1000000000000000000) / 1000000000
    }

    public fun can_migrate<T0>(arg0: &TokenLaunch<T0>) : bool {
        0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve) >= arg0.config.migration_market_cap && !arg0.migrated
    }

    public fun claim_fees<T0>(arg0: &mut TokenLaunch<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::tx_context::sender(arg1);
        if (v0 == arg0.creator) {
            let v2 = FeesDistributed{
                launch_id  : 0x2::object::uid_to_inner(&arg0.id),
                recipient  : v0,
                amount     : 0x2::balance::value<0x2::sui::SUI>(&arg0.creator_fees),
                is_creator : true,
            };
            0x2::event::emit<FeesDistributed>(v2);
            0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.creator_fees), arg1)
        } else if (v0 == arg0.config.platform_wallet) {
            let v3 = FeesDistributed{
                launch_id  : 0x2::object::uid_to_inner(&arg0.id),
                recipient  : v0,
                amount     : 0x2::balance::value<0x2::sui::SUI>(&arg0.platform_fees),
                is_creator : false,
            };
            0x2::event::emit<FeesDistributed>(v3);
            0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.platform_fees), arg1)
        } else {
            0x2::coin::zero<0x2::sui::SUI>(arg1)
        }
    }

    public fun config_initial_market_cap(arg0: &LaunchConfig) : u64 {
        arg0.initial_market_cap
    }

    public fun config_migration_market_cap(arg0: &LaunchConfig) : u64 {
        arg0.migration_market_cap
    }

    public fun config_migration_percent(arg0: &LaunchConfig) : u8 {
        arg0.migration_percent
    }

    public fun create_token<T0>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: LaunchConfig, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : TokenLaunch<T0> {
        assert!(arg5.creator_fee_share + arg5.platform_fee_share == 100, 4);
        assert!(arg5.migration_market_cap > arg5.initial_market_cap, 4);
        assert!(arg5.remaining_action <= 3, 7);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg6) >= 1000000000, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg6, 1000000000, arg8), arg5.platform_wallet);
        if (0x2::coin::value<0x2::sui::SUI>(&arg6) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg6, 0x2::tx_context::sender(arg8));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg6);
        };
        let v0 = 0x2::object::new(arg8);
        let v1 = 0x2::clock::timestamp_ms(arg7);
        let v2 = TokenCreated{
            launch_id : 0x2::object::uid_to_inner(&v0),
            creator   : 0x2::tx_context::sender(arg8),
            name      : arg1,
            symbol    : arg2,
            timestamp : v1,
        };
        0x2::event::emit<TokenCreated>(v2);
        let v3 = if (0x1::string::length(&arg4) > 0) {
            0x2::url::new_unsafe(0x1::string::to_ascii(arg4))
        } else {
            0x2::url::new_unsafe(0x1::string::to_ascii(0x1::string::utf8(b"https://placeholder.com/token.png")))
        };
        TokenLaunch<T0>{
            id                  : v0,
            name                : arg1,
            symbol              : arg2,
            description         : arg3,
            image_url           : v3,
            creator             : 0x2::tx_context::sender(arg8),
            created_at          : v1,
            treasury_cap        : arg0,
            token_reserve       : 0x2::coin::mint_balance<T0>(&mut arg0, 1000000000000000000),
            sui_reserve         : 0x2::balance::zero<0x2::sui::SUI>(),
            tokens_sold         : 0,
            sui_raised          : 0,
            migrated            : false,
            migration_timestamp : 0x1::option::none<u64>(),
            creator_fees        : 0x2::balance::zero<0x2::sui::SUI>(),
            platform_fees       : 0x2::balance::zero<0x2::sui::SUI>(),
            config              : arg5,
        }
    }

    public fun create_token_with_params<T0>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u8, arg10: u8, arg11: address, arg12: u8, arg13: u8, arg14: 0x2::coin::Coin<0x2::sui::SUI>, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) : TokenLaunch<T0> {
        let v0 = LaunchConfig{
            initial_market_cap     : arg5,
            migration_market_cap   : arg6,
            pre_migration_tax_bps  : arg7,
            post_migration_tax_bps : arg8,
            creator_fee_share      : arg9,
            platform_fee_share     : arg10,
            platform_wallet        : arg11,
            migration_percent      : arg12,
            remaining_action       : arg13,
        };
        create_token<T0>(arg0, arg1, arg2, arg3, arg4, v0, arg14, arg15, arg16)
    }

    public fun extract_sui_for_migration<T0>(arg0: &mut TokenLaunch<T0>, arg1: &0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        assert!(0x2::tx_context::sender(arg1) == arg0.creator, 8);
        assert!(can_migrate<T0>(arg0), 5);
        0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_reserve, 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve) * (arg0.config.migration_percent as u64) / 100)
    }

    public fun extract_tokens_for_migration<T0>(arg0: &mut TokenLaunch<T0>, arg1: u64, arg2: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 8);
        assert!(can_migrate<T0>(arg0), 5);
        0x2::balance::split<T0>(&mut arg0.token_reserve, arg1)
    }

    public fun get_config<T0>(arg0: &TokenLaunch<T0>) : LaunchConfig {
        arg0.config
    }

    public fun get_creator<T0>(arg0: &TokenLaunch<T0>) : address {
        arg0.creator
    }

    public fun get_creator_fees<T0>(arg0: &TokenLaunch<T0>) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.creator_fees)
    }

    public fun get_description<T0>(arg0: &TokenLaunch<T0>) : 0x1::string::String {
        arg0.description
    }

    public fun get_name<T0>(arg0: &TokenLaunch<T0>) : 0x1::string::String {
        arg0.name
    }

    public fun get_platform_fees<T0>(arg0: &TokenLaunch<T0>) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.platform_fees)
    }

    public fun get_sui_raised<T0>(arg0: &TokenLaunch<T0>) : u64 {
        arg0.sui_raised
    }

    public fun get_sui_reserve<T0>(arg0: &TokenLaunch<T0>) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve)
    }

    public fun get_symbol<T0>(arg0: &TokenLaunch<T0>) : 0x1::string::String {
        arg0.symbol
    }

    public fun get_tokens_sold<T0>(arg0: &TokenLaunch<T0>) : u64 {
        arg0.tokens_sold
    }

    public fun is_migrated<T0>(arg0: &TokenLaunch<T0>) : bool {
        arg0.migrated
    }

    public fun mark_migrated<T0>(arg0: &mut TokenLaunch<T0>, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 8);
        assert!(can_migrate<T0>(arg0), 5);
        arg0.migrated = true;
        arg0.migration_timestamp = 0x1::option::some<u64>(0x2::clock::timestamp_ms(arg1));
        let v0 = MigrationCompleted{
            launch_id        : 0x2::object::uid_to_inner(&arg0.id),
            pool_address     : 0x1::option::none<address>(),
            liquidity_locked : true,
            timestamp        : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<MigrationCompleted>(v0);
    }

    public fun sell<T0>(arg0: &mut TokenLaunch<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(!arg0.migrated, 3);
        let v0 = 0x2::coin::value<T0>(&arg1);
        let v1 = calculate_sell_amount<T0>(arg0, v0);
        assert!(v1 >= arg2, 2);
        assert!(v1 <= 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve), 6);
        let v2 = if (arg0.migrated) {
            arg0.config.post_migration_tax_bps
        } else {
            arg0.config.pre_migration_tax_bps
        };
        let v3 = v1 * v2 / 10000;
        let v4 = v3 * (arg0.config.creator_fee_share as u64) / 100;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.creator_fees, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_reserve, v4));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.platform_fees, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_reserve, v3 - v4));
        arg0.tokens_sold = arg0.tokens_sold - v0;
        0x2::balance::join<T0>(&mut arg0.token_reserve, 0x2::coin::into_balance<T0>(arg1));
        let v5 = TradeExecuted{
            launch_id : 0x2::object::uid_to_inner(&arg0.id),
            trader    : 0x2::tx_context::sender(arg4),
            is_buy    : false,
            tokens    : v0,
            sui       : v1,
            fee       : v3,
            timestamp : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<TradeExecuted>(v5);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_reserve, v1 - v3), arg4)
    }

    public fun share_launch<T0>(arg0: TokenLaunch<T0>) {
        0x2::transfer::share_object<TokenLaunch<T0>>(arg0);
    }

    // decompiled from Move bytecode v6
}

