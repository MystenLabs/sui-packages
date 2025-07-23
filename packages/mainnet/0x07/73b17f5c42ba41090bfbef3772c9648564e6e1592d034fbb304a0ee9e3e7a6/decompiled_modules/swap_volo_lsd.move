module 0x773b17f5c42ba41090bfbef3772c9648564e6e1592d034fbb304a0ee9e3e7a6::swap_volo_lsd {
    public fun swap_a2b<T0, T1>(arg0: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::stake_pool::StakePool, arg1: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::Metadata<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x1a830340e1caed73881c51f13fd3c1409153879493b56688118012c25b658512::swap_transaction::SwapTransaction<T0, T1>, arg5: &0x1a830340e1caed73881c51f13fd3c1409153879493b56688118012c25b658512::state::State, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT> {
        let v0 = 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::stake_pool::stake(arg0, arg1, arg2, arg3, arg6);
        let v1 = 0x2::object::id<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::stake_pool::StakePool>(arg0);
        0x773b17f5c42ba41090bfbef3772c9648564e6e1592d034fbb304a0ee9e3e7a6::swap_event::emit_common_swap<0x2::sui::SUI, 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(0x1a830340e1caed73881c51f13fd3c1409153879493b56688118012c25b658512::consts::LSD_VOLO(), 0x2::object::id_to_address(&v1), true, 0x2::coin::value<0x2::sui::SUI>(&arg3), 0x2::coin::value<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(&v0), true);
        v0
    }

    public fun swap_b2a<T0, T1>(arg0: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::stake_pool::StakePool, arg1: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::Metadata<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: 0x2::coin::Coin<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg4: &0x1a830340e1caed73881c51f13fd3c1409153879493b56688118012c25b658512::swap_transaction::SwapTransaction<T0, T1>, arg5: &0x1a830340e1caed73881c51f13fd3c1409153879493b56688118012c25b658512::state::State, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::stake_pool::unstake(arg0, arg1, arg2, arg3, arg6);
        let v1 = 0x2::object::id<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::stake_pool::StakePool>(arg0);
        0x773b17f5c42ba41090bfbef3772c9648564e6e1592d034fbb304a0ee9e3e7a6::swap_event::emit_common_swap<0x2::sui::SUI, 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(0x1a830340e1caed73881c51f13fd3c1409153879493b56688118012c25b658512::consts::LSD_VOLO(), 0x2::object::id_to_address(&v1), false, 0x2::coin::value<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(&arg3), 0x2::coin::value<0x2::sui::SUI>(&v0), true);
        v0
    }

    // decompiled from Move bytecode v6
}

