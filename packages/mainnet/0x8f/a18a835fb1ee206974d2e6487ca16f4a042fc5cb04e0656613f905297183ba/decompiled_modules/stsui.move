module 0x8fa18a835fb1ee206974d2e6487ca16f4a042fc5cb04e0656613f905297183ba::stsui {
    public fun mint<T0, T1: drop>(arg0: &mut 0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::session::Session<T0>, arg1: &mut 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::LiquidStakingInfo<T1>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: 0x2::balance::Balance<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<0x2::sui::SUI>) {
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg3) > 0, 1);
        let v0 = 0x2::coin::into_balance<T1>(0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::mint<T1>(arg1, arg2, 0x2::coin::from_balance<0x2::sui::SUI>(arg3, arg4), arg4));
        0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::session::record_leg<T0>(arg0, 0x2::object::id<0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::LiquidStakingInfo<T1>>(arg1), true, 0x2::balance::value<T1>(&v0));
        (v0, 0x2::balance::zero<0x2::sui::SUI>())
    }

    public fun quote<T0, T1>(arg0: &mut 0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::session::Session<T0>, arg1: &0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::LiquidStakingInfo<T1>, arg2: bool) {
        let v0 = vector[];
        let v1 = 0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::session::quote_inputs<T0>(arg0);
        0x1::vector::reverse<u64>(&mut v1);
        let v2 = 0;
        while (v2 < 0x1::vector::length<u64>(&v1)) {
            let v3 = if (arg2) {
                0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::sui_to_lst_mint_price<T1>(arg1, 0x1::vector::pop_back<u64>(&mut v1))
            } else {
                0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::lst_to_sui_redemption_price<T1>(arg1, 0x1::vector::pop_back<u64>(&mut v1))
            };
            0x1::vector::push_back<u64>(&mut v0, v3);
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<u64>(v1);
        0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::session::record_quote<T0>(arg0, 0x2::object::id<0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::LiquidStakingInfo<T1>>(arg1), arg2, v0, vector[], vector[]);
    }

    public fun redeem<T0, T1: drop>(arg0: &mut 0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::session::Session<T0>, arg1: &mut 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::LiquidStakingInfo<T1>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: 0x2::balance::Balance<T1>, arg4: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<0x2::sui::SUI>, 0x2::balance::Balance<T1>) {
        assert!(0x2::balance::value<T1>(&arg3) > 0, 1);
        let v0 = 0x2::coin::into_balance<0x2::sui::SUI>(0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::redeem<T1>(arg1, 0x2::coin::from_balance<T1>(arg3, arg4), arg2, arg4));
        0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::session::record_leg<T0>(arg0, 0x2::object::id<0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::LiquidStakingInfo<T1>>(arg1), false, 0x2::balance::value<0x2::sui::SUI>(&v0));
        (v0, 0x2::balance::zero<T1>())
    }

    // decompiled from Move bytecode v7
}

