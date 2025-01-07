module 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::liquidity_provider {
    struct DepositEvent has copy, drop {
        sender: address,
        pool_id: 0x2::object::ID,
        is_base_coin: bool,
        amount: u64,
        capital: u64,
        base_quote_price: u64,
        quote_usd_price: u64,
        liquidity_change_num: u64,
    }

    struct WithdrawEvent has copy, drop {
        sender: address,
        pool_id: 0x2::object::ID,
        is_base_coin: bool,
        amount: u64,
        capital: u64,
        base_quote_price: u64,
        quote_usd_price: u64,
        liquidity_change_num: u64,
    }

    struct ChargePenaltyEvent has copy, drop {
        sender: address,
        pool_id: 0x2::object::ID,
        is_base_coin: bool,
        amount: u64,
        base_quote_price: u64,
        quote_usd_price: u64,
        liquidity_change_num: u64,
    }

    fun base_capital_burn<T0, T1>(arg0: &mut 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::Pool<T0, T1>, arg1: 0x2::balance::Balance<0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::BasePoolLiquidityCoin<T0, T1>>, arg2: u64) {
        0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::burn_base_capital_coin<T0, T1>(arg0, arg1, arg2);
    }

    public fun deposit_base<T0, T1>(arg0: &0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::ownable::LiquidityOperatorCap<T0, T1>, arg1: &mut 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::Pool<T0, T1>, arg2: &mut 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::assert_version<T0, T1>(arg1);
        0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::assert_deposit_base_allowed<T0, T1>(arg1);
        assert!(0x2::coin::value<T0>(arg2) >= arg6, 1);
        let (v0, v1) = 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_price_id<T0, T1>(arg1);
        let (v2, _, v4, v5) = 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle::calculate_pyth_primitive_prices(v0, v1, arg3, arg4, arg5, 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_base_coin_decimals<T0, T1>(arg1), 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_quote_coin_decimals<T0, T1>(arg1), 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_base_usd_price_age<T0, T1>(arg1), 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_quote_usd_price_age<T0, T1>(arg1));
        0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::set_prices<T0, T1>(arg1, v4, v5);
        deposit_base_internal<T0, T1>(arg1, arg2, v2, arg6, arg7);
    }

    fun deposit_base_internal<T0, T1>(arg0: &mut 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::Pool<T0, T1>, arg1: &mut 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::increase_liquidity_change_num<T0, T1>(arg0);
        let (v0, _) = 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_expected_target<T0, T1>(arg0, arg2);
        let v2 = 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_base_capital_coin_supply<T0, T1>(arg0);
        let v3 = arg3;
        if (v2 == 0) {
            v3 = arg3 + v0;
        } else if (v0 > 0) {
            v3 = 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::safe_math::safe_mul_div_u64(arg3, v2, v0);
        };
        let v4 = mint_base<T0, T1>(arg0, 0x2::balance::split<T0>(0x2::coin::balance_mut<T0>(arg1), arg3), v3, arg4);
        assert!(0x2::coin::value<0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::BasePoolLiquidityCoin<T0, T1>>(&v4) > 0, 2);
        0x2::pay::keep<0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::BasePoolLiquidityCoin<T0, T1>>(v4, arg4);
        let v5 = DepositEvent{
            sender               : 0x2::tx_context::sender(arg4),
            pool_id              : 0x2::object::id<0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::Pool<T0, T1>>(arg0),
            is_base_coin         : true,
            amount               : arg3,
            capital              : v3,
            base_quote_price     : arg2,
            quote_usd_price      : 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_quote_usd_price<T0, T1>(arg0),
            liquidity_change_num : 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_liquidity_change_num<T0, T1>(arg0),
        };
        0x2::event::emit<DepositEvent>(v5);
    }

    public fun deposit_quote<T0, T1>(arg0: &0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::ownable::LiquidityOperatorCap<T0, T1>, arg1: &mut 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::Pool<T0, T1>, arg2: &mut 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::assert_version<T0, T1>(arg1);
        0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::assert_deposit_quote_allowed<T0, T1>(arg1);
        assert!(0x2::coin::value<T1>(arg2) >= arg6, 1);
        let (v0, v1) = 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_price_id<T0, T1>(arg1);
        let (v2, _, v4, v5) = 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle::calculate_pyth_primitive_prices(v0, v1, arg3, arg4, arg5, 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_base_coin_decimals<T0, T1>(arg1), 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_quote_coin_decimals<T0, T1>(arg1), 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_base_usd_price_age<T0, T1>(arg1), 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_quote_usd_price_age<T0, T1>(arg1));
        0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::set_prices<T0, T1>(arg1, v4, v5);
        deposit_quote_internal<T0, T1>(arg1, arg2, v2, arg6, arg7);
    }

    fun deposit_quote_internal<T0, T1>(arg0: &mut 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::Pool<T0, T1>, arg1: &mut 0x2::coin::Coin<T1>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::increase_liquidity_change_num<T0, T1>(arg0);
        let (_, v1) = 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_expected_target<T0, T1>(arg0, arg2);
        let v2 = 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_quote_capital_coin_supply<T0, T1>(arg0);
        let v3 = arg3;
        if (v2 == 0) {
            v3 = arg3 + v1;
        } else if (v1 > 0) {
            v3 = 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::safe_math::safe_mul_div_u64(arg3, v2, v1);
        };
        let v4 = mint_quote<T0, T1>(arg0, 0x2::balance::split<T1>(0x2::coin::balance_mut<T1>(arg1), arg3), v3, arg4);
        assert!(0x2::coin::value<0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::QuotePoolLiquidityCoin<T0, T1>>(&v4) > 0, 2);
        0x2::pay::keep<0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::QuotePoolLiquidityCoin<T0, T1>>(v4, arg4);
        let v5 = DepositEvent{
            sender               : 0x2::tx_context::sender(arg4),
            pool_id              : 0x2::object::id<0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::Pool<T0, T1>>(arg0),
            is_base_coin         : false,
            amount               : arg3,
            capital              : v3,
            base_quote_price     : arg2,
            quote_usd_price      : 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_quote_usd_price<T0, T1>(arg0),
            liquidity_change_num : 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_liquidity_change_num<T0, T1>(arg0),
        };
        0x2::event::emit<DepositEvent>(v5);
    }

    public entry fun entry_withdraw_all_base<T0, T1>(arg0: &mut 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::BasePoolLiquidityCoin<T0, T1>>, arg2: &0x2::clock::Clock, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = withdraw_all_base<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg5));
    }

    public entry fun entry_withdraw_all_quote<T0, T1>(arg0: &mut 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::QuotePoolLiquidityCoin<T0, T1>>, arg2: &0x2::clock::Clock, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = withdraw_all_quote<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v0, 0x2::tx_context::sender(arg5));
    }

    public entry fun entry_withdraw_base<T0, T1>(arg0: &mut 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::Pool<T0, T1>, arg1: &mut 0x2::coin::Coin<0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::BasePoolLiquidityCoin<T0, T1>>, arg2: &0x2::clock::Clock, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = withdraw_base<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg6));
    }

    public entry fun entry_withdraw_quote<T0, T1>(arg0: &mut 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::Pool<T0, T1>, arg1: &mut 0x2::coin::Coin<0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::QuotePoolLiquidityCoin<T0, T1>>, arg2: &0x2::clock::Clock, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = withdraw_quote<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v0, 0x2::tx_context::sender(arg6));
    }

    fun mint_base<T0, T1>(arg0: &mut 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::Pool<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::BasePoolLiquidityCoin<T0, T1>> {
        0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::mint_base_capital<T0, T1>(arg0, arg1, arg2, arg3)
    }

    fun mint_quote<T0, T1>(arg0: &mut 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::Pool<T0, T1>, arg1: 0x2::balance::Balance<T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::QuotePoolLiquidityCoin<T0, T1>> {
        0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::mint_quote_capital<T0, T1>(arg0, arg1, arg2, arg3)
    }

    public fun query_withdraw_base_coin<T0, T1>(arg0: &0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: u64) : (u64, u64) {
        let (v0, v1) = 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_price_id<T0, T1>(arg0);
        let (v2, _, _, _) = 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle::calculate_pyth_primitive_prices(v0, v1, arg1, arg2, arg3, 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_base_coin_decimals<T0, T1>(arg0), 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_quote_coin_decimals<T0, T1>(arg0), 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_base_usd_price_age<T0, T1>(arg0), 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_quote_usd_price_age<T0, T1>(arg0));
        query_withdraw_base_coin_internal<T0, T1>(arg0, v2, arg4)
    }

    public(friend) fun query_withdraw_base_coin_internal<T0, T1>(arg0: &0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::Pool<T0, T1>, arg1: u64, arg2: u64) : (u64, u64) {
        let v0 = 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_lp_base_balance<T0, T1>(arg0, arg1, arg2);
        (v0, 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_withdraw_base_penalty<T0, T1>(arg0, arg1, v0))
    }

    public fun query_withdraw_quote_coin<T0, T1>(arg0: &0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: u64) : (u64, u64) {
        let (v0, v1) = 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_price_id<T0, T1>(arg0);
        let (v2, _, _, _) = 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle::calculate_pyth_primitive_prices(v0, v1, arg1, arg2, arg3, 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_base_coin_decimals<T0, T1>(arg0), 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_quote_coin_decimals<T0, T1>(arg0), 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_base_usd_price_age<T0, T1>(arg0), 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_quote_usd_price_age<T0, T1>(arg0));
        query_withdraw_quote_coin_internal<T0, T1>(arg0, v2, arg4)
    }

    public(friend) fun query_withdraw_quote_coin_internal<T0, T1>(arg0: &0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::Pool<T0, T1>, arg1: u64, arg2: u64) : (u64, u64) {
        let v0 = 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_lp_base_balance<T0, T1>(arg0, arg1, arg2);
        (v0, 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_withdraw_quote_penalty<T0, T1>(arg0, arg1, v0))
    }

    fun quote_capital_burn<T0, T1>(arg0: &mut 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::Pool<T0, T1>, arg1: 0x2::balance::Balance<0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::QuotePoolLiquidityCoin<T0, T1>>, arg2: u64) {
        0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::burn_quote_capital_coin<T0, T1>(arg0, arg1, arg2);
    }

    public fun withdraw_all_base<T0, T1>(arg0: &mut 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::BasePoolLiquidityCoin<T0, T1>>, arg2: &0x2::clock::Clock, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::assert_version<T0, T1>(arg0);
        0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::assert_not_closed<T0, T1>(arg0);
        let (v0, v1) = 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_price_id<T0, T1>(arg0);
        let (v2, _, v4, v5) = 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle::calculate_pyth_primitive_prices(v0, v1, arg2, arg3, arg4, 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_base_coin_decimals<T0, T1>(arg0), 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_quote_coin_decimals<T0, T1>(arg0), 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_base_usd_price_age<T0, T1>(arg0), 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_quote_usd_price_age<T0, T1>(arg0));
        0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::set_prices<T0, T1>(arg0, v4, v5);
        withdraw_all_base_internal<T0, T1>(arg0, arg1, v2, arg5)
    }

    fun withdraw_all_base_internal<T0, T1>(arg0: &mut 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::BasePoolLiquidityCoin<T0, T1>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::increase_liquidity_change_num<T0, T1>(arg0);
        let v0 = 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_lp_base_balance<T0, T1>(arg0, arg2, 0x2::coin::value<0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::BasePoolLiquidityCoin<T0, T1>>(&arg1));
        let v1 = 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_withdraw_base_penalty<T0, T1>(arg0, arg2, v0);
        assert!(v1 <= v0, 7);
        0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::set_target_base_coin_amount<T0, T1>(arg0, 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_target_base_coin_amount<T0, T1>(arg0) - v0);
        let v2 = v0 - v1;
        base_capital_burn<T0, T1>(arg0, 0x2::coin::into_balance<0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::BasePoolLiquidityCoin<T0, T1>>(arg1), v1);
        let v3 = WithdrawEvent{
            sender               : 0x2::tx_context::sender(arg3),
            pool_id              : 0x2::object::id<0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::Pool<T0, T1>>(arg0),
            is_base_coin         : true,
            amount               : v2,
            capital              : 0x2::coin::value<0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::BasePoolLiquidityCoin<T0, T1>>(&arg1),
            base_quote_price     : arg2,
            quote_usd_price      : 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_quote_usd_price<T0, T1>(arg0),
            liquidity_change_num : 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_liquidity_change_num<T0, T1>(arg0),
        };
        0x2::event::emit<WithdrawEvent>(v3);
        let v4 = ChargePenaltyEvent{
            sender               : 0x2::tx_context::sender(arg3),
            pool_id              : 0x2::object::id<0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::Pool<T0, T1>>(arg0),
            is_base_coin         : true,
            amount               : v1,
            base_quote_price     : arg2,
            quote_usd_price      : 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_quote_usd_price<T0, T1>(arg0),
            liquidity_change_num : 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_liquidity_change_num<T0, T1>(arg0),
        };
        0x2::event::emit<ChargePenaltyEvent>(v4);
        0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::base_coin_pay_out<T0, T1>(arg0, v2, arg3)
    }

    public fun withdraw_all_quote<T0, T1>(arg0: &mut 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::QuotePoolLiquidityCoin<T0, T1>>, arg2: &0x2::clock::Clock, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::assert_version<T0, T1>(arg0);
        0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::assert_not_closed<T0, T1>(arg0);
        let (v0, v1) = 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_price_id<T0, T1>(arg0);
        let (v2, _, v4, v5) = 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle::calculate_pyth_primitive_prices(v0, v1, arg2, arg3, arg4, 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_base_coin_decimals<T0, T1>(arg0), 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_quote_coin_decimals<T0, T1>(arg0), 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_base_usd_price_age<T0, T1>(arg0), 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_quote_usd_price_age<T0, T1>(arg0));
        0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::set_prices<T0, T1>(arg0, v4, v5);
        withdraw_all_quote_internal<T0, T1>(arg0, arg1, v2, arg5)
    }

    fun withdraw_all_quote_internal<T0, T1>(arg0: &mut 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::QuotePoolLiquidityCoin<T0, T1>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::increase_liquidity_change_num<T0, T1>(arg0);
        let v0 = 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_lp_quote_balance<T0, T1>(arg0, arg2, 0x2::coin::value<0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::QuotePoolLiquidityCoin<T0, T1>>(&arg1));
        let v1 = 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_withdraw_quote_penalty<T0, T1>(arg0, arg2, v0);
        assert!(v1 <= v0, 7);
        0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::set_target_quote_coin_amount<T0, T1>(arg0, 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_target_quote_coin_amount<T0, T1>(arg0) - v0);
        let v2 = v0 - v1;
        quote_capital_burn<T0, T1>(arg0, 0x2::coin::into_balance<0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::QuotePoolLiquidityCoin<T0, T1>>(arg1), v1);
        let v3 = WithdrawEvent{
            sender               : 0x2::tx_context::sender(arg3),
            pool_id              : 0x2::object::id<0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::Pool<T0, T1>>(arg0),
            is_base_coin         : false,
            amount               : v2,
            capital              : 0x2::coin::value<0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::QuotePoolLiquidityCoin<T0, T1>>(&arg1),
            base_quote_price     : arg2,
            quote_usd_price      : 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_quote_usd_price<T0, T1>(arg0),
            liquidity_change_num : 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_liquidity_change_num<T0, T1>(arg0),
        };
        0x2::event::emit<WithdrawEvent>(v3);
        let v4 = ChargePenaltyEvent{
            sender               : 0x2::tx_context::sender(arg3),
            pool_id              : 0x2::object::id<0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::Pool<T0, T1>>(arg0),
            is_base_coin         : false,
            amount               : v1,
            base_quote_price     : arg2,
            quote_usd_price      : 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_quote_usd_price<T0, T1>(arg0),
            liquidity_change_num : 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_liquidity_change_num<T0, T1>(arg0),
        };
        0x2::event::emit<ChargePenaltyEvent>(v4);
        0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::quote_coin_pay_out<T0, T1>(arg0, v2, arg3)
    }

    public fun withdraw_base<T0, T1>(arg0: &mut 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::Pool<T0, T1>, arg1: &mut 0x2::coin::Coin<0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::BasePoolLiquidityCoin<T0, T1>>, arg2: &0x2::clock::Clock, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::assert_version<T0, T1>(arg0);
        0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::assert_not_closed<T0, T1>(arg0);
        let (v0, v1) = 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_price_id<T0, T1>(arg0);
        let (v2, _, v4, v5) = 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle::calculate_pyth_primitive_prices(v0, v1, arg2, arg3, arg4, 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_base_coin_decimals<T0, T1>(arg0), 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_quote_coin_decimals<T0, T1>(arg0), 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_base_usd_price_age<T0, T1>(arg0), 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_quote_usd_price_age<T0, T1>(arg0));
        0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::set_prices<T0, T1>(arg0, v4, v5);
        withdraw_base_internal<T0, T1>(arg0, arg1, v2, arg5, arg6)
    }

    fun withdraw_base_internal<T0, T1>(arg0: &mut 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::Pool<T0, T1>, arg1: &mut 0x2::coin::Coin<0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::BasePoolLiquidityCoin<T0, T1>>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::increase_liquidity_change_num<T0, T1>(arg0);
        let (v0, _) = 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_expected_target<T0, T1>(arg0, arg2);
        let v2 = 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_base_capital_coin_supply<T0, T1>(arg0);
        assert!(v2 > 0, 3);
        let v3 = 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::safe_math::safe_mul_div_ceil_u64(arg3, v2, v0);
        assert!(v3 <= 0x2::coin::value<0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::BasePoolLiquidityCoin<T0, T1>>(arg1), 5);
        let v4 = 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_withdraw_base_penalty<T0, T1>(arg0, arg2, arg3);
        assert!(v4 <= arg3, 7);
        0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::set_target_base_coin_amount<T0, T1>(arg0, 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_target_base_coin_amount<T0, T1>(arg0) - arg3);
        base_capital_burn<T0, T1>(arg0, 0x2::balance::split<0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::BasePoolLiquidityCoin<T0, T1>>(0x2::coin::balance_mut<0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::BasePoolLiquidityCoin<T0, T1>>(arg1), v3), v4);
        let v5 = arg3 - v4;
        let v6 = WithdrawEvent{
            sender               : 0x2::tx_context::sender(arg4),
            pool_id              : 0x2::object::id<0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::Pool<T0, T1>>(arg0),
            is_base_coin         : true,
            amount               : v5,
            capital              : v3,
            base_quote_price     : arg2,
            quote_usd_price      : 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_quote_usd_price<T0, T1>(arg0),
            liquidity_change_num : 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_liquidity_change_num<T0, T1>(arg0),
        };
        0x2::event::emit<WithdrawEvent>(v6);
        let v7 = ChargePenaltyEvent{
            sender               : 0x2::tx_context::sender(arg4),
            pool_id              : 0x2::object::id<0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::Pool<T0, T1>>(arg0),
            is_base_coin         : true,
            amount               : v4,
            base_quote_price     : arg2,
            quote_usd_price      : 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_quote_usd_price<T0, T1>(arg0),
            liquidity_change_num : 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_liquidity_change_num<T0, T1>(arg0),
        };
        0x2::event::emit<ChargePenaltyEvent>(v7);
        0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::base_coin_pay_out<T0, T1>(arg0, v5, arg4)
    }

    public fun withdraw_quote<T0, T1>(arg0: &mut 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::Pool<T0, T1>, arg1: &mut 0x2::coin::Coin<0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::QuotePoolLiquidityCoin<T0, T1>>, arg2: &0x2::clock::Clock, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::assert_version<T0, T1>(arg0);
        0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::assert_not_closed<T0, T1>(arg0);
        let (v0, v1) = 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_price_id<T0, T1>(arg0);
        let (v2, _, v4, v5) = 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle::calculate_pyth_primitive_prices(v0, v1, arg2, arg3, arg4, 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_base_coin_decimals<T0, T1>(arg0), 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_quote_coin_decimals<T0, T1>(arg0), 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_base_usd_price_age<T0, T1>(arg0), 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_quote_usd_price_age<T0, T1>(arg0));
        0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::set_prices<T0, T1>(arg0, v4, v5);
        withdraw_quote_internal<T0, T1>(arg0, arg1, v2, arg5, arg6)
    }

    fun withdraw_quote_internal<T0, T1>(arg0: &mut 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::Pool<T0, T1>, arg1: &mut 0x2::coin::Coin<0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::QuotePoolLiquidityCoin<T0, T1>>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::increase_liquidity_change_num<T0, T1>(arg0);
        let (_, v1) = 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_expected_target<T0, T1>(arg0, arg2);
        let v2 = 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_quote_capital_coin_supply<T0, T1>(arg0);
        assert!(v2 > 0, 4);
        let v3 = 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::safe_math::safe_mul_div_ceil_u64(arg3, v2, v1);
        assert!(v3 <= 0x2::coin::value<0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::QuotePoolLiquidityCoin<T0, T1>>(arg1), 6);
        let v4 = 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_withdraw_quote_penalty<T0, T1>(arg0, arg2, arg3);
        assert!(v4 < arg3, 7);
        0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::set_target_quote_coin_amount<T0, T1>(arg0, 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_target_quote_coin_amount<T0, T1>(arg0) - arg3);
        let v5 = arg3 - v4;
        quote_capital_burn<T0, T1>(arg0, 0x2::balance::split<0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::QuotePoolLiquidityCoin<T0, T1>>(0x2::coin::balance_mut<0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::QuotePoolLiquidityCoin<T0, T1>>(arg1), v3), v4);
        let v6 = WithdrawEvent{
            sender               : 0x2::tx_context::sender(arg4),
            pool_id              : 0x2::object::id<0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::Pool<T0, T1>>(arg0),
            is_base_coin         : false,
            amount               : v5,
            capital              : v3,
            base_quote_price     : arg2,
            quote_usd_price      : 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_quote_usd_price<T0, T1>(arg0),
            liquidity_change_num : 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_liquidity_change_num<T0, T1>(arg0),
        };
        0x2::event::emit<WithdrawEvent>(v6);
        let v7 = ChargePenaltyEvent{
            sender               : 0x2::tx_context::sender(arg4),
            pool_id              : 0x2::object::id<0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::Pool<T0, T1>>(arg0),
            is_base_coin         : false,
            amount               : v4,
            base_quote_price     : arg2,
            quote_usd_price      : 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_quote_usd_price<T0, T1>(arg0),
            liquidity_change_num : 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_liquidity_change_num<T0, T1>(arg0),
        };
        0x2::event::emit<ChargePenaltyEvent>(v7);
        0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::quote_coin_pay_out<T0, T1>(arg0, v5, arg4)
    }

    // decompiled from Move bytecode v6
}

