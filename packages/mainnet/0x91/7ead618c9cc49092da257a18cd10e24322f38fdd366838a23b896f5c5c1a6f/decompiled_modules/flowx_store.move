module 0x917ead618c9cc49092da257a18cd10e24322f38fdd366838a23b896f5c5c1a6f::flowx_store {
    public fun buy_base<T0, T1, T2>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T0>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg2: &mut 0xc3bcd467604d19ab2e2e87079e0f7dadba5a71f7c84f2b749b671e3e147dc2e::swap_router::Store, arg3: &mut 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::treasury::Treasury, arg4: &mut 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::trade_id_tracker::TradeIdTracker, arg5: &mut 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::partner_manager::PartnerRegistry, arg6: &0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::versioned::Versioned, arg7: 0x2::balance::Balance<T2>, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T2>) {
        let v0 = 0x2::balance::value<T2>(&arg7);
        charge<T0, T1, T2>(arg0, arg1, v0, false, arg8, arg10);
        let v1 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v1, v0);
        let v2 = 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::build<T2, T1>(arg3, arg4, arg5, 0x2::coin::from_balance<T2>(arg7, arg11), 18446744073709551615, 1000000, arg9, v1, 0x1::option::none<0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::commission::Commission>(), arg6, arg11);
        let v3 = 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::start_routing<T2, T1, T1>(&mut v2, arg6, arg11);
        0xc3bcd467604d19ab2e2e87079e0f7dadba5a71f7c84f2b749b671e3e147dc2e::swap_router::swap_exact_y_to_x<T1, T2>(arg2, &mut v3, arg1, 0, arg10, arg11);
        0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::finish_routing<T2, T1, T2>(&mut v2, v3, arg6);
        let v4 = 0x2::coin::into_balance<T1>(0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::settle<T2, T1>(arg3, arg5, v2, arg6, arg10, arg11));
        0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::record_leg<T0>(arg0, 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>>(arg1), false, 0x2::balance::value<T1>(&v4));
        (v4, 0x2::balance::zero<T2>())
    }

    fun charge<T0, T1, T2>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T0>, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg2: u64, arg3: bool, arg4: u64, arg5: &0x2::clock::Clock) {
        assert!(arg4 > 0, 1);
        let (v0, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_trade_params<T1, T2>(arg1);
        let (v3, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_trade_params_next<T1, T2>(arg1);
        assert!(v0 > 0, 1);
        let v6 = if (arg3) {
            let (v7, v8, v9) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quote_quantity_out<T1, T2>(arg1, arg2, arg5);
            let _ = v8;
            let _ = v7;
            v9
        } else {
            let (v12, v13, v14) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_base_quantity_out<T1, T2>(arg1, arg2, arg5);
            let _ = v13;
            let _ = v12;
            v14
        };
        let v15 = 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::search::ceil_mul_div(v6 + 1, 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::search::checked_sum(0x1::u64::max(v0, v3), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::max_additional_taker_fee()), v0);
        let v16 = 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::search::checked_sum(v15, 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::search::ceil_mul_div(v15, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::referral_max_multiplier(), 1000000000));
        assert!(v16 <= 2000000000, 1);
        0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::add_cost<T0>(arg0, 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::search::ceil_mul_div(v16, arg4, 1000000000));
    }

    public fun sell_base<T0, T1, T2>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T0>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg2: &mut 0xc3bcd467604d19ab2e2e87079e0f7dadba5a71f7c84f2b749b671e3e147dc2e::swap_router::Store, arg3: &mut 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::treasury::Treasury, arg4: &mut 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::trade_id_tracker::TradeIdTracker, arg5: &mut 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::partner_manager::PartnerRegistry, arg6: &0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::versioned::Versioned, arg7: 0x2::balance::Balance<T1>, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T2>, 0x2::balance::Balance<T1>) {
        let v0 = 0x2::balance::value<T1>(&arg7);
        charge<T0, T1, T2>(arg0, arg1, v0, true, arg8, arg10);
        let v1 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v1, v0);
        let v2 = 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::build<T1, T2>(arg3, arg4, arg5, 0x2::coin::from_balance<T1>(arg7, arg11), 18446744073709551615, 1000000, arg9, v1, 0x1::option::none<0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::commission::Commission>(), arg6, arg11);
        let v3 = 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::start_routing<T1, T2, T2>(&mut v2, arg6, arg11);
        0xc3bcd467604d19ab2e2e87079e0f7dadba5a71f7c84f2b749b671e3e147dc2e::swap_router::swap_exact_x_to_y<T1, T2>(arg2, &mut v3, arg1, 0, arg10, arg11);
        0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::finish_routing<T1, T2, T1>(&mut v2, v3, arg6);
        let v4 = 0x2::coin::into_balance<T2>(0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::settle<T1, T2>(arg3, arg5, v2, arg6, arg10, arg11));
        0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::record_leg<T0>(arg0, 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>>(arg1), true, 0x2::balance::value<T2>(&v4));
        (v4, 0x2::balance::zero<T1>())
    }

    // decompiled from Move bytecode v7
}

