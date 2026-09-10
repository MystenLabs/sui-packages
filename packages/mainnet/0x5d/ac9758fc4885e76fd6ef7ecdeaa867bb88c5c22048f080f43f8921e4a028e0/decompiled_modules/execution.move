module 0x5dac9758fc4885e76fd6ef7ecdeaa867bb88c5c22048f080f43f8921e4a028e0::execution {
    public fun maybe_stake(arg0: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::stake_pool::StakePool, arg1: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::Metadata<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: 0x1::option::Option<0x2::coin::Coin<0x2::sui::SUI>>, arg4: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::coin::Coin<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>> {
        if (0x1::option::is_none<0x2::coin::Coin<0x2::sui::SUI>>(&arg3)) {
            0x1::option::destroy_none<0x2::coin::Coin<0x2::sui::SUI>>(arg3);
            return 0x1::option::none<0x2::coin::Coin<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>>()
        };
        0x1::option::some<0x2::coin::Coin<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>>(0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::stake_pool::stake(arg0, arg1, arg2, 0x1::option::destroy_some<0x2::coin::Coin<0x2::sui::SUI>>(arg3), arg4))
    }

    public fun maybe_unstake(arg0: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::stake_pool::StakePool, arg1: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::Metadata<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: 0x1::option::Option<0x2::coin::Coin<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>>, arg4: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::coin::Coin<0x2::sui::SUI>> {
        if (0x1::option::is_none<0x2::coin::Coin<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>>(&arg3)) {
            0x1::option::destroy_none<0x2::coin::Coin<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>>(arg3);
            return 0x1::option::none<0x2::coin::Coin<0x2::sui::SUI>>()
        };
        0x1::option::some<0x2::coin::Coin<0x2::sui::SUI>>(0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::stake_pool::unstake(arg0, arg1, arg2, 0x1::option::destroy_some<0x2::coin::Coin<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>>(arg3), arg4))
    }

    // decompiled from Move bytecode v7
}

