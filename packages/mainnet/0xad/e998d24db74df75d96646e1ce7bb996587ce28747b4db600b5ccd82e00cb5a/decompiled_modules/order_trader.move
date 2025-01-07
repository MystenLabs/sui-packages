module 0xade998d24db74df75d96646e1ce7bb996587ce28747b4db600b5ccd82e00cb5a::order_trader {
    struct AccountIdEvent has copy, drop {
        account: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::account::Account,
    }

    public fun get_account_id<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager) {
        let v0 = AccountIdEvent{account: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::account<T0, T1>(arg0, arg1)};
        0x2::event::emit<AccountIdEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

