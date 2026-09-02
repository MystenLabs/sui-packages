module 0x9d466e02c0141fb3ba4c257a41f56e40308d836f927adb6a344623182cb05fa7::rebalance {
    struct RebalanceTicket {
        vault: 0x2::object::ID,
        min_out: u64,
    }

    public fun rebalance_a2b<T0, T1, T2>(arg0: &mut 0x9d466e02c0141fb3ba4c257a41f56e40308d836f927adb6a344623182cb05fa7::vault::Vault<T0>, arg1: &0x9d466e02c0141fb3ba4c257a41f56e40308d836f927adb6a344623182cb05fa7::vault::AdminCap, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg4: u64, arg5: u64, arg6: u128, arg7: &0x2::clock::Clock) {
        0x9d466e02c0141fb3ba4c257a41f56e40308d836f927adb6a344623182cb05fa7::vault::assert_admin<T0>(arg0, arg1);
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T2>(arg2, arg3, true, true, arg4, arg6, arg7);
        let v3 = v2;
        let v4 = v1;
        0x2::balance::destroy_zero<T1>(v0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T2>(arg2, arg3, 0x9d466e02c0141fb3ba4c257a41f56e40308d836f927adb6a344623182cb05fa7::vault::take_balance<T0, T1>(arg0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T2>(&v3)), 0x2::balance::zero<T2>(), v3);
        assert!(0x2::balance::value<T2>(&v4) >= arg5, 1);
        0x9d466e02c0141fb3ba4c257a41f56e40308d836f927adb6a344623182cb05fa7::vault::put_balance<T0, T2>(arg0, v4);
    }

    public fun rebalance_b2a<T0, T1, T2>(arg0: &mut 0x9d466e02c0141fb3ba4c257a41f56e40308d836f927adb6a344623182cb05fa7::vault::Vault<T0>, arg1: &0x9d466e02c0141fb3ba4c257a41f56e40308d836f927adb6a344623182cb05fa7::vault::AdminCap, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg4: u64, arg5: u64, arg6: u128, arg7: &0x2::clock::Clock) {
        0x9d466e02c0141fb3ba4c257a41f56e40308d836f927adb6a344623182cb05fa7::vault::assert_admin<T0>(arg0, arg1);
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T2>(arg2, arg3, false, true, arg4, arg6, arg7);
        let v3 = v2;
        let v4 = v0;
        0x2::balance::destroy_zero<T2>(v1);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T2>(arg2, arg3, 0x2::balance::zero<T1>(), 0x9d466e02c0141fb3ba4c257a41f56e40308d836f927adb6a344623182cb05fa7::vault::take_balance<T0, T2>(arg0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T2>(&v3)), v3);
        assert!(0x2::balance::value<T1>(&v4) >= arg5, 1);
        0x9d466e02c0141fb3ba4c257a41f56e40308d836f927adb6a344623182cb05fa7::vault::put_balance<T0, T1>(arg0, v4);
    }

    public fun rebalance_begin<T0, T1>(arg0: &mut 0x9d466e02c0141fb3ba4c257a41f56e40308d836f927adb6a344623182cb05fa7::vault::Vault<T0>, arg1: &0x9d466e02c0141fb3ba4c257a41f56e40308d836f927adb6a344623182cb05fa7::vault::AdminCap, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, RebalanceTicket) {
        0x9d466e02c0141fb3ba4c257a41f56e40308d836f927adb6a344623182cb05fa7::vault::assert_admin<T0>(arg0, arg1);
        let v0 = RebalanceTicket{
            vault   : 0x2::object::id<0x9d466e02c0141fb3ba4c257a41f56e40308d836f927adb6a344623182cb05fa7::vault::Vault<T0>>(arg0),
            min_out : arg3,
        };
        (0x2::coin::from_balance<T1>(0x9d466e02c0141fb3ba4c257a41f56e40308d836f927adb6a344623182cb05fa7::vault::take_balance<T0, T1>(arg0, arg2), arg4), v0)
    }

    public fun rebalance_end<T0, T1>(arg0: &mut 0x9d466e02c0141fb3ba4c257a41f56e40308d836f927adb6a344623182cb05fa7::vault::Vault<T0>, arg1: RebalanceTicket, arg2: 0x2::coin::Coin<T1>) {
        let RebalanceTicket {
            vault   : v0,
            min_out : v1,
        } = arg1;
        assert!(v0 == 0x2::object::id<0x9d466e02c0141fb3ba4c257a41f56e40308d836f927adb6a344623182cb05fa7::vault::Vault<T0>>(arg0), 2);
        assert!(0x2::coin::value<T1>(&arg2) >= v1, 1);
        0x9d466e02c0141fb3ba4c257a41f56e40308d836f927adb6a344623182cb05fa7::vault::put_balance<T0, T1>(arg0, 0x2::coin::into_balance<T1>(arg2));
    }

    public fun rebalance_via_sui<T0, T1, T2>(arg0: &mut 0x9d466e02c0141fb3ba4c257a41f56e40308d836f927adb6a344623182cb05fa7::vault::Vault<T0>, arg1: &0x9d466e02c0141fb3ba4c257a41f56e40308d836f927adb6a344623182cb05fa7::vault::AdminCap, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x2::sui::SUI, T1>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x2::sui::SUI, T2>, arg5: u64, arg6: u64, arg7: u128, arg8: u128, arg9: &0x2::clock::Clock) {
        0x9d466e02c0141fb3ba4c257a41f56e40308d836f927adb6a344623182cb05fa7::vault::assert_admin<T0>(arg0, arg1);
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<0x2::sui::SUI, T1>(arg2, arg3, false, true, arg5, arg7, arg9);
        let v3 = v2;
        let v4 = v0;
        0x2::balance::destroy_zero<T1>(v1);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<0x2::sui::SUI, T1>(arg2, arg3, 0x2::balance::zero<0x2::sui::SUI>(), 0x9d466e02c0141fb3ba4c257a41f56e40308d836f927adb6a344623182cb05fa7::vault::take_balance<T0, T1>(arg0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<0x2::sui::SUI, T1>(&v3)), v3);
        let (v5, v6, v7) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<0x2::sui::SUI, T2>(arg2, arg4, true, true, 0x2::balance::value<0x2::sui::SUI>(&v4), arg8, arg9);
        let v8 = v6;
        0x2::balance::destroy_zero<0x2::sui::SUI>(v5);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<0x2::sui::SUI, T2>(arg2, arg4, v4, 0x2::balance::zero<T2>(), v7);
        assert!(0x2::balance::value<T2>(&v8) >= arg6, 1);
        0x9d466e02c0141fb3ba4c257a41f56e40308d836f927adb6a344623182cb05fa7::vault::put_balance<T0, T2>(arg0, v8);
    }

    // decompiled from Move bytecode v7
}

