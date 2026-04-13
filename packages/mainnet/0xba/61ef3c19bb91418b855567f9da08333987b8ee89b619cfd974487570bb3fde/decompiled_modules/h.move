module 0xba61ef3c19bb91418b855567f9da08333987b8ee89b619cfd974487570bb3fde::h {
    struct H has key {
        id: 0x2::object::UID,
        w: address,
        a: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::WithdrawCap,
        b: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::DepositCap,
    }

    public entry fun new(arg0: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::WithdrawCap, arg1: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::DepositCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = H{
            id : 0x2::object::new(arg2),
            w  : 0x2::tx_context::sender(arg2),
            a  : arg0,
            b  : arg1,
        };
        0x2::transfer::share_object<H>(v0);
    }

    public entry fun chg(arg0: &mut H, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.w, 202);
        arg0.w = arg1;
    }

    public fun o(arg0: &H) : address {
        arg0.w
    }

    public fun out<T0>(arg0: &H, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::tx_context::sender(arg3) == arg0.w, 202);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw_with_cap<T0>(arg1, &arg0.a, arg2, arg3)
    }

    public fun put<T0>(arg0: &H, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.w, 202);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit_with_cap<T0>(arg1, &arg0.b, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

