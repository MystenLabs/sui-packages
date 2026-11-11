module 0x9440f577f1da6a0387181704293abaf7aa60a33502b9f01a5a4980163909add8::d {
    struct GlobalConfig has key {
        id: 0x2::object::UID,
        admin: address,
        operators: 0x2::vec_set::VecSet<address>,
        balance_manager: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager,
        trade_cap: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap,
        deposit_cap: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::DepositCap,
        withdraw_cap: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::WithdrawCap,
        max_deep: u64,
    }

    fun swap<T0, T1>(arg0: &mut GlobalConfig, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: bool, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        check_operator(arg0, arg6);
        let v0 = 0x2::coin::value<T0>(&arg2);
        let v1 = 0x2::coin::value<T1>(&arg3);
        let v2 = v1 > 0;
        if (arg4) {
            let (_, _, v5) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quantity_out<T0, T1>(arg1, v0, v1, arg5);
            arg4 = can_pay_deep(arg0, v5);
        };
        if (arg4) {
            return 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quantity_with_manager<T0, T1>(arg1, &mut arg0.balance_manager, &arg0.trade_cap, &arg0.deposit_cap, &arg0.withdraw_cap, arg2, arg3, 0, arg5, arg6)
        };
        let v6 = if (v2) {
            let (v7, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quantity_out_input_fee<T0, T1>(arg1, 0, v1, arg5);
            v7
        } else {
            let (v10, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_trade_params<T0, T1>(arg1);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::math::div(v0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::float_scaling() + 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::math::mul(v10, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::fee_penalty_multiplier()))
        };
        let (_, v14, v15) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T0, T1>(arg1);
        let v16 = v6 - v6 % v14;
        if (v16 < v15) {
            return (arg2, arg3)
        };
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit_with_cap<T0>(&mut arg0.balance_manager, &arg0.deposit_cap, arg2, arg6);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit_with_cap<T1>(&mut arg0.balance_manager, &arg0.deposit_cap, arg3, arg6);
        let v17 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_trader(&mut arg0.balance_manager, &arg0.trade_cap, arg6);
        let v18 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_market_order<T0, T1>(arg1, &mut arg0.balance_manager, &v17, 0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::self_matching_allowed(), v16, v2, false, arg5, arg6);
        let (v19, v20) = if (v2) {
            (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::executed_quantity(&v18), v1 - 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::cumulative_quote_quantity(&v18) - 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::paid_fees(&v18))
        } else {
            (v0 - 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::executed_quantity(&v18) - 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::paid_fees(&v18), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::cumulative_quote_quantity(&v18))
        };
        let v21 = withdraw_amount<T0>(arg0, v19, arg6);
        (v21, withdraw_amount<T1>(arg0, v20, arg6))
    }

    public fun add_operator(arg0: &mut GlobalConfig, arg1: address, arg2: &0x2::tx_context::TxContext) {
        check_admin(arg0, arg2);
        0x2::vec_set::insert<address>(&mut arg0.operators, arg1);
    }

    fun can_pay_deep(arg0: &GlobalConfig, arg1: u64) : bool {
        if (arg1 > 0) {
            if (arg1 <= arg0.max_deep) {
                arg1 <= 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg0.balance_manager)
            } else {
                false
            }
        } else {
            false
        }
    }

    fun check_admin(arg0: &GlobalConfig, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 1);
    }

    fun check_operator(arg0: &GlobalConfig, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::vec_set::contains<address>(&arg0.operators, &v0), 2);
    }

    public fun deposit<T0>(arg0: &mut GlobalConfig, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::tx_context::TxContext) {
        check_admin(arg0, arg2);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit_with_cap<T0>(&mut arg0.balance_manager, &arg0.deposit_cap, arg1, arg2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::new(arg0);
        let v1 = GlobalConfig{
            id              : 0x2::object::new(arg0),
            admin           : 0x2::tx_context::sender(arg0),
            operators       : 0x2::vec_set::singleton<address>(0x2::tx_context::sender(arg0)),
            balance_manager : v0,
            trade_cap       : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::mint_trade_cap(&mut v0, arg0),
            deposit_cap     : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::mint_deposit_cap(&mut v0, arg0),
            withdraw_cap    : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::mint_withdraw_cap(&mut v0, arg0),
            max_deep        : 100000000,
        };
        0x2::transfer::share_object<GlobalConfig>(v1);
    }

    public fun remove_operator(arg0: &mut GlobalConfig, arg1: address, arg2: &0x2::tx_context::TxContext) {
        check_admin(arg0, arg2);
        0x2::vec_set::remove<address>(&mut arg0.operators, &arg1);
    }

    public fun set_max_deep(arg0: &mut GlobalConfig, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        check_admin(arg0, arg2);
        arg0.max_deep = arg1;
    }

    public fun sxy<T0, T1>(arg0: &mut GlobalConfig, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: bool, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::zero<T1>(arg5);
        let (v1, v2) = swap<T0, T1>(arg0, arg1, arg2, v0, arg3, arg4, arg5);
        0x9440f577f1da6a0387181704293abaf7aa60a33502b9f01a5a4980163909add8::u::tod<T0>(v1, 0x2::tx_context::sender(arg5));
        v2
    }

    public fun syx<T0, T1>(arg0: &mut GlobalConfig, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: bool, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::zero<T0>(arg5);
        let (v1, v2) = swap<T0, T1>(arg0, arg1, v0, arg2, arg3, arg4, arg5);
        0x9440f577f1da6a0387181704293abaf7aa60a33502b9f01a5a4980163909add8::u::tod<T1>(v2, 0x2::tx_context::sender(arg5));
        v1
    }

    public fun transfer_ownership(arg0: &mut GlobalConfig, arg1: address, arg2: &0x2::tx_context::TxContext) {
        check_admin(arg0, arg2);
        arg0.admin = arg1;
    }

    public fun withdraw<T0>(arg0: &mut GlobalConfig, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        check_admin(arg0, arg2);
        0x9440f577f1da6a0387181704293abaf7aa60a33502b9f01a5a4980163909add8::u::tod<T0>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw_with_cap<T0>(&mut arg0.balance_manager, &arg0.withdraw_cap, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    fun withdraw_amount<T0>(arg0: &mut GlobalConfig, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        if (arg1 == 0) {
            return 0x2::coin::zero<T0>(arg2)
        };
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw_with_cap<T0>(&mut arg0.balance_manager, &arg0.withdraw_cap, arg1, arg2)
    }

    // decompiled from Move bytecode v7
}

