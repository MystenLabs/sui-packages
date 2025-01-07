module 0xb9aae237c9e922f62714a900b88ee2ce9f8b88e70fe3fbacc36a5fa4e9a10bf3::swap_router {
    struct FeeStore has store, key {
        id: 0x2::object::UID,
        admin: address,
        fee: u64,
        balance: 0x2::bag::Bag,
    }

    public entry fun buyV0<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x2::coin::Coin<T1>, arg3: bool, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, arg3, arg4, 79226673515401279992447579055, arg5);
        let v3 = v2;
        let v4 = v0;
        0x2::balance::value<T0>(&v4);
        0x2::coin::join<T1>(arg2, 0x2::coin::from_balance<T1>(v1, arg6));
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(arg2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3), arg6)), v3);
        send_coin<T1>(0x2::coin::take<T1>(0x2::coin::balance_mut<T1>(arg2), 0x2::coin::value<T1>(arg2), arg6), 0x2::tx_context::sender(arg6));
        send_coin<T0>(0x2::coin::from_balance<T0>(v4, arg6), 0x2::tx_context::sender(arg6));
    }

    public entry fun buyV1<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: vector<0x2::coin::Coin<T1>>, arg3: bool, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = merge_coins_internal<T1>(arg2);
        assert!(0x2::coin::value<T1>(&v0) >= arg4, 0);
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, arg3, arg4, 79226673515401279992447579055, arg5);
        let v4 = v3;
        let v5 = v1;
        0x2::balance::value<T0>(&v5);
        0x2::coin::join<T1>(&mut v0, 0x2::coin::from_balance<T1>(v2, arg6));
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v4), arg6)), v4);
        send_coin<T1>(v0, 0x2::tx_context::sender(arg6));
        send_coin<T0>(0x2::coin::from_balance<T0>(v5, arg6), 0x2::tx_context::sender(arg6));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = FeeStore{
            id      : 0x2::object::new(arg0),
            admin   : 0x2::tx_context::sender(arg0),
            fee     : 1000000,
            balance : 0x2::bag::new(arg0),
        };
        0x2::transfer::share_object<FeeStore>(v0);
    }

    public entry fun merge_coins<T0>(arg0: vector<0x2::coin::Coin<T0>>, arg1: &mut 0x2::tx_context::TxContext) {
        send_coin<T0>(merge_coins_internal<T0>(arg0), 0x2::tx_context::sender(arg1));
    }

    public fun merge_coins_internal<T0>(arg0: vector<0x2::coin::Coin<T0>>) : 0x2::coin::Coin<T0> {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg0);
        0x2::pay::join_vec<T0>(&mut v0, arg0);
        v0
    }

    public entry fun sellV0<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x2::coin::Coin<T0>, arg3: bool, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, arg3, arg4, 4295048016, arg5);
        let v3 = v2;
        let v4 = v1;
        0x2::balance::value<T1>(&v4);
        0x2::coin::join<T0>(arg2, 0x2::coin::from_balance<T0>(v0, arg6));
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3), arg6)), 0x2::balance::zero<T1>(), v3);
        send_coin<T0>(0x2::coin::take<T0>(0x2::coin::balance_mut<T0>(arg2), 0x2::coin::value<T0>(arg2), arg6), 0x2::tx_context::sender(arg6));
        send_coin<T1>(0x2::coin::from_balance<T1>(v4, arg6), 0x2::tx_context::sender(arg6));
    }

    public entry fun sellV1<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: vector<0x2::coin::Coin<T0>>, arg3: bool, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = merge_coins_internal<T0>(arg2);
        assert!(0x2::coin::value<T0>(&v0) >= arg4, 1);
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, arg3, arg4, 4295048016, arg5);
        let v4 = v3;
        let v5 = v2;
        0x2::balance::value<T1>(&v5);
        0x2::coin::join<T0>(&mut v0, 0x2::coin::from_balance<T0>(v1, arg6));
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v4), arg6)), 0x2::balance::zero<T1>(), v4);
        send_coin<T0>(v0, 0x2::tx_context::sender(arg6));
        send_coin<T1>(0x2::coin::from_balance<T1>(v5, arg6), 0x2::tx_context::sender(arg6));
    }

    public fun send_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address) {
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
    }

    // decompiled from Move bytecode v6
}

