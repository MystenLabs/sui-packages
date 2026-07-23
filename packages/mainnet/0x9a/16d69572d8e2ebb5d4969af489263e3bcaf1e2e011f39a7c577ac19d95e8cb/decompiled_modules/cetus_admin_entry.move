module 0x9a16d69572d8e2ebb5d4969af489263e3bcaf1e2e011f39a7c577ac19d95e8cb::cetus_admin_entry {
    public fun migrate(arg0: &mut 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::LLVGlobal, arg1: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::LLVGlobalAdminCap, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x9a16d69572d8e2ebb5d4969af489263e3bcaf1e2e011f39a7c577ac19d95e8cb::cetus_entry::migration_witness();
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::migrate_ext_version<0x9a16d69572d8e2ebb5d4969af489263e3bcaf1e2e011f39a7c577ac19d95e8cb::cetus_entry::CetusLegAuth>(arg0, arg1, 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::PROTOCOL_CETUS(), 0x9a16d69572d8e2ebb5d4969af489263e3bcaf1e2e011f39a7c577ac19d95e8cb::cetus_entry::package_version(), &v0, arg2);
    }

    public fun register_cetus_hasui_leg_auth<T0>(arg0: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::LLVGlobal, arg1: &mut 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, T0>, arg2: &0x2::tx_context::TxContext) {
        0x9a16d69572d8e2ebb5d4969af489263e3bcaf1e2e011f39a7c577ac19d95e8cb::cetus_entry::authorize(arg0);
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::register_protocol_leg_auth<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, T0, 0x9a16d69572d8e2ebb5d4969af489263e3bcaf1e2e011f39a7c577ac19d95e8cb::cetus_entry::CetusLegAuth>(arg1, 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::PROTOCOL_CETUS(), arg2);
    }

    public fun register_cetus_leg_auth<T0>(arg0: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::LLVGlobal, arg1: &mut 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<0x2::sui::SUI, T0>, arg2: &0x2::tx_context::TxContext) {
        0x9a16d69572d8e2ebb5d4969af489263e3bcaf1e2e011f39a7c577ac19d95e8cb::cetus_entry::authorize(arg0);
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::register_protocol_leg_auth<0x2::sui::SUI, T0, 0x9a16d69572d8e2ebb5d4969af489263e3bcaf1e2e011f39a7c577ac19d95e8cb::cetus_entry::CetusLegAuth>(arg1, 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::PROTOCOL_CETUS(), arg2);
    }

    // decompiled from Move bytecode v7
}

