module 0x34dde4b33bfecfaad68166922e500e43572f6f60c8e18d9be029d6cd141726d3::alphafi_agg {
    struct AlphafiAgg has drop {
        dummy_field: bool,
    }

    public fun swap<T0: drop>(arg0: &0xf23575bda553a38973514e828c3d5f735d4628bb2c945336b319344d0092b094::router::Router, arg1: &mut 0xf23575bda553a38973514e828c3d5f735d4628bb2c945336b319344d0092b094::swap::SwapContext, arg2: &mut 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::LiquidStakingInfo<T0>, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: bool, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        if (arg4) {
            let v0 = AlphafiAgg{dummy_field: false};
            let v1 = swap_a2b<T0>(arg2, arg3, 0xf23575bda553a38973514e828c3d5f735d4628bb2c945336b319344d0092b094::swap::take_balance<AlphafiAgg, 0x2::sui::SUI>(arg1, arg0, v0, arg5), arg6);
            if (0x2::balance::value<T0>(&v1) > 0) {
                0xf23575bda553a38973514e828c3d5f735d4628bb2c945336b319344d0092b094::swap::put_balance<T0>(arg1, v1);
            } else {
                0x2::balance::destroy_zero<T0>(v1);
            };
        } else {
            let v2 = AlphafiAgg{dummy_field: false};
            let v3 = swap_b2a<T0>(arg2, arg3, 0xf23575bda553a38973514e828c3d5f735d4628bb2c945336b319344d0092b094::swap::take_balance<AlphafiAgg, T0>(arg1, arg0, v2, arg5), arg6);
            if (0x2::balance::value<0x2::sui::SUI>(&v3) > 0) {
                0xf23575bda553a38973514e828c3d5f735d4628bb2c945336b319344d0092b094::swap::put_balance<0x2::sui::SUI>(arg1, v3);
            } else {
                0x2::balance::destroy_zero<0x2::sui::SUI>(v3);
            };
        };
    }

    fun swap_a2b<T0: drop>(arg0: &mut 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::LiquidStakingInfo<T0>, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: 0x2::balance::Balance<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        if (0x2::balance::value<0x2::sui::SUI>(&arg2) == 0) {
            0x2::balance::destroy_zero<0x2::sui::SUI>(arg2);
            return 0x2::balance::zero<T0>()
        };
        0x2::coin::into_balance<T0>(0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::mint<T0>(arg0, arg1, 0x2::coin::from_balance<0x2::sui::SUI>(arg2, arg3), arg3))
    }

    fun swap_b2a<T0: drop>(arg0: &mut 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::LiquidStakingInfo<T0>, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: 0x2::balance::Balance<T0>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        if (0x2::balance::value<T0>(&arg2) == 0) {
            0x2::balance::destroy_zero<T0>(arg2);
            return 0x2::balance::zero<0x2::sui::SUI>()
        };
        0x2::coin::into_balance<0x2::sui::SUI>(0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::redeem<T0>(arg0, 0x2::coin::from_balance<T0>(arg2, arg3), arg1, arg3))
    }

    // decompiled from Move bytecode v6
}

