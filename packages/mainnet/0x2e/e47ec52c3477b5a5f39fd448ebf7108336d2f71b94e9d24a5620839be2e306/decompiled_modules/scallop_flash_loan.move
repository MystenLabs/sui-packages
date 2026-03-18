module 0x2ee47ec52c3477b5a5f39fd448ebf7108336d2f71b94e9d24a5620839be2e306::scallop_flash_loan {
    struct ScallopFlashLoan has drop {
        dummy_field: bool,
    }

    public fun flash_loan<T0, T1>(arg0: &0xbd5ce8a980d4533417cffe9245ded402d6ba6d01205d96df1dcc4318088d07fe::liquidator::Liquidator, arg1: &mut 0xbd5ce8a980d4533417cffe9245ded402d6ba6d01205d96df1dcc4318088d07fe::custom_liquidate::CustomLiquidateReceipt<T0>, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::FlashLoan<T1> {
        let (v0, v1) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::flash_loan::borrow_flash_loan<T1>(arg2, arg3, arg4, arg5);
        let v2 = v1;
        let v3 = ScallopFlashLoan{dummy_field: false};
        0xbd5ce8a980d4533417cffe9245ded402d6ba6d01205d96df1dcc4318088d07fe::custom_liquidate::put_balance<ScallopFlashLoan, T0, T1>(arg1, arg0, v3, 0x2::coin::into_balance<T1>(v0));
        let v4 = ScallopFlashLoan{dummy_field: false};
        0xbd5ce8a980d4533417cffe9245ded402d6ba6d01205d96df1dcc4318088d07fe::custom_liquidate::add_flash_loan_debts<ScallopFlashLoan, T0, T1>(arg1, arg0, v4, 1, total_debt_amount<T1>(&v2), arg5);
        v2
    }

    public fun repay_flash_loan<T0, T1>(arg0: &0xbd5ce8a980d4533417cffe9245ded402d6ba6d01205d96df1dcc4318088d07fe::liquidator::Liquidator, arg1: &mut 0xbd5ce8a980d4533417cffe9245ded402d6ba6d01205d96df1dcc4318088d07fe::custom_liquidate::CustomLiquidateReceipt<T0>, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::FlashLoan<T1>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = total_debt_amount<T1>(&arg4);
        let v1 = ScallopFlashLoan{dummy_field: false};
        let v2 = 0xbd5ce8a980d4533417cffe9245ded402d6ba6d01205d96df1dcc4318088d07fe::custom_liquidate::take_balance<ScallopFlashLoan, T0, T1>(arg1, arg0, v1, v0);
        assert!(0x2::balance::value<T1>(&v2) == v0, 0x2ee47ec52c3477b5a5f39fd448ebf7108336d2f71b94e9d24a5620839be2e306::error::excess_repay_amount());
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::flash_loan::repay_flash_loan<T1>(arg2, arg3, 0x2::coin::from_balance<T1>(v2, arg5), arg4, arg5);
        let v3 = ScallopFlashLoan{dummy_field: false};
        0xbd5ce8a980d4533417cffe9245ded402d6ba6d01205d96df1dcc4318088d07fe::custom_liquidate::sub_flash_loan_debts<ScallopFlashLoan, T0, T1>(arg1, arg0, v3, 1, v0);
    }

    fun total_debt_amount<T0>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::FlashLoan<T0>) : u64 {
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::flash_loan_loan_amount<T0>(arg0) + 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::flash_loan_fee<T0>(arg0)
    }

    // decompiled from Move bytecode v6
}

