module 0xa3c579ff78c2ee11d24543d91db5f4aad915c8aa5580f63bff539638b2912c2d::Cat {
    struct ContractData has store, key {
        id: 0x2::object::UID,
    }

    struct AccessList has store, key {
        id: 0x2::object::UID,
        list: vector<address>,
    }

    public fun access_list_add(arg0: &mut AccessList, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        if (!0x1::vector::contains<address>(&mut arg0.list, &v0)) {
            abort 444
        };
        if (!0x1::vector::contains<address>(&mut arg0.list, &arg1)) {
            let v1 = 0x1::vector::empty<address>();
            0x1::vector::push_back<address>(&mut v1, arg1);
            0x1::vector::append<address>(&mut arg0.list, v1);
        };
    }

    public fun cetus_a_to_b<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: u128, arg4: &0x2::clock::Clock, arg5: &mut AccessList, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        check_valid(arg5, arg6);
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, true, true, 0x2::coin::value<T0>(&arg0), arg3, arg4);
        let v3 = v2;
        let v4 = v1;
        let v5 = 0x2::coin::from_balance<T1>(0x2::balance::zero<T1>(), arg6);
        0x2::balance::value<T1>(&v4);
        0x2::coin::join<T1>(&mut v5, 0x2::coin::from_balance<T1>(v4, arg6));
        0x2::coin::join<T0>(&mut arg0, 0x2::coin::from_balance<T0>(v0, arg6));
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3), arg6)), 0x2::balance::zero<T1>(), v3);
        0x2::pay::keep<T0>(arg0, arg6);
        v5
    }

    public fun cetus_b_to_a<T0, T1>(arg0: 0x2::coin::Coin<T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: u128, arg4: &0x2::clock::Clock, arg5: &mut AccessList, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        check_valid(arg5, arg6);
        let v0 = 0x2::coin::from_balance<T0>(0x2::balance::zero<T0>(), arg6);
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, false, true, 0x2::coin::value<T1>(&arg0), arg3, arg4);
        let v4 = v3;
        let v5 = v1;
        0x2::balance::value<T0>(&v5);
        0x2::coin::join<T1>(&mut arg0, 0x2::coin::from_balance<T1>(v2, arg6));
        0x2::coin::join<T0>(&mut v0, 0x2::coin::from_balance<T0>(v5, arg6));
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v4), arg6)), v4);
        0x2::pay::keep<T1>(arg0, arg6);
        v0
    }

    fun check_valid(arg0: &mut AccessList, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        if (!0x1::vector::contains<address>(&mut arg0.list, &v0)) {
            abort 333
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v0, 0x2::tx_context::sender(arg0));
        let v1 = AccessList{
            id   : 0x2::object::new(arg0),
            list : v0,
        };
        0x2::transfer::share_object<AccessList>(v1);
    }

    public entry fun keep_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg0) < arg1) {
            abort 222
        };
        0x2::pay::keep<T0>(arg0, arg2);
    }

    public fun kriya_a_to_b<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>, arg2: u64, arg3: &mut AccessList, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        check_valid(arg3, arg4);
        0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::swap_token_x<T0, T1>(arg1, arg0, 0x2::coin::value<T0>(&arg0), arg2, arg4)
    }

    public fun kriya_b_to_a<T0, T1>(arg0: 0x2::coin::Coin<T1>, arg1: &mut 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>, arg2: u64, arg3: &mut AccessList, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        check_valid(arg3, arg4);
        0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::swap_token_y<T0, T1>(arg1, arg0, 0x2::coin::value<T1>(&arg0), arg2, arg4)
    }

    // decompiled from Move bytecode v6
}

