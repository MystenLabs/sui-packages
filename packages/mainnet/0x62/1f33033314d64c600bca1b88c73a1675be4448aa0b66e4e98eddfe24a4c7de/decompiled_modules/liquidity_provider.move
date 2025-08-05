module 0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::liquidity_provider {
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

    struct RebalanceWithdrawEvent has copy, drop {
        pool_id: 0x2::object::ID,
        sender: address,
        base_amount: u64,
        quote_amount: u64,
        liquidity_change_num: u64,
    }

    struct RebalanceDepositEvent has copy, drop {
        pool_id: 0x2::object::ID,
        sender: address,
        base_amount: u64,
        quote_amount: u64,
        liquidity_change_num: u64,
    }

    fun base_capital_burn<T0, T1>(arg0: &mut 0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::Pool<T0, T1>, arg1: 0x2::balance::Balance<0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::BasePoolLiquidityCoin<T0, T1>>) {
        0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::burn_base_capital_coin<T0, T1>(arg0, arg1);
    }

    public fun deposit_base<T0, T1>(arg0: &0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::ownable::LiquidityOperatorCap<T0, T1>, arg1: &mut 0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::Pool<T0, T1>, arg2: &mut 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::get_in_rebalance<T0, T1>(arg1), 8);
        0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::assert_version<T0, T1>(arg1);
        0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::assert_deposit_base_allowed<T0, T1>(arg1);
        assert!(0x2::coin::value<T0>(arg2) >= arg3, 1);
        0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::add_init_balance<T0, T1>(arg1, arg3, 0);
        deposit_base_internal<T0, T1>(arg1, arg2, arg3, arg4);
    }

    fun deposit_base_internal<T0, T1>(arg0: &mut 0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::Pool<T0, T1>, arg1: &mut 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::increase_liquidity_change_num<T0, T1>(arg0);
        let v0 = 0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::get_base_balance<T0, T1>(arg0);
        let v1 = 0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::get_base_capital_coin_supply<T0, T1>(arg0);
        let v2 = arg2;
        if (v1 == 0) {
            v2 = arg2 + v0;
        } else if (v0 > 0) {
            v2 = 0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::safe_math::safe_mul_div_u64(arg2, v1, v0);
        };
        let v3 = mint_base<T0, T1>(arg0, 0x2::balance::split<T0>(0x2::coin::balance_mut<T0>(arg1), arg2), v2, arg3);
        assert!(0x2::coin::value<0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::BasePoolLiquidityCoin<T0, T1>>(&v3) > 0, 2);
        0x2::pay::keep<0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::BasePoolLiquidityCoin<T0, T1>>(v3, arg3);
        0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::set_operate_balance<T0, T1>(arg0);
        let v4 = DepositEvent{
            sender               : 0x2::tx_context::sender(arg3),
            pool_id              : 0x2::object::id<0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::Pool<T0, T1>>(arg0),
            is_base_coin         : true,
            amount               : arg2,
            capital              : v2,
            liquidity_change_num : 0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::get_liquidity_change_num<T0, T1>(arg0),
        };
        0x2::event::emit<DepositEvent>(v4);
    }

    public fun deposit_quote<T0, T1>(arg0: &0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::ownable::LiquidityOperatorCap<T0, T1>, arg1: &mut 0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::Pool<T0, T1>, arg2: &mut 0x2::coin::Coin<T1>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::assert_version<T0, T1>(arg1);
        0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::assert_deposit_quote_allowed<T0, T1>(arg1);
        assert!(0x2::coin::value<T1>(arg2) >= arg3, 1);
        assert!(!0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::get_in_rebalance<T0, T1>(arg1), 8);
        0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::add_init_balance<T0, T1>(arg1, 0, arg3);
        deposit_quote_internal<T0, T1>(arg1, arg2, arg3, arg4);
    }

    fun deposit_quote_internal<T0, T1>(arg0: &mut 0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::Pool<T0, T1>, arg1: &mut 0x2::coin::Coin<T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::increase_liquidity_change_num<T0, T1>(arg0);
        let v0 = 0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::get_quote_balance<T0, T1>(arg0);
        let v1 = 0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::get_quote_capital_coin_supply<T0, T1>(arg0);
        let v2 = arg2;
        if (v1 == 0) {
            v2 = arg2 + v0;
        } else if (v0 > 0) {
            v2 = 0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::safe_math::safe_mul_div_u64(arg2, v1, v0);
        };
        let v3 = mint_quote<T0, T1>(arg0, 0x2::balance::split<T1>(0x2::coin::balance_mut<T1>(arg1), arg2), v2, arg3);
        assert!(0x2::coin::value<0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::QuotePoolLiquidityCoin<T0, T1>>(&v3) > 0, 2);
        0x2::pay::keep<0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::QuotePoolLiquidityCoin<T0, T1>>(v3, arg3);
        0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::set_operate_balance<T0, T1>(arg0);
        let v4 = DepositEvent{
            sender               : 0x2::tx_context::sender(arg3),
            pool_id              : 0x2::object::id<0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::Pool<T0, T1>>(arg0),
            is_base_coin         : false,
            amount               : arg2,
            capital              : v2,
            liquidity_change_num : 0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::get_liquidity_change_num<T0, T1>(arg0),
        };
        0x2::event::emit<DepositEvent>(v4);
    }

    public entry fun entry_deposit_base<T0, T1>(arg0: &0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::ownable::LiquidityOperatorCap<T0, T1>, arg1: &mut 0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::Pool<T0, T1>, arg2: &mut 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        deposit_base<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun entry_deposit_quote<T0, T1>(arg0: &0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::ownable::LiquidityOperatorCap<T0, T1>, arg1: &mut 0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::Pool<T0, T1>, arg2: &mut 0x2::coin::Coin<T1>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        deposit_quote<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun entry_withdraw_all_base<T0, T1>(arg0: &mut 0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::BasePoolLiquidityCoin<T0, T1>>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = withdraw_all_base<T0, T1>(arg0, arg1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg2));
    }

    public entry fun entry_withdraw_all_quote<T0, T1>(arg0: &mut 0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::QuotePoolLiquidityCoin<T0, T1>>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = withdraw_all_quote<T0, T1>(arg0, arg1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v0, 0x2::tx_context::sender(arg2));
    }

    public entry fun entry_withdraw_base<T0, T1>(arg0: &mut 0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::Pool<T0, T1>, arg1: &mut 0x2::coin::Coin<0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::BasePoolLiquidityCoin<T0, T1>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = withdraw_base<T0, T1>(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg3));
    }

    public entry fun entry_withdraw_quote<T0, T1>(arg0: &mut 0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::Pool<T0, T1>, arg1: &mut 0x2::coin::Coin<0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::QuotePoolLiquidityCoin<T0, T1>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = withdraw_quote<T0, T1>(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v0, 0x2::tx_context::sender(arg3));
    }

    fun mint_base<T0, T1>(arg0: &mut 0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::Pool<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::BasePoolLiquidityCoin<T0, T1>> {
        0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::mint_base_capital<T0, T1>(arg0, arg1, arg2, arg3)
    }

    fun mint_quote<T0, T1>(arg0: &mut 0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::Pool<T0, T1>, arg1: 0x2::balance::Balance<T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::QuotePoolLiquidityCoin<T0, T1>> {
        0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::mint_quote_capital<T0, T1>(arg0, arg1, arg2, arg3)
    }

    fun quote_capital_burn<T0, T1>(arg0: &mut 0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::Pool<T0, T1>, arg1: 0x2::balance::Balance<0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::QuotePoolLiquidityCoin<T0, T1>>) {
        0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::burn_quote_capital_coin<T0, T1>(arg0, arg1);
    }

    public entry fun rebalance_deposit_base<T0, T1>(arg0: &0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::ownable::LiquidityOperatorCap<T0, T1>, arg1: &mut 0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::Pool<T0, T1>, arg2: &mut 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::set_in_rebalance<T0, T1>(arg1, false);
        deposit_base<T0, T1>(arg0, arg1, arg2, arg3, arg4);
        0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::set_rebalance_balance<T0, T1>(arg1);
        let v0 = RebalanceDepositEvent{
            pool_id              : 0x2::object::id<0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::Pool<T0, T1>>(arg1),
            sender               : 0x2::tx_context::sender(arg4),
            base_amount          : arg3,
            quote_amount         : 0,
            liquidity_change_num : 0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::get_liquidity_change_num<T0, T1>(arg1),
        };
        0x2::event::emit<RebalanceDepositEvent>(v0);
    }

    public entry fun rebalance_deposit_coins<T0, T1>(arg0: &0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::ownable::LiquidityOperatorCap<T0, T1>, arg1: &mut 0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::Pool<T0, T1>, arg2: &mut 0x2::coin::Coin<T0>, arg3: &mut 0x2::coin::Coin<T1>, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::set_in_rebalance<T0, T1>(arg1, false);
        deposit_base<T0, T1>(arg0, arg1, arg2, arg4, arg6);
        deposit_quote<T0, T1>(arg0, arg1, arg3, arg5, arg6);
        0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::set_rebalance_balance<T0, T1>(arg1);
        let v0 = RebalanceDepositEvent{
            pool_id              : 0x2::object::id<0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::Pool<T0, T1>>(arg1),
            sender               : 0x2::tx_context::sender(arg6),
            base_amount          : arg4,
            quote_amount         : arg5,
            liquidity_change_num : 0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::get_liquidity_change_num<T0, T1>(arg1),
        };
        0x2::event::emit<RebalanceDepositEvent>(v0);
    }

    public entry fun rebalance_deposit_quote<T0, T1>(arg0: &0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::ownable::LiquidityOperatorCap<T0, T1>, arg1: &mut 0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::Pool<T0, T1>, arg2: &mut 0x2::coin::Coin<T1>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::set_in_rebalance<T0, T1>(arg1, false);
        deposit_quote<T0, T1>(arg0, arg1, arg2, arg3, arg4);
        0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::set_rebalance_balance<T0, T1>(arg1);
        let v0 = RebalanceDepositEvent{
            pool_id              : 0x2::object::id<0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::Pool<T0, T1>>(arg1),
            sender               : 0x2::tx_context::sender(arg4),
            base_amount          : 0,
            quote_amount         : arg3,
            liquidity_change_num : 0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::get_liquidity_change_num<T0, T1>(arg1),
        };
        0x2::event::emit<RebalanceDepositEvent>(v0);
    }

    public entry fun rebalance_withdraw_base<T0, T1>(arg0: &mut 0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::Pool<T0, T1>, arg1: &mut 0x2::coin::Coin<0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::BasePoolLiquidityCoin<T0, T1>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = withdraw_base<T0, T1>(arg0, arg1, arg2, arg3);
        0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::set_in_rebalance<T0, T1>(arg0, true);
        let v1 = RebalanceWithdrawEvent{
            pool_id              : 0x2::object::id<0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::Pool<T0, T1>>(arg0),
            sender               : 0x2::tx_context::sender(arg3),
            base_amount          : 0x2::coin::value<T0>(&v0),
            quote_amount         : 0,
            liquidity_change_num : 0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::get_liquidity_change_num<T0, T1>(arg0),
        };
        0x2::event::emit<RebalanceWithdrawEvent>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg3));
    }

    public entry fun rebalance_withdraw_quote<T0, T1>(arg0: &mut 0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::Pool<T0, T1>, arg1: &mut 0x2::coin::Coin<0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::QuotePoolLiquidityCoin<T0, T1>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = withdraw_quote<T0, T1>(arg0, arg1, arg2, arg3);
        0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::set_in_rebalance<T0, T1>(arg0, true);
        let v1 = RebalanceWithdrawEvent{
            pool_id              : 0x2::object::id<0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::Pool<T0, T1>>(arg0),
            sender               : 0x2::tx_context::sender(arg3),
            base_amount          : 0,
            quote_amount         : 0x2::coin::value<T1>(&v0),
            liquidity_change_num : 0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::get_liquidity_change_num<T0, T1>(arg0),
        };
        0x2::event::emit<RebalanceWithdrawEvent>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v0, 0x2::tx_context::sender(arg3));
    }

    public fun withdraw_all_base<T0, T1>(arg0: &mut 0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::BasePoolLiquidityCoin<T0, T1>>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::assert_version<T0, T1>(arg0);
        0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::assert_not_closed<T0, T1>(arg0);
        assert!(!0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::get_in_rebalance<T0, T1>(arg0), 8);
        let v0 = withdraw_all_base_internal<T0, T1>(arg0, arg1, arg2);
        0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::decrease_init_balance<T0, T1>(arg0, 0x2::coin::value<T0>(&v0), 0);
        v0
    }

    fun withdraw_all_base_internal<T0, T1>(arg0: &mut 0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::BasePoolLiquidityCoin<T0, T1>>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::increase_liquidity_change_num<T0, T1>(arg0);
        let v0 = 0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::get_lp_base_balance<T0, T1>(arg0, 0x2::coin::value<0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::BasePoolLiquidityCoin<T0, T1>>(&arg1));
        base_capital_burn<T0, T1>(arg0, 0x2::coin::into_balance<0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::BasePoolLiquidityCoin<T0, T1>>(arg1));
        0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::set_operate_balance<T0, T1>(arg0);
        let v1 = WithdrawEvent{
            sender               : 0x2::tx_context::sender(arg2),
            pool_id              : 0x2::object::id<0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::Pool<T0, T1>>(arg0),
            is_base_coin         : true,
            amount               : v0,
            capital              : 0x2::coin::value<0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::BasePoolLiquidityCoin<T0, T1>>(&arg1),
            liquidity_change_num : 0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::get_liquidity_change_num<T0, T1>(arg0),
        };
        0x2::event::emit<WithdrawEvent>(v1);
        0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::base_coin_pay_out<T0, T1>(arg0, v0, arg2)
    }

    public fun withdraw_all_quote<T0, T1>(arg0: &mut 0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::QuotePoolLiquidityCoin<T0, T1>>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::assert_version<T0, T1>(arg0);
        0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::assert_not_closed<T0, T1>(arg0);
        assert!(!0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::get_in_rebalance<T0, T1>(arg0), 8);
        let v0 = withdraw_all_quote_internal<T0, T1>(arg0, arg1, arg2);
        0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::decrease_init_balance<T0, T1>(arg0, 0, 0x2::coin::value<T1>(&v0));
        v0
    }

    fun withdraw_all_quote_internal<T0, T1>(arg0: &mut 0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::QuotePoolLiquidityCoin<T0, T1>>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::increase_liquidity_change_num<T0, T1>(arg0);
        let v0 = 0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::get_lp_quote_balance<T0, T1>(arg0, 0x2::coin::value<0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::QuotePoolLiquidityCoin<T0, T1>>(&arg1));
        quote_capital_burn<T0, T1>(arg0, 0x2::coin::into_balance<0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::QuotePoolLiquidityCoin<T0, T1>>(arg1));
        0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::set_operate_balance<T0, T1>(arg0);
        let v1 = WithdrawEvent{
            sender               : 0x2::tx_context::sender(arg2),
            pool_id              : 0x2::object::id<0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::Pool<T0, T1>>(arg0),
            is_base_coin         : false,
            amount               : v0,
            capital              : 0x2::coin::value<0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::QuotePoolLiquidityCoin<T0, T1>>(&arg1),
            liquidity_change_num : 0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::get_liquidity_change_num<T0, T1>(arg0),
        };
        0x2::event::emit<WithdrawEvent>(v1);
        0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::quote_coin_pay_out<T0, T1>(arg0, v0, arg2)
    }

    public fun withdraw_base<T0, T1>(arg0: &mut 0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::Pool<T0, T1>, arg1: &mut 0x2::coin::Coin<0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::BasePoolLiquidityCoin<T0, T1>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::assert_version<T0, T1>(arg0);
        0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::assert_not_closed<T0, T1>(arg0);
        assert!(!0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::get_in_rebalance<T0, T1>(arg0), 8);
        let v0 = withdraw_base_internal<T0, T1>(arg0, arg1, arg2, arg3);
        0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::decrease_init_balance<T0, T1>(arg0, 0x2::coin::value<T0>(&v0), 0);
        v0
    }

    fun withdraw_base_internal<T0, T1>(arg0: &mut 0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::Pool<T0, T1>, arg1: &mut 0x2::coin::Coin<0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::BasePoolLiquidityCoin<T0, T1>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::increase_liquidity_change_num<T0, T1>(arg0);
        let v0 = 0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::get_base_capital_coin_supply<T0, T1>(arg0);
        assert!(v0 > 0, 3);
        let v1 = 0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::safe_math::safe_mul_div_ceil_u64(arg2, v0, 0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::get_base_balance<T0, T1>(arg0));
        assert!(v1 <= 0x2::coin::value<0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::BasePoolLiquidityCoin<T0, T1>>(arg1), 5);
        base_capital_burn<T0, T1>(arg0, 0x2::balance::split<0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::BasePoolLiquidityCoin<T0, T1>>(0x2::coin::balance_mut<0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::BasePoolLiquidityCoin<T0, T1>>(arg1), v1));
        let v2 = WithdrawEvent{
            sender               : 0x2::tx_context::sender(arg3),
            pool_id              : 0x2::object::id<0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::Pool<T0, T1>>(arg0),
            is_base_coin         : true,
            amount               : arg2,
            capital              : v1,
            liquidity_change_num : 0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::get_liquidity_change_num<T0, T1>(arg0),
        };
        0x2::event::emit<WithdrawEvent>(v2);
        0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::set_operate_balance<T0, T1>(arg0);
        0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::base_coin_pay_out<T0, T1>(arg0, arg2, arg3)
    }

    public fun withdraw_quote<T0, T1>(arg0: &mut 0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::Pool<T0, T1>, arg1: &mut 0x2::coin::Coin<0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::QuotePoolLiquidityCoin<T0, T1>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::assert_version<T0, T1>(arg0);
        0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::assert_not_closed<T0, T1>(arg0);
        assert!(!0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::get_in_rebalance<T0, T1>(arg0), 8);
        let v0 = withdraw_quote_internal<T0, T1>(arg0, arg1, arg2, arg3);
        0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::decrease_init_balance<T0, T1>(arg0, 0, 0x2::coin::value<T1>(&v0));
        v0
    }

    fun withdraw_quote_internal<T0, T1>(arg0: &mut 0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::Pool<T0, T1>, arg1: &mut 0x2::coin::Coin<0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::QuotePoolLiquidityCoin<T0, T1>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::increase_liquidity_change_num<T0, T1>(arg0);
        let v0 = 0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::get_quote_capital_coin_supply<T0, T1>(arg0);
        assert!(v0 > 0, 4);
        let v1 = 0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::safe_math::safe_mul_div_ceil_u64(arg2, v0, 0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::get_quote_balance<T0, T1>(arg0));
        assert!(v1 <= 0x2::coin::value<0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::QuotePoolLiquidityCoin<T0, T1>>(arg1), 6);
        quote_capital_burn<T0, T1>(arg0, 0x2::balance::split<0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::QuotePoolLiquidityCoin<T0, T1>>(0x2::coin::balance_mut<0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::QuotePoolLiquidityCoin<T0, T1>>(arg1), v1));
        let v2 = WithdrawEvent{
            sender               : 0x2::tx_context::sender(arg3),
            pool_id              : 0x2::object::id<0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::Pool<T0, T1>>(arg0),
            is_base_coin         : false,
            amount               : arg2,
            capital              : v1,
            liquidity_change_num : 0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::get_liquidity_change_num<T0, T1>(arg0),
        };
        0x2::event::emit<WithdrawEvent>(v2);
        0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::set_operate_balance<T0, T1>(arg0);
        0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle_driven_pool::quote_coin_pay_out<T0, T1>(arg0, arg2, arg3)
    }

    // decompiled from Move bytecode v6
}

