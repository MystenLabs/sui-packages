module 0xb24d2c9ae39a07cabfeaa8afa89fc99b87486ee329ae3d99816bcdd2c5c6351d::leverage_admin {
    public fun inject_protocol_caller_cap(arg0: &0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::app::AdminCap, arg1: &mut 0xb24d2c9ae39a07cabfeaa8afa89fc99b87486ee329ae3d99816bcdd2c5c6351d::leverage_app::LeverageApp, arg2: 0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::app::PackageCallerCap) {
        0xb24d2c9ae39a07cabfeaa8afa89fc99b87486ee329ae3d99816bcdd2c5c6351d::leverage_app::accept_protocol_caller_cap(arg1, arg2);
    }

    public fun onboard_market<T0>(arg0: &0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::app::AdminCap, arg1: &0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::market::Market<T0>, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::market::assert_emode_group_exists<T0>(arg1, arg2);
        0x2::transfer::public_share_object<0xb24d2c9ae39a07cabfeaa8afa89fc99b87486ee329ae3d99816bcdd2c5c6351d::leverage_market::LeverageMarket>(0xb24d2c9ae39a07cabfeaa8afa89fc99b87486ee329ae3d99816bcdd2c5c6351d::leverage_market::new_market(0x2::object::id<0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::market::Market<T0>>(arg1), arg2, arg3));
    }

    public fun remove_protocol_caller_cap(arg0: &0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::app::AdminCap, arg1: &mut 0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::app::ProtocolApp, arg2: &mut 0xb24d2c9ae39a07cabfeaa8afa89fc99b87486ee329ae3d99816bcdd2c5c6351d::leverage_app::LeverageApp) {
        0xb24d2c9ae39a07cabfeaa8afa89fc99b87486ee329ae3d99816bcdd2c5c6351d::leverage_app::revoke_protocol_caller_cap(arg2, arg1);
    }

    // decompiled from Move bytecode v6
}

