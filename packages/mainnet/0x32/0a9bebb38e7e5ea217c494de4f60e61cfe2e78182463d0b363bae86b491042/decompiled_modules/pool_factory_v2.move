module 0x320a9bebb38e7e5ea217c494de4f60e61cfe2e78182463d0b363bae86b491042::pool_factory_v2 {
    public entry fun create_pool<T0, T1>(arg0: &mut 0x320a9bebb38e7e5ea217c494de4f60e61cfe2e78182463d0b363bae86b491042::amm_v2::Global, arg1: &mut 0x320a9bebb38e7e5ea217c494de4f60e61cfe2e78182463d0b363bae86b491042::amm_v2::PoolRegistry, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: u64, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: vector<u8>, arg10: u64, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) {
        0x320a9bebb38e7e5ea217c494de4f60e61cfe2e78182463d0b363bae86b491042::amm_v2::create_pool_with_lp_tokens<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, 9, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    // decompiled from Move bytecode v6
}

