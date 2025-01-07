module 0x8cf56960f2085caa55b05d2f557503984af031acc03e050d2fe3943a222df3fc::jk {
    public fun deepbookswapv3_0<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x64704f2f04f580cdfde7583bc35de88d4d47fe7280aa9d7939cd54da44cb8cdd::pool::Pool<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg3: &0x64704f2f04f580cdfde7583bc35de88d4d47fe7280aa9d7939cd54da44cb8cdd::pool::AccessList, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::zero<T1>(arg7);
        let v1 = 0x64704f2f04f580cdfde7583bc35de88d4d47fe7280aa9d7939cd54da44cb8cdd::pool::loan<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg3, arg2, 10000000000, arg7);
        let (v2, v3, v4) = swap_exact_quantity<T0, T1>(arg0, arg1, arg4, v0, v1, arg5, arg6, arg7);
        0x64704f2f04f580cdfde7583bc35de88d4d47fe7280aa9d7939cd54da44cb8cdd::pool::repay<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg2, v4, 0, arg7);
        transfer_or_destroy_zero<T0>(v2, 0x2::tx_context::sender(arg7));
        v3
    }

    public fun deepbookswapv3_1<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x64704f2f04f580cdfde7583bc35de88d4d47fe7280aa9d7939cd54da44cb8cdd::pool::Pool<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg3: &0x64704f2f04f580cdfde7583bc35de88d4d47fe7280aa9d7939cd54da44cb8cdd::pool::AccessList, arg4: 0x2::coin::Coin<T1>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::zero<T0>(arg7);
        let v1 = 0x64704f2f04f580cdfde7583bc35de88d4d47fe7280aa9d7939cd54da44cb8cdd::pool::loan<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg3, arg2, 10000000000, arg7);
        let (v2, v3, v4) = swap_exact_quantity<T0, T1>(arg0, arg1, v0, arg4, v1, arg5, arg6, arg7);
        0x64704f2f04f580cdfde7583bc35de88d4d47fe7280aa9d7939cd54da44cb8cdd::pool::repay<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg2, v4, 0, arg7);
        transfer_or_destroy_zero<T1>(v3, 0x2::tx_context::sender(arg7));
        v2
    }

    public fun swap_exact_quantity<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>) {
        let v0 = 0x2::coin::value<T0>(&arg2);
        let v1 = v0;
        let v2 = 0x2::coin::value<T1>(&arg3);
        assert!(v0 > 0 != v2 > 0, 6);
        let v3 = v2 > 0;
        if (v3) {
            let (v4, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quantity_out<T0, T1>(arg0, 0, v2, arg6);
            v1 = v4;
        };
        let v7 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg1, arg7);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T0>(arg1, arg2, arg7);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T1>(arg1, arg3, arg7);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg1, arg4, arg7);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_market_order<T0, T1>(arg0, arg1, &v7, 0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::self_matching_allowed(), v1 - v1 % arg5, v3, 0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg4) > 0, arg6, arg7);
        (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw_all<T0>(arg1, arg7), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw_all<T1>(arg1, arg7), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw_all<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg1, arg7))
    }

    public fun transfer_coins_with_threshold_2<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg0) >= arg1, 10000000001);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg2));
    }

    public fun transfer_or_destroy_zero<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address) {
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
    }

    // decompiled from Move bytecode v6
}

