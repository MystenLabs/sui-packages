module 0x62acbdb5e3f6e41f4a4eccc04a9ec31d9bf19c5a07290b58fdd1824171cbf570::liquidate {
    struct LiqReceipt<phantom T0> {
        receipt: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::Receipt<T0>,
        change: 0x2::balance::Balance<T0>,
    }

    public fun flash_and_liquidate<T0, T1>(arg0: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::Config, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg7: &mut 0x3::sui_system::SuiSystemState, arg8: &0x2::clock::Clock, arg9: u8, arg10: u8, arg11: address, arg12: u64, arg13: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, LiqReceipt<T0>) {
        let (v0, v1) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::flash_loan_with_ctx_v2<T0>(arg0, arg1, arg12, arg7, arg13);
        let (v2, v3) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation_v2<T0, T1>(arg8, arg4, arg3, arg9, arg1, v0, arg10, arg2, arg11, arg5, arg6, arg7, arg13);
        let v4 = LiqReceipt<T0>{
            receipt : v1,
            change  : v3,
        };
        (v2, v4)
    }

    public fun repay_and_assert<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg3: LiqReceipt<T0>, arg4: 0x2::balance::Balance<T0>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let LiqReceipt {
            receipt : v0,
            change  : v1,
        } = arg3;
        0x2::balance::join<T0>(&mut arg4, v1);
        let v2 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::flash_repay_with_ctx<T0>(arg0, arg1, arg2, v0, arg4, arg6);
        assert!(0x2::balance::value<T0>(&v2) >= arg5, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v2, arg6), 0x2::tx_context::sender(arg6));
    }

    // decompiled from Move bytecode v7
}

