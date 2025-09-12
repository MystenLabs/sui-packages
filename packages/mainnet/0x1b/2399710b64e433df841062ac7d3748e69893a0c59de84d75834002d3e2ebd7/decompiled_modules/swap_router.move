module 0x1b2399710b64e433df841062ac7d3748e69893a0c59de84d75834002d3e2ebd7::swap_router {
    public fun swap_exact_x_to_y<T0, T1>(arg0: &mut 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::Route, arg1: &0x8e1144ad9fbc388c61ac30d74ebef4eb741d213e3a086da48124256290233723::config::GlobalConfig, arg2: &mut 0x8e1144ad9fbc388c61ac30d74ebef4eb741d213e3a086da48124256290233723::pool::Pool<T0, T1>, arg3: u128, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::borrow_mut_current_path<T0, T1>(arg0);
        let v1 = 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::take_coin_in<T0, T1>(v0);
        let (v2, v3, v4) = 0x8e1144ad9fbc388c61ac30d74ebef4eb741d213e3a086da48124256290233723::pool::flash_swap<T0, T1>(arg1, arg2, true, true, 0x2::coin::value<T0>(&v1), arg3, arg4);
        let v5 = v4;
        0x8e1144ad9fbc388c61ac30d74ebef4eb741d213e3a086da48124256290233723::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v1, 0x8e1144ad9fbc388c61ac30d74ebef4eb741d213e3a086da48124256290233723::pool::swap_pay_amount<T0, T1>(&v5), arg5)), 0x2::balance::zero<T1>(), v5);
        0x2::coin::join<T0>(&mut v1, 0x2::coin::from_balance<T0>(v2, arg5));
        0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::utils::refund_if_necessary<T0>(v1, 0x2::tx_context::sender(arg5));
        0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::fill_coin_out<T0, T1>(v0, 0x2::coin::from_balance<T1>(v3, arg5));
    }

    public fun swap_exact_y_to_x<T0, T1>(arg0: &mut 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::Route, arg1: &0x8e1144ad9fbc388c61ac30d74ebef4eb741d213e3a086da48124256290233723::config::GlobalConfig, arg2: &mut 0x8e1144ad9fbc388c61ac30d74ebef4eb741d213e3a086da48124256290233723::pool::Pool<T0, T1>, arg3: u128, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::borrow_mut_current_path<T1, T0>(arg0);
        let v1 = 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::take_coin_in<T1, T0>(v0);
        let (v2, v3, v4) = 0x8e1144ad9fbc388c61ac30d74ebef4eb741d213e3a086da48124256290233723::pool::flash_swap<T0, T1>(arg1, arg2, false, true, 0x2::coin::value<T1>(&v1), arg3, arg4);
        let v5 = v4;
        0x8e1144ad9fbc388c61ac30d74ebef4eb741d213e3a086da48124256290233723::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v1, 0x8e1144ad9fbc388c61ac30d74ebef4eb741d213e3a086da48124256290233723::pool::swap_pay_amount<T0, T1>(&v5), arg5)), v5);
        0x2::coin::join<T1>(&mut v1, 0x2::coin::from_balance<T1>(v3, arg5));
        0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::utils::refund_if_necessary<T1>(v1, 0x2::tx_context::sender(arg5));
        0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::fill_coin_out<T1, T0>(v0, 0x2::coin::from_balance<T0>(v2, arg5));
    }

    // decompiled from Move bytecode v6
}

