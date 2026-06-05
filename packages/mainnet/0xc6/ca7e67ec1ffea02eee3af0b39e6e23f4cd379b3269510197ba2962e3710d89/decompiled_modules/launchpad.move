module 0xc6ca7e67ec1ffea02eee3af0b39e6e23f4cd379b3269510197ba2962e3710d89::launchpad {
    struct LAUNCHPAD has drop {
        dummy_field: bool,
    }

    struct PoolToken has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        amount: u64,
    }

    struct CreatorCap has key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
    }

    struct GraduationCap has store, key {
        id: 0x2::object::UID,
    }

    struct ModerationCap has key {
        id: 0x2::object::UID,
    }

    struct AgentCap has key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        pools: 0x2::table::Table<0x2::object::ID, bool>,
        total_launched: u64,
        total_graduated: u64,
    }

    struct RedemptionVault<phantom T0> has key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        reserve: 0x2::balance::Balance<T0>,
        rate_num: u64,
        rate_den: u64,
    }

    struct BondingCurve has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        project_type: u8,
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
        agent_revenue_buyback_pct: u64,
        creator_fees: 0x2::balance::Balance<0x2::sui::SUI>,
        early_buyers: 0x2::table::Table<address, u64>,
        withdrawal_requested_at: u64,
    }

    struct PoolCreated has copy, drop {
        pool_id: 0x2::object::ID,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        website: 0x1::string::String,
        github: 0x1::string::String,
        project_type: u8,
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
        tokens_sold: u64,
        lp_tokens: u64,
    }

    struct RedemptionVaultCreated has copy, drop {
        pool_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        reserve: u64,
    }

    struct TokensRedeemed has copy, drop {
        pool_id: 0x2::object::ID,
        redeemer: address,
        pool_token: u64,
        coins_out: u64,
    }

    struct BuybackExecuted has copy, drop {
        pool_id: 0x2::object::ID,
        sui_spent: u64,
        tokens_burned: u64,
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

    struct CreatorTradeEvent has copy, drop {
        pool_id: 0x2::object::ID,
        is_buy: bool,
        sui_amount: u64,
    }

    struct EarlyBuyerSellEvent has copy, drop {
        pool_id: 0x2::object::ID,
        seller: address,
        tokens_sold: u64,
        sui_out: u64,
        bought_at_ms: u64,
        is_creator: bool,
    }

    public fun buy(arg0: &mut BondingCurve, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : PoolToken {
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
            let v9 = if (0x2::table::contains<address, u64>(&arg0.trader_cashback_volume, 0x2::tx_context::sender(arg4))) {
                *0x2::table::borrow<address, u64>(&arg0.trader_cashback_volume, 0x2::tx_context::sender(arg4))
            } else {
                0
            };
            if (0x2::table::contains<address, u64>(&arg0.trader_cashback_volume, 0x2::tx_context::sender(arg4))) {
                *0x2::table::borrow_mut<address, u64>(&mut arg0.trader_cashback_volume, 0x2::tx_context::sender(arg4)) = v9 + v0;
            } else {
                0x2::table::add<address, u64>(&mut arg0.trader_cashback_volume, 0x2::tx_context::sender(arg4), v9 + v0);
            };
            arg0.total_cashback_volume = arg0.total_cashback_volume + v0;
        };
        let v10 = 0x2::clock::timestamp_ms(arg3) - arg0.created_at;
        if (v10 <= 300000 && arg0.flag_count < 500) {
            if (!0x2::table::contains<address, u64>(&arg0.early_buyers, 0x2::tx_context::sender(arg4))) {
                0x2::table::add<address, u64>(&mut arg0.early_buyers, 0x2::tx_context::sender(arg4), arg0.created_at);
            };
        };
        if (0x2::tx_context::sender(arg4) == arg0.creator) {
            let v11 = CreatorTradeEvent{
                pool_id    : 0x2::object::id<BondingCurve>(arg0),
                is_buy     : true,
                sui_amount : v0,
            };
            0x2::event::emit<CreatorTradeEvent>(v11);
        };
        let v12 = TokensBought{
            pool_id           : 0x2::object::id<BondingCurve>(arg0),
            buyer             : 0x2::tx_context::sender(arg4),
            sui_in            : v0,
            tokens_out        : v2,
            new_token_reserve : arg0.token_reserve,
            new_real_sui      : v8,
            spot_price_mist   : 0xc6ca7e67ec1ffea02eee3af0b39e6e23f4cd379b3269510197ba2962e3710d89::bonding_curve::spot_price_mist(arg0.virtual_sui + v8, arg0.token_reserve, 1000000),
            is_snipe_window   : v10 <= 30000,
        };
        0x2::event::emit<TokensBought>(v12);
        if (v8 >= arg0.graduation_threshold) {
            arg0.bflags = arg0.bflags | 1;
            let v13 = PoolGraduated{
                pool_id  : 0x2::object::id<BondingCurve>(arg0),
                name     : arg0.name,
                real_sui : v8,
            };
            0x2::event::emit<PoolGraduated>(v13);
        };
        PoolToken{
            id      : 0x2::object::new(arg4),
            pool_id : 0x2::object::id<BondingCurve>(arg0),
            amount  : v2,
        }
    }

    public fun buy_exact(arg0: &mut BondingCurve, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (PoolToken, 0x2::coin::Coin<0x2::sui::SUI>) {
        assert!(arg0.bflags & 8 == 0, 5);
        assert!(arg0.bflags & 1 == 0, 2);
        assert!(arg2 > 0, 4);
        assert!(arg2 <= arg0.token_reserve, 15);
        let v0 = 0xc6ca7e67ec1ffea02eee3af0b39e6e23f4cd379b3269510197ba2962e3710d89::bonding_curve::sui_in_for_tokens(arg0.k, arg0.virtual_sui + 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve), arg0.token_reserve, arg2) * 10000 / (10000 - arg0.trade_fee_bps) + 1;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= v0, 3);
        let v1 = 0x2::coin::split<0x2::sui::SUI>(&mut arg1, 0x2::coin::value<0x2::sui::SUI>(&arg1) - v0, arg4);
        (buy(arg0, arg1, arg2, arg3, arg4), v1)
    }

    public fun buyback_on(arg0: &BondingCurve) : bool {
        arg0.bflags & 32 != 0
    }

    public fun claim_cashback(arg0: &mut BondingCurve, arg1: &mut 0x2::tx_context::TxContext) {
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
            pool_id : 0x2::object::id<BondingCurve>(arg0),
            trader  : v0,
            amount  : v2,
        };
        0x2::event::emit<CashbackClaimed>(v3);
    }

    public fun claim_creator_fees(arg0: &CreatorCap, arg1: &mut BondingCurve, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.pool_id == 0x2::object::id<BondingCurve>(arg1), 6);
        assert!(arg1.withdrawal_requested_at > 0, 13);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg1.withdrawal_requested_at + 172800000, 13);
        arg1.withdrawal_requested_at = 0;
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg1.creator_fees) > 0, 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg1.creator_fees), arg3), 0x2::tx_context::sender(arg3));
    }

    public fun create_redemption_vault<T0>(arg0: &GraduationCap, arg1: &BondingCurve, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.bflags & 1 != 0, 7);
        let v0 = 0x2::coin::into_balance<T0>(arg2);
        let v1 = RedemptionVault<T0>{
            id       : 0x2::object::new(arg3),
            pool_id  : 0x2::object::id<BondingCurve>(arg1),
            reserve  : v0,
            rate_num : 1,
            rate_den : 1,
        };
        let v2 = RedemptionVaultCreated{
            pool_id  : 0x2::object::id<BondingCurve>(arg1),
            vault_id : 0x2::object::id<RedemptionVault<T0>>(&v1),
            reserve  : 0x2::balance::value<T0>(&v0),
        };
        0x2::event::emit<RedemptionVaultCreated>(v2);
        0x2::transfer::share_object<RedemptionVault<T0>>(v1);
    }

    public fun creator(arg0: &BondingCurve) : address {
        arg0.creator
    }

    public fun deposit_agent_revenue(arg0: &AgentCap, arg1: &mut BondingCurve, arg2: 0x2::coin::Coin<0x2::sui::SUI>) {
        assert!(arg0.pool_id == 0x2::object::id<BondingCurve>(arg1), 12);
        arg1.bflags = arg1.bflags | 16;
        let v0 = arg1.agent_revenue_buyback_pct;
        let v1 = 0x2::coin::into_balance<0x2::sui::SUI>(arg2);
        if (v0 > 0 && arg1.bflags & 32 != 0) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg1.buyback_pool, 0x2::balance::split<0x2::sui::SUI>(&mut v1, 0x2::coin::value<0x2::sui::SUI>(&arg2) * v0 / 100));
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.creator_fees, v1);
    }

    public fun execute_buyback(arg0: &mut BondingCurve) {
        assert!(arg0.bflags & 32 != 0, 11);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.buyback_pool);
        assert!(v0 > 0, 4);
        let v1 = 0xc6ca7e67ec1ffea02eee3af0b39e6e23f4cd379b3269510197ba2962e3710d89::bonding_curve::tokens_out(arg0.k, arg0.virtual_sui + 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve), arg0.token_reserve, v0);
        assert!(v1 > 0, 4);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_reserve, 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.buyback_pool));
        arg0.token_reserve = arg0.token_reserve - v1;
        let v2 = if (arg0.total_minted >= v1) {
            arg0.total_minted - v1
        } else {
            0
        };
        arg0.total_minted = v2;
        arg0.k = 0xc6ca7e67ec1ffea02eee3af0b39e6e23f4cd379b3269510197ba2962e3710d89::bonding_curve::compute_k(arg0.virtual_sui + 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve), arg0.token_reserve);
        let v3 = BuybackExecuted{
            pool_id       : 0x2::object::id<BondingCurve>(arg0),
            sui_spent     : v0,
            tokens_burned : v1,
        };
        0x2::event::emit<BuybackExecuted>(v3);
    }

    public fun finalize_graduation(arg0: &GraduationCap, arg1: &mut BondingCurve, arg2: &mut Registry) {
        assert!(arg1.bflags & 1 != 0, 7);
        assert!(arg1.bflags & 2 == 0, 2);
        arg1.bflags = arg1.bflags | 2;
        arg2.total_graduated = arg2.total_graduated + 1;
    }

    public fun flag_pool(arg0: &mut BondingCurve, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
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
            pool_id    : 0x2::object::id<BondingCurve>(arg0),
            flagger    : 0x2::tx_context::sender(arg3),
            flag_count : arg0.flag_count,
            suspended  : v0,
        };
        0x2::event::emit<PoolFlagged>(v1);
    }

    public fun graduated(arg0: &BondingCurve) : bool {
        arg0.bflags & 1 != 0
    }

    public fun has_agent(arg0: &BondingCurve) : bool {
        arg0.bflags & 16 != 0
    }

    fun init(arg0: LAUNCHPAD, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<LAUNCHPAD>(arg0, arg1);
        let v0 = GraduationCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<GraduationCap>(v0, 0x2::tx_context::sender(arg1));
        let v1 = ModerationCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<ModerationCap>(v1, 0x2::tx_context::sender(arg1));
        let v2 = Registry{
            id              : 0x2::object::new(arg1),
            pools           : 0x2::table::new<0x2::object::ID, bool>(arg1),
            total_launched  : 0,
            total_graduated : 0,
        };
        0x2::transfer::share_object<Registry>(v2);
    }

    public fun issue_agent_cap(arg0: &CreatorCap, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) : AgentCap {
        AgentCap{
            id      : 0x2::object::new(arg2),
            pool_id : arg1,
        }
    }

    public fun launch(arg0: &mut Registry, arg1: &0xc6ca7e67ec1ffea02eee3af0b39e6e23f4cd379b3269510197ba2962e3710d89::config::LaunchpadConfig, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: u8, arg10: u8, arg11: u64, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        assert!(!0xc6ca7e67ec1ffea02eee3af0b39e6e23f4cd379b3269510197ba2962e3710d89::config::launch_paused(arg1), 0);
        assert!(arg10 <= 1, 10);
        assert!(arg11 <= 500, 11);
        let v0 = 0xc6ca7e67ec1ffea02eee3af0b39e6e23f4cd379b3269510197ba2962e3710d89::config::creation_fee_mist(arg1);
        let v1 = 0x2::coin::into_balance<0x2::sui::SUI>(arg2);
        assert!(0x2::balance::value<0x2::sui::SUI>(&v1) >= v0, 1);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v1, v0), arg13), 0xc6ca7e67ec1ffea02eee3af0b39e6e23f4cd379b3269510197ba2962e3710d89::config::treasury(arg1));
        };
        if (0x2::balance::value<0x2::sui::SUI>(&v1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v1, arg13), 0x2::tx_context::sender(arg13));
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v1);
        };
        let v2 = 0xc6ca7e67ec1ffea02eee3af0b39e6e23f4cd379b3269510197ba2962e3710d89::config::virtual_sui_reserve(arg1);
        let v3 = 0xc6ca7e67ec1ffea02eee3af0b39e6e23f4cd379b3269510197ba2962e3710d89::config::initial_token_reserve(arg1);
        let v4 = 0x2::clock::timestamp_ms(arg12);
        let v5 = 0x1::string::utf8(arg3);
        let v6 = 0x1::string::utf8(arg4);
        let v7 = 0x1::string::utf8(arg5);
        let v8 = 0x1::string::utf8(arg6);
        let v9 = if (arg11 > 0) {
            32
        } else {
            0
        };
        let v10 = BondingCurve{
            id                        : 0x2::object::new(arg13),
            name                      : v5,
            symbol                    : v6,
            description               : v7,
            image_url                 : v8,
            project_type              : arg9,
            virtual_sui               : v2,
            graduation_threshold      : 0xc6ca7e67ec1ffea02eee3af0b39e6e23f4cd379b3269510197ba2962e3710d89::config::graduation_sui_threshold(arg1),
            trade_fee_bps             : 0xc6ca7e67ec1ffea02eee3af0b39e6e23f4cd379b3269510197ba2962e3710d89::config::trade_fee_bps(arg1),
            creator_fee_pct           : 0xc6ca7e67ec1ffea02eee3af0b39e6e23f4cd379b3269510197ba2962e3710d89::config::creator_fee_pct(arg1),
            protocol_fee_pct          : 0xc6ca7e67ec1ffea02eee3af0b39e6e23f4cd379b3269510197ba2962e3710d89::config::protocol_fee_pct(arg1),
            protocol_treasury         : 0xc6ca7e67ec1ffea02eee3af0b39e6e23f4cd379b3269510197ba2962e3710d89::config::treasury(arg1),
            k                         : 0xc6ca7e67ec1ffea02eee3af0b39e6e23f4cd379b3269510197ba2962e3710d89::bonding_curve::compute_k(v2, v3),
            token_reserve             : v3,
            grad_token_reserve        : 0xc6ca7e67ec1ffea02eee3af0b39e6e23f4cd379b3269510197ba2962e3710d89::config::lp_token_reserve(arg1),
            total_minted              : 0,
            sui_reserve               : 0x2::balance::zero<0x2::sui::SUI>(),
            creator                   : 0x2::tx_context::sender(arg13),
            created_at                : v4,
            bflags                    : v9,
            flag_count                : 0,
            flaggers                  : 0x2::table::new<address, bool>(arg13),
            reward_mode               : arg10,
            cashback_pool             : 0x2::balance::zero<0x2::sui::SUI>(),
            total_cashback_volume     : 0,
            trader_cashback_volume    : 0x2::table::new<address, u64>(arg13),
            buyback_rate_bps          : arg11,
            buyback_pool              : 0x2::balance::zero<0x2::sui::SUI>(),
            agent_revenue_buyback_pct : 100,
            creator_fees              : 0x2::balance::zero<0x2::sui::SUI>(),
            early_buyers              : 0x2::table::new<address, u64>(arg13),
            withdrawal_requested_at   : 0,
        };
        let v11 = 0x2::object::id<BondingCurve>(&v10);
        0x2::table::add<0x2::object::ID, bool>(&mut arg0.pools, v11, true);
        arg0.total_launched = arg0.total_launched + 1;
        let v12 = CreatorCap{
            id      : 0x2::object::new(arg13),
            pool_id : v11,
        };
        0x2::transfer::transfer<CreatorCap>(v12, 0x2::tx_context::sender(arg13));
        0x2::transfer::share_object<BondingCurve>(v10);
        let v13 = PoolCreated{
            pool_id              : v11,
            name                 : v5,
            symbol               : v6,
            description          : v7,
            image_url            : v8,
            website              : 0x1::string::utf8(arg7),
            github               : 0x1::string::utf8(arg8),
            project_type         : arg9,
            creator              : 0x2::tx_context::sender(arg13),
            virtual_sui          : v2,
            graduation_threshold : 0xc6ca7e67ec1ffea02eee3af0b39e6e23f4cd379b3269510197ba2962e3710d89::config::graduation_sui_threshold(arg1),
            reward_mode          : arg10,
            buyback_rate_bps     : arg11,
            created_at           : v4,
        };
        0x2::event::emit<PoolCreated>(v13);
    }

    public fun lp_created(arg0: &BondingCurve) : bool {
        arg0.bflags & 2 != 0
    }

    public fun merge_tokens(arg0: PoolToken, arg1: PoolToken) : PoolToken {
        assert!(arg0.pool_id == arg1.pool_id, 14);
        let PoolToken {
            id      : v0,
            pool_id : _,
            amount  : v2,
        } = arg1;
        0x2::object::delete(v0);
        arg0.amount = arg0.amount + v2;
        arg0
    }

    public fun name(arg0: &BondingCurve) : 0x1::string::String {
        arg0.name
    }

    public fun pool_id(arg0: &BondingCurve) : 0x2::object::ID {
        0x2::object::id<BondingCurve>(arg0)
    }

    public fun redeem<T0>(arg0: &mut RedemptionVault<T0>, arg1: PoolToken, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg1.pool_id == arg0.pool_id, 14);
        let v0 = arg1.amount;
        assert!(v0 > 0, 4);
        let PoolToken {
            id      : v1,
            pool_id : _,
            amount  : _,
        } = arg1;
        0x2::object::delete(v1);
        let v4 = (((v0 as u128) * (arg0.rate_num as u128) / (arg0.rate_den as u128)) as u64);
        assert!(v4 > 0, 4);
        assert!(v4 <= 0x2::balance::value<T0>(&arg0.reserve), 15);
        let v5 = TokensRedeemed{
            pool_id    : arg0.pool_id,
            redeemer   : 0x2::tx_context::sender(arg2),
            pool_token : v0,
            coins_out  : v4,
        };
        0x2::event::emit<TokensRedeemed>(v5);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.reserve, v4), arg2)
    }

    public fun request_withdrawal(arg0: &CreatorCap, arg1: &mut BondingCurve, arg2: &0x2::clock::Clock) {
        assert!(arg0.pool_id == 0x2::object::id<BondingCurve>(arg1), 6);
        arg1.withdrawal_requested_at = 0x2::clock::timestamp_ms(arg2);
    }

    public fun reward_mode(arg0: &BondingCurve) : u8 {
        arg0.reward_mode
    }

    public fun sell(arg0: &mut BondingCurve, arg1: PoolToken, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(arg0.bflags & 8 == 0, 5);
        assert!(arg1.pool_id == 0x2::object::id<BondingCurve>(arg0), 14);
        let v0 = arg1.amount;
        assert!(v0 > 0, 4);
        let PoolToken {
            id      : v1,
            pool_id : _,
            amount  : _,
        } = arg1;
        0x2::object::delete(v1);
        let v4 = 0xc6ca7e67ec1ffea02eee3af0b39e6e23f4cd379b3269510197ba2962e3710d89::bonding_curve::sui_out_gross(arg0.k, arg0.virtual_sui + 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve), arg0.token_reserve, v0);
        let v5 = v4 * arg0.trade_fee_bps / 10000;
        let v6 = v5 * arg0.creator_fee_pct / 100;
        let v7 = v5 * arg0.protocol_fee_pct / 100;
        let v8 = if (arg0.reward_mode == 1) {
            v5 - v6 - v7
        } else {
            0
        };
        let v9 = if (arg0.bflags & 32 != 0) {
            v5 * arg0.buyback_rate_bps / 10000
        } else {
            0
        };
        let v10 = v4 - v5;
        assert!(v10 >= arg2, 3);
        arg0.token_reserve = arg0.token_reserve + v0;
        arg0.total_minted = arg0.total_minted - v0;
        if (v6 > 0) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.creator_fees, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_reserve, v6));
        };
        if (v8 > 0) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.cashback_pool, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_reserve, v8));
        };
        if (v9 > 0) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.buyback_pool, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_reserve, v9));
        };
        let v11 = 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve) - v10;
        if (v7 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_reserve, v7), arg4), arg0.protocol_treasury);
        };
        0x2::clock::timestamp_ms(arg3);
        if (0x2::table::contains<address, u64>(&arg0.early_buyers, 0x2::tx_context::sender(arg4))) {
            let v12 = EarlyBuyerSellEvent{
                pool_id      : 0x2::object::id<BondingCurve>(arg0),
                seller       : 0x2::tx_context::sender(arg4),
                tokens_sold  : v0,
                sui_out      : v10,
                bought_at_ms : *0x2::table::borrow<address, u64>(&arg0.early_buyers, 0x2::tx_context::sender(arg4)),
                is_creator   : 0x2::tx_context::sender(arg4) == arg0.creator,
            };
            0x2::event::emit<EarlyBuyerSellEvent>(v12);
        };
        if (0x2::tx_context::sender(arg4) == arg0.creator) {
            let v13 = CreatorTradeEvent{
                pool_id    : 0x2::object::id<BondingCurve>(arg0),
                is_buy     : false,
                sui_amount : v10,
            };
            0x2::event::emit<CreatorTradeEvent>(v13);
        };
        let v14 = TokensSold{
            pool_id           : 0x2::object::id<BondingCurve>(arg0),
            seller            : 0x2::tx_context::sender(arg4),
            tokens_in         : v0,
            sui_out           : v10,
            new_token_reserve : arg0.token_reserve,
            new_real_sui      : v11,
            spot_price_mist   : 0xc6ca7e67ec1ffea02eee3af0b39e6e23f4cd379b3269510197ba2962e3710d89::bonding_curve::spot_price_mist(arg0.virtual_sui + v11, arg0.token_reserve, 1000000),
        };
        0x2::event::emit<TokensSold>(v14);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_reserve, v10), arg4)
    }

    public fun set_agent_buyback_pct(arg0: &CreatorCap, arg1: &mut BondingCurve, arg2: u64) {
        assert!(arg2 <= 100, 11);
        arg1.agent_revenue_buyback_pct = arg2;
    }

    public fun split_token(arg0: &mut PoolToken, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : PoolToken {
        assert!(arg1 < arg0.amount, 4);
        arg0.amount = arg0.amount - arg1;
        PoolToken{
            id      : 0x2::object::new(arg2),
            pool_id : arg0.pool_id,
            amount  : arg1,
        }
    }

    public fun sui_reserve(arg0: &BondingCurve) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve)
    }

    public fun suspend_pool(arg0: &ModerationCap, arg1: &mut BondingCurve) {
        arg1.bflags = arg1.bflags | 8;
    }

    public fun suspended(arg0: &BondingCurve) : bool {
        arg0.bflags & 8 != 0
    }

    public fun symbol(arg0: &BondingCurve) : 0x1::string::String {
        arg0.symbol
    }

    public fun token_amount(arg0: &PoolToken) : u64 {
        arg0.amount
    }

    public fun token_pool_id(arg0: &PoolToken) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun token_reserve(arg0: &BondingCurve) : u64 {
        arg0.token_reserve
    }

    public fun total_minted(arg0: &BondingCurve) : u64 {
        arg0.total_minted
    }

    public fun unsuspend_pool(arg0: &ModerationCap, arg1: &mut BondingCurve) {
        arg1.bflags = arg1.bflags ^ arg1.bflags & 8;
        arg1.flag_count = 0;
    }

    public fun vault_reserve<T0>(arg0: &RedemptionVault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.reserve)
    }

    public fun verified(arg0: &BondingCurve) : bool {
        arg0.bflags & 4 != 0
    }

    public fun verify_pool(arg0: &ModerationCap, arg1: &mut BondingCurve) {
        arg1.bflags = arg1.bflags | 4;
        let v0 = PoolVerified{pool_id: 0x2::object::id<BondingCurve>(arg1)};
        0x2::event::emit<PoolVerified>(v0);
    }

    public fun withdraw_graduated_liquidity(arg0: &GraduationCap, arg1: &mut BondingCurve, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, u64, u64) {
        assert!(arg1.bflags & 1 != 0, 7);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg1.sui_reserve);
        let v1 = arg1.total_minted;
        let v2 = arg1.grad_token_reserve;
        let v3 = GraduatedLiquidityWithdrawn{
            pool_id     : 0x2::object::id<BondingCurve>(arg1),
            sui_amount  : v0,
            tokens_sold : v1,
            lp_tokens   : v2,
        };
        0x2::event::emit<GraduatedLiquidityWithdrawn>(v3);
        (0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.sui_reserve, v0), arg2), v1, v2)
    }

    // decompiled from Move bytecode v7
}

