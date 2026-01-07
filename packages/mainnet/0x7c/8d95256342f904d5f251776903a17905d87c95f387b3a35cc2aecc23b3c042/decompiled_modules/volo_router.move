module 0x7c8d95256342f904d5f251776903a17905d87c95f387b3a35cc2aecc23b3c042::volo_router {
    public fun swap(arg0: &mut 0x7e57926855b32baa3b3cabed89380b8d415606fdedadc18e58bd1ef1e60aee48::aggregator::SwapSession, arg1: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::stake_pool::StakePool, arg2: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::Metadata<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: bool, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        if (arg4) {
            swap_a_to_b(arg0, arg1, arg2, arg3, arg5, arg6);
        } else {
            swap_b_to_a(arg0, arg1, arg2, arg3, arg5, arg6);
        };
    }

    fun swap_a_to_b(arg0: &mut 0x7e57926855b32baa3b3cabed89380b8d415606fdedadc18e58bd1ef1e60aee48::aggregator::SwapSession, arg1: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::stake_pool::StakePool, arg2: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::Metadata<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x7e57926855b32baa3b3cabed89380b8d415606fdedadc18e58bd1ef1e60aee48::aggregator::take_balance<0x2::sui::SUI>(arg0, arg4);
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v0);
            return
        };
        let v2 = 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::stake_pool::stake(arg1, arg2, arg3, 0x2::coin::from_balance<0x2::sui::SUI>(v0, arg5), arg5);
        0x7e57926855b32baa3b3cabed89380b8d415606fdedadc18e58bd1ef1e60aee48::aggregator::merge_balance<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(arg0, 0x2::coin::into_balance<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(v2));
        0x7e57926855b32baa3b3cabed89380b8d415606fdedadc18e58bd1ef1e60aee48::aggregator::emit_swap_event<0x2::sui::SUI, 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(arg0, b"volo", 0x2::object::id<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::stake_pool::StakePool>(arg1), v1, 0x2::coin::value<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(&v2), 0);
    }

    fun swap_b_to_a(arg0: &mut 0x7e57926855b32baa3b3cabed89380b8d415606fdedadc18e58bd1ef1e60aee48::aggregator::SwapSession, arg1: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::stake_pool::StakePool, arg2: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::Metadata<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x7e57926855b32baa3b3cabed89380b8d415606fdedadc18e58bd1ef1e60aee48::aggregator::take_balance<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(arg0, arg4);
        let v1 = 0x2::balance::value<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(v0);
            return
        };
        let v2 = 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::stake_pool::unstake(arg1, arg2, arg3, 0x2::coin::from_balance<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(v0, arg5), arg5);
        0x7e57926855b32baa3b3cabed89380b8d415606fdedadc18e58bd1ef1e60aee48::aggregator::merge_balance<0x2::sui::SUI>(arg0, 0x2::coin::into_balance<0x2::sui::SUI>(v2));
        0x7e57926855b32baa3b3cabed89380b8d415606fdedadc18e58bd1ef1e60aee48::aggregator::emit_swap_event<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT, 0x2::sui::SUI>(arg0, b"volo", 0x2::object::id<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::stake_pool::StakePool>(arg1), v1, 0x2::coin::value<0x2::sui::SUI>(&v2), 0);
    }

    // decompiled from Move bytecode v6
}

