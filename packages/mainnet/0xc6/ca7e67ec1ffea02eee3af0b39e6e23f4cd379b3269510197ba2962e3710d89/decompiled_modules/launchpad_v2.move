module 0xc6ca7e67ec1ffea02eee3af0b39e6e23f4cd379b3269510197ba2962e3710d89::launchpad_v2 {
    struct CreatorCap has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
    }

    struct GraduationCap has store, key {
        id: 0x2::object::UID,
    }

    struct ModerationCap has store, key {
        id: 0x2::object::UID,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        pools: 0x2::table::Table<0x2::object::ID, bool>,
        total_launched: u64,
        total_graduated: u64,
    }

    struct BondingCurve<phantom T0> has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        treasury: 0x2::coin::TreasuryCap<T0>,
        virtual_sui: u64,
        graduation_threshold: u64,
        trade_fee_bps: u64,
        creator_fee_pct: u64,
        protocol_fee_pct: u64,
        protocol_treasury: address,
        k: u128,
        token_reserve: u64,
        grad_token_reserve: u64,
        total_minted: u64,
        sui_reserve: 0x2::balance::Balance<0x2::sui::SUI>,
        creator: address,
        created_at: u64,
        bflags: u8,
        flag_count: u64,
        flaggers: 0x2::table::Table<address, bool>,
        reward_mode: u8,
        cashback_pool: 0x2::balance::Balance<0x2::sui::SUI>,
        total_cashback_volume: u64,
        trader_cashback_volume: 0x2::table::Table<address, u64>,
        buyback_rate_bps: u64,
        buyback_pool: 0x2::balance::Balance<0x2::sui::SUI>,
        creator_fees: 0x2::balance::Balance<0x2::sui::SUI>,
        early_buyers: 0x2::table::Table<address, u64>,
        withdrawal_requested_at: u64,
    }

    struct PoolCreated has copy, drop {
        pool_id: 0x2::object::ID,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        coin_type_name: 0x1::string::String,
        creator: address,
        virtual_sui: u64,
        graduation_threshold: u64,
        reward_mode: u8,
        buyback_rate_bps: u64,
        created_at: u64,
    }

    struct TokensBought has copy, drop {
        pool_id: 0x2::object::ID,
        buyer: address,
        sui_in: u64,
        tokens_out: u64,
        new_token_reserve: u64,
        new_real_sui: u64,
        spot_price_mist: u64,
        is_snipe_window: bool,
    }

    struct TokensSold has copy, drop {
        pool_id: 0x2::object::ID,
        seller: address,
        tokens_in: u64,
        sui_out: u64,
        new_token_reserve: u64,
        new_real_sui: u64,
        spot_price_mist: u64,
    }

    struct PoolGraduated has copy, drop {
        pool_id: 0x2::object::ID,
        name: 0x1::string::String,
        real_sui: u64,
    }

    struct GraduatedLiquidityWithdrawn has copy, drop {
        pool_id: 0x2::object::ID,
        sui_amount: u64,
        lp_tokens: u64,
    }

    struct PoolFlagged has copy, drop {
        pool_id: 0x2::object::ID,
        flagger: address,
        flag_count: u64,
        suspended: bool,
    }

    struct PoolVerified has copy, drop {
        pool_id: 0x2::object::ID,
    }

    struct CashbackClaimed has copy, drop {
        pool_id: 0x2::object::ID,
        trader: address,
        amount: u64,
    }

    struct BuybackExecuted has copy, drop {
        pool_id: 0x2::object::ID,
        sui_spent: u64,
        tokens_burned: u64,
    }

    public fun buy<T0>(arg0: &mut BondingCurve<T0>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.bflags & 8 == 0, 5);
        assert!(arg0.bflags & 1 == 0, 2);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 > 0, 4);
        let v1 = v0 * arg0.trade_fee_bps / 10000;
        let v2 = 0xc6ca7e67ec1ffea02eee3af0b39e6e23f4cd379b3269510197ba2962e3710d89::bonding_curve::tokens_out(arg0.k, arg0.virtual_sui + 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve), arg0.token_reserve, v0 - v1);
        assert!(v2 > 0, 4);
        assert!(v2 >= arg2, 3);
        assert!(v2 <= arg0.token_reserve, 15);
        let v3 = v1 * arg0.creator_fee_pct / 100;
        let v4 = v1 * arg0.protocol_fee_pct / 100;
        let v5 = if (arg0.reward_mode == 1) {
            v1 - v3 - v4
        } else {
            0
        };
        let v6 = if (arg0.bflags & 32 != 0) {
            v1 * arg0.buyback_rate_bps / 10000
        } else {
            0
        };
        let v7 = 0x2::coin::into_balance<0x2::sui::SUI>(arg1);
        if (v4 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v7, v4), arg4), arg0.protocol_treasury);
        };
        if (v3 > 0) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.creator_fees, 0x2::balance::split<0x2::sui::SUI>(&mut v7, v3));
        };
        if (v5 > 0) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.cashback_pool, 0x2::balance::split<0x2::sui::SUI>(&mut v7, v5));
        };
        if (v6 > 0) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.buyback_pool, 0x2::balance::split<0x2::sui::SUI>(&mut v7, v6));
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_reserve, v7);
        arg0.token_reserve = arg0.token_reserve - v2;
        arg0.total_minted = arg0.total_minted + v2;
        let v8 = 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve);
        if (arg0.reward_mode == 1) {
            let v9 = 0x2::tx_context::sender(arg4);
            if (0x2::table::contains<address, u64>(&arg0.trader_cashback_volume, v9)) {
                *0x2::table::borrow_mut<address, u64>(&mut arg0.trader_cashback_volume, v9) = *0x2::table::borrow<address, u64>(&arg0.trader_cashback_volume, v9) + v0;
            } else {
                0x2::table::add<address, u64>(&mut arg0.trader_cashback_volume, v9, v0);
            };
            arg0.total_cashback_volume = arg0.total_cashback_volume + v0;
        };
        let v10 = 0x2::clock::timestamp_ms(arg3) - arg0.created_at;
        if (v10 <= 300000 && !0x2::table::contains<address, u64>(&arg0.early_buyers, 0x2::tx_context::sender(arg4))) {
            0x2::table::add<address, u64>(&mut arg0.early_buyers, 0x2::tx_context::sender(arg4), arg0.created_at);
        };
        let v11 = TokensBought{
            pool_id           : 0x2::object::id<BondingCurve<T0>>(arg0),
            buyer             : 0x2::tx_context::sender(arg4),
            sui_in            : v0,
            tokens_out        : v2,
            new_token_reserve : arg0.token_reserve,
            new_real_sui      : v8,
            spot_price_mist   : 0xc6ca7e67ec1ffea02eee3af0b39e6e23f4cd379b3269510197ba2962e3710d89::bonding_curve::spot_price_mist(arg0.virtual_sui + v8, arg0.token_reserve, 1000000),
            is_snipe_window   : v10 <= 30000,
        };
        0x2::event::emit<TokensBought>(v11);
        if (v8 >= arg0.graduation_threshold) {
            arg0.bflags = arg0.bflags | 1;
            let v12 = PoolGraduated{
                pool_id  : 0x2::object::id<BondingCurve<T0>>(arg0),
                name     : arg0.name,
                real_sui : v8,
            };
            0x2::event::emit<PoolGraduated>(v12);
        };
        0x2::coin::mint<T0>(&mut arg0.treasury, v2, arg4)
    }

    public fun claim_cashback<T0>(arg0: &mut BondingCurve<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(arg0.reward_mode == 1, 10);
        assert!(0x2::table::contains<address, u64>(&arg0.trader_cashback_volume, v0), 4);
        let v1 = arg0.total_cashback_volume;
        assert!(v1 > 0, 4);
        let v2 = (((0x2::balance::value<0x2::sui::SUI>(&arg0.cashback_pool) as u128) * (*0x2::table::borrow<address, u64>(&arg0.trader_cashback_volume, v0) as u128) / (v1 as u128)) as u64);
        assert!(v2 > 0, 4);
        *0x2::table::borrow_mut<address, u64>(&mut arg0.trader_cashback_volume, v0) = 0;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.cashback_pool, v2), arg1), v0);
        let v3 = CashbackClaimed{
            pool_id : 0x2::object::id<BondingCurve<T0>>(arg0),
            trader  : v0,
            amount  : v2,
        };
        0x2::event::emit<CashbackClaimed>(v3);
    }

    public fun claim_creator_fees<T0>(arg0: &CreatorCap, arg1: &mut BondingCurve<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.pool_id == 0x2::object::id<BondingCurve<T0>>(arg1), 6);
        assert!(arg1.withdrawal_requested_at > 0, 13);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg1.withdrawal_requested_at + 172800000, 13);
        arg1.withdrawal_requested_at = 0;
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg1.creator_fees) > 0, 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg1.creator_fees), arg3), 0x2::tx_context::sender(arg3));
    }

    public fun creator<T0>(arg0: &BondingCurve<T0>) : address {
        arg0.creator
    }

    public fun execute_buyback<T0>(arg0: &mut BondingCurve<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.bflags & 32 != 0, 11);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.buyback_pool);
        assert!(v0 > 0, 4);
        let v1 = 0xc6ca7e67ec1ffea02eee3af0b39e6e23f4cd379b3269510197ba2962e3710d89::bonding_curve::tokens_out(arg0.k, arg0.virtual_sui + 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve), arg0.token_reserve, v0);
        assert!(v1 > 0, 4);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_reserve, 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.buyback_pool));
        arg0.token_reserve = arg0.token_reserve - v1;
        arg0.k = 0xc6ca7e67ec1ffea02eee3af0b39e6e23f4cd379b3269510197ba2962e3710d89::bonding_curve::compute_k(arg0.virtual_sui + 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve), arg0.token_reserve);
        let v2 = BuybackExecuted{
            pool_id       : 0x2::object::id<BondingCurve<T0>>(arg0),
            sui_spent     : v0,
            tokens_burned : v1,
        };
        0x2::event::emit<BuybackExecuted>(v2);
    }

    public fun flag_pool<T0>(arg0: &mut BondingCurve<T0>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.bflags & 1 == 0, 2);
        assert!(!0x2::table::contains<address, bool>(&arg0.flaggers, 0x2::tx_context::sender(arg3)), 8);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= 1000000000, 9);
        0x2::table::add<address, bool>(&mut arg0.flaggers, 0x2::tx_context::sender(arg3), true);
        arg0.flag_count = arg0.flag_count + 1;
        let v0 = arg0.flag_count >= 10;
        if (v0) {
            arg0.bflags = arg0.bflags | 8;
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.creator_fees, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v1 = PoolFlagged{
            pool_id    : 0x2::object::id<BondingCurve<T0>>(arg0),
            flagger    : 0x2::tx_context::sender(arg3),
            flag_count : arg0.flag_count,
            suspended  : v0,
        };
        0x2::event::emit<PoolFlagged>(v1);
    }

    public fun graduated<T0>(arg0: &BondingCurve<T0>) : bool {
        arg0.bflags & 1 != 0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GraduationCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<GraduationCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = ModerationCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<ModerationCap>(v1, 0x2::tx_context::sender(arg0));
        let v2 = Registry{
            id              : 0x2::object::new(arg0),
            pools           : 0x2::table::new<0x2::object::ID, bool>(arg0),
            total_launched  : 0,
            total_graduated : 0,
        };
        0x2::transfer::share_object<Registry>(v2);
    }

    public fun launch<T0>(arg0: &mut Registry, arg1: &0xc6ca7e67ec1ffea02eee3af0b39e6e23f4cd379b3269510197ba2962e3710d89::config::LaunchpadConfig, arg2: 0x2::coin::TreasuryCap<T0>, arg3: &0x2::coin::CoinMetadata<T0>, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: vector<u8>, arg6: vector<u8>, arg7: u8, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(!0xc6ca7e67ec1ffea02eee3af0b39e6e23f4cd379b3269510197ba2962e3710d89::config::launch_paused(arg1), 0);
        assert!(arg7 <= 1, 10);
        assert!(arg8 <= 500, 11);
        assert!(0x2::coin::total_supply<T0>(&arg2) == 0, 17);
        let v0 = 0xc6ca7e67ec1ffea02eee3af0b39e6e23f4cd379b3269510197ba2962e3710d89::config::creation_fee_mist(arg1);
        let v1 = 0x2::coin::into_balance<0x2::sui::SUI>(arg4);
        assert!(0x2::balance::value<0x2::sui::SUI>(&v1) >= v0, 1);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v1, v0), arg10), 0xc6ca7e67ec1ffea02eee3af0b39e6e23f4cd379b3269510197ba2962e3710d89::config::treasury(arg1));
        };
        if (0x2::balance::value<0x2::sui::SUI>(&v1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v1, arg10), 0x2::tx_context::sender(arg10));
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v1);
        };
        let v2 = 0xc6ca7e67ec1ffea02eee3af0b39e6e23f4cd379b3269510197ba2962e3710d89::config::virtual_sui_reserve(arg1);
        let v3 = 0xc6ca7e67ec1ffea02eee3af0b39e6e23f4cd379b3269510197ba2962e3710d89::config::initial_token_reserve(arg1);
        let v4 = 0x2::clock::timestamp_ms(arg9);
        let v5 = if (arg8 > 0) {
            32
        } else {
            0
        };
        let v6 = BondingCurve<T0>{
            id                      : 0x2::object::new(arg10),
            name                    : 0x1::string::utf8(arg5),
            symbol                  : 0x1::string::utf8(arg6),
            treasury                : arg2,
            virtual_sui             : v2,
            graduation_threshold    : 0xc6ca7e67ec1ffea02eee3af0b39e6e23f4cd379b3269510197ba2962e3710d89::config::graduation_sui_threshold(arg1),
            trade_fee_bps           : 0xc6ca7e67ec1ffea02eee3af0b39e6e23f4cd379b3269510197ba2962e3710d89::config::trade_fee_bps(arg1),
            creator_fee_pct         : 0xc6ca7e67ec1ffea02eee3af0b39e6e23f4cd379b3269510197ba2962e3710d89::config::creator_fee_pct(arg1),
            protocol_fee_pct        : 0xc6ca7e67ec1ffea02eee3af0b39e6e23f4cd379b3269510197ba2962e3710d89::config::protocol_fee_pct(arg1),
            protocol_treasury       : 0xc6ca7e67ec1ffea02eee3af0b39e6e23f4cd379b3269510197ba2962e3710d89::config::treasury(arg1),
            k                       : 0xc6ca7e67ec1ffea02eee3af0b39e6e23f4cd379b3269510197ba2962e3710d89::bonding_curve::compute_k(v2, v3),
            token_reserve           : v3,
            grad_token_reserve      : 0xc6ca7e67ec1ffea02eee3af0b39e6e23f4cd379b3269510197ba2962e3710d89::config::lp_token_reserve(arg1),
            total_minted            : 0,
            sui_reserve             : 0x2::balance::zero<0x2::sui::SUI>(),
            creator                 : 0x2::tx_context::sender(arg10),
            created_at              : v4,
            bflags                  : v5,
            flag_count              : 0,
            flaggers                : 0x2::table::new<address, bool>(arg10),
            reward_mode             : arg7,
            cashback_pool           : 0x2::balance::zero<0x2::sui::SUI>(),
            total_cashback_volume   : 0,
            trader_cashback_volume  : 0x2::table::new<address, u64>(arg10),
            buyback_rate_bps        : arg8,
            buyback_pool            : 0x2::balance::zero<0x2::sui::SUI>(),
            creator_fees            : 0x2::balance::zero<0x2::sui::SUI>(),
            early_buyers            : 0x2::table::new<address, u64>(arg10),
            withdrawal_requested_at : 0,
        };
        let v7 = 0x2::object::id<BondingCurve<T0>>(&v6);
        0x2::table::add<0x2::object::ID, bool>(&mut arg0.pools, v7, true);
        arg0.total_launched = arg0.total_launched + 1;
        let v8 = CreatorCap{
            id      : 0x2::object::new(arg10),
            pool_id : v7,
        };
        0x2::transfer::transfer<CreatorCap>(v8, 0x2::tx_context::sender(arg10));
        let v9 = PoolCreated{
            pool_id              : v7,
            name                 : v6.name,
            symbol               : v6.symbol,
            coin_type_name       : 0x1::string::utf8(b""),
            creator              : 0x2::tx_context::sender(arg10),
            virtual_sui          : v2,
            graduation_threshold : 0xc6ca7e67ec1ffea02eee3af0b39e6e23f4cd379b3269510197ba2962e3710d89::config::graduation_sui_threshold(arg1),
            reward_mode          : arg7,
            buyback_rate_bps     : arg8,
            created_at           : v4,
        };
        0x2::event::emit<PoolCreated>(v9);
        0x2::transfer::share_object<BondingCurve<T0>>(v6);
    }

    public fun lp_created<T0>(arg0: &BondingCurve<T0>) : bool {
        arg0.bflags & 2 != 0
    }

    public fun pool_id<T0>(arg0: &BondingCurve<T0>) : 0x2::object::ID {
        0x2::object::id<BondingCurve<T0>>(arg0)
    }

    public fun request_withdrawal<T0>(arg0: &CreatorCap, arg1: &mut BondingCurve<T0>, arg2: &0x2::clock::Clock) {
        assert!(arg0.pool_id == 0x2::object::id<BondingCurve<T0>>(arg1), 6);
        arg1.withdrawal_requested_at = 0x2::clock::timestamp_ms(arg2);
    }

    public fun sell<T0>(arg0: &mut BondingCurve<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(arg0.bflags & 8 == 0, 5);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 4);
        let v1 = 0xc6ca7e67ec1ffea02eee3af0b39e6e23f4cd379b3269510197ba2962e3710d89::bonding_curve::sui_out_gross(arg0.k, arg0.virtual_sui + 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve), arg0.token_reserve, v0);
        let v2 = v1 * arg0.trade_fee_bps / 10000;
        let v3 = v2 * arg0.creator_fee_pct / 100;
        let v4 = v2 * arg0.protocol_fee_pct / 100;
        let v5 = if (arg0.reward_mode == 1) {
            v2 - v3 - v4
        } else {
            0
        };
        let v6 = if (arg0.bflags & 32 != 0) {
            v2 * arg0.buyback_rate_bps / 10000
        } else {
            0
        };
        let v7 = v1 - v2;
        assert!(v7 >= arg2, 3);
        0x2::coin::burn<T0>(&mut arg0.treasury, arg1);
        arg0.token_reserve = arg0.token_reserve + v0;
        arg0.total_minted = arg0.total_minted - v0;
        if (v3 > 0) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.creator_fees, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_reserve, v3));
        };
        if (v5 > 0) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.cashback_pool, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_reserve, v5));
        };
        if (v6 > 0) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.buyback_pool, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_reserve, v6));
        };
        let v8 = 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve) - v7;
        if (v4 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_reserve, v4), arg4), arg0.protocol_treasury);
        };
        let v9 = TokensSold{
            pool_id           : 0x2::object::id<BondingCurve<T0>>(arg0),
            seller            : 0x2::tx_context::sender(arg4),
            tokens_in         : v0,
            sui_out           : v7,
            new_token_reserve : arg0.token_reserve,
            new_real_sui      : v8,
            spot_price_mist   : 0xc6ca7e67ec1ffea02eee3af0b39e6e23f4cd379b3269510197ba2962e3710d89::bonding_curve::spot_price_mist(arg0.virtual_sui + v8, arg0.token_reserve, 1000000),
        };
        0x2::event::emit<TokensSold>(v9);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_reserve, v7), arg4)
    }

    public fun sui_reserve<T0>(arg0: &BondingCurve<T0>) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve)
    }

    public fun suspend_pool<T0>(arg0: &ModerationCap, arg1: &mut BondingCurve<T0>) {
        arg1.bflags = arg1.bflags | 8;
    }

    public fun suspended<T0>(arg0: &BondingCurve<T0>) : bool {
        arg0.bflags & 8 != 0
    }

    public fun token_reserve<T0>(arg0: &BondingCurve<T0>) : u64 {
        arg0.token_reserve
    }

    public fun total_minted<T0>(arg0: &BondingCurve<T0>) : u64 {
        arg0.total_minted
    }

    public fun unsuspend_pool<T0>(arg0: &ModerationCap, arg1: &mut BondingCurve<T0>) {
        arg1.bflags = arg1.bflags ^ arg1.bflags & 8;
        arg1.flag_count = 0;
    }

    public fun verified<T0>(arg0: &BondingCurve<T0>) : bool {
        arg0.bflags & 4 != 0
    }

    public fun verify_pool<T0>(arg0: &ModerationCap, arg1: &mut BondingCurve<T0>) {
        arg1.bflags = arg1.bflags | 4;
        let v0 = PoolVerified{pool_id: 0x2::object::id<BondingCurve<T0>>(arg1)};
        0x2::event::emit<PoolVerified>(v0);
    }

    public fun withdraw_graduated_liquidity<T0>(arg0: &GraduationCap, arg1: &mut BondingCurve<T0>, arg2: &mut Registry, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<T0>) {
        assert!(arg1.bflags & 1 != 0, 7);
        assert!(arg1.bflags & 2 == 0, 2);
        arg1.bflags = arg1.bflags | 2;
        arg2.total_graduated = arg2.total_graduated + 1;
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg1.sui_reserve);
        let v1 = arg1.grad_token_reserve;
        let v2 = GraduatedLiquidityWithdrawn{
            pool_id    : 0x2::object::id<BondingCurve<T0>>(arg1),
            sui_amount : v0,
            lp_tokens  : v1,
        };
        0x2::event::emit<GraduatedLiquidityWithdrawn>(v2);
        (0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.sui_reserve, v0), arg3), 0x2::coin::mint<T0>(&mut arg1.treasury, v1, arg3))
    }

    // decompiled from Move bytecode v7
}

