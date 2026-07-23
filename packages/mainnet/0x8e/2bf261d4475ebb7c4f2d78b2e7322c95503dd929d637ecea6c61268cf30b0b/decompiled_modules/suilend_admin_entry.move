module 0x8e2bf261d4475ebb7c4f2d78b2e7322c95503dd929d637ecea6c61268cf30b0b::suilend_admin_entry {
    public fun init_suilend_obligation<T0, T1, T2>(arg0: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::LLVGlobal, arg1: &mut 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T1, T2>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x8e2bf261d4475ebb7c4f2d78b2e7322c95503dd929d637ecea6c61268cf30b0b::suilend_entry::authorize(arg0);
        assert!(!0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::has_protocol_cap<T1, T2, 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::SuilendObligationCapKey>(arg1, 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::PROTOCOL_SUILEND(), 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::suilend_obligation_cap_key()), 1);
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_validation::validate_suilend_config<T1, T2>(arg1, 0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>>(arg2), arg3);
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::store_protocol_cap<T1, T2, 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::SuilendObligationCapKey, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>>(arg1, 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::PROTOCOL_SUILEND(), 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::suilend_obligation_cap_key(), 0x8e2bf261d4475ebb7c4f2d78b2e7322c95503dd929d637ecea6c61268cf30b0b::suilend_adapter::create_obligation<T0>(arg2, arg4), arg4);
    }

    public fun migrate(arg0: &mut 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::LLVGlobal, arg1: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::LLVGlobalAdminCap, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x8e2bf261d4475ebb7c4f2d78b2e7322c95503dd929d637ecea6c61268cf30b0b::suilend_entry::migration_witness();
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::migrate_ext_version<0x8e2bf261d4475ebb7c4f2d78b2e7322c95503dd929d637ecea6c61268cf30b0b::suilend_entry::SuilendLegAuth>(arg0, arg1, 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::PROTOCOL_SUILEND(), 0x8e2bf261d4475ebb7c4f2d78b2e7322c95503dd929d637ecea6c61268cf30b0b::suilend_entry::package_version(), &v0, arg2);
    }

    public fun register_suilend_leg_auth<T0, T1>(arg0: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::LLVGlobal, arg1: &mut 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>, arg2: &0x2::tx_context::TxContext) {
        0x8e2bf261d4475ebb7c4f2d78b2e7322c95503dd929d637ecea6c61268cf30b0b::suilend_entry::authorize(arg0);
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::register_protocol_leg_auth<T0, T1, 0x8e2bf261d4475ebb7c4f2d78b2e7322c95503dd929d637ecea6c61268cf30b0b::suilend_entry::SuilendLegAuth>(arg1, 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::PROTOCOL_SUILEND(), arg2);
    }

    // decompiled from Move bytecode v7
}

