module 0xb66ef76147ac5bdeafb38519aae785bbe34782e6e3bad706176c5e771a65737f::arb {
    entry fun snipe_cetus_to_db<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: u64, arg4: u64, arg5: address, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 > 0 && arg3 <= 30000000000, 2);
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T0, T1>(arg2, arg3, arg7);
        let v2 = v0;
        let (v3, v4, v5) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, true, 0x2::coin::value<T1>(&v2), 0, arg6);
        let v6 = v4;
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(v2), v5);
        if (0x2::balance::value<T1>(&v6) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v6, arg7), arg5);
        } else {
            0x2::balance::destroy_zero<T1>(v6);
        };
        let (v7, v8, v9) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_base_for_quote<T0, T1>(arg2, 0x2::coin::from_balance<T0>(v3, arg7), 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg7), 0, arg6, arg7);
        let v10 = v9;
        let v11 = v8;
        0x2::coin::destroy_zero<T0>(v7);
        if (0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&v10) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>>(v10, arg5);
        } else {
            0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v10);
        };
        let v12 = 0x2::coin::value<T1>(&v11);
        let v13 = if (v12 > arg3) {
            v12 - arg3
        } else {
            0
        };
        assert!(v13 >= arg4, 1);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T0, T1>(arg2, 0x2::coin::split<T1>(&mut v11, arg3, arg7), v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v11, arg5);
    }

    entry fun snipe_db_to_cetus<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: u64, arg4: u64, arg5: address, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 > 0 && arg3 <= 30000000000, 2);
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T0, T1>(arg2, arg3, arg7);
        let (v2, v3, v4) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quote_for_base<T0, T1>(arg2, v0, 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg7), 0, arg6, arg7);
        let v5 = v4;
        let v6 = v3;
        let v7 = v2;
        if (0x2::coin::value<T1>(&v6) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v6, arg5);
        } else {
            0x2::coin::destroy_zero<T1>(v6);
        };
        if (0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&v5) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>>(v5, arg5);
        } else {
            0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v5);
        };
        let (v8, v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, true, 0x2::coin::value<T0>(&v7), 0, arg6);
        let v11 = v8;
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(v7), 0x2::balance::zero<T1>(), v10);
        if (0x2::balance::value<T0>(&v11) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v11, arg7), arg5);
        } else {
            0x2::balance::destroy_zero<T0>(v11);
        };
        let v12 = 0x2::coin::from_balance<T1>(v9, arg7);
        let v13 = 0x2::coin::value<T1>(&v12);
        let v14 = if (v13 > arg3) {
            v13 - arg3
        } else {
            0
        };
        assert!(v14 >= arg4, 1);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T0, T1>(arg2, 0x2::coin::split<T1>(&mut v12, arg3, arg7), v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v12, arg5);
    }

    // decompiled from Move bytecode v7
}

