module 0xa68b5415932fb44b1fc43fb7890175af15a5b378448d7943b24c239c16d007a4::deepbook {
    struct Loan {
        inner: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan,
        amount: u64,
    }

    public fun ask<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &0x2::clock::Clock, arg3: 0x2::balance::Balance<T0>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let v0 = floor_lot<T0, T1>(arg0, 0x2::balance::value<T0>(&arg3));
        trade<T0, T1, T0>(arg0, arg1, arg2, arg3, v0, false, true, arg4);
        0x2::coin::into_balance<T1>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw_all<T1>(arg1, arg4))
    }

    public fun ask_direct<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: 0x2::balance::Balance<T0>, arg3: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T0>) {
        let (v0, v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_base_for_quote<T0, T1>(arg0, 0x2::coin::from_balance<T0>(arg2, arg3), 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg3), 0, arg1, arg3);
        0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v2);
        (0x2::coin::into_balance<T1>(v1), 0x2::coin::into_balance<T0>(v0))
    }

    public fun ask_input_fee<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &0x2::clock::Clock, arg3: 0x2::balance::Balance<T0>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let v0 = floor_lot<T0, T1>(arg0, div(0x2::balance::value<T0>(&arg3), arg4));
        trade<T0, T1, T0>(arg0, arg1, arg2, arg3, v0, false, false, arg5);
        0x2::coin::into_balance<T1>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw_all<T1>(arg1, arg5))
    }

    public fun bid<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &0x2::clock::Clock, arg3: 0x2::balance::Balance<T1>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let (v0, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quantity_out<T0, T1>(arg0, 0, 0x2::balance::value<T1>(&arg3), arg2);
        let v3 = floor_lot<T0, T1>(arg0, v0);
        trade<T0, T1, T1>(arg0, arg1, arg2, arg3, v3, true, true, arg4);
        0x2::coin::into_balance<T0>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw_all<T0>(arg1, arg4))
    }

    public fun bid_direct<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: 0x2::balance::Balance<T1>, arg3: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let (v0, v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quote_for_base<T0, T1>(arg0, 0x2::coin::from_balance<T1>(arg2, arg3), 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg3), 0, arg1, arg3);
        0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v2);
        (0x2::coin::into_balance<T0>(v0), 0x2::coin::into_balance<T1>(v1))
    }

    public fun bid_input_fee<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &0x2::clock::Clock, arg3: 0x2::balance::Balance<T1>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let (v0, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quantity_out_input_fee<T0, T1>(arg0, 0, 0x2::balance::value<T1>(&arg3), arg2);
        let v3 = floor_lot<T0, T1>(arg0, v0);
        trade<T0, T1, T1>(arg0, arg1, arg2, arg3, v3, true, false, arg4);
        0x2::coin::into_balance<T0>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw_all<T0>(arg1, arg4))
    }

    public fun bid_keep_deep<T0>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP, T0>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &0x2::clock::Clock, arg3: 0x2::balance::Balance<T0>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP> {
        let (v0, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quantity_out<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP, T0>(arg0, 0, 0x2::balance::value<T0>(&arg3), arg2);
        let v3 = floor_lot<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP, T0>(arg0, v0);
        let v4 = trade<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP, T0, T0>(arg0, arg1, arg2, arg3, v3, true, true, arg4);
        0x2::coin::into_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg1, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::executed_quantity(&v4), arg4))
    }

    fun div(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * 1000000000 / (arg1 as u128)) as u64)
    }

    fun floor_lot<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: u64) : u64 {
        let (_, v1, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T0, T1>(arg0);
        arg1 / v1 * v1
    }

    public fun loan_base<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, Loan) {
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_base<T0, T1>(arg0, arg1, arg2);
        let v2 = Loan{
            inner  : v1,
            amount : arg1,
        };
        (0x2::coin::into_balance<T0>(v0), v2)
    }

    public fun loan_quote<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, Loan) {
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T0, T1>(arg0, arg1, arg2);
        let v2 = Loan{
            inner  : v1,
            amount : arg1,
        };
        (0x2::coin::into_balance<T1>(v0), v2)
    }

    public fun reclaim<T0>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg1: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0x2::coin::into_balance<T0>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw_all<T0>(arg0, arg1))
    }

    public fun repay_base<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: Loan, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let Loan {
            inner  : v0,
            amount : v1,
        } = arg2;
        let v2 = &mut arg1;
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_base<T0, T1>(arg0, 0x2::coin::from_balance<T0>(take<T0>(v2, v1), arg3), v0);
        arg1
    }

    public fun repay_quote<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2::balance::Balance<T1>, arg2: Loan, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let Loan {
            inner  : v0,
            amount : v1,
        } = arg2;
        let v2 = &mut arg1;
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T0, T1>(arg0, 0x2::coin::from_balance<T1>(take<T1>(v2, v1), arg3), v0);
        arg1
    }

    fun take<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        assert!(0x2::balance::value<T0>(arg0) >= arg1, 1);
        0x2::balance::split<T0>(arg0, arg1)
    }

    fun trade<T0, T1, T2>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &0x2::clock::Clock, arg3: 0x2::balance::Balance<T2>, arg4: u64, arg5: bool, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::OrderInfo {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T2>(arg1, 0x2::coin::from_balance<T2>(arg3, arg7), arg7);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg1, arg7);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_market_order<T0, T1>(arg0, arg1, &v0, 0, 0, arg4, arg5, arg6, arg2, arg7)
    }

    // decompiled from Move bytecode v7
}

