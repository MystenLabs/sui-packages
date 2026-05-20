module 0xe6cacdfdc40c8d67b1357e1ae6c09bce9d97b716311ac8c9a1f972897fd97eff::hypernative_helper {
    public fun total_deposit_balance<T0>(arg0: &0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::DepositVault) : u64 {
        0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::active_balance<T0>(arg0) + 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::deactivating_balance<T0>(arg0) + 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::inactive_balance<T0>(arg0) + 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::warmup_balance<T0>(arg0) + 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::premium_balance<T0>(arg0) + 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::incentive_balance<T0>(arg0)
    }

    // decompiled from Move bytecode v7
}

