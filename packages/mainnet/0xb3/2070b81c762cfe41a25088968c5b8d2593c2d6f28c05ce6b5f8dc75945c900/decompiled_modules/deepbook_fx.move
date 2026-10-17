module 0xb32070b81c762cfe41a25088968c5b8d2593c2d6f28c05ce6b5f8dc75945c900::deepbook_fx {
    public fun buy_base<T0, T1>(arg0: &mut 0xc3bcd467604d19ab2e2e87079e0f7dadba5a71f7c84f2b749b671e3e147dc2e::swap_router::Store, arg1: &mut 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::treasury::Treasury, arg2: &mut 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::trade_id_tracker::TradeIdTracker, arg3: &mut 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::partner_manager::PartnerRegistry, arg4: &0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::versioned::Versioned, arg5: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg6: 0x2::balance::Balance<T1>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = 0x2::balance::value<T1>(&arg6);
        let (v1, v2) = if (v0 == 0) {
            (0, 0)
        } else {
            let (v3, v4, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quantity_out<T0, T1>(arg5, 0, v0, arg7);
            (v3, v4)
        };
        if (v1 == 0) {
            return (0x2::balance::zero<T0>(), arg6)
        };
        let v6 = v0 - v2;
        let v7 = v6;
        if (v2 > 0) {
            let (v8, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quantity_out<T0, T1>(arg5, 0, v6, arg7);
            if (v8 != v1) {
                v7 = v0;
            };
        };
        let v11 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v11, v7);
        let v12 = 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::build<T1, T0>(arg1, arg2, arg3, 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg6, v7), arg8), 18446744073709551615, 1000000, 18446744073709551615, v11, 0x1::option::none<0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::commission::Commission>(), arg4, arg8);
        let v13 = 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::start_routing<T1, T0, T0>(&mut v12, arg4, arg8);
        0xc3bcd467604d19ab2e2e87079e0f7dadba5a71f7c84f2b749b671e3e147dc2e::swap_router::swap_exact_y_to_x<T0, T1>(arg0, &mut v13, arg5, 0, arg7, arg8);
        0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::finish_routing<T1, T0, T1>(&mut v12, v13, arg4);
        (0x2::coin::into_balance<T0>(0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::settle<T1, T0>(arg1, arg3, v12, arg4, arg7, arg8)), arg6)
    }

    public fun peek_buy_base<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: u64) : u64 {
        if (arg2 == 0) {
            return 0
        };
        let (v0, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quantity_out<T0, T1>(arg0, 0, arg2, arg1);
        v0
    }

    public fun peek_sell_base<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: u64) : u64 {
        if (arg2 == 0) {
            return 0
        };
        let (_, v1, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quantity_out<T0, T1>(arg0, arg2, 0, arg1);
        v1
    }

    public fun sell_base<T0, T1>(arg0: &mut 0xc3bcd467604d19ab2e2e87079e0f7dadba5a71f7c84f2b749b671e3e147dc2e::swap_router::Store, arg1: &mut 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::treasury::Treasury, arg2: &mut 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::trade_id_tracker::TradeIdTracker, arg3: &mut 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::partner_manager::PartnerRegistry, arg4: &0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::versioned::Versioned, arg5: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg6: 0x2::balance::Balance<T0>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T0>) {
        let v0 = 0x2::balance::value<T0>(&arg6);
        let v1 = if (v0 == 0) {
            0
        } else {
            let (v2, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quantity_out<T0, T1>(arg5, v0, 0, arg7);
            v2
        };
        let v5 = v0 - v1;
        if (v5 == 0) {
            return (0x2::balance::zero<T1>(), arg6)
        };
        let v6 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v6, v5);
        let v7 = 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::build<T0, T1>(arg1, arg2, arg3, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg6, v5), arg8), 18446744073709551615, 1000000, 18446744073709551615, v6, 0x1::option::none<0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::commission::Commission>(), arg4, arg8);
        let v8 = 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::start_routing<T0, T1, T1>(&mut v7, arg4, arg8);
        0xc3bcd467604d19ab2e2e87079e0f7dadba5a71f7c84f2b749b671e3e147dc2e::swap_router::swap_exact_x_to_y<T0, T1>(arg0, &mut v8, arg5, 0, arg7, arg8);
        0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::finish_routing<T0, T1, T0>(&mut v7, v8, arg4);
        (0x2::coin::into_balance<T1>(0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::settle<T0, T1>(arg1, arg3, v7, arg4, arg7, arg8)), arg6)
    }

    // decompiled from Move bytecode v7
}

