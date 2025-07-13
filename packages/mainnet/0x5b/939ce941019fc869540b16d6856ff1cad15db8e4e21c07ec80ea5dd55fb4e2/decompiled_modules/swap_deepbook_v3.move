module 0x5b939ce941019fc869540b16d6856ff1cad15db8e4e21c07ec80ea5dd55fb4e2::swap_deepbook_v3 {
    public fun swap<T0, T1, T2, T3>(arg0: 0x1::option::Option<0x2::coin::Coin<T0>>, arg1: 0x1::option::Option<0x2::coin::Coin<T1>>, arg2: 0x1::option::Option<0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>>, arg3: 0x1::option::Option<0x2::coin::Coin<0x2::sui::SUI>>, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP, 0x2::sui::SUI>, arg6: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg7: &0x5b939ce941019fc869540b16d6856ff1cad15db8e4e21c07ec80ea5dd55fb4e2::swap_transaction::SwapTransaction<T2, T3>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0x5b939ce941019fc869540b16d6856ff1cad15db8e4e21c07ec80ea5dd55fb4e2::utils::only_one_some<0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, 0x2::coin::Coin<0x2::sui::SUI>>(&arg2, &arg3);
        let v0 = if (0x1::option::is_some<0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>>(&arg2)) {
            0x1::option::destroy_none<0x2::coin::Coin<0x2::sui::SUI>>(arg3);
            0x1::option::destroy_some<0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>>(arg2)
        } else {
            0x1::option::destroy_none<0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>>(arg2);
            let v1 = 0x2::coin::into_balance<0x2::sui::SUI>(0x1::option::destroy_some<0x2::coin::Coin<0x2::sui::SUI>>(arg3));
            let (v2, v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP, 0x2::sui::SUI>(arg6, arg5, false, true, 0x2::balance::value<0x2::sui::SUI>(&v1), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price(), arg8);
            0x5b939ce941019fc869540b16d6856ff1cad15db8e4e21c07ec80ea5dd55fb4e2::utils::transfer_or_destroy<0x2::sui::SUI>(0x2::coin::from_balance<0x2::sui::SUI>(v3, arg9), arg9);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP, 0x2::sui::SUI>(arg6, arg5, 0x2::balance::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(), v1, v4);
            0x2::coin::from_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v2, arg9)
        };
        let (v5, v6) = 0x5b939ce941019fc869540b16d6856ff1cad15db8e4e21c07ec80ea5dd55fb4e2::utils::parse_amount_and_direction<T0, T1>(&arg0, &arg1);
        let v7 = if (0x1::option::is_some<0x2::coin::Coin<T0>>(&arg0)) {
            0x1::option::destroy_some<0x2::coin::Coin<T0>>(arg0)
        } else {
            0x1::option::destroy_none<0x2::coin::Coin<T0>>(arg0);
            0x2::coin::zero<T0>(arg9)
        };
        let v8 = if (0x1::option::is_some<0x2::coin::Coin<T1>>(&arg1)) {
            0x1::option::destroy_some<0x2::coin::Coin<T1>>(arg1)
        } else {
            0x1::option::destroy_none<0x2::coin::Coin<T1>>(arg1);
            0x2::coin::zero<T1>(arg9)
        };
        let (v9, v10, v11) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quantity<T0, T1>(arg4, v7, v8, v0, 0, arg8, arg9);
        let v12 = v10;
        let v13 = v9;
        0x5b939ce941019fc869540b16d6856ff1cad15db8e4e21c07ec80ea5dd55fb4e2::utils::transfer_or_destroy<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v11, arg9);
        let v14 = 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg4);
        let v15 = if (v6) {
            0x2::coin::value<T1>(&v12)
        } else {
            0x2::coin::value<T0>(&v13)
        };
        0x5b939ce941019fc869540b16d6856ff1cad15db8e4e21c07ec80ea5dd55fb4e2::swap_event::emit_common_swap<T0, T1>(0x5b939ce941019fc869540b16d6856ff1cad15db8e4e21c07ec80ea5dd55fb4e2::consts::DEX_DEEPBOOK_V3(), 0x2::object::id_to_address(&v14), v6, v5, v15, true);
        (v13, v12)
    }

    public fun swap_a2b<T0, T1, T2, T3>(arg0: 0x1::option::Option<0x2::coin::Coin<T0>>, arg1: 0x1::option::Option<0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>>, arg2: 0x1::option::Option<0x2::coin::Coin<0x2::sui::SUI>>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP, 0x2::sui::SUI>, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &0x5b939ce941019fc869540b16d6856ff1cad15db8e4e21c07ec80ea5dd55fb4e2::swap_transaction::SwapTransaction<T2, T3>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1) = swap<T0, T1, T2, T3>(arg0, 0x1::option::none<0x2::coin::Coin<T1>>(), arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        0x5b939ce941019fc869540b16d6856ff1cad15db8e4e21c07ec80ea5dd55fb4e2::utils::transfer_or_destroy<T0>(v0, arg8);
        v1
    }

    public fun swap_b2a<T0, T1, T2, T3>(arg0: 0x1::option::Option<0x2::coin::Coin<T0>>, arg1: 0x1::option::Option<0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>>, arg2: 0x1::option::Option<0x2::coin::Coin<0x2::sui::SUI>>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP, 0x2::sui::SUI>, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &0x5b939ce941019fc869540b16d6856ff1cad15db8e4e21c07ec80ea5dd55fb4e2::swap_transaction::SwapTransaction<T2, T3>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1) = swap<T0, T1, T2, T3>(arg0, 0x1::option::none<0x2::coin::Coin<T1>>(), arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        0x5b939ce941019fc869540b16d6856ff1cad15db8e4e21c07ec80ea5dd55fb4e2::utils::transfer_or_destroy<T1>(v1, arg8);
        v0
    }

    // decompiled from Move bytecode v6
}

