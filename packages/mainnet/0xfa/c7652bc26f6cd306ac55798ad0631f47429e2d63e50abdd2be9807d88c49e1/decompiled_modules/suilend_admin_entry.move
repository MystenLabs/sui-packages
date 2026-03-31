module 0xfac7652bc26f6cd306ac55798ad0631f47429e2d63e50abdd2be9807d88c49e1::suilend_admin_entry {
    public fun init_suilend_obligation<T0, T1, T2>(arg0: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::LLVGlobal, arg1: &mut 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::LLVPool<T1, T2>, arg2: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::LLVPoolAdminCap, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::assert_version(arg0);
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_validation::validate_suilend_config<T1, T2>(arg1, 0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>>(arg3), arg4);
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::store_protocol_cap<T1, T2, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::SuilendObligationCapKey, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>>(arg1, arg2, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::suilend_obligation_cap_key(), 0xfac7652bc26f6cd306ac55798ad0631f47429e2d63e50abdd2be9807d88c49e1::suilend_adapter::create_obligation<T0>(arg3, arg5));
    }

    // decompiled from Move bytecode v6
}

