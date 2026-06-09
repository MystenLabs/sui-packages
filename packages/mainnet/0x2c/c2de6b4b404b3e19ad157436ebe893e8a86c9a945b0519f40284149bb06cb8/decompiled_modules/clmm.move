module 0x2cc2de6b4b404b3e19ad157436ebe893e8a86c9a945b0519f40284149bb06cb8::clmm {
    public fun swap<T0, T1>(arg0: &mut 0x4dea343c9fe65d83b514a8520fdc619464be1debf598ad1e60f19b513cddb204::router::SwapContext, arg1: &0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::config::GlobalConfig, arg2: &mut 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::Pool<T0, T1>, arg3: bool, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        if (arg3) {
            swap_a2b<T0, T1>(arg0, arg1, arg2, arg4, arg5, arg6);
        } else {
            swap_b2a<T0, T1>(arg0, arg1, arg2, arg4, arg5, arg6);
        };
    }

    fun swap_a2b<T0, T1>(arg0: &mut 0x4dea343c9fe65d83b514a8520fdc619464be1debf598ad1e60f19b513cddb204::router::SwapContext, arg1: &0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::config::GlobalConfig, arg2: &mut 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::Pool<T0, T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x4dea343c9fe65d83b514a8520fdc619464be1debf598ad1e60f19b513cddb204::router::take_balance<T0>(arg0, arg3);
        let v1 = 0x2::balance::value<T0>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<T0>(v0);
            return
        };
        let (v2, v3, v4) = 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::flash_swap<T0, T1>(arg1, arg2, true, true, v1, 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::tick_math::min_sqrt_price(), arg4);
        0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::repay_flash_swap<T0, T1>(arg1, arg2, v0, 0x2::balance::zero<T1>(), v4);
        if (arg3 == 0x4dea343c9fe65d83b514a8520fdc619464be1debf598ad1e60f19b513cddb204::router::max_amount_in()) {
            0x4dea343c9fe65d83b514a8520fdc619464be1debf598ad1e60f19b513cddb204::router::transfer_remaining_balance<T0>(arg0, v2, arg5);
        } else {
            0x4dea343c9fe65d83b514a8520fdc619464be1debf598ad1e60f19b513cddb204::router::merge_balance<T0>(arg0, v2);
        };
        0x4dea343c9fe65d83b514a8520fdc619464be1debf598ad1e60f19b513cddb204::router::merge_balance<T1>(arg0, v3);
    }

    fun swap_b2a<T0, T1>(arg0: &mut 0x4dea343c9fe65d83b514a8520fdc619464be1debf598ad1e60f19b513cddb204::router::SwapContext, arg1: &0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::config::GlobalConfig, arg2: &mut 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::Pool<T0, T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x4dea343c9fe65d83b514a8520fdc619464be1debf598ad1e60f19b513cddb204::router::take_balance<T1>(arg0, arg3);
        let v1 = 0x2::balance::value<T1>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<T1>(v0);
            return
        };
        let (v2, v3, v4) = 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::flash_swap<T0, T1>(arg1, arg2, false, true, v1, 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::tick_math::max_sqrt_price(), arg4);
        0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::zero<T0>(), v0, v4);
        if (arg3 == 0x4dea343c9fe65d83b514a8520fdc619464be1debf598ad1e60f19b513cddb204::router::max_amount_in()) {
            0x4dea343c9fe65d83b514a8520fdc619464be1debf598ad1e60f19b513cddb204::router::transfer_remaining_balance<T1>(arg0, v3, arg5);
        } else {
            0x4dea343c9fe65d83b514a8520fdc619464be1debf598ad1e60f19b513cddb204::router::merge_balance<T1>(arg0, v3);
        };
        0x4dea343c9fe65d83b514a8520fdc619464be1debf598ad1e60f19b513cddb204::router::merge_balance<T0>(arg0, v2);
    }

    // decompiled from Move bytecode v7
}

