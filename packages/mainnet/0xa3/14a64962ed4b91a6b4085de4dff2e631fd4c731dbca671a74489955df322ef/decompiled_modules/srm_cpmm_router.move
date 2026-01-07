module 0xa314a64962ed4b91a6b4085de4dff2e631fd4c731dbca671a74489955df322ef::srm_cpmm_router {
    public fun swap<T0, T1>(arg0: &mut 0x7e57926855b32baa3b3cabed89380b8d415606fdedadc18e58bd1ef1e60aee48::aggregator::SwapSession, arg1: &mut 0x5f51d02fa049194239ffeac3e446a0020e7bbfc5d9149ff888366c24b2456b1::SRMV1::Pool<T0, T1>, arg2: &0x5f51d02fa049194239ffeac3e446a0020e7bbfc5d9149ff888366c24b2456b1::SRMV1::Config, arg3: bool, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        if (arg3) {
            swap_a_to_b<T0, T1>(arg0, arg1, arg2, arg4, arg5, arg6);
        } else {
            swap_b_to_a<T0, T1>(arg0, arg1, arg2, arg4, arg5, arg6);
        };
    }

    fun swap_a_to_b<T0, T1>(arg0: &mut 0x7e57926855b32baa3b3cabed89380b8d415606fdedadc18e58bd1ef1e60aee48::aggregator::SwapSession, arg1: &mut 0x5f51d02fa049194239ffeac3e446a0020e7bbfc5d9149ff888366c24b2456b1::SRMV1::Pool<T0, T1>, arg2: &0x5f51d02fa049194239ffeac3e446a0020e7bbfc5d9149ff888366c24b2456b1::SRMV1::Config, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x7e57926855b32baa3b3cabed89380b8d415606fdedadc18e58bd1ef1e60aee48::aggregator::take_balance<T0>(arg0, arg3);
        let v1 = 0x2::balance::value<T0>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<T0>(v0);
            return
        };
        let v2 = 0x5f51d02fa049194239ffeac3e446a0020e7bbfc5d9149ff888366c24b2456b1::SRMV1::swap_a_for_b<T0, T1>(arg1, arg2, v0, 0, arg4, arg5);
        0x7e57926855b32baa3b3cabed89380b8d415606fdedadc18e58bd1ef1e60aee48::aggregator::merge_balance<T1>(arg0, v2);
        0x7e57926855b32baa3b3cabed89380b8d415606fdedadc18e58bd1ef1e60aee48::aggregator::emit_swap_event<T0, T1>(arg0, b"srm-cpmm", 0x2::object::id<0x5f51d02fa049194239ffeac3e446a0020e7bbfc5d9149ff888366c24b2456b1::SRMV1::Pool<T0, T1>>(arg1), v1, 0x2::balance::value<T1>(&v2), 0);
    }

    fun swap_b_to_a<T0, T1>(arg0: &mut 0x7e57926855b32baa3b3cabed89380b8d415606fdedadc18e58bd1ef1e60aee48::aggregator::SwapSession, arg1: &mut 0x5f51d02fa049194239ffeac3e446a0020e7bbfc5d9149ff888366c24b2456b1::SRMV1::Pool<T0, T1>, arg2: &0x5f51d02fa049194239ffeac3e446a0020e7bbfc5d9149ff888366c24b2456b1::SRMV1::Config, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x7e57926855b32baa3b3cabed89380b8d415606fdedadc18e58bd1ef1e60aee48::aggregator::take_balance<T1>(arg0, arg3);
        let v1 = 0x2::balance::value<T1>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<T1>(v0);
            return
        };
        let v2 = 0x5f51d02fa049194239ffeac3e446a0020e7bbfc5d9149ff888366c24b2456b1::SRMV1::swap_b_for_a<T0, T1>(arg1, arg2, v0, 0, arg4, arg5);
        0x7e57926855b32baa3b3cabed89380b8d415606fdedadc18e58bd1ef1e60aee48::aggregator::merge_balance<T0>(arg0, v2);
        0x7e57926855b32baa3b3cabed89380b8d415606fdedadc18e58bd1ef1e60aee48::aggregator::emit_swap_event<T1, T0>(arg0, b"srm-cpmm", 0x2::object::id<0x5f51d02fa049194239ffeac3e446a0020e7bbfc5d9149ff888366c24b2456b1::SRMV1::Pool<T0, T1>>(arg1), v1, 0x2::balance::value<T0>(&v2), 0);
    }

    // decompiled from Move bytecode v6
}

