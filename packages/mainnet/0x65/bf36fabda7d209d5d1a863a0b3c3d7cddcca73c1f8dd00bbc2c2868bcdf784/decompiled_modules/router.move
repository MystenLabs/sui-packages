module 0xf9dacb778acd871ca929c7c6c71db90c086634018dcdb20bd820cff3423d0878::router {
    struct Routed has copy, drop {
        pool_id: 0x2::object::ID,
        a_to_b: bool,
        amount_in: u64,
        amount_out: u64,
        sender: address,
    }

    fun settle_refund<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address) {
        if (0x2::coin::value<T0>(&arg0) == 0) {
            0x2::coin::destroy_zero<T0>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
        };
    }

    public fun swap_a_to_b<T0, T1>(arg0: &0xf9dacb778acd871ca929c7c6c71db90c086634018dcdb20bd820cff3423d0878::launchpad::Launchpad, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T0>) {
        let v0 = 0x2::coin::value<T0>(&arg4);
        assert!(v0 > 0, 1);
        0xf9dacb778acd871ca929c7c6c71db90c086634018dcdb20bd820cff3423d0878::launchpad::assert_partner(arg0, arg3);
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap_with_partner<T0, T1>(arg1, arg2, arg3, true, true, v0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price(), arg6);
        let v4 = v3;
        let v5 = v2;
        let v6 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v4);
        let v7 = 0x2::coin::into_balance<T0>(arg4);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap_with_partner<T0, T1>(arg1, arg2, arg3, 0x2::balance::split<T0>(&mut v7, v6), 0x2::balance::zero<T1>(), v4);
        0x2::balance::destroy_zero<T0>(v1);
        let v8 = 0x2::balance::value<T1>(&v5);
        assert!(v8 >= arg5, 2);
        let v9 = Routed{
            pool_id    : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2),
            a_to_b     : true,
            amount_in  : v6,
            amount_out : v8,
            sender     : 0x2::tx_context::sender(arg7),
        };
        0x2::event::emit<Routed>(v9);
        (0x2::coin::from_balance<T1>(v5, arg7), 0x2::coin::from_balance<T0>(v7, arg7))
    }

    public fun swap_b_to_a<T0, T1>(arg0: &0xf9dacb778acd871ca929c7c6c71db90c086634018dcdb20bd820cff3423d0878::launchpad::Launchpad, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg4: 0x2::coin::Coin<T1>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x2::coin::value<T1>(&arg4);
        assert!(v0 > 0, 1);
        0xf9dacb778acd871ca929c7c6c71db90c086634018dcdb20bd820cff3423d0878::launchpad::assert_partner(arg0, arg3);
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap_with_partner<T0, T1>(arg1, arg2, arg3, false, true, v0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price(), arg6);
        let v4 = v3;
        let v5 = v1;
        let v6 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v4);
        let v7 = 0x2::coin::into_balance<T1>(arg4);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap_with_partner<T0, T1>(arg1, arg2, arg3, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v7, v6), v4);
        0x2::balance::destroy_zero<T1>(v2);
        let v8 = 0x2::balance::value<T0>(&v5);
        assert!(v8 >= arg5, 2);
        let v9 = Routed{
            pool_id    : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2),
            a_to_b     : false,
            amount_in  : v6,
            amount_out : v8,
            sender     : 0x2::tx_context::sender(arg7),
        };
        0x2::event::emit<Routed>(v9);
        (0x2::coin::from_balance<T0>(v5, arg7), 0x2::coin::from_balance<T1>(v7, arg7))
    }

    public fun trade_a_to_b<T0, T1>(arg0: &0xf9dacb778acd871ca929c7c6c71db90c086634018dcdb20bd820cff3423d0878::launchpad::Launchpad, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = swap_a_to_b<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        let v2 = 0x2::tx_context::sender(arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v0, v2);
        settle_refund<T0>(v1, v2);
    }

    public fun trade_b_to_a<T0, T1>(arg0: &0xf9dacb778acd871ca929c7c6c71db90c086634018dcdb20bd820cff3423d0878::launchpad::Launchpad, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg4: 0x2::coin::Coin<T1>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = swap_b_to_a<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        let v2 = 0x2::tx_context::sender(arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, v2);
        settle_refund<T1>(v1, v2);
    }

    // decompiled from Move bytecode v7
}

