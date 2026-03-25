module 0xf6b3c5c7be96df154c08bc5831265a61665878d3feb3c1a021b577531615762::liquidate {
    struct CustomLiquidateReceipt<phantom T0, phantom T1> {
        ticket: 0xf23575bda553a38973514e828c3d5f735d4628bb2c945336b319344d0092b094::swap::EmptyTokenTicket,
        debt_quota: u64,
    }

    public fun custom_liquidate<T0, T1, T2>(arg0: &0xf6b3c5c7be96df154c08bc5831265a61665878d3feb3c1a021b577531615762::liquidator::Liquidator, arg1: 0x2::coin::Coin<T2>, arg2: &0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::app::ProtocolApp, arg3: 0x2::object::ID, arg4: &mut 0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::market::Market<T0>, arg5: &0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::coin_decimals_registry::CoinDecimalsRegistry, arg6: &0xf4b6a35a90a54d9758c06cf304ef93534fc37746ab0eff62bcae6bf272e50e83::x_oracle::XOracle, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (CustomLiquidateReceipt<T1, T2>, 0xf23575bda553a38973514e828c3d5f735d4628bb2c945336b319344d0092b094::swap::SwapContext) {
        0xf6b3c5c7be96df154c08bc5831265a61665878d3feb3c1a021b577531615762::liquidator::ensure_caller_whitelisted(arg0, 0x2::tx_context::sender(arg8));
        let (v0, v1) = 0xf23575bda553a38973514e828c3d5f735d4628bb2c945336b319344d0092b094::swap::new_swap_context(arg8);
        let v2 = v0;
        let v3 = CustomLiquidateReceipt<T1, T2>{
            ticket     : v1,
            debt_quota : 0x2::coin::value<T2>(&arg1),
        };
        let (v4, v5) = 0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::liquidate::liquidate_as_coin<T0, T2, T1>(arg2, 0xf6b3c5c7be96df154c08bc5831265a61665878d3feb3c1a021b577531615762::liquidator::borrow_package_caller_cap(arg0), arg3, arg4, arg1, arg5, arg6, arg7, arg8);
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

    public fun verify_custom_liquidate<T0, T1>(arg0: CustomLiquidateReceipt<T0, T1>, arg1: 0xf23575bda553a38973514e828c3d5f735d4628bb2c945336b319344d0092b094::swap::SwapContext, arg2: u64, arg3: &0xf6b3c5c7be96df154c08bc5831265a61665878d3feb3c1a021b577531615762::liquidator::Liquidator, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let CustomLiquidateReceipt {
            ticket     : v0,
            debt_quota : v1,
        } = arg0;
        let v2 = v0;
        assert!(v1 * (1000 + 1) / 1000 >= arg2, 0xf6b3c5c7be96df154c08bc5831265a61665878d3feb3c1a021b577531615762::error::invalid_repay_amount());
        0xf6b3c5c7be96df154c08bc5831265a61665878d3feb3c1a021b577531615762::liquidator::transfer_to_recipient<T0>(arg3, 0xf23575bda553a38973514e828c3d5f735d4628bb2c945336b319344d0092b094::swap::empty_token_as_coin<T0>(&mut arg1, &v2, arg4));
        let v3 = 0xf23575bda553a38973514e828c3d5f735d4628bb2c945336b319344d0092b094::swap::empty_token_as_coin<T1>(&mut arg1, &v2, arg4);
        0xf6b3c5c7be96df154c08bc5831265a61665878d3feb3c1a021b577531615762::liquidator::transfer_to_recipient<T1>(arg3, v3);
        0xf23575bda553a38973514e828c3d5f735d4628bb2c945336b319344d0092b094::swap::end_swap(arg1, v2);
        0x2::coin::split<T1>(&mut v3, arg2, arg4)
    }

    // decompiled from Move bytecode v6
}

