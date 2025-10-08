module 0x56cfab5e80f347d5aae12e28ebc9be50d571e16f3149f21aa198c7fc44df0045::bonding_curve {
    struct TokenLaunch has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        creator: address,
        created_at: u64,
        sui_reserve: 0x2::balance::Balance<0x2::sui::SUI>,
        tokens_sold: u64,
        migrated: bool,
        initial_mc: u64,
        migration_mc: u64,
        pre_tax_bps: u64,
        post_tax_bps: u64,
        creator_fee_share: u8,
        platform_fee_share: u8,
        platform_wallet: address,
        migration_percent: u8,
    }

    struct TokenCreated has copy, drop {
        launch_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
    }

    struct TradeExecuted has copy, drop {
        launch_id: 0x2::object::ID,
        trader: address,
        is_buy: bool,
        tokens: u64,
        sui: u64,
    }

    public fun buy(arg0: &mut TokenLaunch, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(!arg0.migrated, 3);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        let v1 = calculate_buy_amount(arg0, v0);
        assert!(v1 >= arg2, 2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_reserve, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, v0 - v0 * arg0.pre_tax_bps / 10000, arg3)));
        arg0.tokens_sold = arg0.tokens_sold + v1;
        let v2 = TradeExecuted{
            launch_id : 0x2::object::uid_to_inner(&arg0.id),
            trader    : 0x2::tx_context::sender(arg3),
            is_buy    : true,
            tokens    : v1,
            sui       : v0,
        };
        0x2::event::emit<TradeExecuted>(v2);
        arg1
    }

    public fun calculate_buy_amount(arg0: &TokenLaunch, arg1: u64) : u64 {
        let v0 = arg0.initial_mc + (arg0.migration_mc - arg0.initial_mc) * arg0.tokens_sold / 1000000000000000000;
        if (v0 == 0) {
            return 0
        };
        arg1 * 1000000000 / v0
    }

    public fun calculate_sell_amount(arg0: &TokenLaunch, arg1: u64) : u64 {
        arg1 * (arg0.initial_mc + (arg0.migration_mc - arg0.initial_mc) * arg0.tokens_sold / 1000000000000000000) / 1000000000
    }

    public fun can_migrate(arg0: &TokenLaunch) : bool {
        0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve) >= arg0.migration_mc && !arg0.migrated
    }

    public fun create_token(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u8, arg9: u8, arg10: address, arg11: u8, arg12: 0x2::coin::Coin<0x2::sui::SUI>, arg13: 0x2::coin::Coin<0x2::sui::SUI>, arg14: &mut 0x2::tx_context::TxContext) : TokenLaunch {
        assert!(arg8 + arg9 == 100, 4);
        assert!(arg5 > arg4, 4);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg12) >= 1000000000, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg12, 1000000000, arg14)), arg14), arg10);
        if (0x2::coin::value<0x2::sui::SUI>(&arg12) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg12, 0x2::tx_context::sender(arg14));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg12);
        };
        let v0 = 0x2::object::new(arg14);
        let v1 = TokenCreated{
            launch_id : 0x2::object::uid_to_inner(&v0),
            creator   : 0x2::tx_context::sender(arg14),
            name      : arg0,
            symbol    : arg1,
        };
        0x2::event::emit<TokenCreated>(v1);
        let v2 = TokenLaunch{
            id                 : v0,
            name               : arg0,
            symbol             : arg1,
            description        : arg2,
            image_url          : arg3,
            creator            : 0x2::tx_context::sender(arg14),
            created_at         : 0x2::tx_context::epoch_timestamp_ms(arg14),
            sui_reserve        : 0x2::balance::zero<0x2::sui::SUI>(),
            tokens_sold        : 0,
            migrated           : false,
            initial_mc         : arg4,
            migration_mc       : arg5,
            pre_tax_bps        : arg6,
            post_tax_bps       : arg7,
            creator_fee_share  : arg8,
            platform_fee_share : arg9,
            platform_wallet    : arg10,
            migration_percent  : arg11,
        };
        let v3 = 0x2::coin::value<0x2::sui::SUI>(&arg13);
        if (v3 > 0) {
            let v4 = calculate_buy_amount(&v2, v3);
            0x2::balance::join<0x2::sui::SUI>(&mut v2.sui_reserve, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg13, v3 - v3 * v2.pre_tax_bps / 10000, arg14)));
            v2.tokens_sold = v2.tokens_sold + v4;
            let v5 = TradeExecuted{
                launch_id : 0x2::object::uid_to_inner(&v2.id),
                trader    : 0x2::tx_context::sender(arg14),
                is_buy    : true,
                tokens    : v4,
                sui       : v3,
            };
            0x2::event::emit<TradeExecuted>(v5);
        };
        if (0x2::coin::value<0x2::sui::SUI>(&arg13) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg13, 0x2::tx_context::sender(arg14));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg13);
        };
        v2
    }

    public fun get_name(arg0: &TokenLaunch) : 0x1::string::String {
        arg0.name
    }

    public fun get_sui_reserve(arg0: &TokenLaunch) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve)
    }

    public fun get_symbol(arg0: &TokenLaunch) : 0x1::string::String {
        arg0.symbol
    }

    public fun get_tokens_sold(arg0: &TokenLaunch) : u64 {
        arg0.tokens_sold
    }

    public fun is_migrated(arg0: &TokenLaunch) : bool {
        arg0.migrated
    }

    public fun sell(arg0: &mut TokenLaunch, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(!arg0.migrated, 3);
        let v0 = calculate_sell_amount(arg0, arg1);
        assert!(v0 >= arg2, 2);
        arg0.tokens_sold = arg0.tokens_sold - arg1;
        let v1 = TradeExecuted{
            launch_id : 0x2::object::uid_to_inner(&arg0.id),
            trader    : 0x2::tx_context::sender(arg3),
            is_buy    : false,
            tokens    : arg1,
            sui       : v0,
        };
        0x2::event::emit<TradeExecuted>(v1);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_reserve, v0 - v0 * arg0.pre_tax_bps / 10000), arg3)
    }

    public fun share_launch(arg0: TokenLaunch) {
        0x2::transfer::share_object<TokenLaunch>(arg0);
    }

    // decompiled from Move bytecode v6
}

