module 0xb27aa9a7996a2630380441e012481eeb7012938107e3b7de8ac6c2386ac0e9f3::clmm {
    public fun swap<T0, T1>(arg0: &mut 0x4dea343c9fe65d83b514a8520fdc619464be1debf598ad1e60f19b513cddb204::router::SwapContext, arg1: &0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::config::HopConfig, arg2: &0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::dynamic_fee::DynamicFee, arg3: &mut 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::Pool<T0, T1>, arg4: bool, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        if (arg4) {
            swap_a2b<T0, T1>(arg0, arg1, arg2, arg3, arg5, arg6);
        } else {
            swap_b2a<T0, T1>(arg0, arg1, arg2, arg3, arg5, arg6);
        };
    }

    fun swap_a2b<T0, T1>(arg0: &mut 0x4dea343c9fe65d83b514a8520fdc619464be1debf598ad1e60f19b513cddb204::router::SwapContext, arg1: &0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::config::HopConfig, arg2: &0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::dynamic_fee::DynamicFee, arg3: &mut 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::Pool<T0, T1>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x4dea343c9fe65d83b514a8520fdc619464be1debf598ad1e60f19b513cddb204::router::take_balance<T0>(arg0, arg4);
        if (0x2::balance::value<T0>(&v0) == 0) {
            0x2::balance::destroy_zero<T0>(v0);
            return
        };
        let (v1, v2) = 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::trade::swap_returns<T0, T1>(arg1, arg2, arg3, 0x2::coin::from_balance<T0>(v0, arg5), 0x2::coin::zero<T1>(arg5), true, true, 4295048016, arg5);
        0x4dea343c9fe65d83b514a8520fdc619464be1debf598ad1e60f19b513cddb204::router::merge_balance<T1>(arg0, 0x2::coin::into_balance<T1>(v2));
        if (arg4 == 0x4dea343c9fe65d83b514a8520fdc619464be1debf598ad1e60f19b513cddb204::router::max_amount_in()) {
            0x4dea343c9fe65d83b514a8520fdc619464be1debf598ad1e60f19b513cddb204::router::transfer_remaining_balance<T0>(arg0, 0x2::coin::into_balance<T0>(v1), arg5);
        } else {
            0x4dea343c9fe65d83b514a8520fdc619464be1debf598ad1e60f19b513cddb204::router::merge_balance<T0>(arg0, 0x2::coin::into_balance<T0>(v1));
        };
    }

    fun swap_b2a<T0, T1>(arg0: &mut 0x4dea343c9fe65d83b514a8520fdc619464be1debf598ad1e60f19b513cddb204::router::SwapContext, arg1: &0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::config::HopConfig, arg2: &0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::dynamic_fee::DynamicFee, arg3: &mut 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::Pool<T0, T1>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x4dea343c9fe65d83b514a8520fdc619464be1debf598ad1e60f19b513cddb204::router::take_balance<T1>(arg0, arg4);
        if (0x2::balance::value<T1>(&v0) == 0) {
            0x2::balance::destroy_zero<T1>(v0);
            return
        };
        let (v1, v2) = 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::trade::swap_returns<T0, T1>(arg1, arg2, arg3, 0x2::coin::zero<T0>(arg5), 0x2::coin::from_balance<T1>(v0, arg5), false, true, 79226673515401279992447579055, arg5);
        0x4dea343c9fe65d83b514a8520fdc619464be1debf598ad1e60f19b513cddb204::router::merge_balance<T0>(arg0, 0x2::coin::into_balance<T0>(v1));
        if (arg4 == 0x4dea343c9fe65d83b514a8520fdc619464be1debf598ad1e60f19b513cddb204::router::max_amount_in()) {
            0x4dea343c9fe65d83b514a8520fdc619464be1debf598ad1e60f19b513cddb204::router::transfer_remaining_balance<T1>(arg0, 0x2::coin::into_balance<T1>(v2), arg5);
        } else {
            0x4dea343c9fe65d83b514a8520fdc619464be1debf598ad1e60f19b513cddb204::router::merge_balance<T1>(arg0, 0x2::coin::into_balance<T1>(v2));
        };
    }

    // decompiled from Move bytecode v7
}

