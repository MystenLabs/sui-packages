module 0x1eafada0672ad3939134223bca1638124b1bd5512bf88398cf3bbc451b983c8c::deepbook_adapter {
    public fun swap_in_vault<T0, T1>(arg0: &mut 0x1eafada0672ad3939134223bca1638124b1bd5512bf88398cf3bbc451b983c8c::account::TraderAccount, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &mut 0x1eafada0672ad3939134223bca1638124b1bd5512bf88398cf3bbc451b983c8c::vault::Vault<T0>, arg3: &mut 0x1eafada0672ad3939134223bca1638124b1bd5512bf88398cf3bbc451b983c8c::vault::Vault<T1>, arg4: &mut 0x1eafada0672ad3939134223bca1638124b1bd5512bf88398cf3bbc451b983c8c::vault::Vault<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg5: bool, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0x1eafada0672ad3939134223bca1638124b1bd5512bf88398cf3bbc451b983c8c::account::assert_owner(arg0, arg9);
        if (arg5) {
            let (_, _, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quote_quantity_out<T0, T1>(arg1, arg6, arg8);
            assert!(v2 > 0, 104);
            let (v3, v4, v5) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_base_for_quote<T0, T1>(arg1, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(0x1eafada0672ad3939134223bca1638124b1bd5512bf88398cf3bbc451b983c8c::vault::borrow_balance_mut<T0>(arg2), arg6), arg9), 0x2::coin::from_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(0x2::balance::split<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(0x1eafada0672ad3939134223bca1638124b1bd5512bf88398cf3bbc451b983c8c::vault::borrow_balance_mut<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg4), v2), arg9), arg7, arg8, arg9);
            let v6 = v4;
            assert!(0x2::coin::value<T1>(&v6) >= arg7, 102);
            0x2::balance::join<T0>(0x1eafada0672ad3939134223bca1638124b1bd5512bf88398cf3bbc451b983c8c::vault::borrow_balance_mut<T0>(arg2), 0x2::coin::into_balance<T0>(v3));
            0x2::balance::join<T1>(0x1eafada0672ad3939134223bca1638124b1bd5512bf88398cf3bbc451b983c8c::vault::borrow_balance_mut<T1>(arg3), 0x2::coin::into_balance<T1>(v6));
            0x2::balance::join<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(0x1eafada0672ad3939134223bca1638124b1bd5512bf88398cf3bbc451b983c8c::vault::borrow_balance_mut<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg4), 0x2::coin::into_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v5));
        } else {
            let (_, _, v9) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_base_quantity_out<T0, T1>(arg1, arg6, arg8);
            assert!(v9 > 0, 104);
            let (v10, v11, v12) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quote_for_base<T0, T1>(arg1, 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(0x1eafada0672ad3939134223bca1638124b1bd5512bf88398cf3bbc451b983c8c::vault::borrow_balance_mut<T1>(arg3), arg6), arg9), 0x2::coin::from_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(0x2::balance::split<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(0x1eafada0672ad3939134223bca1638124b1bd5512bf88398cf3bbc451b983c8c::vault::borrow_balance_mut<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg4), v9), arg9), arg7, arg8, arg9);
            let v13 = v10;
            assert!(0x2::coin::value<T0>(&v13) >= arg7, 102);
            0x2::balance::join<T0>(0x1eafada0672ad3939134223bca1638124b1bd5512bf88398cf3bbc451b983c8c::vault::borrow_balance_mut<T0>(arg2), 0x2::coin::into_balance<T0>(v13));
            0x2::balance::join<T1>(0x1eafada0672ad3939134223bca1638124b1bd5512bf88398cf3bbc451b983c8c::vault::borrow_balance_mut<T1>(arg3), 0x2::coin::into_balance<T1>(v11));
            0x2::balance::join<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(0x1eafada0672ad3939134223bca1638124b1bd5512bf88398cf3bbc451b983c8c::vault::borrow_balance_mut<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg4), 0x2::coin::into_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v12));
        };
    }

    // decompiled from Move bytecode v6
}

