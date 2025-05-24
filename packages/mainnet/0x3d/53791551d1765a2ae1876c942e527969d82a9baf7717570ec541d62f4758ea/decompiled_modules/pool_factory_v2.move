module 0x3d53791551d1765a2ae1876c942e527969d82a9baf7717570ec541d62f4758ea::pool_factory_v2 {
    public entry fun create_pool<T0, T1>(arg0: &mut 0x3d53791551d1765a2ae1876c942e527969d82a9baf7717570ec541d62f4758ea::amm_v2::Global, arg1: &mut 0x3d53791551d1765a2ae1876c942e527969d82a9baf7717570ec541d62f4758ea::amm_v2::PoolRegistry, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: u64, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: vector<u8>, arg10: u64, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) {
        0x3d53791551d1765a2ae1876c942e527969d82a9baf7717570ec541d62f4758ea::amm_v2::create_pool_with_lp_tokens<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, 9, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    // decompiled from Move bytecode v6
}

