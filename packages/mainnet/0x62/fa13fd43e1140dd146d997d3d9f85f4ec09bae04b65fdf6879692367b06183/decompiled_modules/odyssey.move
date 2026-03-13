module 0x62fa13fd43e1140dd146d997d3d9f85f4ec09bae04b65fdf6879692367b06183::odyssey {
    struct TokenPool<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        creator: address,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        x_social: 0x1::string::String,
        telegram_social: 0x1::string::String,
        website: 0x1::string::String,
        created_at: u64,
        graduated_at: u64,
        state: u8,
        meme_balance: 0x2::balance::Balance<T0>,
        quote_balance: 0x2::balance::Balance<T1>,
        virtual_liquidity: u64,
        target_quote_liquidity: u64,
        liquidity_provision: 0x2::balance::Balance<T0>,
        treasury_cap: 0x2::coin::TreasuryCap<T0>,
        total_bought: u64,
        total_sold: u64,
        total_volume: u64,
        holder_count: u64,
        trading_fee_bps: u64,
        burn_tax_bps: u64,
        admin_fee_balance: 0x2::balance::Balance<T1>,
        creator_fee_balance: 0x2::balance::Balance<T1>,
        staking_fee_balance: 0x2::balance::Balance<T1>,
        aida_staking_pool: address,
    }

    struct PlatformConfig has key {
        id: 0x2::object::UID,
        admin: address,
        platform_fee_wallet: address,
    }

    struct TokenRegistry has key {
        id: 0x2::object::UID,
        pools: 0x2::table::Table<0x2::object::ID, address>,
        total_tokens: u64,
        total_volume: u64,
    }

    struct TokenCreated has copy, drop {
        pool_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        virtual_liquidity: u64,
        target_liquidity: u64,
    }

    struct TokenTrade has copy, drop {
        pool_id: 0x2::object::ID,
        trader: address,
        is_buy: bool,
        quote_amount_in: u64,
        meme_amount_out: u64,
        trading_fee: u64,
        admin_fee: u64,
        creator_fee: u64,
        staking_fee: u64,
        new_meme_balance: u64,
        new_quote_balance: u64,
    }

    struct TokenGraduated has copy, drop {
        pool_id: 0x2::object::ID,
        final_quote_liquidity: u64,
        creator_payout: u64,
        liquidity_provision_amount: u64,
        migration_fee: u64,
    }

    struct MigrationStarted has copy, drop {
        pool_id: 0x2::object::ID,
        migration_witness: 0x1::type_name::TypeName,
    }

    struct FeeClaimed has copy, drop {
        pool_id: 0x2::object::ID,
        claimer: address,
        fee_type: u8,
        amount: u64,
        timestamp: u64,
    }

    public fun buy<T0, T1>(arg0: &mut TokenPool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: 0x1::option::Option<address>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::value<T1>(&arg1);
        assert!(v0 > 0, 10);
        assert!(arg0.state == 0, 7);
        let (v1, v2) = calculate_buy_output<T0, T1>(v0, arg0);
        assert!(v1 >= arg2, 3);
        let v3 = v2 * 4500 / 10000;
        let v4 = v2 * 2500 / 10000;
        let v5 = v2 * 3000 / 10000;
        0x2::balance::join<T1>(&mut arg0.quote_balance, 0x2::coin::into_balance<T1>(arg1));
        if (v3 > 0) {
            0x2::balance::join<T1>(&mut arg0.admin_fee_balance, 0x2::coin::into_balance<T1>(0x2::coin::take<T1>(&mut arg0.quote_balance, v3, arg4)));
        };
        if (v4 > 0) {
            0x2::balance::join<T1>(&mut arg0.creator_fee_balance, 0x2::coin::into_balance<T1>(0x2::coin::take<T1>(&mut arg0.quote_balance, v4, arg4)));
        };
        if (v5 > 0) {
            0x2::balance::join<T1>(&mut arg0.staking_fee_balance, 0x2::coin::into_balance<T1>(0x2::coin::take<T1>(&mut arg0.quote_balance, v5, arg4)));
        };
        arg0.total_bought = arg0.total_bought + v1;
        arg0.total_volume = arg0.total_volume + v0;
        let v6 = 0x2::balance::value<T1>(&arg0.quote_balance);
        if (v6 >= arg0.target_quote_liquidity) {
            arg0.state = 1;
        };
        let v7 = TokenTrade{
            pool_id           : 0x2::object::id<TokenPool<T0, T1>>(arg0),
            trader            : 0x2::tx_context::sender(arg4),
            is_buy            : true,
            quote_amount_in   : v0,
            meme_amount_out   : v1,
            trading_fee       : v2,
            admin_fee         : v3,
            creator_fee       : v4,
            staking_fee       : v5,
            new_meme_balance  : 0x2::balance::value<T0>(&arg0.meme_balance),
            new_quote_balance : v6,
        };
        0x2::event::emit<TokenTrade>(v7);
        0x2::coin::mint<T0>(&mut arg0.treasury_cap, v1, arg4)
    }

    public fun buy_simple<T0, T1>(arg0: &mut TokenPool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        buy<T0, T1>(arg0, arg1, arg2, 0x1::option::none<address>(), arg3)
    }

    fun calculate_buy_output<T0, T1>(arg0: u64, arg1: &TokenPool<T0, T1>) : (u64, u64) {
        let v0 = arg1.virtual_liquidity;
        let v1 = arg0 * arg1.trading_fee_bps / 10000;
        ((0x2::balance::value<T0>(&arg1.meme_balance) + v0) * (arg0 - v1) / (0x2::balance::value<T1>(&arg1.quote_balance) + v0), v1)
    }

    fun calculate_sell_output<T0, T1>(arg0: u64, arg1: &TokenPool<T0, T1>) : (u64, u64) {
        let v0 = arg1.virtual_liquidity;
        let v1 = (0x2::balance::value<T1>(&arg1.quote_balance) + v0) * (arg0 - arg0 * arg1.burn_tax_bps / 10000) / (0x2::balance::value<T0>(&arg1.meme_balance) + v0);
        let v2 = v1 * arg1.trading_fee_bps / 10000;
        (v1 - v2, v2)
    }

    public fun claim_admin_fee<T0, T1>(arg0: &mut TokenPool<T0, T1>, arg1: &PlatformConfig, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(arg1.admin == 0x2::tx_context::sender(arg2), 6);
        let v0 = 0x2::balance::value<T1>(&arg0.admin_fee_balance);
        assert!(v0 > 0, 10);
        let v1 = FeeClaimed{
            pool_id   : 0x2::object::id<TokenPool<T0, T1>>(arg0),
            claimer   : 0x2::tx_context::sender(arg2),
            fee_type  : 0,
            amount    : v0,
            timestamp : 0x2::tx_context::epoch(arg2),
        };
        0x2::event::emit<FeeClaimed>(v1);
        0x2::coin::take<T1>(&mut arg0.admin_fee_balance, v0, arg2)
    }

    public fun claim_creator_fee<T0, T1>(arg0: &mut TokenPool<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(arg0.creator == 0x2::tx_context::sender(arg1), 5);
        let v0 = 0x2::balance::value<T1>(&arg0.creator_fee_balance);
        assert!(v0 > 0, 10);
        let v1 = FeeClaimed{
            pool_id   : 0x2::object::id<TokenPool<T0, T1>>(arg0),
            claimer   : 0x2::tx_context::sender(arg1),
            fee_type  : 1,
            amount    : v0,
            timestamp : 0x2::tx_context::epoch(arg1),
        };
        0x2::event::emit<FeeClaimed>(v1);
        0x2::coin::take<T1>(&mut arg0.creator_fee_balance, v0, arg1)
    }

    public fun claim_staking_fee<T0, T1>(arg0: &mut TokenPool<T0, T1>, arg1: &PlatformConfig, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg1.admin || v0 == arg0.aida_staking_pool, 6);
        let v1 = 0x2::balance::value<T1>(&arg0.staking_fee_balance);
        assert!(v1 > 0, 10);
        let v2 = FeeClaimed{
            pool_id   : 0x2::object::id<TokenPool<T0, T1>>(arg0),
            claimer   : v0,
            fee_type  : 2,
            amount    : v1,
            timestamp : 0x2::tx_context::epoch(arg2),
        };
        0x2::event::emit<FeeClaimed>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut arg0.staking_fee_balance, v1, arg2), arg0.aida_staking_pool);
        0x2::coin::zero<T1>(arg2)
    }

    public fun create_pool<T0, T1>(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x2::coin::Coin<T1>, arg8: 0x2::coin::TreasuryCap<T0>, arg9: address, arg10: u64, arg11: u64, arg12: &mut TokenRegistry, arg13: &PlatformConfig, arg14: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::tx_context::sender(arg14);
        assert!(0x2::coin::value<T1>(&arg7) >= 1000000000, 4);
        let v1 = 0x2::coin::total_supply<T0>(&arg8);
        let v2 = 0x2::coin::mint<T0>(&mut arg8, v1, arg14);
        let v3 = TokenPool<T0, T1>{
            id                     : 0x2::object::new(arg14),
            creator                : v0,
            name                   : arg0,
            symbol                 : arg1,
            description            : arg2,
            image_url              : arg3,
            x_social               : arg4,
            telegram_social        : arg5,
            website                : arg6,
            created_at             : 0x2::tx_context::epoch(arg14),
            graduated_at           : 0,
            state                  : 0,
            meme_balance           : 0x2::coin::into_balance<T0>(v2),
            quote_balance          : 0x2::coin::into_balance<T1>(arg7),
            virtual_liquidity      : arg10,
            target_quote_liquidity : arg11,
            liquidity_provision    : 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v2, v1 / 10, arg14)),
            treasury_cap           : arg8,
            total_bought           : 0,
            total_sold             : 0,
            total_volume           : 0,
            holder_count           : 1,
            trading_fee_bps        : 200,
            burn_tax_bps           : 0,
            admin_fee_balance      : 0x2::balance::zero<T1>(),
            creator_fee_balance    : 0x2::balance::zero<T1>(),
            staking_fee_balance    : 0x2::balance::zero<T1>(),
            aida_staking_pool      : arg9,
        };
        let v4 = 0x2::object::id<TokenPool<T0, T1>>(&v3);
        0x2::table::add<0x2::object::ID, address>(&mut arg12.pools, v4, 0x2::object::id_to_address(&v4));
        arg12.total_tokens = arg12.total_tokens + 1;
        let v5 = TokenCreated{
            pool_id           : v4,
            creator           : v0,
            name              : v3.name,
            symbol            : v3.symbol,
            virtual_liquidity : arg10,
            target_liquidity  : arg11,
        };
        0x2::event::emit<TokenCreated>(v5);
        0x2::transfer::share_object<TokenPool<T0, T1>>(v3);
        v4
    }

    public fun get_admin_fee_balance<T0, T1>(arg0: &TokenPool<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.admin_fee_balance)
    }

    public fun get_aida_staking_pool<T0, T1>(arg0: &TokenPool<T0, T1>) : address {
        arg0.aida_staking_pool
    }

    public fun get_creator<T0, T1>(arg0: &TokenPool<T0, T1>) : address {
        arg0.creator
    }

    public fun get_creator_fee_balance<T0, T1>(arg0: &TokenPool<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.creator_fee_balance)
    }

    public fun get_meme_balance<T0, T1>(arg0: &TokenPool<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.meme_balance)
    }

    public fun get_migration_fee() : u64 {
        100000000
    }

    public fun get_pool_count(arg0: &TokenRegistry) : u64 {
        arg0.total_tokens
    }

    public fun get_pool_state<T0, T1>(arg0: &TokenPool<T0, T1>) : u8 {
        arg0.state
    }

    public fun get_progress<T0, T1>(arg0: &TokenPool<T0, T1>) : u64 {
        if (arg0.target_quote_liquidity == 0) {
            return 0
        };
        0x2::balance::value<T1>(&arg0.quote_balance) * 10000 / arg0.target_quote_liquidity
    }

    public fun get_quote_balance<T0, T1>(arg0: &TokenPool<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.quote_balance)
    }

    public fun get_staking_fee_balance<T0, T1>(arg0: &TokenPool<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.staking_fee_balance)
    }

    public fun get_target_liquidity<T0, T1>(arg0: &TokenPool<T0, T1>) : u64 {
        arg0.target_quote_liquidity
    }

    public fun get_total_volume<T0, T1>(arg0: &TokenPool<T0, T1>) : u64 {
        arg0.total_volume
    }

    public fun get_trading_fee_bps<T0, T1>(arg0: &TokenPool<T0, T1>) : u64 {
        arg0.trading_fee_bps
    }

    public fun get_virtual_liquidity<T0, T1>(arg0: &TokenPool<T0, T1>) : u64 {
        arg0.virtual_liquidity
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PlatformConfig{
            id                  : 0x2::object::new(arg0),
            admin               : 0x2::tx_context::sender(arg0),
            platform_fee_wallet : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<PlatformConfig>(v0);
        let v1 = TokenRegistry{
            id           : 0x2::object::new(arg0),
            pools        : 0x2::table::new<0x2::object::ID, address>(arg0),
            total_tokens : 0,
            total_volume : 0,
        };
        0x2::transfer::share_object<TokenRegistry>(v1);
    }

    public fun is_bonding<T0, T1>(arg0: &TokenPool<T0, T1>) : bool {
        arg0.state == 0
    }

    public fun is_migrated<T0, T1>(arg0: &TokenPool<T0, T1>) : bool {
        arg0.state == 2
    }

    public fun migrate<T0, T1>(arg0: &mut TokenPool<T0, T1>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &PlatformConfig, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T0>) {
        assert!(arg0.state == 1, 8);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= 100000000, 13);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, arg2.platform_fee_wallet);
        let v0 = 0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.liquidity_provision), arg3);
        arg0.state = 2;
        arg0.graduated_at = 0x2::tx_context::epoch(arg3);
        let v1 = TokenGraduated{
            pool_id                    : 0x2::object::id<TokenPool<T0, T1>>(arg0),
            final_quote_liquidity      : 0x2::balance::value<T1>(&arg0.quote_balance),
            creator_payout             : 0,
            liquidity_provision_amount : 0x2::coin::value<T0>(&v0),
            migration_fee              : 100000000,
        };
        0x2::event::emit<TokenGraduated>(v1);
        (0x2::coin::from_balance<T1>(0x2::balance::withdraw_all<T1>(&mut arg0.quote_balance), arg3), v0)
    }

    public fun quote_buy<T0, T1>(arg0: &TokenPool<T0, T1>, arg1: u64) : (u64, u64, u64, u64, u64) {
        let (v0, v1) = calculate_buy_output<T0, T1>(arg1, arg0);
        (v0, v1, v1 * 4500 / 10000, v1 * 2500 / 10000, v1 * 3000 / 10000)
    }

    public fun quote_sell<T0, T1>(arg0: &TokenPool<T0, T1>, arg1: u64) : (u64, u64, u64, u64, u64) {
        let (v0, v1) = calculate_sell_output<T0, T1>(arg1, arg0);
        (v0, v1, v1 * 4500 / 10000, v1 * 2500 / 10000, v1 * 3000 / 10000)
    }

    public fun sell<T0, T1>(arg0: &mut TokenPool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: 0x1::option::Option<address>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 10);
        assert!(arg0.state == 0, 7);
        let (v1, v2) = calculate_sell_output<T0, T1>(v0, arg0);
        assert!(v1 >= arg2, 3);
        assert!(0x2::balance::value<T1>(&arg0.quote_balance) >= v1 + v2, 2);
        let v3 = v2 * 4500 / 10000;
        let v4 = v2 * 2500 / 10000;
        let v5 = v2 * 3000 / 10000;
        0x2::coin::burn<T0>(&mut arg0.treasury_cap, arg1);
        let v6 = 0x2::coin::take<T1>(&mut arg0.quote_balance, v1 + v2, arg4);
        if (v3 > 0) {
            0x2::balance::join<T1>(&mut arg0.admin_fee_balance, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v6, v3, arg4)));
        };
        if (v4 > 0) {
            0x2::balance::join<T1>(&mut arg0.creator_fee_balance, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v6, v4, arg4)));
        };
        if (v5 > 0) {
            0x2::balance::join<T1>(&mut arg0.staking_fee_balance, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v6, v5, arg4)));
        };
        arg0.total_sold = arg0.total_sold + v0;
        arg0.total_volume = arg0.total_volume + v1;
        let v7 = TokenTrade{
            pool_id           : 0x2::object::id<TokenPool<T0, T1>>(arg0),
            trader            : 0x2::tx_context::sender(arg4),
            is_buy            : false,
            quote_amount_in   : v0,
            meme_amount_out   : v1,
            trading_fee       : v2,
            admin_fee         : v3,
            creator_fee       : v4,
            staking_fee       : v5,
            new_meme_balance  : 0x2::balance::value<T0>(&arg0.meme_balance),
            new_quote_balance : 0x2::balance::value<T1>(&arg0.quote_balance),
        };
        0x2::event::emit<TokenTrade>(v7);
        v6
    }

    public fun sell_simple<T0, T1>(arg0: &mut TokenPool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        sell<T0, T1>(arg0, arg1, arg2, 0x1::option::none<address>(), arg3)
    }

    public fun start_migration<T0, T1>(arg0: &mut TokenPool<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.state == 0, 7);
        assert!(0x2::balance::value<T1>(&arg0.quote_balance) >= arg0.target_quote_liquidity, 9);
        arg0.state = 1;
        let v0 = MigrationStarted{
            pool_id           : 0x2::object::id<TokenPool<T0, T1>>(arg0),
            migration_witness : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<MigrationStarted>(v0);
    }

    public fun update_admin(arg0: &mut PlatformConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg2), 6);
        arg0.admin = arg1;
    }

    public fun update_platform_wallet(arg0: &mut PlatformConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg2), 6);
        arg0.platform_fee_wallet = arg1;
    }

    // decompiled from Move bytecode v6
}

