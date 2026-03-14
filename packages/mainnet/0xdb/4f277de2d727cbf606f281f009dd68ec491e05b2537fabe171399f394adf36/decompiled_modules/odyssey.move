module 0xdb4f277de2d727cbf606f281f009dd68ec491e05b2537fabe171399f394adf36::odyssey {
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
        migration_type: u8,
        fee_recipient: address,
        fee_recipient_handle: 0x1::option::Option<0x1::string::String>,
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
        recipient_fee_balance: 0x2::balance::Balance<T1>,
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
        total_joyride: u64,
    }

    struct VerifiedHandles has store, key {
        id: 0x2::object::UID,
        handles: 0x2::table::Table<0x1::string::String, address>,
    }

    struct TokenCreated has copy, drop {
        pool_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        migration_type: u8,
        virtual_liquidity: u64,
        target_liquidity: u64,
        fee_recipient: 0x1::option::Option<address>,
        fee_recipient_handle: 0x1::option::Option<0x1::string::String>,
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
        recipient_fee: u64,
        new_meme_balance: u64,
        new_quote_balance: u64,
    }

    struct TokenGraduated has copy, drop {
        pool_id: 0x2::object::ID,
        migration_type: u8,
        final_quote_liquidity: u64,
        creator_payout: u64,
        recipient_payout: u64,
        liquidity_provision_amount: u64,
        migration_fee: u64,
    }

    struct MigrationStarted has copy, drop {
        pool_id: 0x2::object::ID,
        migration_type: u8,
    }

    struct FeeClaimed has copy, drop {
        pool_id: 0x2::object::ID,
        claimer: address,
        fee_type: u8,
        amount: u64,
        timestamp: u64,
    }

    struct HandleVerified has copy, drop {
        handle: 0x1::string::String,
        wallet: address,
        verified_by: address,
    }

    public fun buy<T0, T1>(arg0: &mut TokenPool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::value<T1>(&arg1);
        assert!(v0 > 0, 10);
        assert!(arg0.state == 0, 7);
        let (v1, v2) = calculate_buy_output<T0, T1>(v0, arg0);
        assert!(v1 >= arg2, 3);
        let v3 = v2 * 4500 / 10000;
        let v4 = v2 * 2500 / 10000;
        let v5 = v4;
        let v6 = v2 * 3000 / 10000;
        let v7 = 0;
        if (arg0.migration_type == 0 && arg0.fee_recipient != @0x0) {
            v7 = v4;
            v5 = 0;
        };
        let v8 = 0x2::coin::into_balance<T1>(arg1);
        0x2::balance::join<T1>(&mut arg0.quote_balance, 0x2::balance::split<T1>(&mut v8, v0 - v2));
        let v9 = 0x2::balance::split<T1>(&mut v8, v2);
        if (v3 > 0) {
            0x2::balance::join<T1>(&mut arg0.admin_fee_balance, 0x2::balance::split<T1>(&mut v9, v3));
        };
        if (v5 > 0) {
            0x2::balance::join<T1>(&mut arg0.creator_fee_balance, 0x2::balance::split<T1>(&mut v9, v5));
        };
        if (v6 > 0) {
            0x2::balance::join<T1>(&mut arg0.staking_fee_balance, 0x2::balance::split<T1>(&mut v9, v6));
        };
        if (v7 > 0) {
            0x2::balance::join<T1>(&mut arg0.recipient_fee_balance, 0x2::balance::split<T1>(&mut v9, v7));
        };
        0x2::balance::join<T1>(&mut arg0.admin_fee_balance, v9);
        0x2::balance::join<T1>(&mut arg0.admin_fee_balance, v8);
        arg0.total_bought = arg0.total_bought + v1;
        arg0.total_volume = arg0.total_volume + v0;
        let v10 = 0x2::balance::value<T1>(&arg0.quote_balance);
        if (v10 >= arg0.target_quote_liquidity && arg0.migration_type != 0) {
            arg0.state = 1;
        };
        let v11 = TokenTrade{
            pool_id           : 0x2::object::id<TokenPool<T0, T1>>(arg0),
            trader            : 0x2::tx_context::sender(arg3),
            is_buy            : true,
            quote_amount_in   : v0,
            meme_amount_out   : v1,
            trading_fee       : v2,
            admin_fee         : v3,
            creator_fee       : v5,
            staking_fee       : v6,
            recipient_fee     : v7,
            new_meme_balance  : 0x2::balance::value<T0>(&arg0.meme_balance),
            new_quote_balance : v10,
        };
        0x2::event::emit<TokenTrade>(v11);
        0x2::coin::mint<T0>(&mut arg0.treasury_cap, v1, arg3)
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

    public fun claim_recipient_fee<T0, T1>(arg0: &mut TokenPool<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(arg0.fee_recipient == v0, 5);
        let v1 = 0x2::balance::value<T1>(&arg0.recipient_fee_balance);
        assert!(v1 > 0, 10);
        let v2 = FeeClaimed{
            pool_id   : 0x2::object::id<TokenPool<T0, T1>>(arg0),
            claimer   : v0,
            fee_type  : 3,
            amount    : v1,
            timestamp : 0x2::tx_context::epoch(arg1),
        };
        0x2::event::emit<FeeClaimed>(v2);
        0x2::coin::take<T1>(&mut arg0.recipient_fee_balance, v1, arg1)
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

    public fun create_pool<T0, T1>(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: u8, arg8: 0x1::option::Option<0x1::string::String>, arg9: 0x2::coin::Coin<T1>, arg10: 0x2::coin::TreasuryCap<T0>, arg11: address, arg12: u64, arg13: u64, arg14: &mut TokenRegistry, arg15: &VerifiedHandles, arg16: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::tx_context::sender(arg16);
        assert!(0x2::coin::value<T1>(&arg9) >= 1000000000, 4);
        assert!(arg7 <= 2, 1);
        let v1 = @0x0;
        if (arg7 == 0) {
            if (0x1::option::is_some<0x1::string::String>(&arg8)) {
                let v2 = 0x1::option::borrow<0x1::string::String>(&arg8);
                if (0x2::table::contains<0x1::string::String, address>(&arg15.handles, *v2)) {
                    v1 = *0x2::table::borrow<0x1::string::String, address>(&arg15.handles, *v2);
                };
            };
        };
        let v3 = 0x2::coin::total_supply<T0>(&arg10);
        let v4 = 0x2::coin::mint<T0>(&mut arg10, v3, arg16);
        let v5 = TokenPool<T0, T1>{
            id                     : 0x2::object::new(arg16),
            creator                : v0,
            name                   : arg0,
            symbol                 : arg1,
            description            : arg2,
            image_url              : arg3,
            x_social               : arg4,
            telegram_social        : arg5,
            website                : arg6,
            created_at             : 0x2::tx_context::epoch(arg16),
            graduated_at           : 0,
            migration_type         : arg7,
            fee_recipient          : v1,
            fee_recipient_handle   : arg8,
            state                  : 0,
            meme_balance           : 0x2::coin::into_balance<T0>(v4),
            quote_balance          : 0x2::coin::into_balance<T1>(arg9),
            virtual_liquidity      : arg12,
            target_quote_liquidity : arg13,
            liquidity_provision    : 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, v3 / 10, arg16)),
            treasury_cap           : arg10,
            total_bought           : 0,
            total_sold             : 0,
            total_volume           : 0,
            holder_count           : 1,
            trading_fee_bps        : 200,
            burn_tax_bps           : 0,
            admin_fee_balance      : 0x2::balance::zero<T1>(),
            creator_fee_balance    : 0x2::balance::zero<T1>(),
            staking_fee_balance    : 0x2::balance::zero<T1>(),
            recipient_fee_balance  : 0x2::balance::zero<T1>(),
            aida_staking_pool      : arg11,
        };
        let v6 = 0x2::object::id<TokenPool<T0, T1>>(&v5);
        0x2::table::add<0x2::object::ID, address>(&mut arg14.pools, v6, 0x2::object::id_to_address(&v6));
        arg14.total_tokens = arg14.total_tokens + 1;
        if (arg7 == 0) {
            arg14.total_joyride = arg14.total_joyride + 1;
        };
        let v7 = if (v1 != @0x0) {
            0x1::option::some<address>(v1)
        } else {
            0x1::option::none<address>()
        };
        let v8 = TokenCreated{
            pool_id              : v6,
            creator              : v0,
            name                 : v5.name,
            symbol               : v5.symbol,
            migration_type       : arg7,
            virtual_liquidity    : arg12,
            target_liquidity     : arg13,
            fee_recipient        : v7,
            fee_recipient_handle : arg8,
        };
        0x2::event::emit<TokenCreated>(v8);
        0x2::transfer::share_object<TokenPool<T0, T1>>(v5);
        v6
    }

    public fun get_creator<T0, T1>(arg0: &TokenPool<T0, T1>) : address {
        arg0.creator
    }

    public fun get_fee_recipient<T0, T1>(arg0: &TokenPool<T0, T1>) : address {
        arg0.fee_recipient
    }

    public fun get_joyride_count(arg0: &TokenRegistry) : u64 {
        arg0.total_joyride
    }

    public fun get_meme_balance<T0, T1>(arg0: &TokenPool<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.meme_balance)
    }

    public fun get_migration_fee() : u64 {
        100000000
    }

    public fun get_migration_type<T0, T1>(arg0: &TokenPool<T0, T1>) : u8 {
        arg0.migration_type
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

    public fun get_total_volume<T0, T1>(arg0: &TokenPool<T0, T1>) : u64 {
        arg0.total_volume
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PlatformConfig{
            id                  : 0x2::object::new(arg0),
            admin               : 0x2::tx_context::sender(arg0),
            platform_fee_wallet : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<PlatformConfig>(v0);
        let v1 = TokenRegistry{
            id            : 0x2::object::new(arg0),
            pools         : 0x2::table::new<0x2::object::ID, address>(arg0),
            total_tokens  : 0,
            total_volume  : 0,
            total_joyride : 0,
        };
        0x2::transfer::share_object<TokenRegistry>(v1);
        let v2 = VerifiedHandles{
            id      : 0x2::object::new(arg0),
            handles : 0x2::table::new<0x1::string::String, address>(arg0),
        };
        0x2::transfer::share_object<VerifiedHandles>(v2);
    }

    public fun is_joyride<T0, T1>(arg0: &TokenPool<T0, T1>) : bool {
        arg0.migration_type == 0
    }

    public fun migrate<T0, T1>(arg0: &mut TokenPool<T0, T1>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &PlatformConfig, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T0>) {
        assert!(arg0.state == 1, 8);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= 100000000, 13);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, arg2.platform_fee_wallet);
        let v0 = 0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.liquidity_provision), arg3);
        let v1 = 0x2::balance::value<T1>(&arg0.quote_balance);
        arg0.state = 2;
        arg0.graduated_at = 0x2::tx_context::epoch(arg3);
        let v2 = TokenGraduated{
            pool_id                    : 0x2::object::id<TokenPool<T0, T1>>(arg0),
            migration_type             : arg0.migration_type,
            final_quote_liquidity      : v1,
            creator_payout             : v1 * 2500 / 10000,
            recipient_payout           : 0,
            liquidity_provision_amount : 0x2::coin::value<T0>(&v0),
            migration_fee              : 100000000,
        };
        0x2::event::emit<TokenGraduated>(v2);
        (0x2::coin::from_balance<T1>(0x2::balance::withdraw_all<T1>(&mut arg0.quote_balance), arg3), v0)
    }

    public fun quote_buy<T0, T1>(arg0: &TokenPool<T0, T1>, arg1: u64) : (u64, u64) {
        calculate_buy_output<T0, T1>(arg1, arg0)
    }

    public fun quote_sell<T0, T1>(arg0: &TokenPool<T0, T1>, arg1: u64) : (u64, u64) {
        calculate_sell_output<T0, T1>(arg1, arg0)
    }

    public fun sell<T0, T1>(arg0: &mut TokenPool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 10);
        assert!(arg0.state == 0, 7);
        let (v1, v2) = calculate_sell_output<T0, T1>(v0, arg0);
        assert!(v1 >= arg2, 3);
        assert!(0x2::balance::value<T1>(&arg0.quote_balance) >= v1 + v2, 2);
        let v3 = v2 * 4500 / 10000;
        let v4 = v2 * 2500 / 10000;
        let v5 = v4;
        let v6 = v2 * 3000 / 10000;
        let v7 = 0;
        if (arg0.migration_type == 0 && arg0.fee_recipient != @0x0) {
            v7 = v4;
            v5 = 0;
        };
        0x2::coin::burn<T0>(&mut arg0.treasury_cap, arg1);
        let v8 = 0x2::coin::take<T1>(&mut arg0.quote_balance, v1 + v2, arg3);
        if (v3 > 0) {
            0x2::balance::join<T1>(&mut arg0.admin_fee_balance, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v8, v3, arg3)));
        };
        if (v5 > 0) {
            0x2::balance::join<T1>(&mut arg0.creator_fee_balance, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v8, v5, arg3)));
        };
        if (v6 > 0) {
            0x2::balance::join<T1>(&mut arg0.staking_fee_balance, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v8, v6, arg3)));
        };
        if (v7 > 0) {
            0x2::balance::join<T1>(&mut arg0.recipient_fee_balance, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v8, v7, arg3)));
        };
        arg0.total_sold = arg0.total_sold + v0;
        arg0.total_volume = arg0.total_volume + v1;
        let v9 = TokenTrade{
            pool_id           : 0x2::object::id<TokenPool<T0, T1>>(arg0),
            trader            : 0x2::tx_context::sender(arg3),
            is_buy            : false,
            quote_amount_in   : v0,
            meme_amount_out   : v1,
            trading_fee       : v2,
            admin_fee         : v3,
            creator_fee       : v5,
            staking_fee       : v6,
            recipient_fee     : v7,
            new_meme_balance  : 0x2::balance::value<T0>(&arg0.meme_balance),
            new_quote_balance : 0x2::balance::value<T1>(&arg0.quote_balance),
        };
        0x2::event::emit<TokenTrade>(v9);
        v8
    }

    public fun start_migration<T0, T1>(arg0: &mut TokenPool<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.state == 0, 7);
        assert!(arg0.migration_type != 0, 7);
        assert!(0x2::balance::value<T1>(&arg0.quote_balance) >= arg0.target_quote_liquidity, 9);
        arg0.state = 1;
        let v0 = MigrationStarted{
            pool_id        : 0x2::object::id<TokenPool<T0, T1>>(arg0),
            migration_type : arg0.migration_type,
        };
        0x2::event::emit<MigrationStarted>(v0);
    }

    public fun unverify_handle(arg0: &mut VerifiedHandles, arg1: 0x1::string::String, arg2: &PlatformConfig, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.admin == 0x2::tx_context::sender(arg3), 6);
        0x2::table::remove<0x1::string::String, address>(&mut arg0.handles, arg1);
    }

    public fun update_admin(arg0: &mut PlatformConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg2), 6);
        arg0.admin = arg1;
    }

    public fun update_platform_wallet(arg0: &mut PlatformConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg2), 6);
        arg0.platform_fee_wallet = arg1;
    }

    public fun verify_handle(arg0: &mut VerifiedHandles, arg1: 0x1::string::String, arg2: address, arg3: &PlatformConfig, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg3.admin == 0x2::tx_context::sender(arg4), 6);
        0x2::table::add<0x1::string::String, address>(&mut arg0.handles, arg1, arg2);
        let v0 = HandleVerified{
            handle      : arg1,
            wallet      : arg2,
            verified_by : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<HandleVerified>(v0);
    }

    // decompiled from Move bytecode v6
}

