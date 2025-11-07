module 0xbd565f17c7f959cc177cc9c3d0d093259e09d6abdf6befdd39c0d5346d71f746::whitelist_admin {
    public fun burn_whitelist(arg0: &mut 0xbd565f17c7f959cc177cc9c3d0d093259e09d6abdf6befdd39c0d5346d71f746::app::ProtocolApp, arg1: 0xbd565f17c7f959cc177cc9c3d0d093259e09d6abdf6befdd39c0d5346d71f746::app::PackageCallerCap) {
        let v0 = 0x2::object::id<0xbd565f17c7f959cc177cc9c3d0d093259e09d6abdf6befdd39c0d5346d71f746::app::PackageCallerCap>(&arg1);
        let (_, _) = 0x2::vec_map::remove<0x2::object::ID, u32>(0xbd565f17c7f959cc177cc9c3d0d093259e09d6abdf6befdd39c0d5346d71f746::app::whitelist_mut(arg0), &v0);
        0xbd565f17c7f959cc177cc9c3d0d093259e09d6abdf6befdd39c0d5346d71f746::app::burn_cap(arg1);
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

    public fun mint_new_whitelist(arg0: &0xbd565f17c7f959cc177cc9c3d0d093259e09d6abdf6befdd39c0d5346d71f746::app::AdminCap, arg1: &mut 0xbd565f17c7f959cc177cc9c3d0d093259e09d6abdf6befdd39c0d5346d71f746::app::ProtocolApp, arg2: &mut 0x2::tx_context::TxContext) : 0xbd565f17c7f959cc177cc9c3d0d093259e09d6abdf6befdd39c0d5346d71f746::app::PackageCallerCap {
        let v0 = 0xbd565f17c7f959cc177cc9c3d0d093259e09d6abdf6befdd39c0d5346d71f746::app::mint_cap(arg2);
        0x2::vec_map::insert<0x2::object::ID, u32>(0xbd565f17c7f959cc177cc9c3d0d093259e09d6abdf6befdd39c0d5346d71f746::app::whitelist_mut(arg1), 0x2::object::id<0xbd565f17c7f959cc177cc9c3d0d093259e09d6abdf6befdd39c0d5346d71f746::app::PackageCallerCap>(&v0), 0);
        v0
    }

    public fun remove_whitelist(arg0: &0xbd565f17c7f959cc177cc9c3d0d093259e09d6abdf6befdd39c0d5346d71f746::app::AdminCap, arg1: &mut 0xbd565f17c7f959cc177cc9c3d0d093259e09d6abdf6befdd39c0d5346d71f746::app::ProtocolApp, arg2: 0x2::object::ID) {
        let (_, _) = 0x2::vec_map::remove<0x2::object::ID, u32>(0xbd565f17c7f959cc177cc9c3d0d093259e09d6abdf6befdd39c0d5346d71f746::app::whitelist_mut(arg1), &arg2);
    }

    public fun update_permission(arg0: &0xbd565f17c7f959cc177cc9c3d0d093259e09d6abdf6befdd39c0d5346d71f746::app::AdminCap, arg1: &mut 0xbd565f17c7f959cc177cc9c3d0d093259e09d6abdf6befdd39c0d5346d71f746::app::ProtocolApp, arg2: 0x2::object::ID, arg3: u8, arg4: bool) {
        assert!(arg3 < 3, 13906834397681680383);
        let v0 = 0x2::vec_map::get_mut<0x2::object::ID, u32>(0xbd565f17c7f959cc177cc9c3d0d093259e09d6abdf6befdd39c0d5346d71f746::app::whitelist_mut(arg1), &arg2);
        if (arg4) {
            *v0 = *v0 | 1 << arg3;
        } else {
            *v0 = *v0 & (1 << arg3 ^ 4294967295);
        };
    }

    // decompiled from Move bytecode v6
}

