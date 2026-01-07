module 0xa5dc665dc3c1c846a6d1e00811c84cae3510c839ab4dc0873f85dc8908d0606::sevenk_fun_router {
    public fun swap<T0>(arg0: &mut 0x7e57926855b32baa3b3cabed89380b8d415606fdedadc18e58bd1ef1e60aee48::aggregator::SwapSession, arg1: &mut 0xc42fd2cde04281a5d2659e5c96c89ba625ddeef9b622713c3d6aa1efd5ea21ab::fun_7k::Configuration, arg2: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg3: &0x2::clock::Clock, arg4: bool, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        if (arg4) {
            swap_a_to_b<T0>(arg0, arg1, arg2, arg3, arg5, arg6);
        } else {
            swap_b_to_a<T0>(arg0, arg1, arg5, arg6);
        };
    }

    fun handle_locked_coin<T0>(arg0: 0xc42fd2cde04281a5d2659e5c96c89ba625ddeef9b622713c3d6aa1efd5ea21ab::locked_coin::LockedCoin<T0>, arg1: &0x2::tx_context::TxContext) {
        if (0xc42fd2cde04281a5d2659e5c96c89ba625ddeef9b622713c3d6aa1efd5ea21ab::locked_coin::value<T0>(&arg0) == 0) {
            0xc42fd2cde04281a5d2659e5c96c89ba625ddeef9b622713c3d6aa1efd5ea21ab::locked_coin::destroy_zero<T0>(arg0);
        } else {
            0x2::transfer::public_transfer<0xc42fd2cde04281a5d2659e5c96c89ba625ddeef9b622713c3d6aa1efd5ea21ab::locked_coin::LockedCoin<T0>>(arg0, 0x2::tx_context::sender(arg1));
        };
    }

    public fun swap_a_to_b<T0>(arg0: &mut 0x7e57926855b32baa3b3cabed89380b8d415606fdedadc18e58bd1ef1e60aee48::aggregator::SwapSession, arg1: &mut 0xc42fd2cde04281a5d2659e5c96c89ba625ddeef9b622713c3d6aa1efd5ea21ab::fun_7k::Configuration, arg2: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg3: &0x2::clock::Clock, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x7e57926855b32baa3b3cabed89380b8d415606fdedadc18e58bd1ef1e60aee48::aggregator::take_balance<0x2::sui::SUI>(arg0, arg4);
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v0);
            return
        };
        let v2 = 0x2::coin::from_balance<0x2::sui::SUI>(v0, arg5);
        let (v3, v4) = 0xc42fd2cde04281a5d2659e5c96c89ba625ddeef9b622713c3d6aa1efd5ea21ab::fun_7k::buy_<T0>(arg1, &mut v2, true, 0, arg3, arg2, arg5);
        let v5 = v3;
        handle_locked_coin<T0>(v4, arg5);
        0x7e57926855b32baa3b3cabed89380b8d415606fdedadc18e58bd1ef1e60aee48::aggregator::merge_balance<T0>(arg0, 0x2::coin::into_balance<T0>(v5));
        let v6 = 0x2::coin::value<0x2::sui::SUI>(&v2);
        if (arg4 == 0x7e57926855b32baa3b3cabed89380b8d415606fdedadc18e58bd1ef1e60aee48::aggregator::max_amount_in()) {
            0x7e57926855b32baa3b3cabed89380b8d415606fdedadc18e58bd1ef1e60aee48::utils::transfer_balance<0x2::sui::SUI>(0x2::coin::into_balance<0x2::sui::SUI>(v2), 0x2::tx_context::sender(arg5), arg5);
        } else {
            0x7e57926855b32baa3b3cabed89380b8d415606fdedadc18e58bd1ef1e60aee48::aggregator::merge_balance<0x2::sui::SUI>(arg0, 0x2::coin::into_balance<0x2::sui::SUI>(v2));
        };
        0x7e57926855b32baa3b3cabed89380b8d415606fdedadc18e58bd1ef1e60aee48::aggregator::emit_swap_event<0x2::sui::SUI, T0>(arg0, b"sevenk-fun", 0x2::object::id<0xc42fd2cde04281a5d2659e5c96c89ba625ddeef9b622713c3d6aa1efd5ea21ab::fun_7k::Configuration>(arg1), v1 - v6, 0x2::coin::value<T0>(&v5), v6);
    }

    public fun swap_b_to_a<T0>(arg0: &mut 0x7e57926855b32baa3b3cabed89380b8d415606fdedadc18e58bd1ef1e60aee48::aggregator::SwapSession, arg1: &mut 0xc42fd2cde04281a5d2659e5c96c89ba625ddeef9b622713c3d6aa1efd5ea21ab::fun_7k::Configuration, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x7e57926855b32baa3b3cabed89380b8d415606fdedadc18e58bd1ef1e60aee48::aggregator::take_balance<T0>(arg0, arg2);
        let v1 = 0x2::balance::value<T0>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<T0>(v0);
            return
        };
        let v2 = 0x2::coin::from_balance<T0>(v0, arg3);
        let v3 = 0xc42fd2cde04281a5d2659e5c96c89ba625ddeef9b622713c3d6aa1efd5ea21ab::fun_7k::sell_<T0>(arg1, &mut v2, true, 0, arg3);
        0x7e57926855b32baa3b3cabed89380b8d415606fdedadc18e58bd1ef1e60aee48::aggregator::merge_balance<0x2::sui::SUI>(arg0, 0x2::coin::into_balance<0x2::sui::SUI>(v3));
        let v4 = 0x2::coin::value<T0>(&v2);
        if (arg2 == 0x7e57926855b32baa3b3cabed89380b8d415606fdedadc18e58bd1ef1e60aee48::aggregator::max_amount_in()) {
            0x7e57926855b32baa3b3cabed89380b8d415606fdedadc18e58bd1ef1e60aee48::utils::transfer_balance<T0>(0x2::coin::into_balance<T0>(v2), 0x2::tx_context::sender(arg3), arg3);
        } else {
            0x7e57926855b32baa3b3cabed89380b8d415606fdedadc18e58bd1ef1e60aee48::aggregator::merge_balance<T0>(arg0, 0x2::coin::into_balance<T0>(v2));
        };
        0x7e57926855b32baa3b3cabed89380b8d415606fdedadc18e58bd1ef1e60aee48::aggregator::emit_swap_event<T0, 0x2::sui::SUI>(arg0, b"sevenk-fun", 0x2::object::id<0xc42fd2cde04281a5d2659e5c96c89ba625ddeef9b622713c3d6aa1efd5ea21ab::fun_7k::Configuration>(arg1), v1 - v4, 0x2::coin::value<0x2::sui::SUI>(&v3), v4);
    }

    // decompiled from Move bytecode v6
}

