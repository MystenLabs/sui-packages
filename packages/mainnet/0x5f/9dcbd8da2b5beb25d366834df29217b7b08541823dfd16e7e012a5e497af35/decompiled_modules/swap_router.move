module 0x5f9dcbd8da2b5beb25d366834df29217b7b08541823dfd16e7e012a5e497af35::swap_router {
    public fun swap_exact_input<T0, T1, T2>(arg0: &mut 0x785e9d433a65ae2aae4f9cd69fc194334acb0f55a2747ed91996c57a7e2f7e2e::universal_router::Route, arg1: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry, arg2: &mut 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T0>, arg3: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg4: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg5: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg6: &mut 0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x785e9d433a65ae2aae4f9cd69fc194334acb0f55a2747ed91996c57a7e2f7e2e::universal_router::borrow_mut_current_path<T1, T2>(arg0);
        0x785e9d433a65ae2aae4f9cd69fc194334acb0f55a2747ed91996c57a7e2f7e2e::universal_router::fill_coin_out<T1, T2>(v0, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::swap::swap_exact_in<T0, T1, T2>(arg2, arg1, arg3, arg4, arg5, arg6, 0x785e9d433a65ae2aae4f9cd69fc194334acb0f55a2747ed91996c57a7e2f7e2e::universal_router::take_coin_in<T1, T2>(v0), arg7, 1000000000000000000, arg8));
    }

    // decompiled from Move bytecode v6
}

