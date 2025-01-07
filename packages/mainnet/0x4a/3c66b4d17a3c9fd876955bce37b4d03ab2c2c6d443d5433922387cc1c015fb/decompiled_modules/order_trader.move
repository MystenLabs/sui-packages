module 0x624a80998bfca8118a794c71cccca771c351158eecd425661e07056f4ed94683::order_trader {
    struct OrderTrader has store, key {
        id: 0x2::object::UID,
        trade_cap: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap,
    }

    struct InitOrderTraderEvent has copy, drop {
        trade_cap_id: 0x2::object::ID,
        cetus_balance_manager_id: 0x2::object::ID,
    }

    struct AccountIdEvent has copy, drop {
        account: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::account::Account,
    }

    public fun get_account_id<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager) {
        let v0 = AccountIdEvent{account: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::account<T0, T1>(arg0, arg1)};
        0x2::event::emit<AccountIdEvent>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x624a80998bfca8118a794c71cccca771c351158eecd425661e07056f4ed94683::cetus_balance_manager::new(arg0);
        let v1 = 0x624a80998bfca8118a794c71cccca771c351158eecd425661e07056f4ed94683::cetus_balance_manager::mint_trade_cap(&mut v0, arg0);
        let v2 = OrderTrader{
            id        : 0x2::object::new(arg0),
            trade_cap : v1,
        };
        let v3 = InitOrderTraderEvent{
            trade_cap_id             : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap>(&v1),
            cetus_balance_manager_id : 0x2::object::id<0x624a80998bfca8118a794c71cccca771c351158eecd425661e07056f4ed94683::cetus_balance_manager::CetusBalanceManager>(&v0),
        };
        0x2::event::emit<InitOrderTraderEvent>(v3);
        0x624a80998bfca8118a794c71cccca771c351158eecd425661e07056f4ed94683::cetus_balance_manager::share(v0);
        0x2::transfer::share_object<OrderTrader>(v2);
    }

    public fun place_market_order<T0, T1>(arg0: &mut 0x624a80998bfca8118a794c71cccca771c351158eecd425661e07056f4ed94683::global_config::GlobalConfig, arg1: &OrderTrader, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: &mut 0x624a80998bfca8118a794c71cccca771c351158eecd425661e07056f4ed94683::cetus_balance_manager::CetusBalanceManager, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg7: u8, arg8: u64, arg9: bool, arg10: bool, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0x624a80998bfca8118a794c71cccca771c351158eecd425661e07056f4ed94683::global_config::checked_package_version(arg0);
        if (arg9) {
            0x624a80998bfca8118a794c71cccca771c351158eecd425661e07056f4ed94683::cetus_balance_manager::deposit<T1>(arg3, arg5, arg12);
            0x624a80998bfca8118a794c71cccca771c351158eecd425661e07056f4ed94683::deepbookv3_utils::send_or_destory_zero_coin<T0>(arg4, arg12);
        } else {
            0x624a80998bfca8118a794c71cccca771c351158eecd425661e07056f4ed94683::cetus_balance_manager::deposit<T0>(arg3, arg4, arg12);
            0x624a80998bfca8118a794c71cccca771c351158eecd425661e07056f4ed94683::deepbookv3_utils::send_or_destory_zero_coin<T1>(arg5, arg12);
        };
        if (0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg6) > 0) {
            0x624a80998bfca8118a794c71cccca771c351158eecd425661e07056f4ed94683::cetus_balance_manager::deposit<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg3, arg6, arg12);
        } else {
            0x624a80998bfca8118a794c71cccca771c351158eecd425661e07056f4ed94683::deepbookv3_utils::send_or_destory_zero_coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg6, arg12);
        };
        0x624a80998bfca8118a794c71cccca771c351158eecd425661e07056f4ed94683::cetus_balance_manager::deposit_proxy_deep(arg3, arg0, arg12);
        let v0 = 0x624a80998bfca8118a794c71cccca771c351158eecd425661e07056f4ed94683::cetus_balance_manager::place_market_order_by_trader<T0, T1>(arg3, arg2, &arg1.trade_cap, 1107, arg7, arg8, arg9, arg10, arg11, arg12);
        if (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::fee_is_deep(&v0) && 0x624a80998bfca8118a794c71cccca771c351158eecd425661e07056f4ed94683::global_config::advance_deep_fee(arg0)) {
            0x624a80998bfca8118a794c71cccca771c351158eecd425661e07056f4ed94683::global_config::deposit_deep_fee(arg0, 0x624a80998bfca8118a794c71cccca771c351158eecd425661e07056f4ed94683::cetus_balance_manager::withdraw_refund_deep<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg3, 0x624a80998bfca8118a794c71cccca771c351158eecd425661e07056f4ed94683::global_config::advance_amount(arg0) - 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::paid_fees(&v0), arg12));
        } else {
            0x624a80998bfca8118a794c71cccca771c351158eecd425661e07056f4ed94683::global_config::deposit_deep_fee(arg0, 0x624a80998bfca8118a794c71cccca771c351158eecd425661e07056f4ed94683::cetus_balance_manager::withdraw_refund_deep<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg3, 0x624a80998bfca8118a794c71cccca771c351158eecd425661e07056f4ed94683::global_config::advance_amount(arg0), arg12));
        };
        (0x624a80998bfca8118a794c71cccca771c351158eecd425661e07056f4ed94683::cetus_balance_manager::withdraw_all<T0>(arg3, arg12), 0x624a80998bfca8118a794c71cccca771c351158eecd425661e07056f4ed94683::cetus_balance_manager::withdraw_all<T1>(arg3, arg12))
    }

    // decompiled from Move bytecode v6
}

