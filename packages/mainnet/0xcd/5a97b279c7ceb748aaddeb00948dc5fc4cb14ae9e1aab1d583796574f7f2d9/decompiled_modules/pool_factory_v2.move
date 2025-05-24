module 0xcd5a97b279c7ceb748aaddeb00948dc5fc4cb14ae9e1aab1d583796574f7f2d9::pool_factory_v2 {
    public entry fun create_pool<T0, T1>(arg0: &mut 0xcd5a97b279c7ceb748aaddeb00948dc5fc4cb14ae9e1aab1d583796574f7f2d9::amm_v2::Global, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (_, v1) = 0xcd5a97b279c7ceb748aaddeb00948dc5fc4cb14ae9e1aab1d583796574f7f2d9::amm_v2::create_pool_with_lp_tokens<T0, T1>(arg0, arg1, arg2, arg3, arg4, 9, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<0xcd5a97b279c7ceb748aaddeb00948dc5fc4cb14ae9e1aab1d583796574f7f2d9::amm_v2::LP<T0, T1>>>(v1);
    }

    // decompiled from Move bytecode v6
}

