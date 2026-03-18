module 0x43d69ed5e405a66dc5c0b27a86b48188c8ebb46f9e84779133ed24b9eb64050::navi_flash_loan {
    struct NaviFlashLoan has drop {
        dummy_field: bool,
    }

    public fun flash_loan<T0, T1>(arg0: &0xbd5ce8a980d4533417cffe9245ded402d6ba6d01205d96df1dcc4318088d07fe::liquidator::Liquidator, arg1: &mut 0xbd5ce8a980d4533417cffe9245ded402d6ba6d01205d96df1dcc4318088d07fe::custom_liquidate::CustomLiquidateReceipt<T0>, arg2: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::Config, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg4: u64, arg5: &mut 0x3::sui_system::SuiSystemState, arg6: &mut 0x2::tx_context::TxContext) : 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::Receipt<T1> {
        let (v0, v1) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::flash_loan_with_ctx_v2<T1>(arg2, arg3, arg4, arg5, arg6);
        let v2 = v1;
        let v3 = NaviFlashLoan{dummy_field: false};
        0xbd5ce8a980d4533417cffe9245ded402d6ba6d01205d96df1dcc4318088d07fe::custom_liquidate::put_balance<NaviFlashLoan, T0, T1>(arg1, arg0, v3, v0);
        let v4 = NaviFlashLoan{dummy_field: false};
        0xbd5ce8a980d4533417cffe9245ded402d6ba6d01205d96df1dcc4318088d07fe::custom_liquidate::add_flash_loan_debts<NaviFlashLoan, T0, T1>(arg1, arg0, v4, 0, total_debt_amount<T1>(&v2), arg6);
        v2
    }

    public fun repay_flash_loan<T0, T1>(arg0: &0xbd5ce8a980d4533417cffe9245ded402d6ba6d01205d96df1dcc4318088d07fe::liquidator::Liquidator, arg1: &mut 0xbd5ce8a980d4533417cffe9245ded402d6ba6d01205d96df1dcc4318088d07fe::custom_liquidate::CustomLiquidateReceipt<T0>, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg4: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::Receipt<T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = total_debt_amount<T1>(&arg4);
        let v1 = NaviFlashLoan{dummy_field: false};
        let v2 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::flash_repay_with_ctx<T1>(arg5, arg2, arg3, arg4, 0xbd5ce8a980d4533417cffe9245ded402d6ba6d01205d96df1dcc4318088d07fe::custom_liquidate::take_balance<NaviFlashLoan, T0, T1>(arg1, arg0, v1, v0), arg6);
        assert!(0x2::balance::value<T1>(&v2) == 0, 0x43d69ed5e405a66dc5c0b27a86b48188c8ebb46f9e84779133ed24b9eb64050::error::excess_repay_amount());
        0x2::balance::destroy_zero<T1>(v2);
        let v3 = NaviFlashLoan{dummy_field: false};
        0xbd5ce8a980d4533417cffe9245ded402d6ba6d01205d96df1dcc4318088d07fe::custom_liquidate::sub_flash_loan_debts<NaviFlashLoan, T0, T1>(arg1, arg0, v3, 0, v0);
    }

    fun total_debt_amount<T0>(arg0: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::Receipt<T0>) : u64 {
        let (_, _, v2, _, v4, v5) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::parsed_receipt<T0>(arg0);
        v2 + v4 + v5
    }

    // decompiled from Move bytecode v6
}

