module 0x2c11c14fe07381e97c5b4033b7c85c21cb7ae30a4c35a91a64685a4728d85f90::leverage_admin {
    public fun inject_protocol_caller_cap(arg0: &0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::app::AdminCap, arg1: &mut 0x2c11c14fe07381e97c5b4033b7c85c21cb7ae30a4c35a91a64685a4728d85f90::leverage_app::LeverageApp, arg2: 0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::app::PackageCallerCap) {
        0x2c11c14fe07381e97c5b4033b7c85c21cb7ae30a4c35a91a64685a4728d85f90::leverage_app::accept_protocol_caller_cap(arg1, arg2);
    }

    public fun onboard_market<T0>(arg0: &0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::app::AdminCap, arg1: &0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::market::Market<T0>, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::market::assert_emode_group_exists<T0>(arg1, arg2);
        0x2::transfer::public_share_object<0x2c11c14fe07381e97c5b4033b7c85c21cb7ae30a4c35a91a64685a4728d85f90::leverage_market::LeverageMarket>(0x2c11c14fe07381e97c5b4033b7c85c21cb7ae30a4c35a91a64685a4728d85f90::leverage_market::new_market(0x2::object::id<0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::market::Market<T0>>(arg1), arg2, arg3));
    }

    public fun remove_protocol_caller_cap(arg0: &0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::app::AdminCap, arg1: &mut 0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::app::ProtocolApp, arg2: &mut 0x2c11c14fe07381e97c5b4033b7c85c21cb7ae30a4c35a91a64685a4728d85f90::leverage_app::LeverageApp) {
        0x2c11c14fe07381e97c5b4033b7c85c21cb7ae30a4c35a91a64685a4728d85f90::leverage_app::revoke_protocol_caller_cap(arg2, arg1);
    }

    // decompiled from Move bytecode v6
}

