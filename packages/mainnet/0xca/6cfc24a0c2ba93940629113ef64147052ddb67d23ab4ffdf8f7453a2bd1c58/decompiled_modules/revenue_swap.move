module 0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::revenue_swap {
    struct RevenueSwappedToSui has copy, drop {
        input_amount: u64,
        sui_out: u64,
    }

    public entry fun swap_vault_a_to_sui<T0>(arg0: &0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::lumi::AdminCap, arg1: &mut 0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::revenue::RevenueVault<T0>, arg2: &mut 0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::revenue::RevenueVault<0x2::sui::SUI>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg5: u64, arg6: u64, arg7: u128, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg5 > 0, 1);
        let v0 = 0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::revenue::withdraw<T0>(arg1, arg0, arg5, arg9);
        let v1 = if (arg7 == 0) {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price()
        } else {
            arg7
        };
        let (v2, v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, 0x2::sui::SUI>(arg3, arg4, true, true, arg5, v1, arg8);
        let v5 = v4;
        let v6 = v3;
        let v7 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, 0x2::sui::SUI>(&v5);
        assert!(v7 == arg5, 3);
        let v8 = 0x2::balance::value<0x2::sui::SUI>(&v6);
        assert!(v8 >= arg6, 2);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, 0x2::sui::SUI>(arg3, arg4, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v0, v7, arg9)), 0x2::balance::zero<0x2::sui::SUI>(), v5);
        0x2::coin::join<T0>(&mut v0, 0x2::coin::from_balance<T0>(v2, arg9));
        0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::revenue::deposit_coin<T0>(arg1, v0);
        0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::revenue::deposit<0x2::sui::SUI>(arg2, v6);
        let v9 = RevenueSwappedToSui{
            input_amount : arg5,
            sui_out      : v8,
        };
        0x2::event::emit<RevenueSwappedToSui>(v9);
    }

    // decompiled from Move bytecode v7
}

