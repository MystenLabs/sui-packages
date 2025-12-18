module 0xd53303eb3c15c3c03cce839fe9148371bfe109e9a78760c017cc4225aa46167d::deepbook {
    public fun liquidate_c2d<T0, T1, T2>(arg0: &0xd53303eb3c15c3c03cce839fe9148371bfe109e9a78760c017cc4225aa46167d::liquidator::Liquidator, arg1: &mut 0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::app::ProtocolApp, arg2: 0x2::object::ID, arg3: &mut 0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::market::Market<T0>, arg4: &0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::coin_decimals_registry::CoinDecimalsRegistry, arg5: &0x117990857c81164f62e7b620657e8a0349430259c8adbd844371f9b6df297cc9::x_oracle::XOracle, arg6: u8, arg7: u64, arg8: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg9: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        0xd53303eb3c15c3c03cce839fe9148371bfe109e9a78760c017cc4225aa46167d::liquidator::ensure_caller_whitelisted(arg0, 0x2::tx_context::sender(arg11));
        0xd53303eb3c15c3c03cce839fe9148371bfe109e9a78760c017cc4225aa46167d::liquidator::transfer_to_recipient<T2>(arg0, liquidate_with_deepbook_c2d<T0, T1, T2>(arg1, 0xd53303eb3c15c3c03cce839fe9148371bfe109e9a78760c017cc4225aa46167d::liquidator::borrow_package_caller_cap(arg0), arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11));
    }

    public fun liquidate_c2d_testing<T0, T1>(arg0: 0x2::coin::Coin<T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T0>, arg2: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = liquidate_with_deepbook_c2d_testing<T0, T1>(arg0, arg1, arg2, arg3, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v0, 0x2::tx_context::sender(arg4));
    }

    public fun liquidate_d2c<T0, T1, T2>(arg0: &0xd53303eb3c15c3c03cce839fe9148371bfe109e9a78760c017cc4225aa46167d::liquidator::Liquidator, arg1: &mut 0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::app::ProtocolApp, arg2: 0x2::object::ID, arg3: &mut 0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::market::Market<T0>, arg4: &0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::coin_decimals_registry::CoinDecimalsRegistry, arg5: &0x117990857c81164f62e7b620657e8a0349430259c8adbd844371f9b6df297cc9::x_oracle::XOracle, arg6: u8, arg7: u64, arg8: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg9: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        0xd53303eb3c15c3c03cce839fe9148371bfe109e9a78760c017cc4225aa46167d::liquidator::ensure_caller_whitelisted(arg0, 0x2::tx_context::sender(arg11));
        0xd53303eb3c15c3c03cce839fe9148371bfe109e9a78760c017cc4225aa46167d::liquidator::transfer_to_recipient<T2>(arg0, liquidate_with_deepbook_d2c<T0, T1, T2>(arg1, 0xd53303eb3c15c3c03cce839fe9148371bfe109e9a78760c017cc4225aa46167d::liquidator::borrow_package_caller_cap(arg0), arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11));
    }

    public fun liquidate_d2c_testing<T0, T1>(arg0: 0x2::coin::Coin<T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = liquidate_with_deepbook_d2c_testing<T0, T1>(arg0, arg1, arg2, arg3, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v0, 0x2::tx_context::sender(arg4));
    }

    fun liquidate_with_deepbook_c2d<T0, T1, T2>(arg0: &mut 0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::app::ProtocolApp, arg1: &0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::app::PackageCallerCap, arg2: 0x2::object::ID, arg3: &mut 0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::market::Market<T0>, arg4: &0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::coin_decimals_registry::CoinDecimalsRegistry, arg5: &0x117990857c81164f62e7b620657e8a0349430259c8adbd844371f9b6df297cc9::x_oracle::XOracle, arg6: u8, arg7: u64, arg8: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg9: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        let (v0, v1) = 0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::flash_loan::borrow_flash_loan<T0, T1>(arg0, arg1, arg3, arg6, arg7, arg11);
        let v2 = v0;
        let v3 = (((0x2::coin::value<T1>(&v2) as u128) * ((5 + 10000) as u128) / 10000) as u64);
        let (v4, v5, v6) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_base_for_quote<T2, T1>(arg8, 0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::liquidate::liquidate_as_coin<T0, T1, T2>(arg0, arg1, arg2, arg3, v2, arg4, arg5, arg10, arg11), arg9, v3, arg10, arg11);
        let v7 = v6;
        let v8 = v5;
        let v9 = v4;
        0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::flash_loan::repay_flash_loan<T0, T1>(arg0, arg3, 0x2::coin::split<T1>(&mut v8, v3, arg11), v1, 0x1::option::none<0x1::string::String>(), arg11);
        if (0x2::coin::value<T1>(&v8) > 0) {
            let (v10, v11, v12) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quote_for_base<T2, T1>(arg8, v8, v7, 0, arg10, arg11);
            let v13 = v12;
            let v14 = v11;
            0x2::coin::join<T2>(&mut v9, v10);
            if (0x2::coin::value<T1>(&v14) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v14, 0x2::tx_context::sender(arg11));
            } else {
                0x2::coin::destroy_zero<T1>(v14);
            };
            if (0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&v13) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>>(v13, 0x2::tx_context::sender(arg11));
            } else {
                0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v13);
            };
        } else {
            0x2::coin::destroy_zero<T1>(v8);
            if (0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&v7) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>>(v7, 0x2::tx_context::sender(arg11));
            } else {
                0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v7);
            };
        };
        v9
    }

    fun liquidate_with_deepbook_c2d_testing<T0, T1>(arg0: 0x2::coin::Coin<T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T0>, arg2: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_base_for_quote<T1, T0>(arg1, arg0, arg2, 0, arg3, arg4);
        let v3 = v2;
        let v4 = v1;
        let v5 = v0;
        if (0x2::coin::value<T0>(&v4) > 0) {
            let (v6, v7, v8) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quote_for_base<T1, T0>(arg1, v4, v3, 0, arg3, arg4);
            let v9 = v8;
            let v10 = v7;
            0x2::coin::join<T1>(&mut v5, v6);
            if (0x2::coin::value<T0>(&v10) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v10, 0x2::tx_context::sender(arg4));
            } else {
                0x2::coin::destroy_zero<T0>(v10);
            };
            if (0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&v9) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>>(v9, 0x2::tx_context::sender(arg4));
            } else {
                0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v9);
            };
        } else {
            0x2::coin::destroy_zero<T0>(v4);
            if (0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&v3) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>>(v3, 0x2::tx_context::sender(arg4));
            } else {
                0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v3);
            };
        };
        v5
    }

    fun liquidate_with_deepbook_d2c<T0, T1, T2>(arg0: &mut 0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::app::ProtocolApp, arg1: &0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::app::PackageCallerCap, arg2: 0x2::object::ID, arg3: &mut 0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::market::Market<T0>, arg4: &0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::coin_decimals_registry::CoinDecimalsRegistry, arg5: &0x117990857c81164f62e7b620657e8a0349430259c8adbd844371f9b6df297cc9::x_oracle::XOracle, arg6: u8, arg7: u64, arg8: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg9: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        let (v0, v1) = 0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::flash_loan::borrow_flash_loan<T0, T1>(arg0, arg1, arg3, arg6, arg7, arg11);
        let v2 = v0;
        let v3 = (((0x2::coin::value<T1>(&v2) as u128) * ((5 + 10000) as u128) / 10000) as u64);
        let (v4, v5, v6) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quote_for_base<T1, T2>(arg8, 0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::liquidate::liquidate_as_coin<T0, T1, T2>(arg0, arg1, arg2, arg3, v2, arg4, arg5, arg10, arg11), arg9, v3, arg10, arg11);
        let v7 = v6;
        let v8 = v5;
        let v9 = v4;
        0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::flash_loan::repay_flash_loan<T0, T1>(arg0, arg3, 0x2::coin::split<T1>(&mut v9, v3, arg11), v1, 0x1::option::none<0x1::string::String>(), arg11);
        if (0x2::coin::value<T1>(&v9) > 0) {
            let (v10, v11, v12) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_base_for_quote<T1, T2>(arg8, v9, v7, 0, arg10, arg11);
            let v13 = v12;
            let v14 = v10;
            0x2::coin::join<T2>(&mut v8, v11);
            if (0x2::coin::value<T1>(&v14) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v14, 0x2::tx_context::sender(arg11));
            } else {
                0x2::coin::destroy_zero<T1>(v14);
            };
            if (0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&v13) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>>(v13, 0x2::tx_context::sender(arg11));
            } else {
                0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v13);
            };
        } else {
            0x2::coin::destroy_zero<T1>(v9);
            if (0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&v7) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>>(v7, 0x2::tx_context::sender(arg11));
            } else {
                0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v7);
            };
        };
        v8
    }

    fun liquidate_with_deepbook_d2c_testing<T0, T1>(arg0: 0x2::coin::Coin<T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quote_for_base<T0, T1>(arg1, arg0, arg2, 0, arg3, arg4);
        let v3 = v2;
        let v4 = v1;
        let v5 = v0;
        if (0x2::coin::value<T0>(&v5) > 0) {
            let (v6, v7, v8) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_base_for_quote<T0, T1>(arg1, v5, v3, 0, arg3, arg4);
            let v9 = v8;
            let v10 = v6;
            0x2::coin::join<T1>(&mut v4, v7);
            if (0x2::coin::value<T0>(&v10) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v10, 0x2::tx_context::sender(arg4));
            } else {
                0x2::coin::destroy_zero<T0>(v10);
            };
            if (0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&v9) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>>(v9, 0x2::tx_context::sender(arg4));
            } else {
                0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v9);
            };
        } else {
            0x2::coin::destroy_zero<T0>(v5);
            if (0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&v3) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>>(v3, 0x2::tx_context::sender(arg4));
            } else {
                0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v3);
            };
        };
        v4
    }

    // decompiled from Move bytecode v6
}

