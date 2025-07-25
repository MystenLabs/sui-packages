module 0xd52f42314d7e62068a17658278d300669136f346a8f9d9e8ae7e903128f70627::liquidity_provider {
    struct DepositEvent has copy, drop {
        sender: address,
        pool_id: 0x2::object::ID,
        is_base_coin: bool,
        amount: u64,
        capital: u64,
        liquidity_change_num: u64,
    }

    struct WithdrawEvent has copy, drop {
        sender: address,
        pool_id: 0x2::object::ID,
        is_base_coin: bool,
        amount: u64,
        capital: u64,
        liquidity_change_num: u64,
    }

    fun base_capital_burn<T0, T1>(arg0: &mut 0xd52f42314d7e62068a17658278d300669136f346a8f9d9e8ae7e903128f70627::oracle_driven_pool::Pool<T0, T1>, arg1: 0x2::balance::Balance<0xd52f42314d7e62068a17658278d300669136f346a8f9d9e8ae7e903128f70627::oracle_driven_pool::BasePoolLiquidityCoin<T0, T1>>) {
        0xd52f42314d7e62068a17658278d300669136f346a8f9d9e8ae7e903128f70627::oracle_driven_pool::burn_base_capital_coin<T0, T1>(arg0, arg1);
    }

    public fun deposit_base<T0, T1>(arg0: &0xd52f42314d7e62068a17658278d300669136f346a8f9d9e8ae7e903128f70627::ownable::LiquidityOperatorCap<T0, T1>, arg1: &mut 0xd52f42314d7e62068a17658278d300669136f346a8f9d9e8ae7e903128f70627::oracle_driven_pool::Pool<T0, T1>, arg2: &mut 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0xd52f42314d7e62068a17658278d300669136f346a8f9d9e8ae7e903128f70627::oracle_driven_pool::assert_version<T0, T1>(arg1);
        0xd52f42314d7e62068a17658278d300669136f346a8f9d9e8ae7e903128f70627::oracle_driven_pool::assert_deposit_base_allowed<T0, T1>(arg1);
        assert!(0x2::coin::value<T0>(arg2) >= arg3, 1);
        deposit_base_internal<T0, T1>(arg1, arg2, arg3, arg4);
    }

    fun deposit_base_internal<T0, T1>(arg0: &mut 0xd52f42314d7e62068a17658278d300669136f346a8f9d9e8ae7e903128f70627::oracle_driven_pool::Pool<T0, T1>, arg1: &mut 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0xd52f42314d7e62068a17658278d300669136f346a8f9d9e8ae7e903128f70627::oracle_driven_pool::increase_liquidity_change_num<T0, T1>(arg0);
        let v0 = 0xd52f42314d7e62068a17658278d300669136f346a8f9d9e8ae7e903128f70627::oracle_driven_pool::get_base_balance<T0, T1>(arg0);
        let v1 = 0xd52f42314d7e62068a17658278d300669136f346a8f9d9e8ae7e903128f70627::oracle_driven_pool::get_base_capital_coin_supply<T0, T1>(arg0);
        let v2 = arg2;
        if (v1 == 0) {
            v2 = arg2 + v0;
        } else if (v0 > 0) {
            v2 = 0xd52f42314d7e62068a17658278d300669136f346a8f9d9e8ae7e903128f70627::safe_math::safe_mul_div_u64(arg2, v1, v0);
        };
        let v3 = mint_base<T0, T1>(arg0, 0x2::balance::split<T0>(0x2::coin::balance_mut<T0>(arg1), arg2), v2, arg3);
        assert!(0x2::coin::value<0xd52f42314d7e62068a17658278d300669136f346a8f9d9e8ae7e903128f70627::oracle_driven_pool::BasePoolLiquidityCoin<T0, T1>>(&v3) > 0, 2);
        0x2::pay::keep<0xd52f42314d7e62068a17658278d300669136f346a8f9d9e8ae7e903128f70627::oracle_driven_pool::BasePoolLiquidityCoin<T0, T1>>(v3, arg3);
        let v4 = DepositEvent{
            sender               : 0x2::tx_context::sender(arg3),
            pool_id              : 0x2::object::id<0xd52f42314d7e62068a17658278d300669136f346a8f9d9e8ae7e903128f70627::oracle_driven_pool::Pool<T0, T1>>(arg0),
            is_base_coin         : true,
            amount               : arg2,
            capital              : v2,
            liquidity_change_num : 0xd52f42314d7e62068a17658278d300669136f346a8f9d9e8ae7e903128f70627::oracle_driven_pool::get_liquidity_change_num<T0, T1>(arg0),
        };
        0x2::event::emit<DepositEvent>(v4);
    }

    public fun deposit_quote<T0, T1>(arg0: &0xd52f42314d7e62068a17658278d300669136f346a8f9d9e8ae7e903128f70627::ownable::LiquidityOperatorCap<T0, T1>, arg1: &mut 0xd52f42314d7e62068a17658278d300669136f346a8f9d9e8ae7e903128f70627::oracle_driven_pool::Pool<T0, T1>, arg2: &mut 0x2::coin::Coin<T1>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0xd52f42314d7e62068a17658278d300669136f346a8f9d9e8ae7e903128f70627::oracle_driven_pool::assert_version<T0, T1>(arg1);
        0xd52f42314d7e62068a17658278d300669136f346a8f9d9e8ae7e903128f70627::oracle_driven_pool::assert_deposit_quote_allowed<T0, T1>(arg1);
        assert!(0x2::coin::value<T1>(arg2) >= arg3, 1);
        deposit_quote_internal<T0, T1>(arg1, arg2, arg3, arg4);
    }

    fun deposit_quote_internal<T0, T1>(arg0: &mut 0xd52f42314d7e62068a17658278d300669136f346a8f9d9e8ae7e903128f70627::oracle_driven_pool::Pool<T0, T1>, arg1: &mut 0x2::coin::Coin<T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0xd52f42314d7e62068a17658278d300669136f346a8f9d9e8ae7e903128f70627::oracle_driven_pool::increase_liquidity_change_num<T0, T1>(arg0);
        let v0 = 0xd52f42314d7e62068a17658278d300669136f346a8f9d9e8ae7e903128f70627::oracle_driven_pool::get_quote_balance<T0, T1>(arg0);
        let v1 = 0xd52f42314d7e62068a17658278d300669136f346a8f9d9e8ae7e903128f70627::oracle_driven_pool::get_quote_capital_coin_supply<T0, T1>(arg0);
        let v2 = arg2;
        if (v1 == 0) {
            v2 = arg2 + v0;
        } else if (v0 > 0) {
            v2 = 0xd52f42314d7e62068a17658278d300669136f346a8f9d9e8ae7e903128f70627::safe_math::safe_mul_div_u64(arg2, v1, v0);
        };
        let v3 = mint_quote<T0, T1>(arg0, 0x2::balance::split<T1>(0x2::coin::balance_mut<T1>(arg1), arg2), v2, arg3);
        assert!(0x2::coin::value<0xd52f42314d7e62068a17658278d300669136f346a8f9d9e8ae7e903128f70627::oracle_driven_pool::QuotePoolLiquidityCoin<T0, T1>>(&v3) > 0, 2);
        0x2::pay::keep<0xd52f42314d7e62068a17658278d300669136f346a8f9d9e8ae7e903128f70627::oracle_driven_pool::QuotePoolLiquidityCoin<T0, T1>>(v3, arg3);
        let v4 = DepositEvent{
            sender               : 0x2::tx_context::sender(arg3),
            pool_id              : 0x2::object::id<0xd52f42314d7e62068a17658278d300669136f346a8f9d9e8ae7e903128f70627::oracle_driven_pool::Pool<T0, T1>>(arg0),
            is_base_coin         : false,
            amount               : arg2,
            capital              : v2,
            liquidity_change_num : 0xd52f42314d7e62068a17658278d300669136f346a8f9d9e8ae7e903128f70627::oracle_driven_pool::get_liquidity_change_num<T0, T1>(arg0),
        };
        0x2::event::emit<DepositEvent>(v4);
    }

    public entry fun entry_withdraw_all_base<T0, T1>(arg0: &mut 0xd52f42314d7e62068a17658278d300669136f346a8f9d9e8ae7e903128f70627::oracle_driven_pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<0xd52f42314d7e62068a17658278d300669136f346a8f9d9e8ae7e903128f70627::oracle_driven_pool::BasePoolLiquidityCoin<T0, T1>>, arg2: &0x2::clock::Clock, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = withdraw_all_base<T0, T1>(arg0, arg1, arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg5));
    }

    public entry fun entry_withdraw_all_quote<T0, T1>(arg0: &mut 0xd52f42314d7e62068a17658278d300669136f346a8f9d9e8ae7e903128f70627::oracle_driven_pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<0xd52f42314d7e62068a17658278d300669136f346a8f9d9e8ae7e903128f70627::oracle_driven_pool::QuotePoolLiquidityCoin<T0, T1>>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = withdraw_all_quote<T0, T1>(arg0, arg1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v0, 0x2::tx_context::sender(arg2));
    }

    public entry fun entry_withdraw_base<T0, T1>(arg0: &mut 0xd52f42314d7e62068a17658278d300669136f346a8f9d9e8ae7e903128f70627::oracle_driven_pool::Pool<T0, T1>, arg1: &mut 0x2::coin::Coin<0xd52f42314d7e62068a17658278d300669136f346a8f9d9e8ae7e903128f70627::oracle_driven_pool::BasePoolLiquidityCoin<T0, T1>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = withdraw_base<T0, T1>(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg3));
    }

    public entry fun entry_withdraw_quote<T0, T1>(arg0: &mut 0xd52f42314d7e62068a17658278d300669136f346a8f9d9e8ae7e903128f70627::oracle_driven_pool::Pool<T0, T1>, arg1: &mut 0x2::coin::Coin<0xd52f42314d7e62068a17658278d300669136f346a8f9d9e8ae7e903128f70627::oracle_driven_pool::QuotePoolLiquidityCoin<T0, T1>>, arg2: &0x2::clock::Clock, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = withdraw_quote<T0, T1>(arg0, arg1, arg2, arg3, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v0, 0x2::tx_context::sender(arg4));
    }

    fun mint_base<T0, T1>(arg0: &mut 0xd52f42314d7e62068a17658278d300669136f346a8f9d9e8ae7e903128f70627::oracle_driven_pool::Pool<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xd52f42314d7e62068a17658278d300669136f346a8f9d9e8ae7e903128f70627::oracle_driven_pool::BasePoolLiquidityCoin<T0, T1>> {
        0xd52f42314d7e62068a17658278d300669136f346a8f9d9e8ae7e903128f70627::oracle_driven_pool::mint_base_capital<T0, T1>(arg0, arg1, arg2, arg3)
    }

    fun mint_quote<T0, T1>(arg0: &mut 0xd52f42314d7e62068a17658278d300669136f346a8f9d9e8ae7e903128f70627::oracle_driven_pool::Pool<T0, T1>, arg1: 0x2::balance::Balance<T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xd52f42314d7e62068a17658278d300669136f346a8f9d9e8ae7e903128f70627::oracle_driven_pool::QuotePoolLiquidityCoin<T0, T1>> {
        0xd52f42314d7e62068a17658278d300669136f346a8f9d9e8ae7e903128f70627::oracle_driven_pool::mint_quote_capital<T0, T1>(arg0, arg1, arg2, arg3)
    }

    fun quote_capital_burn<T0, T1>(arg0: &mut 0xd52f42314d7e62068a17658278d300669136f346a8f9d9e8ae7e903128f70627::oracle_driven_pool::Pool<T0, T1>, arg1: 0x2::balance::Balance<0xd52f42314d7e62068a17658278d300669136f346a8f9d9e8ae7e903128f70627::oracle_driven_pool::QuotePoolLiquidityCoin<T0, T1>>) {
        0xd52f42314d7e62068a17658278d300669136f346a8f9d9e8ae7e903128f70627::oracle_driven_pool::burn_quote_capital_coin<T0, T1>(arg0, arg1);
    }

    public fun withdraw_all_base<T0, T1>(arg0: &mut 0xd52f42314d7e62068a17658278d300669136f346a8f9d9e8ae7e903128f70627::oracle_driven_pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<0xd52f42314d7e62068a17658278d300669136f346a8f9d9e8ae7e903128f70627::oracle_driven_pool::BasePoolLiquidityCoin<T0, T1>>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xd52f42314d7e62068a17658278d300669136f346a8f9d9e8ae7e903128f70627::oracle_driven_pool::assert_version<T0, T1>(arg0);
        0xd52f42314d7e62068a17658278d300669136f346a8f9d9e8ae7e903128f70627::oracle_driven_pool::assert_not_closed<T0, T1>(arg0);
        withdraw_all_base_internal<T0, T1>(arg0, arg1, arg2)
    }

    fun withdraw_all_base_internal<T0, T1>(arg0: &mut 0xd52f42314d7e62068a17658278d300669136f346a8f9d9e8ae7e903128f70627::oracle_driven_pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<0xd52f42314d7e62068a17658278d300669136f346a8f9d9e8ae7e903128f70627::oracle_driven_pool::BasePoolLiquidityCoin<T0, T1>>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xd52f42314d7e62068a17658278d300669136f346a8f9d9e8ae7e903128f70627::oracle_driven_pool::increase_liquidity_change_num<T0, T1>(arg0);
        let v0 = 0xd52f42314d7e62068a17658278d300669136f346a8f9d9e8ae7e903128f70627::oracle_driven_pool::get_lp_base_balance<T0, T1>(arg0, 0x2::coin::value<0xd52f42314d7e62068a17658278d300669136f346a8f9d9e8ae7e903128f70627::oracle_driven_pool::BasePoolLiquidityCoin<T0, T1>>(&arg1));
        base_capital_burn<T0, T1>(arg0, 0x2::coin::into_balance<0xd52f42314d7e62068a17658278d300669136f346a8f9d9e8ae7e903128f70627::oracle_driven_pool::BasePoolLiquidityCoin<T0, T1>>(arg1));
        let v1 = WithdrawEvent{
            sender               : 0x2::tx_context::sender(arg2),
            pool_id              : 0x2::object::id<0xd52f42314d7e62068a17658278d300669136f346a8f9d9e8ae7e903128f70627::oracle_driven_pool::Pool<T0, T1>>(arg0),
            is_base_coin         : true,
            amount               : v0,
            capital              : 0x2::coin::value<0xd52f42314d7e62068a17658278d300669136f346a8f9d9e8ae7e903128f70627::oracle_driven_pool::BasePoolLiquidityCoin<T0, T1>>(&arg1),
            liquidity_change_num : 0xd52f42314d7e62068a17658278d300669136f346a8f9d9e8ae7e903128f70627::oracle_driven_pool::get_liquidity_change_num<T0, T1>(arg0),
        };
        0x2::event::emit<WithdrawEvent>(v1);
        0xd52f42314d7e62068a17658278d300669136f346a8f9d9e8ae7e903128f70627::oracle_driven_pool::base_coin_pay_out<T0, T1>(arg0, v0, arg2)
    }

    public fun withdraw_all_quote<T0, T1>(arg0: &mut 0xd52f42314d7e62068a17658278d300669136f346a8f9d9e8ae7e903128f70627::oracle_driven_pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<0xd52f42314d7e62068a17658278d300669136f346a8f9d9e8ae7e903128f70627::oracle_driven_pool::QuotePoolLiquidityCoin<T0, T1>>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xd52f42314d7e62068a17658278d300669136f346a8f9d9e8ae7e903128f70627::oracle_driven_pool::assert_version<T0, T1>(arg0);
        0xd52f42314d7e62068a17658278d300669136f346a8f9d9e8ae7e903128f70627::oracle_driven_pool::assert_not_closed<T0, T1>(arg0);
        withdraw_all_quote_internal<T0, T1>(arg0, arg1, arg2)
    }

    fun withdraw_all_quote_internal<T0, T1>(arg0: &mut 0xd52f42314d7e62068a17658278d300669136f346a8f9d9e8ae7e903128f70627::oracle_driven_pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<0xd52f42314d7e62068a17658278d300669136f346a8f9d9e8ae7e903128f70627::oracle_driven_pool::QuotePoolLiquidityCoin<T0, T1>>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xd52f42314d7e62068a17658278d300669136f346a8f9d9e8ae7e903128f70627::oracle_driven_pool::increase_liquidity_change_num<T0, T1>(arg0);
        let v0 = 0xd52f42314d7e62068a17658278d300669136f346a8f9d9e8ae7e903128f70627::oracle_driven_pool::get_lp_quote_balance<T0, T1>(arg0, 0x2::coin::value<0xd52f42314d7e62068a17658278d300669136f346a8f9d9e8ae7e903128f70627::oracle_driven_pool::QuotePoolLiquidityCoin<T0, T1>>(&arg1));
        quote_capital_burn<T0, T1>(arg0, 0x2::coin::into_balance<0xd52f42314d7e62068a17658278d300669136f346a8f9d9e8ae7e903128f70627::oracle_driven_pool::QuotePoolLiquidityCoin<T0, T1>>(arg1));
        let v1 = WithdrawEvent{
            sender               : 0x2::tx_context::sender(arg2),
            pool_id              : 0x2::object::id<0xd52f42314d7e62068a17658278d300669136f346a8f9d9e8ae7e903128f70627::oracle_driven_pool::Pool<T0, T1>>(arg0),
            is_base_coin         : false,
            amount               : v0,
            capital              : 0x2::coin::value<0xd52f42314d7e62068a17658278d300669136f346a8f9d9e8ae7e903128f70627::oracle_driven_pool::QuotePoolLiquidityCoin<T0, T1>>(&arg1),
            liquidity_change_num : 0xd52f42314d7e62068a17658278d300669136f346a8f9d9e8ae7e903128f70627::oracle_driven_pool::get_liquidity_change_num<T0, T1>(arg0),
        };
        0x2::event::emit<WithdrawEvent>(v1);
        0xd52f42314d7e62068a17658278d300669136f346a8f9d9e8ae7e903128f70627::oracle_driven_pool::quote_coin_pay_out<T0, T1>(arg0, v0, arg2)
    }

    public fun withdraw_base<T0, T1>(arg0: &mut 0xd52f42314d7e62068a17658278d300669136f346a8f9d9e8ae7e903128f70627::oracle_driven_pool::Pool<T0, T1>, arg1: &mut 0x2::coin::Coin<0xd52f42314d7e62068a17658278d300669136f346a8f9d9e8ae7e903128f70627::oracle_driven_pool::BasePoolLiquidityCoin<T0, T1>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xd52f42314d7e62068a17658278d300669136f346a8f9d9e8ae7e903128f70627::oracle_driven_pool::assert_version<T0, T1>(arg0);
        0xd52f42314d7e62068a17658278d300669136f346a8f9d9e8ae7e903128f70627::oracle_driven_pool::assert_not_closed<T0, T1>(arg0);
        withdraw_base_internal<T0, T1>(arg0, arg1, arg2, arg3)
    }

    fun withdraw_base_internal<T0, T1>(arg0: &mut 0xd52f42314d7e62068a17658278d300669136f346a8f9d9e8ae7e903128f70627::oracle_driven_pool::Pool<T0, T1>, arg1: &mut 0x2::coin::Coin<0xd52f42314d7e62068a17658278d300669136f346a8f9d9e8ae7e903128f70627::oracle_driven_pool::BasePoolLiquidityCoin<T0, T1>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xd52f42314d7e62068a17658278d300669136f346a8f9d9e8ae7e903128f70627::oracle_driven_pool::increase_liquidity_change_num<T0, T1>(arg0);
        let v0 = 0xd52f42314d7e62068a17658278d300669136f346a8f9d9e8ae7e903128f70627::oracle_driven_pool::get_base_capital_coin_supply<T0, T1>(arg0);
        assert!(v0 > 0, 3);
        let v1 = 0xd52f42314d7e62068a17658278d300669136f346a8f9d9e8ae7e903128f70627::safe_math::safe_mul_div_ceil_u64(arg2, v0, 0xd52f42314d7e62068a17658278d300669136f346a8f9d9e8ae7e903128f70627::oracle_driven_pool::get_base_balance<T0, T1>(arg0));
        assert!(v1 <= 0x2::coin::value<0xd52f42314d7e62068a17658278d300669136f346a8f9d9e8ae7e903128f70627::oracle_driven_pool::BasePoolLiquidityCoin<T0, T1>>(arg1), 5);
        base_capital_burn<T0, T1>(arg0, 0x2::balance::split<0xd52f42314d7e62068a17658278d300669136f346a8f9d9e8ae7e903128f70627::oracle_driven_pool::BasePoolLiquidityCoin<T0, T1>>(0x2::coin::balance_mut<0xd52f42314d7e62068a17658278d300669136f346a8f9d9e8ae7e903128f70627::oracle_driven_pool::BasePoolLiquidityCoin<T0, T1>>(arg1), v1));
        let v2 = WithdrawEvent{
            sender               : 0x2::tx_context::sender(arg3),
            pool_id              : 0x2::object::id<0xd52f42314d7e62068a17658278d300669136f346a8f9d9e8ae7e903128f70627::oracle_driven_pool::Pool<T0, T1>>(arg0),
            is_base_coin         : true,
            amount               : arg2,
            capital              : v1,
            liquidity_change_num : 0xd52f42314d7e62068a17658278d300669136f346a8f9d9e8ae7e903128f70627::oracle_driven_pool::get_liquidity_change_num<T0, T1>(arg0),
        };
        0x2::event::emit<WithdrawEvent>(v2);
        0xd52f42314d7e62068a17658278d300669136f346a8f9d9e8ae7e903128f70627::oracle_driven_pool::base_coin_pay_out<T0, T1>(arg0, arg2, arg3)
    }

    public fun withdraw_quote<T0, T1>(arg0: &mut 0xd52f42314d7e62068a17658278d300669136f346a8f9d9e8ae7e903128f70627::oracle_driven_pool::Pool<T0, T1>, arg1: &mut 0x2::coin::Coin<0xd52f42314d7e62068a17658278d300669136f346a8f9d9e8ae7e903128f70627::oracle_driven_pool::QuotePoolLiquidityCoin<T0, T1>>, arg2: &0x2::clock::Clock, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xd52f42314d7e62068a17658278d300669136f346a8f9d9e8ae7e903128f70627::oracle_driven_pool::assert_version<T0, T1>(arg0);
        0xd52f42314d7e62068a17658278d300669136f346a8f9d9e8ae7e903128f70627::oracle_driven_pool::assert_not_closed<T0, T1>(arg0);
        withdraw_quote_internal<T0, T1>(arg0, arg1, arg3, arg4)
    }

    fun withdraw_quote_internal<T0, T1>(arg0: &mut 0xd52f42314d7e62068a17658278d300669136f346a8f9d9e8ae7e903128f70627::oracle_driven_pool::Pool<T0, T1>, arg1: &mut 0x2::coin::Coin<0xd52f42314d7e62068a17658278d300669136f346a8f9d9e8ae7e903128f70627::oracle_driven_pool::QuotePoolLiquidityCoin<T0, T1>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xd52f42314d7e62068a17658278d300669136f346a8f9d9e8ae7e903128f70627::oracle_driven_pool::increase_liquidity_change_num<T0, T1>(arg0);
        let v0 = 0xd52f42314d7e62068a17658278d300669136f346a8f9d9e8ae7e903128f70627::oracle_driven_pool::get_quote_capital_coin_supply<T0, T1>(arg0);
        assert!(v0 > 0, 4);
        let v1 = 0xd52f42314d7e62068a17658278d300669136f346a8f9d9e8ae7e903128f70627::safe_math::safe_mul_div_ceil_u64(arg2, v0, 0xd52f42314d7e62068a17658278d300669136f346a8f9d9e8ae7e903128f70627::oracle_driven_pool::get_quote_balance<T0, T1>(arg0));
        assert!(v1 <= 0x2::coin::value<0xd52f42314d7e62068a17658278d300669136f346a8f9d9e8ae7e903128f70627::oracle_driven_pool::QuotePoolLiquidityCoin<T0, T1>>(arg1), 6);
        quote_capital_burn<T0, T1>(arg0, 0x2::balance::split<0xd52f42314d7e62068a17658278d300669136f346a8f9d9e8ae7e903128f70627::oracle_driven_pool::QuotePoolLiquidityCoin<T0, T1>>(0x2::coin::balance_mut<0xd52f42314d7e62068a17658278d300669136f346a8f9d9e8ae7e903128f70627::oracle_driven_pool::QuotePoolLiquidityCoin<T0, T1>>(arg1), v1));
        let v2 = WithdrawEvent{
            sender               : 0x2::tx_context::sender(arg3),
            pool_id              : 0x2::object::id<0xd52f42314d7e62068a17658278d300669136f346a8f9d9e8ae7e903128f70627::oracle_driven_pool::Pool<T0, T1>>(arg0),
            is_base_coin         : false,
            amount               : arg2,
            capital              : v1,
            liquidity_change_num : 0xd52f42314d7e62068a17658278d300669136f346a8f9d9e8ae7e903128f70627::oracle_driven_pool::get_liquidity_change_num<T0, T1>(arg0),
        };
        0x2::event::emit<WithdrawEvent>(v2);
        0xd52f42314d7e62068a17658278d300669136f346a8f9d9e8ae7e903128f70627::oracle_driven_pool::quote_coin_pay_out<T0, T1>(arg0, arg2, arg3)
    }

    // decompiled from Move bytecode v6
}

