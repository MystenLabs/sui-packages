module 0x501fba888600d5e2bcf286654474891bd83c488c0650b8392f7dd3c515475631::volo_lst {
    public fun stake(arg0: &0x91dd844df4f20026f6c6a4c44d0c87a960316e2e3f8c8a0e55e1532a05a86ab2::router::HopReceipt, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::stake_pool::StakePool, arg3: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::Metadata<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT> {
        0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::stake_pool::stake(arg2, arg3, arg4, arg1, arg5)
    }

    public fun unstake(arg0: &0x91dd844df4f20026f6c6a4c44d0c87a960316e2e3f8c8a0e55e1532a05a86ab2::router::HopReceipt, arg1: 0x2::coin::Coin<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg2: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::stake_pool::StakePool, arg3: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::Metadata<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::stake_pool::unstake(arg2, arg3, arg4, arg1, arg5)
    }

    // decompiled from Move bytecode v7
}

