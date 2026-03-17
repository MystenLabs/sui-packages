module 0xf6dfb51231300e0fab9d45f31a5551d40d519b28a6540d44406d38f9fffa4a9::navi_flash_loan {
    struct NaviFlashLoan has drop {
        dummy_field: bool,
    }

    public fun flash_loan<T0, T1>(arg0: &0xfddabf2333596909a075c8b11b6e8b42c2040806728ae63bebcff3a3bdde41b2::liquidator::Liquidator, arg1: &mut 0xfddabf2333596909a075c8b11b6e8b42c2040806728ae63bebcff3a3bdde41b2::custom_liquidate::CustomLiquidateReceipt<T0>, arg2: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::Config, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg4: u64, arg5: &mut 0x3::sui_system::SuiSystemState, arg6: &mut 0x2::tx_context::TxContext) : 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::Receipt<T1> {
        let (v0, v1) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::flash_loan_with_ctx_v2<T1>(arg2, arg3, arg4, arg5, arg6);
        let v2 = v1;
        let v3 = NaviFlashLoan{dummy_field: false};
        0xfddabf2333596909a075c8b11b6e8b42c2040806728ae63bebcff3a3bdde41b2::custom_liquidate::put_balance<NaviFlashLoan, T0, T1>(arg1, arg0, v3, v0);
        let v4 = NaviFlashLoan{dummy_field: false};
        0xfddabf2333596909a075c8b11b6e8b42c2040806728ae63bebcff3a3bdde41b2::custom_liquidate::add_flash_loan_debts<NaviFlashLoan, T0, T1>(arg1, arg0, v4, 0, total_debt_amount<T1>(&v2), arg6);
        v2
    }

    public fun repay_flash_loan<T0, T1>(arg0: &0xfddabf2333596909a075c8b11b6e8b42c2040806728ae63bebcff3a3bdde41b2::liquidator::Liquidator, arg1: &mut 0xfddabf2333596909a075c8b11b6e8b42c2040806728ae63bebcff3a3bdde41b2::custom_liquidate::CustomLiquidateReceipt<T0>, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg4: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::Receipt<T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = NaviFlashLoan{dummy_field: false};
        let v1 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::flash_repay_with_ctx<T1>(arg5, arg2, arg3, arg4, 0xfddabf2333596909a075c8b11b6e8b42c2040806728ae63bebcff3a3bdde41b2::custom_liquidate::take_balance<NaviFlashLoan, T0, T1>(arg1, arg0, v0, total_debt_amount<T1>(&arg4)), arg6);
        if (0x2::balance::value<T1>(&v1) == 0) {
            0x2::balance::destroy_zero<T1>(v1);
        } else {
            let v2 = NaviFlashLoan{dummy_field: false};
            0xfddabf2333596909a075c8b11b6e8b42c2040806728ae63bebcff3a3bdde41b2::custom_liquidate::put_balance<NaviFlashLoan, T0, T1>(arg1, arg0, v2, v1);
        };
    }

    fun total_debt_amount<T0>(arg0: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::Receipt<T0>) : u64 {
        let (_, _, v2, _, v4, v5) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::parsed_receipt<T0>(arg0);
        v2 + v4 + v5
    }

    // decompiled from Move bytecode v6
}

