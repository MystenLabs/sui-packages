module 0xff89af338638b5b8e8b7838c61a1f3af2409ac36c8b096b3712f1f418af09eac::volo_agg {
    struct VoloAgg has drop {
        dummy_field: bool,
    }

    public fun swap(arg0: &0xf23575bda553a38973514e828c3d5f735d4628bb2c945336b319344d0092b094::router::Router, arg1: &mut 0xf23575bda553a38973514e828c3d5f735d4628bb2c945336b319344d0092b094::swap::SwapContext, arg2: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::stake_pool::StakePool, arg3: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::Metadata<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: bool, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        if (arg5) {
            let v0 = VoloAgg{dummy_field: false};
            let v1 = swap_a2b(arg2, arg3, arg4, 0xf23575bda553a38973514e828c3d5f735d4628bb2c945336b319344d0092b094::swap::take_balance<VoloAgg, 0x2::sui::SUI>(arg1, arg0, v0, arg6), arg7);
            if (0x2::balance::value<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(&v1) > 0) {
                0xf23575bda553a38973514e828c3d5f735d4628bb2c945336b319344d0092b094::swap::put_balance<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(arg1, v1);
            } else {
                0x2::balance::destroy_zero<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(v1);
            };
        } else {
            let v2 = VoloAgg{dummy_field: false};
            let v3 = swap_b2a(arg2, arg3, arg4, 0xf23575bda553a38973514e828c3d5f735d4628bb2c945336b319344d0092b094::swap::take_balance<VoloAgg, 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(arg1, arg0, v2, arg6), arg7);
            if (0x2::balance::value<0x2::sui::SUI>(&v3) > 0) {
                0xf23575bda553a38973514e828c3d5f735d4628bb2c945336b319344d0092b094::swap::put_balance<0x2::sui::SUI>(arg1, v3);
            } else {
                0x2::balance::destroy_zero<0x2::sui::SUI>(v3);
            };
        };
    }

    fun swap_a2b(arg0: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::stake_pool::StakePool, arg1: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::Metadata<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: 0x2::balance::Balance<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT> {
        if (0x2::balance::value<0x2::sui::SUI>(&arg3) == 0) {
            0x2::balance::destroy_zero<0x2::sui::SUI>(arg3);
            return 0x2::balance::zero<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>()
        };
        0x2::coin::into_balance<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::stake_pool::stake(arg0, arg1, arg2, 0x2::coin::from_balance<0x2::sui::SUI>(arg3, arg4), arg4))
    }

    fun swap_b2a(arg0: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::stake_pool::StakePool, arg1: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::Metadata<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: 0x2::balance::Balance<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        if (0x2::balance::value<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(&arg3) == 0) {
            0x2::balance::destroy_zero<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(arg3);
            return 0x2::balance::zero<0x2::sui::SUI>()
        };
        0x2::coin::into_balance<0x2::sui::SUI>(0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::stake_pool::unstake(arg0, arg1, arg2, 0x2::coin::from_balance<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(arg3, arg4), arg4))
    }

    // decompiled from Move bytecode v6
}

