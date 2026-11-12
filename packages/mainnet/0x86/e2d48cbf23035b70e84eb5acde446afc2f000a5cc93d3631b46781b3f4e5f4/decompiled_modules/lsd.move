module 0x86e2d48cbf23035b70e84eb5acde446afc2f000a5cc93d3631b46781b3f4e5f4::lsd {
    public fun swap(arg0: &mut 0x452e3f18946ae8de3f7f2e00a4bc64a043490ab2957a0c55de228678253d3d0e::router::SwapContext, arg1: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::stake_pool::StakePool, arg2: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::Metadata<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: bool, arg5: u64, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) {
        if (arg4) {
            swap_a2b(arg0, arg1, arg2, arg3, arg5, arg6, arg7);
        } else {
            swap_b2a(arg0, arg1, arg2, arg3, arg5, arg6, arg7);
        };
    }

    fun swap_a2b(arg0: &mut 0x452e3f18946ae8de3f7f2e00a4bc64a043490ab2957a0c55de228678253d3d0e::router::SwapContext, arg1: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::stake_pool::StakePool, arg2: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::Metadata<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: u64, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x452e3f18946ae8de3f7f2e00a4bc64a043490ab2957a0c55de228678253d3d0e::router::take_balance<0x2::sui::SUI>(arg0, arg4);
        if (0x2::balance::value<0x2::sui::SUI>(&v0) == 0) {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v0);
            0x452e3f18946ae8de3f7f2e00a4bc64a043490ab2957a0c55de228678253d3d0e::router::sweep_if_last<0x2::sui::SUI>(arg0, arg5, arg6);
            return
        };
        0x452e3f18946ae8de3f7f2e00a4bc64a043490ab2957a0c55de228678253d3d0e::router::merge_balance<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(arg0, 0x2::coin::into_balance<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::stake_pool::stake(arg1, arg2, arg3, 0x2::coin::from_balance<0x2::sui::SUI>(v0, arg6), arg6)));
        0x452e3f18946ae8de3f7f2e00a4bc64a043490ab2957a0c55de228678253d3d0e::router::sweep_if_last<0x2::sui::SUI>(arg0, arg5, arg6);
    }

    fun swap_b2a(arg0: &mut 0x452e3f18946ae8de3f7f2e00a4bc64a043490ab2957a0c55de228678253d3d0e::router::SwapContext, arg1: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::stake_pool::StakePool, arg2: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::Metadata<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: u64, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x452e3f18946ae8de3f7f2e00a4bc64a043490ab2957a0c55de228678253d3d0e::router::take_balance<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(arg0, arg4);
        if (0x2::balance::value<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(&v0) == 0) {
            0x2::balance::destroy_zero<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(v0);
            0x452e3f18946ae8de3f7f2e00a4bc64a043490ab2957a0c55de228678253d3d0e::router::sweep_if_last<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(arg0, arg5, arg6);
            return
        };
        0x452e3f18946ae8de3f7f2e00a4bc64a043490ab2957a0c55de228678253d3d0e::router::merge_balance<0x2::sui::SUI>(arg0, 0x2::coin::into_balance<0x2::sui::SUI>(0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::stake_pool::unstake(arg1, arg2, arg3, 0x2::coin::from_balance<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(v0, arg6), arg6)));
        0x452e3f18946ae8de3f7f2e00a4bc64a043490ab2957a0c55de228678253d3d0e::router::sweep_if_last<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(arg0, arg5, arg6);
    }

    // decompiled from Move bytecode v7
}

