module 0xc575870dd6c9c5100a733402d6ce1b3874f1a0367404106d62148f76a7cb6ce6::magma_almm_router {
    public fun swap<T0, T1>(arg0: &mut 0x8bcdc1dadd7ccbb67dcea82ee496044d8f54986de20cd7cd1e70c2b40086f1f5::aggregator::SwapSession, arg1: &mut 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_pair::AlmmPair<T0, T1>, arg2: &0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::Factory, arg3: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg4: u64, arg5: bool, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        if (arg5) {
            swap_a_to_b<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg6, arg7);
        } else {
            swap_b_to_a<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg6, arg7);
        };
    }

    public fun swap_a_to_b<T0, T1>(arg0: &mut 0x8bcdc1dadd7ccbb67dcea82ee496044d8f54986de20cd7cd1e70c2b40086f1f5::aggregator::SwapSession, arg1: &mut 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_pair::AlmmPair<T0, T1>, arg2: &0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::Factory, arg3: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x8bcdc1dadd7ccbb67dcea82ee496044d8f54986de20cd7cd1e70c2b40086f1f5::aggregator::take_balance<T0>(arg0, arg4);
        let v1 = 0x2::balance::value<T0>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<T0>(v0);
            return
        };
        let (v2, v3, _) = 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_pair::swap<T0, T1>(arg1, arg2, arg3, 0x2::coin::from_balance<T0>(v0, arg6), 0x2::coin::zero<T1>(arg6), v1, 0, true, 0x2::tx_context::sender(arg6), arg5, arg6);
        let v5 = v3;
        let v6 = v2;
        let v7 = 0x2::balance::value<T0>(&v6);
        if (arg4 == 0x8bcdc1dadd7ccbb67dcea82ee496044d8f54986de20cd7cd1e70c2b40086f1f5::aggregator::max_amount_in()) {
            0x8bcdc1dadd7ccbb67dcea82ee496044d8f54986de20cd7cd1e70c2b40086f1f5::utils::transfer_balance<T0>(v6, 0x2::tx_context::sender(arg6), arg6);
        } else {
            0x8bcdc1dadd7ccbb67dcea82ee496044d8f54986de20cd7cd1e70c2b40086f1f5::aggregator::merge_balance<T0>(arg0, v6);
        };
        0x8bcdc1dadd7ccbb67dcea82ee496044d8f54986de20cd7cd1e70c2b40086f1f5::aggregator::merge_balance<T1>(arg0, v5);
        0x8bcdc1dadd7ccbb67dcea82ee496044d8f54986de20cd7cd1e70c2b40086f1f5::aggregator::emit_swap_event<T0, T1>(arg0, b"magma-almm", 0x2::object::id<0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_pair::AlmmPair<T0, T1>>(arg1), v1 - v7, 0x2::balance::value<T1>(&v5), v7);
    }

    public fun swap_b_to_a<T0, T1>(arg0: &mut 0x8bcdc1dadd7ccbb67dcea82ee496044d8f54986de20cd7cd1e70c2b40086f1f5::aggregator::SwapSession, arg1: &mut 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_pair::AlmmPair<T0, T1>, arg2: &0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::Factory, arg3: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x8bcdc1dadd7ccbb67dcea82ee496044d8f54986de20cd7cd1e70c2b40086f1f5::aggregator::take_balance<T1>(arg0, arg4);
        let v1 = 0x2::balance::value<T1>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<T1>(v0);
            return
        };
        let (v2, v3, _) = 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_pair::swap<T0, T1>(arg1, arg2, arg3, 0x2::coin::zero<T0>(arg6), 0x2::coin::from_balance<T1>(v0, arg6), 0, v1, false, 0x2::tx_context::sender(arg6), arg5, arg6);
        let v5 = v3;
        let v6 = v2;
        let v7 = 0x2::balance::value<T1>(&v5);
        if (arg4 == 0x8bcdc1dadd7ccbb67dcea82ee496044d8f54986de20cd7cd1e70c2b40086f1f5::aggregator::max_amount_in()) {
            0x8bcdc1dadd7ccbb67dcea82ee496044d8f54986de20cd7cd1e70c2b40086f1f5::utils::transfer_balance<T1>(v5, 0x2::tx_context::sender(arg6), arg6);
        } else {
            0x8bcdc1dadd7ccbb67dcea82ee496044d8f54986de20cd7cd1e70c2b40086f1f5::aggregator::merge_balance<T1>(arg0, v5);
        };
        0x8bcdc1dadd7ccbb67dcea82ee496044d8f54986de20cd7cd1e70c2b40086f1f5::aggregator::merge_balance<T0>(arg0, v6);
        0x8bcdc1dadd7ccbb67dcea82ee496044d8f54986de20cd7cd1e70c2b40086f1f5::aggregator::emit_swap_event<T1, T0>(arg0, b"magma-almm", 0x2::object::id<0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_pair::AlmmPair<T0, T1>>(arg1), v1 - v7, 0x2::balance::value<T0>(&v6), v7);
    }

    // decompiled from Move bytecode v6
}

