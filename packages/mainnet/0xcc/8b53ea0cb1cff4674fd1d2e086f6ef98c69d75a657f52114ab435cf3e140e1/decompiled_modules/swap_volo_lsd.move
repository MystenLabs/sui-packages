module 0xcc8b53ea0cb1cff4674fd1d2e086f6ef98c69d75a657f52114ab435cf3e140e1::swap_volo_lsd {
    public fun swap_a2b<T0, T1>(arg0: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::stake_pool::StakePool, arg1: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::Metadata<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0xcc8b53ea0cb1cff4674fd1d2e086f6ef98c69d75a657f52114ab435cf3e140e1::swap_transaction::SwapTransaction<T0, T1>, arg5: &0xcc8b53ea0cb1cff4674fd1d2e086f6ef98c69d75a657f52114ab435cf3e140e1::state::State, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT> {
        let v0 = 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::stake_pool::stake(arg0, arg1, arg2, arg3, arg6);
        let v1 = 0x2::object::id<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::stake_pool::StakePool>(arg0);
        0xcc8b53ea0cb1cff4674fd1d2e086f6ef98c69d75a657f52114ab435cf3e140e1::swap_event::emit_common_swap<0x2::sui::SUI, 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(0xcc8b53ea0cb1cff4674fd1d2e086f6ef98c69d75a657f52114ab435cf3e140e1::consts::LSD_VOLO(), 0x2::object::id_to_address(&v1), true, 0x2::coin::value<0x2::sui::SUI>(&arg3), 0x2::coin::value<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(&v0), true);
        v0
    }

    public fun swap_b2a<T0, T1>(arg0: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::stake_pool::StakePool, arg1: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::Metadata<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: 0x2::coin::Coin<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg4: &0xcc8b53ea0cb1cff4674fd1d2e086f6ef98c69d75a657f52114ab435cf3e140e1::swap_transaction::SwapTransaction<T0, T1>, arg5: &0xcc8b53ea0cb1cff4674fd1d2e086f6ef98c69d75a657f52114ab435cf3e140e1::state::State, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::stake_pool::unstake(arg0, arg1, arg2, arg3, arg6);
        let v1 = 0x2::object::id<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::stake_pool::StakePool>(arg0);
        0xcc8b53ea0cb1cff4674fd1d2e086f6ef98c69d75a657f52114ab435cf3e140e1::swap_event::emit_common_swap<0x2::sui::SUI, 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(0xcc8b53ea0cb1cff4674fd1d2e086f6ef98c69d75a657f52114ab435cf3e140e1::consts::LSD_VOLO(), 0x2::object::id_to_address(&v1), false, 0x2::coin::value<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(&arg3), 0x2::coin::value<0x2::sui::SUI>(&v0), true);
        v0
    }

    // decompiled from Move bytecode v6
}

