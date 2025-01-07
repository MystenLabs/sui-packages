module 0xa854f19e0fef40fc81d6f87e1fec2e91946154ce27a9a3dd0df33ff922899464::swap_router {
    struct FeeStore has store, key {
        id: 0x2::object::UID,
        fee: u64,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct FeeCap has key {
        id: 0x2::object::UID,
    }

    public entry fun buyWithoutFee<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x2::coin::Coin<T1>, arg3: bool, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, arg3, arg4, 79226673515401279992447579055, arg5);
        let v3 = v2;
        let v4 = v0;
        0x2::balance::value<T0>(&v4);
        0x2::coin::join<T1>(arg2, 0x2::coin::from_balance<T1>(v1, arg6));
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(arg2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3), arg6)), v3);
        send_coin<T1>(0x2::coin::take<T1>(0x2::coin::balance_mut<T1>(arg2), 0x2::coin::value<T1>(arg2), arg6), 0x2::tx_context::sender(arg6));
        send_coin<T0>(0x2::coin::from_balance<T0>(v4, arg6), 0x2::tx_context::sender(arg6));
    }

    entry fun collectFee(arg0: &mut FeeCap, arg1: &mut FeeStore, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.balance, 0x2::balance::value<0x2::sui::SUI>(&arg1.balance), arg2), 0x2::tx_context::sender(arg2));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = FeeStore{
            id      : 0x2::object::new(arg0),
            fee     : 1000000,
            balance : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<FeeStore>(v0);
        let v1 = FeeCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<FeeCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun sellWithoutFee<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x2::coin::Coin<T0>, arg3: bool, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, arg3, arg4, 4295048016, arg5);
        let v3 = v2;
        let v4 = v1;
        0x2::balance::value<T1>(&v4);
        0x2::coin::join<T0>(arg2, 0x2::coin::from_balance<T0>(v0, arg6));
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3), arg6)), 0x2::balance::zero<T1>(), v3);
        send_coin<T0>(0x2::coin::take<T0>(0x2::coin::balance_mut<T0>(arg2), 0x2::coin::value<T0>(arg2), arg6), 0x2::tx_context::sender(arg6));
        send_coin<T1>(0x2::coin::from_balance<T1>(v4, arg6), 0x2::tx_context::sender(arg6));
    }

    public fun send_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address) {
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
    }

    entry fun setFee(arg0: &mut FeeCap, arg1: &mut FeeStore, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.fee = arg2;
    }

    // decompiled from Move bytecode v6
}

