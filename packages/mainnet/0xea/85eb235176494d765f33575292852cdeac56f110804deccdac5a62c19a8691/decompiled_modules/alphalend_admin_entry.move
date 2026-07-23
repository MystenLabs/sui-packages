module 0xea85eb235176494d765f33575292852cdeac56f110804deccdac5a62c19a8691::alphalend_admin_entry {
    public fun init_alphalend_position_cap<T0, T1>(arg0: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::LLVGlobal, arg1: &mut 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: &mut 0x2::tx_context::TxContext) {
        0xea85eb235176494d765f33575292852cdeac56f110804deccdac5a62c19a8691::alphalend_entry::authorize(arg0);
        let v0 = 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::alphalend_position_cap_key();
        assert!(!0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::has_protocol_cap<T0, T1, 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::AlphaLendPositionCapKey>(arg1, 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::PROTOCOL_ALPHALEND(), v0), 1);
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_validation::validate_alphalend_protocol<T0, T1>(arg1, 0x2::object::id<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol>(arg2));
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::store_protocol_cap<T0, T1, 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::AlphaLendPositionCapKey, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap>(arg1, 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::PROTOCOL_ALPHALEND(), v0, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::create_position(arg2, arg3), arg3);
    }

    public fun migrate(arg0: &mut 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::LLVGlobal, arg1: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::LLVGlobalAdminCap, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0xea85eb235176494d765f33575292852cdeac56f110804deccdac5a62c19a8691::alphalend_entry::migration_witness();
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::migrate_ext_version<0xea85eb235176494d765f33575292852cdeac56f110804deccdac5a62c19a8691::alphalend_entry::AlphaLendLegAuth>(arg0, arg1, 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::PROTOCOL_ALPHALEND(), 0xea85eb235176494d765f33575292852cdeac56f110804deccdac5a62c19a8691::alphalend_entry::package_version(), &v0, arg2);
    }

    public fun register_alphalend_leg_auth<T0, T1>(arg0: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::LLVGlobal, arg1: &mut 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>, arg2: &0x2::tx_context::TxContext) {
        0xea85eb235176494d765f33575292852cdeac56f110804deccdac5a62c19a8691::alphalend_entry::authorize(arg0);
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::register_protocol_leg_auth<T0, T1, 0xea85eb235176494d765f33575292852cdeac56f110804deccdac5a62c19a8691::alphalend_entry::AlphaLendLegAuth>(arg1, 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::PROTOCOL_ALPHALEND(), arg2);
    }

    // decompiled from Move bytecode v7
}

