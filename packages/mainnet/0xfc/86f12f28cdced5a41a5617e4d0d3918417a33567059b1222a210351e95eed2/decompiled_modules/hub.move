module 0xe1b9fbd9b9de70a494d4ec4aa487ccd24dc926a2ab0060b0bcea116e8ea3db9a::hub {
    public fun reclaim_all<T0>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg1: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0x2::coin::into_balance<T0>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw_all<T0>(arg0, arg1))
    }

    public fun reclaim_and_merge<T0>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg1: 0x2::balance::Balance<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0xe1b9fbd9b9de70a494d4ec4aa487ccd24dc926a2ab0060b0bcea116e8ea3db9a::settle::merge<T0>(arg1, reclaim_excess<T0>(arg0, arg2, arg3))
    }

    public fun reclaim_and_sweep<T0>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = reclaim_excess<T0>(arg0, arg2, arg3);
        0xe1b9fbd9b9de70a494d4ec4aa487ccd24dc926a2ab0060b0bcea116e8ea3db9a::settle::sweep<T0>(v0, arg1, arg3);
    }

    public fun reclaim_both<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg1: 0x2::balance::Balance<T0>, arg2: u64, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = reclaim_and_merge<T0>(arg0, arg1, arg2, arg5);
        reclaim_and_sweep<T1>(arg0, arg4, arg3, arg5);
        v0
    }

    public fun reclaim_excess<T0>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg0);
        if (v0 > arg1) {
            0x2::coin::into_balance<T0>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<T0>(arg0, v0 - arg1, arg2))
        } else {
            0x2::balance::zero<T0>()
        }
    }

    // decompiled from Move bytecode v7
}

