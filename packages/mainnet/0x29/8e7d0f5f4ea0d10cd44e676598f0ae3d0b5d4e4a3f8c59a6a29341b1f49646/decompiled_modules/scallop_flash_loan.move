module 0x298e7d0f5f4ea0d10cd44e676598f0ae3d0b5d4e4a3f8c59a6a29341b1f49646::scallop_flash_loan {
    struct ScallopFlashLoan has drop {
        dummy_field: bool,
    }

    public fun flash_loan<T0, T1>(arg0: &0xfddabf2333596909a075c8b11b6e8b42c2040806728ae63bebcff3a3bdde41b2::liquidator::Liquidator, arg1: &mut 0xfddabf2333596909a075c8b11b6e8b42c2040806728ae63bebcff3a3bdde41b2::custom_liquidate::CustomLiquidateReceipt<T0>, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::FlashLoan<T1> {
        let (v0, v1) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::flash_loan::borrow_flash_loan<T1>(arg2, arg3, arg4, arg5);
        let v2 = v1;
        let v3 = ScallopFlashLoan{dummy_field: false};
        0xfddabf2333596909a075c8b11b6e8b42c2040806728ae63bebcff3a3bdde41b2::custom_liquidate::put_balance<ScallopFlashLoan, T0, T1>(arg1, arg0, v3, 0x2::coin::into_balance<T1>(v0));
        let v4 = ScallopFlashLoan{dummy_field: false};
        0xfddabf2333596909a075c8b11b6e8b42c2040806728ae63bebcff3a3bdde41b2::custom_liquidate::add_flash_loan_debts<ScallopFlashLoan, T0, T1>(arg1, arg0, v4, 1, total_debt_amount<T1>(&v2), arg5);
        v2
    }

    public fun repay_flash_loan<T0, T1>(arg0: &0xfddabf2333596909a075c8b11b6e8b42c2040806728ae63bebcff3a3bdde41b2::liquidator::Liquidator, arg1: &mut 0xfddabf2333596909a075c8b11b6e8b42c2040806728ae63bebcff3a3bdde41b2::custom_liquidate::CustomLiquidateReceipt<T0>, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::FlashLoan<T1>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = ScallopFlashLoan{dummy_field: false};
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::flash_loan::repay_flash_loan<T1>(arg2, arg3, 0x2::coin::from_balance<T1>(0xfddabf2333596909a075c8b11b6e8b42c2040806728ae63bebcff3a3bdde41b2::custom_liquidate::take_balance<ScallopFlashLoan, T0, T1>(arg1, arg0, v0, total_debt_amount<T1>(&arg4)), arg5), arg4, arg5);
    }

    fun total_debt_amount<T0>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::FlashLoan<T0>) : u64 {
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::flash_loan_loan_amount<T0>(arg0) + 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::flash_loan_fee<T0>(arg0)
    }

    // decompiled from Move bytecode v6
}

