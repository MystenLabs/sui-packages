module 0x1065ab063f42e795ce5bb99d05558a3e27dcefebc76fc4aac73f714ffb5078cf::il {
    public fun dC<T0, T1, T2>(arg0: &mut 0x1065ab063f42e795ce5bb99d05558a3e27dcefebc76fc4aac73f714ffb5078cf::cB::AC, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg3: bool, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        if (arg3) {
            dD<T0, T1, T2>(arg0, arg1, arg2, arg4, arg5);
        } else {
            eF<T0, T1, T2>(arg0, arg1, arg2, arg4, arg5);
        };
    }

    fun dD<T0, T1, T2>(arg0: &mut 0x1065ab063f42e795ce5bb99d05558a3e27dcefebc76fc4aac73f714ffb5078cf::cB::AC, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1065ab063f42e795ce5bb99d05558a3e27dcefebc76fc4aac73f714ffb5078cf::cB::gO<T0>(arg0);
        let v1 = 0x2::balance::value<T0>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<T0>(v0);
            return
        };
        let v2 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v2, 0x2::coin::from_balance<T0>(v0, arg4));
        let (v3, v4) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_a_b_with_return_<T0, T1, T2>(arg2, v2, v1, 0, 4295048017, true, 0x2::tx_context::sender(arg4), 0x2::clock::timestamp_ms(arg3) + 18000, arg3, arg1, arg4);
        0x1065ab063f42e795ce5bb99d05558a3e27dcefebc76fc4aac73f714ffb5078cf::cB::gD<T0>(v4, arg4);
        0x1065ab063f42e795ce5bb99d05558a3e27dcefebc76fc4aac73f714ffb5078cf::cB::eA<T1>(arg0, 0x2::coin::into_balance<T1>(v3));
    }

    fun eF<T0, T1, T2>(arg0: &mut 0x1065ab063f42e795ce5bb99d05558a3e27dcefebc76fc4aac73f714ffb5078cf::cB::AC, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1065ab063f42e795ce5bb99d05558a3e27dcefebc76fc4aac73f714ffb5078cf::cB::gO<T1>(arg0);
        let v1 = 0x2::balance::value<T1>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<T1>(v0);
            return
        };
        let v2 = 0x1::vector::empty<0x2::coin::Coin<T1>>();
        0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut v2, 0x2::coin::from_balance<T1>(v0, arg4));
        let (v3, v4) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_b_a_with_return_<T0, T1, T2>(arg2, v2, v1, 0, 79226673515401279992447579054, true, 0x2::tx_context::sender(arg4), 0x2::clock::timestamp_ms(arg3) + 18000, arg3, arg1, arg4);
        0x1065ab063f42e795ce5bb99d05558a3e27dcefebc76fc4aac73f714ffb5078cf::cB::gD<T1>(v4, arg4);
        0x1065ab063f42e795ce5bb99d05558a3e27dcefebc76fc4aac73f714ffb5078cf::cB::eA<T0>(arg0, 0x2::coin::into_balance<T0>(v3));
    }

    // decompiled from Move bytecode v6
}

