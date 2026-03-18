module 0x8d24a2d7c171db6f5021149197e4bccfc6070fea586a862acdefd45de2568b62::whitelist_admin {
    public fun adl() : u8 {
        3
    }

    public fun burn_whitelist(arg0: &mut 0x8d24a2d7c171db6f5021149197e4bccfc6070fea586a862acdefd45de2568b62::app::ProtocolApp, arg1: 0x8d24a2d7c171db6f5021149197e4bccfc6070fea586a862acdefd45de2568b62::app::PackageCallerCap) {
        0x8d24a2d7c171db6f5021149197e4bccfc6070fea586a862acdefd45de2568b62::app::ensure_version_matches(arg0);
        let v0 = 0x8d24a2d7c171db6f5021149197e4bccfc6070fea586a862acdefd45de2568b62::app::whitelist_mut(arg0);
        let v1 = 0x2::object::id<0x8d24a2d7c171db6f5021149197e4bccfc6070fea586a862acdefd45de2568b62::app::PackageCallerCap>(&arg1);
        if (0x2::vec_map::contains<0x2::object::ID, u32>(v0, &v1)) {
            let (_, _) = 0x2::vec_map::remove<0x2::object::ID, u32>(v0, &v1);
        };
        0x8d24a2d7c171db6f5021149197e4bccfc6070fea586a862acdefd45de2568b62::app::burn_cap(arg1);
    }

    public fun enter_market_with_emode() : u8 {
        1
    }

    public fun flash_loan() : u8 {
        0
    }

    public fun liquidation() : u8 {
        2
    }

    public fun mint_new_whitelist(arg0: &0x8d24a2d7c171db6f5021149197e4bccfc6070fea586a862acdefd45de2568b62::app::AdminCap, arg1: &mut 0x8d24a2d7c171db6f5021149197e4bccfc6070fea586a862acdefd45de2568b62::app::ProtocolApp, arg2: &mut 0x2::tx_context::TxContext) : 0x8d24a2d7c171db6f5021149197e4bccfc6070fea586a862acdefd45de2568b62::app::PackageCallerCap {
        let v0 = 0x8d24a2d7c171db6f5021149197e4bccfc6070fea586a862acdefd45de2568b62::app::mint_cap(arg2);
        0x8d24a2d7c171db6f5021149197e4bccfc6070fea586a862acdefd45de2568b62::app::ensure_version_matches(arg1);
        0x2::vec_map::insert<0x2::object::ID, u32>(0x8d24a2d7c171db6f5021149197e4bccfc6070fea586a862acdefd45de2568b62::app::whitelist_mut(arg1), 0x2::object::id<0x8d24a2d7c171db6f5021149197e4bccfc6070fea586a862acdefd45de2568b62::app::PackageCallerCap>(&v0), 0);
        v0
    }

    public fun remove_whitelist(arg0: &0x8d24a2d7c171db6f5021149197e4bccfc6070fea586a862acdefd45de2568b62::app::AdminCap, arg1: &mut 0x8d24a2d7c171db6f5021149197e4bccfc6070fea586a862acdefd45de2568b62::app::ProtocolApp, arg2: 0x2::object::ID) {
        0x8d24a2d7c171db6f5021149197e4bccfc6070fea586a862acdefd45de2568b62::app::ensure_version_matches(arg1);
        let (_, _) = 0x2::vec_map::remove<0x2::object::ID, u32>(0x8d24a2d7c171db6f5021149197e4bccfc6070fea586a862acdefd45de2568b62::app::whitelist_mut(arg1), &arg2);
    }

    public fun update_permission(arg0: &0x8d24a2d7c171db6f5021149197e4bccfc6070fea586a862acdefd45de2568b62::app::AdminCap, arg1: &mut 0x8d24a2d7c171db6f5021149197e4bccfc6070fea586a862acdefd45de2568b62::app::ProtocolApp, arg2: 0x2::object::ID, arg3: u8, arg4: bool) {
        assert!(arg3 < 4, 0x8d24a2d7c171db6f5021149197e4bccfc6070fea586a862acdefd45de2568b62::error::invalid_params_error());
        0x8d24a2d7c171db6f5021149197e4bccfc6070fea586a862acdefd45de2568b62::app::ensure_version_matches(arg1);
        let v0 = 0x2::vec_map::get_mut<0x2::object::ID, u32>(0x8d24a2d7c171db6f5021149197e4bccfc6070fea586a862acdefd45de2568b62::app::whitelist_mut(arg1), &arg2);
        if (arg4) {
            *v0 = *v0 | 1 << arg3;
        } else {
            *v0 = *v0 & (1 << arg3 ^ 4294967295);
        };
    }

    // decompiled from Move bytecode v6
}

