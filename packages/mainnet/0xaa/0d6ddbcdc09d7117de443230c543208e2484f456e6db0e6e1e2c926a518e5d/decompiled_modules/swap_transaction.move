module 0xaa0d6ddbcdc09d7117de443230c543208e2484f456e6db0e6e1e2c926a518e5d::swap_transaction {
    struct SwapTransaction<phantom T0, phantom T1> {
        minAmountOut: u64,
        output_coin: 0x2::balance::Balance<T1>,
    }

    public fun begin<T0, T1>(arg0: u64, arg1: &0xaa0d6ddbcdc09d7117de443230c543208e2484f456e6db0e6e1e2c926a518e5d::state::State, arg2: &mut 0x2::tx_context::TxContext) : SwapTransaction<T0, T1> {
        assert!(!0xaa0d6ddbcdc09d7117de443230c543208e2484f456e6db0e6e1e2c926a518e5d::state::pause(arg1), 1);
        SwapTransaction<T0, T1>{
            minAmountOut : arg0,
            output_coin  : 0x2::balance::zero<T1>(),
        }
    }

    public fun end<T0, T1>(arg0: SwapTransaction<T0, T1>, arg1: &mut 0xaa0d6ddbcdc09d7117de443230c543208e2484f456e6db0e6e1e2c926a518e5d::fee_pool::FeePool, arg2: &0xaa0d6ddbcdc09d7117de443230c543208e2484f456e6db0e6e1e2c926a518e5d::state::State, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let SwapTransaction {
            minAmountOut : v0,
            output_coin  : v1,
        } = arg0;
        let v2 = v1;
        let v3 = 0x2::balance::value<T1>(&v2);
        assert!(v3 >= v0, 0);
        if (0xaa0d6ddbcdc09d7117de443230c543208e2484f456e6db0e6e1e2c926a518e5d::state::fee_enabled(arg2)) {
            0xaa0d6ddbcdc09d7117de443230c543208e2484f456e6db0e6e1e2c926a518e5d::fee_pool::deposit<T1>(arg1, 0x2::balance::split<T1>(&mut v2, (((v3 as u128) * (0xaa0d6ddbcdc09d7117de443230c543208e2484f456e6db0e6e1e2c926a518e5d::state::fee_rate(arg2) as u128) / 100000) as u64)), arg3);
        };
        0x2::coin::from_balance<T1>(v2, arg3)
    }

    public fun merge_output<T0, T1>(arg0: &mut SwapTransaction<T0, T1>, arg1: 0x2::balance::Balance<T1>) {
        0x2::balance::join<T1>(&mut arg0.output_coin, arg1);
    }

    // decompiled from Move bytecode v6
}

