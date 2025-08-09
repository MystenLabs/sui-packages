module 0x70dcf63182f0755c02ac3c8e448777320998c8fd2400fa3b6d1847296b0d5f81::swap_bluemove {
    public fun swap_a2b<T0, T1, T2, T3>(arg0: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg1: 0x2::coin::Coin<T0>, arg2: &0x1a830340e1caed73881c51f13fd3c1409153879493b56688118012c25b658512::swap_transaction::SwapTransaction<T2, T3>, arg3: &0x1a830340e1caed73881c51f13fd3c1409153879493b56688118012c25b658512::state::State, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::value<T0>(&arg1);
        let v1 = 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::router::swap_exact_input_<T0, T1>(v0, arg1, 0, arg0, arg4);
        let v2 = 0x2::object::id<0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info>(arg0);
        0x70dcf63182f0755c02ac3c8e448777320998c8fd2400fa3b6d1847296b0d5f81::swap_event::emit_common_swap<T0, T1>(0x1a830340e1caed73881c51f13fd3c1409153879493b56688118012c25b658512::consts::DEX_BLUEMOVE(), 0x2::object::id_to_address(&v2), true, v0, 0x2::coin::value<T1>(&v1), true);
        v1
    }

    public fun swap_b2a<T0, T1, T2, T3>(arg0: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg1: 0x2::coin::Coin<T1>, arg2: &0x1a830340e1caed73881c51f13fd3c1409153879493b56688118012c25b658512::swap_transaction::SwapTransaction<T2, T3>, arg3: &0x1a830340e1caed73881c51f13fd3c1409153879493b56688118012c25b658512::state::State, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::value<T1>(&arg1);
        let v1 = 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::router::swap_exact_input_<T1, T0>(v0, arg1, 0, arg0, arg4);
        let v2 = 0x2::object::id<0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info>(arg0);
        0x70dcf63182f0755c02ac3c8e448777320998c8fd2400fa3b6d1847296b0d5f81::swap_event::emit_common_swap<T0, T1>(0x1a830340e1caed73881c51f13fd3c1409153879493b56688118012c25b658512::consts::DEX_BLUEMOVE(), 0x2::object::id_to_address(&v2), false, v0, 0x2::coin::value<T0>(&v1), true);
        v1
    }

    // decompiled from Move bytecode v6
}

