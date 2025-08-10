module 0x70dcf63182f0755c02ac3c8e448777320998c8fd2400fa3b6d1847296b0d5f81::swap_sevenk {
    public fun swap_a2b<T0, T1, T2, T3, T4>(arg0: &mut 0x4142285db093ba0cf0623b3cbc07372fb4f5ed00af1fb62be6d55f49a42c0b0e::pool_v1::Pool<T0, T1, T2>, arg1: &0x8c36ea167c5e6da8c3d60b4fc897416105dcb986471bd81cfbfd38720a4487c0::oracle::OracleHolder, arg2: 0x2::coin::Coin<T0>, arg3: &0x1a830340e1caed73881c51f13fd3c1409153879493b56688118012c25b658512::swap_transaction::SwapTransaction<T3, T4>, arg4: &0x1a830340e1caed73881c51f13fd3c1409153879493b56688118012c25b658512::state::State, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x4142285db093ba0cf0623b3cbc07372fb4f5ed00af1fb62be6d55f49a42c0b0e::pool_v1::swap_x_to_y<T0, T1, T2>(arg0, arg1, arg2, 0, arg5);
        let v1 = 0x2::object::id<0x4142285db093ba0cf0623b3cbc07372fb4f5ed00af1fb62be6d55f49a42c0b0e::pool_v1::Pool<T0, T1, T2>>(arg0);
        0x70dcf63182f0755c02ac3c8e448777320998c8fd2400fa3b6d1847296b0d5f81::swap_event::emit_common_swap<T0, T1>(0x1a830340e1caed73881c51f13fd3c1409153879493b56688118012c25b658512::consts::DEX_SEVENK(), 0x2::object::id_to_address(&v1), true, 0x2::coin::value<T0>(&arg2), 0x2::coin::value<T1>(&v0), true);
        v0
    }

    public fun swap_b2a<T0, T1, T2, T3, T4>(arg0: &mut 0x4142285db093ba0cf0623b3cbc07372fb4f5ed00af1fb62be6d55f49a42c0b0e::pool_v1::Pool<T0, T1, T2>, arg1: &0x8c36ea167c5e6da8c3d60b4fc897416105dcb986471bd81cfbfd38720a4487c0::oracle::OracleHolder, arg2: 0x2::coin::Coin<T1>, arg3: &0x1a830340e1caed73881c51f13fd3c1409153879493b56688118012c25b658512::swap_transaction::SwapTransaction<T3, T4>, arg4: &0x1a830340e1caed73881c51f13fd3c1409153879493b56688118012c25b658512::state::State, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x4142285db093ba0cf0623b3cbc07372fb4f5ed00af1fb62be6d55f49a42c0b0e::pool_v1::swap_y_to_x<T0, T1, T2>(arg0, arg1, arg2, 0, arg5);
        let v1 = 0x2::object::id<0x4142285db093ba0cf0623b3cbc07372fb4f5ed00af1fb62be6d55f49a42c0b0e::pool_v1::Pool<T0, T1, T2>>(arg0);
        0x70dcf63182f0755c02ac3c8e448777320998c8fd2400fa3b6d1847296b0d5f81::swap_event::emit_common_swap<T0, T1>(0x1a830340e1caed73881c51f13fd3c1409153879493b56688118012c25b658512::consts::DEX_SEVENK(), 0x2::object::id_to_address(&v1), false, 0x2::coin::value<T1>(&arg2), 0x2::coin::value<T0>(&v0), true);
        v0
    }

    // decompiled from Move bytecode v6
}

