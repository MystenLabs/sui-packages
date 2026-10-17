module 0x10728af0f588c151a3c7854ca2f78d2a063151a0fc0deed6fd14526bb5a3cf41::r {
    public fun deepbook_flowx_a2b<T0, T1>(arg0: &mut 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::Session, arg1: &mut 0xc3bcd467604d19ab2e2e87079e0f7dadba5a71f7c84f2b749b671e3e147dc2e::swap_router::Store, arg2: &mut 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::treasury::Treasury, arg3: &mut 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::trade_id_tracker::TradeIdTracker, arg4: &mut 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::partner_manager::PartnerRegistry, arg5: &0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::versioned::Versioned, arg6: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg7: u8, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        if (!0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::armed(arg0)) {
            return 0x2::coin::zero<T0>(arg10)
        };
        let v0 = 0x2::coin::from_balance<T0>(0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::take<T0>(arg0, arg7), arg10);
        let (_, v2, v3) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T0, T1>(arg6);
        let v4 = 0x2::coin::value<T0>(&v0);
        let v5 = v4 - v4 % v2;
        if (v5 < v3) {
            0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::put<T1>(arg0, arg7, 0x2::balance::zero<T1>(), arg8);
            return v0
        };
        let v6 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v6, v5);
        let v7 = 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::build<T0, T1>(arg2, arg3, arg4, 0x2::coin::split<T0>(&mut v0, v5, arg10), 18446744073709551615, 1000000, 18446744073709551615, v6, 0x1::option::none<0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::commission::Commission>(), arg5, arg10);
        let v8 = 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::start_routing<T0, T1, T1>(&mut v7, arg5, arg10);
        0xc3bcd467604d19ab2e2e87079e0f7dadba5a71f7c84f2b749b671e3e147dc2e::swap_router::swap_exact_x_to_y<T0, T1>(arg1, &mut v8, arg6, 0, arg9, arg10);
        0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::finish_routing<T0, T1, T0>(&mut v7, v8, arg5);
        0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::put<T1>(arg0, arg7, 0x2::coin::into_balance<T1>(0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::settle<T0, T1>(arg2, arg4, v7, arg5, arg9, arg10)), arg8);
        v0
    }

    public fun deepbook_flowx_b2a<T0, T1>(arg0: &mut 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::Session, arg1: &mut 0xc3bcd467604d19ab2e2e87079e0f7dadba5a71f7c84f2b749b671e3e147dc2e::swap_router::Store, arg2: &mut 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::treasury::Treasury, arg3: &mut 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::trade_id_tracker::TradeIdTracker, arg4: &mut 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::partner_manager::PartnerRegistry, arg5: &0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::versioned::Versioned, arg6: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg7: u8, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        if (!0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::armed(arg0)) {
            return
        };
        let v0 = 0x2::coin::from_balance<T1>(0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::take<T1>(arg0, arg7), arg10);
        let v1 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v1, 0x2::coin::value<T1>(&v0));
        let v2 = 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::build<T1, T0>(arg2, arg3, arg4, v0, 18446744073709551615, 1000000, 18446744073709551615, v1, 0x1::option::none<0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::commission::Commission>(), arg5, arg10);
        let v3 = 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::start_routing<T1, T0, T0>(&mut v2, arg5, arg10);
        0xc3bcd467604d19ab2e2e87079e0f7dadba5a71f7c84f2b749b671e3e147dc2e::swap_router::swap_exact_y_to_x<T0, T1>(arg1, &mut v3, arg6, 0, arg9, arg10);
        0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::finish_routing<T1, T0, T1>(&mut v2, v3, arg5);
        0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::put<T0>(arg0, arg7, 0x2::coin::into_balance<T0>(0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::settle<T1, T0>(arg2, arg4, v2, arg5, arg9, arg10)), arg8);
    }

    // decompiled from Move bytecode v7
}

