module 0x1127c9b1a8caffd6749d00bfd9191b0392f6afba3bef16a8072dc45f1eb61b38::cclmm {
    public fun sp<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0xbed221ac7d10f58c3d52bd4326e69848fd3e8b4d3d5fa5dbb9aedabe630c1ac7::bm::CBM, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: bool, arg4: u64, arg5: u64, arg6: u128, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : u64 {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg2, arg3, true, arg4, arg6, arg7);
        let v3 = v2;
        let v4 = v1;
        let v5 = v0;
        let v6 = if (arg3) {
            0x2::balance::value<T1>(&v4)
        } else {
            0x2::balance::value<T0>(&v5)
        };
        assert!(v6 >= arg5, 1);
        let v7 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3);
        let (v8, v9) = if (arg3) {
            (0xbed221ac7d10f58c3d52bd4326e69848fd3e8b4d3d5fa5dbb9aedabe630c1ac7::bm::wd<T0>(arg1, v7, arg8), 0x2::coin::zero<T1>(arg8))
        } else {
            (0x2::coin::zero<T0>(arg8), 0xbed221ac7d10f58c3d52bd4326e69848fd3e8b4d3d5fa5dbb9aedabe630c1ac7::bm::wd<T1>(arg1, v7, arg8))
        };
        let v10 = v9;
        let v11 = v8;
        let (v12, v13) = if (arg3) {
            (0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v11, v7, arg8)), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v10, v7, arg8)))
        };
        0x2::coin::join<T0>(&mut v11, 0x2::coin::from_balance<T0>(v5, arg8));
        0x2::coin::join<T1>(&mut v10, 0x2::coin::from_balance<T1>(v4, arg8));
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg2, v12, v13, v3);
        0xbed221ac7d10f58c3d52bd4326e69848fd3e8b4d3d5fa5dbb9aedabe630c1ac7::bm::dp<T0>(arg1, v11, arg8);
        0xbed221ac7d10f58c3d52bd4326e69848fd3e8b4d3d5fa5dbb9aedabe630c1ac7::bm::dp<T1>(arg1, v10, arg8);
        0
    }

    // decompiled from Move bytecode v6
}

