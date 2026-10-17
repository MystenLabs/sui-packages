module 0x8eb8be0e9d3432e979bdfbf432dc1691ea44c8c3dcb5c1c3fe7adc48aa458ba4::route {
    public fun repay_base<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_base<T0, T1>(arg0, 0x2::coin::split<T0>(&mut arg2, arg3, arg6), arg1);
        if (arg4 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg2, arg4, arg6), arg5);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, arg5);
    }

    public fun repay_quote<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T0, T1>(arg0, 0x2::coin::split<T1>(&mut arg2, arg3, arg6), arg1);
        if (arg4 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut arg2, arg4, arg6), arg5);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg2, arg5);
    }

    public fun swap_a2b<T0, T1>(arg0: &mut 0x79bd71317665179f4f6025df6c478d9ed47fd281c9335c4c51e1ba0996010519::global_config::GlobalConfig, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1, v2) = 0x79bd71317665179f4f6025df6c478d9ed47fd281c9335c4c51e1ba0996010519::deepbook_v3::swap_a2b_<T0, T1>(arg0, arg1, arg2, 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg4), arg3, arg4);
        transfer_or_destroy<T0>(v0, arg4);
        transfer_or_destroy<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v2, arg4);
        v1
    }

    public fun swap_b2a<T0, T1>(arg0: &mut 0x79bd71317665179f4f6025df6c478d9ed47fd281c9335c4c51e1ba0996010519::global_config::GlobalConfig, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1, v2) = 0x79bd71317665179f4f6025df6c478d9ed47fd281c9335c4c51e1ba0996010519::deepbook_v3::swap_b2a_<T0, T1>(arg0, arg1, arg2, 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg4), arg3, arg4);
        transfer_or_destroy<T1>(v1, arg4);
        transfer_or_destroy<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v2, arg4);
        v0
    }

    public fun swap_fx_a2b<T0, T1>(arg0: &mut 0xc3bcd467604d19ab2e2e87079e0f7dadba5a71f7c84f2b749b671e3e147dc2e::swap_router::Store, arg1: &mut 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::treasury::Treasury, arg2: &mut 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::trade_id_tracker::TradeIdTracker, arg3: &mut 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::partner_manager::PartnerRegistry, arg4: &0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::versioned::Versioned, arg5: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg6: 0x2::coin::Coin<T0>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v0, 0x2::coin::value<T0>(&arg6));
        let v1 = 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::build<T0, T1>(arg1, arg2, arg3, arg6, 18446744073709551615, 1000000, 18446744073709551615, v0, 0x1::option::none<0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::commission::Commission>(), arg4, arg8);
        let v2 = 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::start_routing<T0, T1, T1>(&mut v1, arg4, arg8);
        0xc3bcd467604d19ab2e2e87079e0f7dadba5a71f7c84f2b749b671e3e147dc2e::swap_router::swap_exact_x_to_y<T0, T1>(arg0, &mut v2, arg5, 0, arg7, arg8);
        0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::finish_routing<T0, T1, T0>(&mut v1, v2, arg4);
        0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::settle<T0, T1>(arg1, arg3, v1, arg4, arg7, arg8)
    }

    public fun swap_fx_b2a<T0, T1>(arg0: &mut 0xc3bcd467604d19ab2e2e87079e0f7dadba5a71f7c84f2b749b671e3e147dc2e::swap_router::Store, arg1: &mut 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::treasury::Treasury, arg2: &mut 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::trade_id_tracker::TradeIdTracker, arg3: &mut 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::partner_manager::PartnerRegistry, arg4: &0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::versioned::Versioned, arg5: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg6: 0x2::coin::Coin<T1>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v0, 0x2::coin::value<T1>(&arg6));
        let v1 = 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::build<T1, T0>(arg1, arg2, arg3, arg6, 18446744073709551615, 1000000, 18446744073709551615, v0, 0x1::option::none<0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::commission::Commission>(), arg4, arg8);
        let v2 = 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::start_routing<T1, T0, T0>(&mut v1, arg4, arg8);
        0xc3bcd467604d19ab2e2e87079e0f7dadba5a71f7c84f2b749b671e3e147dc2e::swap_router::swap_exact_y_to_x<T0, T1>(arg0, &mut v2, arg5, 0, arg7, arg8);
        0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::finish_routing<T1, T0, T1>(&mut v1, v2, arg4);
        0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::settle<T1, T0>(arg1, arg3, v1, arg4, arg7, arg8)
    }

    fun transfer_or_destroy<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg0) == 0) {
            0x2::coin::destroy_zero<T0>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg1));
        };
    }

    // decompiled from Move bytecode v7
}

