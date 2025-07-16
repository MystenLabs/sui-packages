module 0x74feb2a4b9a798d06ae22806e041ae00ce823ddf133995085dbbb1622c12534b::swap_transaction {
    struct SwapTransaction<phantom T0, phantom T1> {
        minAmountOut: u64,
        output_coin: 0x2::balance::Balance<T1>,
    }

    public fun begin<T0, T1>(arg0: u64, arg1: &0x74feb2a4b9a798d06ae22806e041ae00ce823ddf133995085dbbb1622c12534b::state::State, arg2: &mut 0x2::tx_context::TxContext) : SwapTransaction<T0, T1> {
        assert!(!0x74feb2a4b9a798d06ae22806e041ae00ce823ddf133995085dbbb1622c12534b::state::pause(arg1), 1);
        SwapTransaction<T0, T1>{
            minAmountOut : arg0,
            output_coin  : 0x2::balance::zero<T1>(),
        }
    }

    public fun end<T0, T1>(arg0: SwapTransaction<T0, T1>, arg1: &mut 0x74feb2a4b9a798d06ae22806e041ae00ce823ddf133995085dbbb1622c12534b::fee_pool::FeePool, arg2: &0x74feb2a4b9a798d06ae22806e041ae00ce823ddf133995085dbbb1622c12534b::state::State, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let SwapTransaction {
            minAmountOut : v0,
            output_coin  : v1,
        } = arg0;
        let v2 = v1;
        let v3 = 0x2::balance::value<T1>(&v2);
        assert!(v3 >= v0, 0);
        if (0x74feb2a4b9a798d06ae22806e041ae00ce823ddf133995085dbbb1622c12534b::state::fee_enabled(arg2)) {
            0x74feb2a4b9a798d06ae22806e041ae00ce823ddf133995085dbbb1622c12534b::fee_pool::deposit<T1>(arg1, 0x2::balance::split<T1>(&mut v2, (((v3 as u128) * (0x74feb2a4b9a798d06ae22806e041ae00ce823ddf133995085dbbb1622c12534b::state::fee_rate(arg2) as u128) / 100000) as u64)), arg3);
        };
        0x2::coin::from_balance<T1>(v2, arg3)
    }

    public fun merge_output<T0, T1>(arg0: &mut SwapTransaction<T0, T1>, arg1: 0x2::balance::Balance<T1>) {
        0x2::balance::join<T1>(&mut arg0.output_coin, arg1);
    }

    // decompiled from Move bytecode v6
}

