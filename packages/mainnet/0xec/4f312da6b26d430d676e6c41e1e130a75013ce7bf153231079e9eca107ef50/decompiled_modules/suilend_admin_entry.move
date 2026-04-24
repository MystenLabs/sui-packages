module 0xec4f312da6b26d430d676e6c41e1e130a75013ce7bf153231079e9eca107ef50::suilend_admin_entry {
    public fun init_suilend_obligation<T0, T1, T2>(arg0: &0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_admin::LLVGlobal, arg1: &mut 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::LLVPool<T1, T2>, arg2: &0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_admin::LLVPoolAdminCap, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_admin::assert_version(arg0);
        assert!(!0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::has_protocol_cap<T1, T2, 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::SuilendObligationCapKey>(arg1, 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::suilend_obligation_cap_key()), 1);
        0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_validation::validate_suilend_config<T1, T2>(arg1, 0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>>(arg3), arg4);
        0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::store_protocol_cap<T1, T2, 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::SuilendObligationCapKey, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>>(arg1, arg2, 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::suilend_obligation_cap_key(), 0xec4f312da6b26d430d676e6c41e1e130a75013ce7bf153231079e9eca107ef50::suilend_adapter::create_obligation<T0>(arg3, arg5));
    }

    // decompiled from Move bytecode v7
}

