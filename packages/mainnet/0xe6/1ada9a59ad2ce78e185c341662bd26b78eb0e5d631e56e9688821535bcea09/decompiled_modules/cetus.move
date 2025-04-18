module 0x5bce01814bf05fd605b528e1dfd419d1352cd3e25018a54797d59b7eb1eea4c3::cetus {
    struct CetusSwapEvent has copy, drop, store {
        pool: 0x2::object::ID,
        amount_in: u64,
        amount_out: u64,
        a2b: bool,
        by_amount_in: bool,
        partner_id: address,
        coin_a: 0x1::type_name::TypeName,
        coin_b: 0x1::type_name::TypeName,
    }

    public fun flash_swap<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: u64, arg3: u64, arg4: bool, arg5: bool, arg6: u128, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, arg4, arg5, arg2, arg6, arg7);
        let v3 = v2;
        let v4 = v1;
        let v5 = v0;
        let v6 = 0x2::balance::value<T0>(&v5);
        let v7 = 0x2::balance::value<T1>(&v4);
        let v8 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3);
        if (arg5) {
            assert!(v7 + v6 >= arg3, 2);
        } else {
            assert!(v8 < arg3, 3);
        };
        let v9 = if (arg5) {
            arg2
        } else {
            v8
        };
        let v10 = CetusSwapEvent{
            pool         : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1),
            amount_in    : v9,
            amount_out   : v6 + v7,
            a2b          : arg4,
            by_amount_in : arg5,
            partner_id   : @0x0,
            coin_a       : 0x1::type_name::get<T0>(),
            coin_b       : 0x1::type_name::get<T1>(),
        };
        0x2::event::emit<CetusSwapEvent>(v10);
        (0x2::coin::from_balance<T0>(v5, arg8), 0x2::coin::from_balance<T1>(v4, arg8), v3)
    }

    public fun flash_swap_with_partner<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: u64, arg3: u64, arg4: bool, arg5: bool, arg6: u128, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap_with_partner<T0, T1>(arg0, arg1, arg7, arg4, arg5, arg2, arg6, arg8);
        let v3 = v2;
        let v4 = v1;
        let v5 = v0;
        let v6 = 0x2::balance::value<T0>(&v5);
        let v7 = 0x2::balance::value<T1>(&v4);
        let v8 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3);
        if (arg5) {
            assert!(v7 + v6 >= arg3, 2);
        } else {
            assert!(v8 < arg3, 3);
        };
        let v9 = if (arg5) {
            arg2
        } else {
            v8
        };
        let v10 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner>(arg7);
        let v11 = CetusSwapEvent{
            pool         : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1),
            amount_in    : v9,
            amount_out   : v6 + v7,
            a2b          : arg4,
            by_amount_in : arg5,
            partner_id   : 0x2::object::id_to_address(&v10),
            coin_a       : 0x1::type_name::get<T0>(),
            coin_b       : 0x1::type_name::get<T1>(),
        };
        0x2::event::emit<CetusSwapEvent>(v11);
        (0x2::coin::from_balance<T0>(v5, arg9), 0x2::coin::from_balance<T1>(v4, arg9), v3)
    }

    public fun repay_flash_swap<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: bool, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&arg5);
        let (v1, v2) = if (arg2) {
            assert!(0x2::coin::value<T0>(&arg3) >= v0, 6);
            (0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg3, v0, arg6)), 0x2::balance::zero<T1>())
        } else {
            assert!(0x2::coin::value<T1>(&arg4) >= v0, 6);
            (0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg4, v0, arg6)))
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, v1, v2, arg5);
        (arg3, arg4)
    }

    public fun repay_flash_swap_with_partner<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: bool, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&arg5);
        let (v1, v2) = if (arg2) {
            assert!(0x2::coin::value<T0>(&arg3) >= v0, 6);
            (0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg3, v0, arg7)), 0x2::balance::zero<T1>())
        } else {
            assert!(0x2::coin::value<T1>(&arg4) >= v0, 6);
            (0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg4, v0, arg7)))
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap_with_partner<T0, T1>(arg0, arg1, arg6, v1, v2, arg5);
        (arg3, arg4)
    }

    // decompiled from Move bytecode v6
}

