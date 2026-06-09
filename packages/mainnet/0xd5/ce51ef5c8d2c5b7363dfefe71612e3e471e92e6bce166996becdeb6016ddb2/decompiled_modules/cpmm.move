module 0xd5ce51ef5c8d2c5b7363dfefe71612e3e471e92e6bce166996becdeb6016ddb2::cpmm {
    public fun swap<T0, T1>(arg0: &mut 0x4dea343c9fe65d83b514a8520fdc619464be1debf598ad1e60f19b513cddb204::router::SwapContext, arg1: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg2: bool, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        if (arg2) {
            swap_a2b<T0, T1>(arg0, arg1, arg3, arg4);
        } else {
            swap_b2a<T0, T1>(arg0, arg1, arg3, arg4);
        };
    }

    public fun swap_a2b<T0, T1>(arg0: &mut 0x4dea343c9fe65d83b514a8520fdc619464be1debf598ad1e60f19b513cddb204::router::SwapContext, arg1: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::from_balance<T0>(0x4dea343c9fe65d83b514a8520fdc619464be1debf598ad1e60f19b513cddb204::router::take_balance<T0>(arg0, arg2), arg3);
        if (0x2::coin::value<T0>(&v0) == 0) {
            0x2::coin::destroy_zero<T0>(v0);
            return
        };
        0x4dea343c9fe65d83b514a8520fdc619464be1debf598ad1e60f19b513cddb204::router::merge_balance<T1>(arg0, 0x2::coin::into_balance<T1>(0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::router::swap_exact_input_direct<T0, T1>(arg1, v0, arg3)));
    }

    public fun swap_b2a<T0, T1>(arg0: &mut 0x4dea343c9fe65d83b514a8520fdc619464be1debf598ad1e60f19b513cddb204::router::SwapContext, arg1: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::from_balance<T1>(0x4dea343c9fe65d83b514a8520fdc619464be1debf598ad1e60f19b513cddb204::router::take_balance<T1>(arg0, arg2), arg3);
        if (0x2::coin::value<T1>(&v0) == 0) {
            0x2::coin::destroy_zero<T1>(v0);
            return
        };
        0x4dea343c9fe65d83b514a8520fdc619464be1debf598ad1e60f19b513cddb204::router::merge_balance<T0>(arg0, 0x2::coin::into_balance<T0>(0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::router::swap_exact_input_direct<T1, T0>(arg1, v0, arg3)));
    }

    // decompiled from Move bytecode v7
}

