module 0xfd2f720fd4c0d5bc2d35406d757d12ef2620291985fcc2ffc0c10f737ab93198::bluefin_agg {
    struct BluefinAgg has drop {
        dummy_field: bool,
    }

    public fun swap<T0, T1, T2>(arg0: &0x3ea8086d86d553af887e758efe2fc67554ee599b9428a9e26312881a7a26b007::liquidator::Liquidator, arg1: &mut 0x3ea8086d86d553af887e758efe2fc67554ee599b9428a9e26312881a7a26b007::custom_liquidate::CustomLiquidateReceipt<T0>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg4: bool, arg5: u64, arg6: &0x2::clock::Clock) {
        let (v0, v1) = if (arg4) {
            let v2 = BluefinAgg{dummy_field: false};
            swap_a2b<T1, T2>(arg2, arg3, 0x3ea8086d86d553af887e758efe2fc67554ee599b9428a9e26312881a7a26b007::custom_liquidate::take_balance<BluefinAgg, T0, T1>(arg1, arg0, v2, arg5), arg6)
        } else {
            let v3 = BluefinAgg{dummy_field: false};
            swap_b2a<T1, T2>(arg2, arg3, 0x3ea8086d86d553af887e758efe2fc67554ee599b9428a9e26312881a7a26b007::custom_liquidate::take_balance<BluefinAgg, T0, T2>(arg1, arg0, v3, arg5), arg6)
        };
        let v4 = v1;
        let v5 = v0;
        if (0x2::balance::value<T1>(&v5) > 0) {
            let v6 = BluefinAgg{dummy_field: false};
            0x3ea8086d86d553af887e758efe2fc67554ee599b9428a9e26312881a7a26b007::custom_liquidate::put_balance<BluefinAgg, T0, T1>(arg1, arg0, v6, v5);
        } else {
            0x2::balance::destroy_zero<T1>(v5);
        };
        if (0x2::balance::value<T2>(&v4) > 0) {
            let v7 = BluefinAgg{dummy_field: false};
            0x3ea8086d86d553af887e758efe2fc67554ee599b9428a9e26312881a7a26b007::custom_liquidate::put_balance<BluefinAgg, T0, T2>(arg1, arg0, v7, v4);
        } else {
            0x2::balance::destroy_zero<T2>(v4);
        };
    }

    fun swap_a2b<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = 0x2::balance::value<T0>(&arg2);
        if (v0 == 0) {
            0x2::balance::destroy_zero<T0>(arg2);
            return (0x2::balance::zero<T0>(), 0x2::balance::zero<T1>())
        };
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg3, arg0, arg1, arg2, 0x2::balance::zero<T1>(), true, true, v0, 0, 4295048017)
    }

    fun swap_b2a<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T1>, arg3: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = 0x2::balance::value<T1>(&arg2);
        if (v0 == 0) {
            0x2::balance::destroy_zero<T1>(arg2);
            return (0x2::balance::zero<T0>(), 0x2::balance::zero<T1>())
        };
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg3, arg0, arg1, 0x2::balance::zero<T0>(), arg2, false, true, v0, 0, 79226673515401279992447579054)
    }

    // decompiled from Move bytecode v6
}

