module 0x950f94d33060c0575389c9f84fabab1e140776c6c84389d4237a0c2687a7adc9::magma_almm_router {
    public fun swap<T0, T1>(arg0: &mut 0x7e57926855b32baa3b3cabed89380b8d415606fdedadc18e58bd1ef1e60aee48::aggregator::SwapSession, arg1: &mut 0x532bf64e6f0bf702353387d53a28a3239249f47c39d58954f2c0a1f9f4436c20::almm_pair::AlmmPair<T0, T1>, arg2: &0x532bf64e6f0bf702353387d53a28a3239249f47c39d58954f2c0a1f9f4436c20::almm_factory::Factory, arg3: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg4: u64, arg5: bool, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        if (arg5) {
            swap_a_to_b<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg6, arg7);
        } else {
            swap_b_to_a<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg6, arg7);
        };
    }

    public fun swap_a_to_b<T0, T1>(arg0: &mut 0x7e57926855b32baa3b3cabed89380b8d415606fdedadc18e58bd1ef1e60aee48::aggregator::SwapSession, arg1: &mut 0x532bf64e6f0bf702353387d53a28a3239249f47c39d58954f2c0a1f9f4436c20::almm_pair::AlmmPair<T0, T1>, arg2: &0x532bf64e6f0bf702353387d53a28a3239249f47c39d58954f2c0a1f9f4436c20::almm_factory::Factory, arg3: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x7e57926855b32baa3b3cabed89380b8d415606fdedadc18e58bd1ef1e60aee48::aggregator::take_balance<T0>(arg0, arg4);
        let v1 = 0x2::balance::value<T0>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<T0>(v0);
            return
        };
        let (v2, v3, _) = 0x532bf64e6f0bf702353387d53a28a3239249f47c39d58954f2c0a1f9f4436c20::almm_pair::swap<T0, T1>(arg1, arg2, arg3, 0x2::coin::from_balance<T0>(v0, arg6), 0x2::coin::zero<T1>(arg6), v1, 0, true, 0x2::tx_context::sender(arg6), arg5, arg6);
        let v5 = v3;
        let v6 = v2;
        let v7 = 0x2::balance::value<T0>(&v6);
        if (arg4 == 0x7e57926855b32baa3b3cabed89380b8d415606fdedadc18e58bd1ef1e60aee48::aggregator::max_amount_in()) {
            0x7e57926855b32baa3b3cabed89380b8d415606fdedadc18e58bd1ef1e60aee48::utils::transfer_balance<T0>(v6, 0x2::tx_context::sender(arg6), arg6);
        } else {
            0x7e57926855b32baa3b3cabed89380b8d415606fdedadc18e58bd1ef1e60aee48::aggregator::merge_balance<T0>(arg0, v6);
        };
        0x7e57926855b32baa3b3cabed89380b8d415606fdedadc18e58bd1ef1e60aee48::aggregator::merge_balance<T1>(arg0, v5);
        0x7e57926855b32baa3b3cabed89380b8d415606fdedadc18e58bd1ef1e60aee48::aggregator::emit_swap_event<T0, T1>(arg0, b"magma-almm", 0x2::object::id<0x532bf64e6f0bf702353387d53a28a3239249f47c39d58954f2c0a1f9f4436c20::almm_pair::AlmmPair<T0, T1>>(arg1), v1 - v7, 0x2::balance::value<T1>(&v5), v7);
    }

    public fun swap_b_to_a<T0, T1>(arg0: &mut 0x7e57926855b32baa3b3cabed89380b8d415606fdedadc18e58bd1ef1e60aee48::aggregator::SwapSession, arg1: &mut 0x532bf64e6f0bf702353387d53a28a3239249f47c39d58954f2c0a1f9f4436c20::almm_pair::AlmmPair<T0, T1>, arg2: &0x532bf64e6f0bf702353387d53a28a3239249f47c39d58954f2c0a1f9f4436c20::almm_factory::Factory, arg3: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x7e57926855b32baa3b3cabed89380b8d415606fdedadc18e58bd1ef1e60aee48::aggregator::take_balance<T1>(arg0, arg4);
        let v1 = 0x2::balance::value<T1>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<T1>(v0);
            return
        };
        let (v2, v3, _) = 0x532bf64e6f0bf702353387d53a28a3239249f47c39d58954f2c0a1f9f4436c20::almm_pair::swap<T0, T1>(arg1, arg2, arg3, 0x2::coin::zero<T0>(arg6), 0x2::coin::from_balance<T1>(v0, arg6), v1, 0, false, 0x2::tx_context::sender(arg6), arg5, arg6);
        let v5 = v3;
        let v6 = v2;
        let v7 = 0x2::balance::value<T1>(&v5);
        if (arg4 == 0x7e57926855b32baa3b3cabed89380b8d415606fdedadc18e58bd1ef1e60aee48::aggregator::max_amount_in()) {
            0x7e57926855b32baa3b3cabed89380b8d415606fdedadc18e58bd1ef1e60aee48::utils::transfer_balance<T1>(v5, 0x2::tx_context::sender(arg6), arg6);
        } else {
            0x7e57926855b32baa3b3cabed89380b8d415606fdedadc18e58bd1ef1e60aee48::aggregator::merge_balance<T1>(arg0, v5);
        };
        0x7e57926855b32baa3b3cabed89380b8d415606fdedadc18e58bd1ef1e60aee48::aggregator::merge_balance<T0>(arg0, v6);
        0x7e57926855b32baa3b3cabed89380b8d415606fdedadc18e58bd1ef1e60aee48::aggregator::emit_swap_event<T1, T0>(arg0, b"magma-almm", 0x2::object::id<0x532bf64e6f0bf702353387d53a28a3239249f47c39d58954f2c0a1f9f4436c20::almm_pair::AlmmPair<T0, T1>>(arg1), v1 - v7, 0x2::balance::value<T0>(&v6), v7);
    }

    // decompiled from Move bytecode v6
}

