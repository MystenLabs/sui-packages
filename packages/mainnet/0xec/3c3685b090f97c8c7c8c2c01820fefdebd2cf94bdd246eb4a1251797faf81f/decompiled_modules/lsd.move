module 0xec3c3685b090f97c8c7c8c2c01820fefdebd2cf94bdd246eb4a1251797faf81f::lsd {
    public fun swap(arg0: &mut 0x27f0a2dd036967aed0ffc395ce040b3f2a84b6e56b466500af3670aaf99c3ec4::router::SwapContext, arg1: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::stake_pool::StakePool, arg2: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::Metadata<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: bool, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        if (arg4) {
            swap_a2b(arg0, arg1, arg2, arg3, arg5, arg6);
        } else {
            swap_b2a(arg0, arg1, arg2, arg3, arg5, arg6);
        };
    }

    fun swap_a2b(arg0: &mut 0x27f0a2dd036967aed0ffc395ce040b3f2a84b6e56b466500af3670aaf99c3ec4::router::SwapContext, arg1: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::stake_pool::StakePool, arg2: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::Metadata<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x27f0a2dd036967aed0ffc395ce040b3f2a84b6e56b466500af3670aaf99c3ec4::router::take_balance<0x2::sui::SUI>(arg0, arg4);
        if (0x2::balance::value<0x2::sui::SUI>(&v0) == 0) {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v0);
            return
        };
        0x27f0a2dd036967aed0ffc395ce040b3f2a84b6e56b466500af3670aaf99c3ec4::router::merge_balance<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(arg0, 0x2::coin::into_balance<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::stake_pool::stake(arg1, arg2, arg3, 0x2::coin::from_balance<0x2::sui::SUI>(v0, arg5), arg5)));
    }

    fun swap_b2a(arg0: &mut 0x27f0a2dd036967aed0ffc395ce040b3f2a84b6e56b466500af3670aaf99c3ec4::router::SwapContext, arg1: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::stake_pool::StakePool, arg2: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::Metadata<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x27f0a2dd036967aed0ffc395ce040b3f2a84b6e56b466500af3670aaf99c3ec4::router::take_balance<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(arg0, arg4);
        if (0x2::balance::value<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(&v0) == 0) {
            0x2::balance::destroy_zero<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(v0);
            return
        };
        0x27f0a2dd036967aed0ffc395ce040b3f2a84b6e56b466500af3670aaf99c3ec4::router::merge_balance<0x2::sui::SUI>(arg0, 0x2::coin::into_balance<0x2::sui::SUI>(0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::stake_pool::unstake(arg1, arg2, arg3, 0x2::coin::from_balance<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(v0, arg5), arg5)));
    }

    // decompiled from Move bytecode v7
}

