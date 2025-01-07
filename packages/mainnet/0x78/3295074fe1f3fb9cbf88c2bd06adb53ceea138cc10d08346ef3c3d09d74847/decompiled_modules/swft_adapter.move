module 0x783295074fe1f3fb9cbf88c2bd06adb53ceea138cc10d08346ef3c3d09d74847::swft_adapter {
    entry fun xbridge_swft<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: &mut 0x2::tx_context::TxContext) {
        0xc5ed6cc658e92632dcbd32d943c78dd2a47c082fbd26f7e68eb00e11fce161e3::Bridgers::swap<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    // decompiled from Move bytecode v6
}

