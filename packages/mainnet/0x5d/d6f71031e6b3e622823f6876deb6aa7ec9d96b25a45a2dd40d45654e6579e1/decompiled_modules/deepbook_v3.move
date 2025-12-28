module 0x5dd6f71031e6b3e622823f6876deb6aa7ec9d96b25a45a2dd40d45654e6579e1::deepbook_v3 {
    struct Lllllll0 has store, key {
        id: 0x2::object::UID,
        llllll11: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager,
        lllll1ll: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap,
        llll1lll: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::DepositCap,
        lll1llll: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::WithdrawCap,
    }

    public fun l1l1l1l1<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg1));
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
    }

    public fun ll1ll1ll<T0, T1>(arg0: &mut Lllllll0, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quote_for_base_with_manager<T0, T1>(arg1, &mut arg0.llllll11, &arg0.lllll1ll, &arg0.llll1lll, &arg0.lll1llll, arg2, 0, arg3, arg4);
        l1l1l1l1<T1>(v1, arg4);
        v0
    }

    public fun lll1ll1l<T0, T1>(arg0: &mut Lllllll0, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_base_for_quote_with_manager<T0, T1>(arg1, &mut arg0.llllll11, &arg0.lllll1ll, &arg0.llll1lll, &arg0.lll1llll, arg2, 0, arg3, arg4);
        l1l1l1l1<T0>(v0, arg4);
        v1
    }

    public fun lll1lll1(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::new(arg0);
        let v1 = Lllllll0{
            id       : 0x2::object::new(arg0),
            llllll11 : v0,
            lllll1ll : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::mint_trade_cap(&mut v0, arg0),
            llll1lll : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::mint_deposit_cap(&mut v0, arg0),
            lll1llll : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::mint_withdraw_cap(&mut v0, arg0),
        };
        0x2::transfer::share_object<Lllllll0>(v1);
    }

    // decompiled from Move bytecode v6
}

