module 0xd0e06b360a35bf50532f1947c8f131b724c2cff11db847bc3a04bcf3242b0f1c::liquidate {
    struct CustomLiquidateReceipt<phantom T0, phantom T1> {
        ticket: 0xf23575bda553a38973514e828c3d5f735d4628bb2c945336b319344d0092b094::swap::EmptyTokenTicket,
        debt_quota: u64,
    }

    public fun custom_liquidate<T0, T1, T2>(arg0: &0xd0e06b360a35bf50532f1947c8f131b724c2cff11db847bc3a04bcf3242b0f1c::liquidator::Liquidator, arg1: 0x2::coin::Coin<T2>, arg2: &0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::app::ProtocolApp, arg3: 0x2::object::ID, arg4: &mut 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::market::Market<T0>, arg5: &0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::coin_decimals_registry::CoinDecimalsRegistry, arg6: &0x3ae4e0c6999229ea9128cd3f88449707f0d1326fc8346af6db86f99bd77c6201::x_oracle::XOracle, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (CustomLiquidateReceipt<T1, T2>, 0xf23575bda553a38973514e828c3d5f735d4628bb2c945336b319344d0092b094::swap::SwapContext) {
        0xd0e06b360a35bf50532f1947c8f131b724c2cff11db847bc3a04bcf3242b0f1c::liquidator::ensure_caller_whitelisted(arg0, 0x2::tx_context::sender(arg8));
        let (v0, v1) = 0xf23575bda553a38973514e828c3d5f735d4628bb2c945336b319344d0092b094::swap::new_swap_context(arg8);
        let v2 = v0;
        let v3 = CustomLiquidateReceipt<T1, T2>{
            ticket     : v1,
            debt_quota : 0x2::coin::value<T2>(&arg1),
        };
        let (v4, v5) = 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::liquidate::liquidate_as_coin<T0, T2, T1>(arg2, 0xd0e06b360a35bf50532f1947c8f131b724c2cff11db847bc3a04bcf3242b0f1c::liquidator::borrow_package_caller_cap(arg0), arg3, arg4, arg1, arg5, arg6, arg7, arg8);
        let v6 = v5;
        v3.debt_quota = v3.debt_quota - 0x2::coin::value<T2>(&v6);
        0xf23575bda553a38973514e828c3d5f735d4628bb2c945336b319344d0092b094::swap::put_balance<T1>(&mut v2, 0x2::coin::into_balance<T1>(v4));
        if (0x2::coin::value<T2>(&v6) == 0) {
            0x2::coin::destroy_zero<T2>(v6);
        } else {
            0xf23575bda553a38973514e828c3d5f735d4628bb2c945336b319344d0092b094::swap::put_balance<T2>(&mut v2, 0x2::coin::into_balance<T2>(v6));
        };
        (v3, v2)
    }

    public fun verify_custom_liquidate<T0, T1>(arg0: CustomLiquidateReceipt<T0, T1>, arg1: 0xf23575bda553a38973514e828c3d5f735d4628bb2c945336b319344d0092b094::swap::SwapContext, arg2: u64, arg3: &0xd0e06b360a35bf50532f1947c8f131b724c2cff11db847bc3a04bcf3242b0f1c::liquidator::Liquidator, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let CustomLiquidateReceipt {
            ticket     : v0,
            debt_quota : v1,
        } = arg0;
        let v2 = v0;
        assert!(v1 * (1000 + 30) / 1000 >= arg2, 0xd0e06b360a35bf50532f1947c8f131b724c2cff11db847bc3a04bcf3242b0f1c::error::invalid_repay_amount());
        0xd0e06b360a35bf50532f1947c8f131b724c2cff11db847bc3a04bcf3242b0f1c::liquidator::transfer_to_recipient<T0>(arg3, 0xf23575bda553a38973514e828c3d5f735d4628bb2c945336b319344d0092b094::swap::empty_token_as_coin<T0>(&mut arg1, &v2, arg4));
        let v3 = 0xf23575bda553a38973514e828c3d5f735d4628bb2c945336b319344d0092b094::swap::empty_token_as_coin<T1>(&mut arg1, &v2, arg4);
        0xd0e06b360a35bf50532f1947c8f131b724c2cff11db847bc3a04bcf3242b0f1c::liquidator::transfer_to_recipient<T1>(arg3, v3);
        0xf23575bda553a38973514e828c3d5f735d4628bb2c945336b319344d0092b094::swap::end_swap(arg1, v2);
        0x2::coin::split<T1>(&mut v3, arg2, arg4)
    }

    // decompiled from Move bytecode v6
}

