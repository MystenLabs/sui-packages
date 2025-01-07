module 0xb61a6b7b359f492647d508d632a262c60af873ee337980a4986794f2a7e88465::router {
    struct OwnerCap has key {
        id: 0x2::object::UID,
    }

    struct Shop<phantom T0> has key {
        id: 0x2::object::UID,
        address_table: 0x2::table::Table<address, u8>,
        balance: 0x2::balance::Balance<T0>,
    }

    fun swap<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: bool, arg5: u64, arg6: u64, arg7: u128, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, arg4, true, arg5, arg7, arg8);
        let v3 = v2;
        let v4 = v1;
        let v5 = v0;
        if (arg4) {
        };
        let (v6, v7) = if (arg4) {
            (0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3), arg9)), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg3, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3), arg9)))
        };
        0x2::coin::join<T1>(&mut arg3, 0x2::coin::from_balance<T1>(v4, arg9));
        0x2::coin::join<T0>(&mut arg2, 0x2::coin::from_balance<T0>(v5, arg9));
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, v6, v7, v3);
        (arg2, arg3)
    }

    public entry fun add_address<T0>(arg0: &OwnerCap, arg1: &mut Shop<T0>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            let v1 = *0x1::vector::borrow<address>(&arg2, v0);
            if (!0x2::table::contains<address, u8>(&arg1.address_table, v1)) {
                0x2::table::add<address, u8>(&mut arg1.address_table, v1, 1);
            };
            v0 = v0 + 1;
        };
    }

    public entry fun create_shop<T0>(arg0: &OwnerCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Shop<T0>{
            id            : 0x2::object::new(arg1),
            address_table : 0x2::table::new<address, u8>(arg1),
            balance       : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::share_object<Shop<T0>>(v0);
    }

    public entry fun deposit<T0>(arg0: &OwnerCap, arg1: &mut Shop<T0>, arg2: &mut 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(arg2) >= arg3, 1);
        0x2::balance::join<T0>(&mut arg1.balance, 0x2::balance::split<T0>(0x2::coin::balance_mut<T0>(arg2), arg3));
    }

    public entry fun deposit2<T0>(arg0: &OwnerCap, arg1: &mut Shop<T0>, arg2: vector<0x2::coin::Coin<T0>>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::coin::Coin<T0>>(&arg2)) {
            0x2::balance::join<T0>(&mut arg1.balance, 0x2::coin::into_balance<T0>(0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg2)));
            v0 = v0 + 1;
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(arg2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OwnerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<OwnerCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun swap_a2b_b2c_a2c<T0, T1, T2>(arg0: &OwnerCap, arg1: &mut Shop<T0>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: u128, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg6: u128, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg8: u128, arg9: u64, arg10: bool, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::take<T0>(&mut arg1.balance, arg9, arg12);
        let v1 = 0x2::coin::zero<T1>(arg12);
        let (v2, v3) = swap<T0, T1>(arg2, arg3, v0, v1, true, arg9, 0, arg4, arg11, arg12);
        0x2::coin::destroy_zero<T0>(v2);
        let v4 = v3;
        let v5 = 0x2::coin::zero<T2>(arg12);
        let (v6, v7) = swap<T1, T2>(arg2, arg5, v4, v5, true, 0x2::coin::value<T1>(&v4), 0, arg6, arg11, arg12);
        0x2::coin::destroy_zero<T1>(v6);
        let v8 = v7;
        let v9 = 0x2::coin::zero<T0>(arg12);
        let (v10, v11) = swap<T0, T2>(arg2, arg7, v9, v8, false, 0x2::coin::value<T2>(&v8), 0, arg8, arg11, arg12);
        let v12 = v10;
        if (arg10) {
            assert!(0x2::coin::value<T0>(&v12) > arg9, 3);
        };
        0x2::coin::destroy_zero<T2>(v11);
        0x2::balance::join<T0>(&mut arg1.balance, 0x2::coin::into_balance<T0>(v12));
    }

    public entry fun swap_a2b_b2c_c2a<T0, T1, T2>(arg0: &OwnerCap, arg1: &mut Shop<T0>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: u128, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg6: u128, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg8: u128, arg9: u64, arg10: bool, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::take<T0>(&mut arg1.balance, arg9, arg12);
        let v1 = 0x2::coin::zero<T1>(arg12);
        let (v2, v3) = swap<T0, T1>(arg2, arg3, v0, v1, true, arg9, 0, arg4, arg11, arg12);
        0x2::coin::destroy_zero<T0>(v2);
        let v4 = v3;
        let v5 = 0x2::coin::zero<T2>(arg12);
        let (v6, v7) = swap<T1, T2>(arg2, arg5, v4, v5, true, 0x2::coin::value<T1>(&v4), 0, arg6, arg11, arg12);
        0x2::coin::destroy_zero<T1>(v6);
        let v8 = v7;
        let v9 = 0x2::coin::zero<T0>(arg12);
        let (v10, v11) = swap<T2, T0>(arg2, arg7, v8, v9, true, 0x2::coin::value<T2>(&v8), 0, arg8, arg11, arg12);
        let v12 = v11;
        if (arg10) {
            assert!(0x2::coin::value<T0>(&v12) > arg9, 3);
        };
        0x2::coin::destroy_zero<T2>(v10);
        0x2::balance::join<T0>(&mut arg1.balance, 0x2::coin::into_balance<T0>(v12));
    }

    public entry fun swap_a2b_c2b_a2c<T0, T1, T2>(arg0: &OwnerCap, arg1: &mut Shop<T0>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: u128, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg6: u128, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg8: u128, arg9: u64, arg10: bool, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::take<T0>(&mut arg1.balance, arg9, arg12);
        let v1 = 0x2::coin::zero<T1>(arg12);
        let (v2, v3) = swap<T0, T1>(arg2, arg3, v0, v1, true, arg9, 0, arg4, arg11, arg12);
        0x2::coin::destroy_zero<T0>(v2);
        let v4 = v3;
        let v5 = 0x2::coin::zero<T2>(arg12);
        let (v6, v7) = swap<T2, T1>(arg2, arg5, v5, v4, false, 0x2::coin::value<T1>(&v4), 0, arg6, arg11, arg12);
        0x2::coin::destroy_zero<T1>(v7);
        let v8 = v6;
        let v9 = 0x2::coin::zero<T0>(arg12);
        let (v10, v11) = swap<T0, T2>(arg2, arg7, v9, v8, false, 0x2::coin::value<T2>(&v8), 0, arg8, arg11, arg12);
        let v12 = v10;
        if (arg10) {
            assert!(0x2::coin::value<T0>(&v12) > arg9, 3);
        };
        0x2::coin::destroy_zero<T2>(v11);
        0x2::balance::join<T0>(&mut arg1.balance, 0x2::coin::into_balance<T0>(v12));
    }

    public entry fun swap_a2b_c2b_c2a<T0, T1, T2>(arg0: &OwnerCap, arg1: &mut Shop<T0>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: u128, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg6: u128, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg8: u128, arg9: u64, arg10: bool, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::take<T0>(&mut arg1.balance, arg9, arg12);
        let v1 = 0x2::coin::zero<T1>(arg12);
        let (v2, v3) = swap<T0, T1>(arg2, arg3, v0, v1, true, arg9, 0, arg4, arg11, arg12);
        0x2::coin::destroy_zero<T0>(v2);
        let v4 = v3;
        let v5 = 0x2::coin::zero<T2>(arg12);
        let (v6, v7) = swap<T2, T1>(arg2, arg5, v5, v4, false, 0x2::coin::value<T1>(&v4), 0, arg6, arg11, arg12);
        0x2::coin::destroy_zero<T1>(v7);
        let v8 = v6;
        let v9 = 0x2::coin::zero<T0>(arg12);
        let (v10, v11) = swap<T2, T0>(arg2, arg7, v8, v9, true, 0x2::coin::value<T2>(&v8), 0, arg8, arg11, arg12);
        let v12 = v11;
        if (arg10) {
            assert!(0x2::coin::value<T0>(&v12) > arg9, 3);
        };
        0x2::coin::destroy_zero<T2>(v10);
        0x2::balance::join<T0>(&mut arg1.balance, 0x2::coin::into_balance<T0>(v12));
    }

    public entry fun swap_b2a_a2c_b2c<T0, T1, T2>(arg0: &OwnerCap, arg1: &mut Shop<T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: u128, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg6: u128, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg8: u128, arg9: u64, arg10: bool, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::zero<T0>(arg12);
        let v1 = 0x2::coin::take<T1>(&mut arg1.balance, arg9, arg12);
        let (v2, v3) = swap<T0, T1>(arg2, arg3, v0, v1, false, arg9, 0, arg4, arg11, arg12);
        0x2::coin::destroy_zero<T1>(v3);
        let v4 = v2;
        let v5 = 0x2::coin::zero<T2>(arg12);
        let (v6, v7) = swap<T0, T2>(arg2, arg5, v4, v5, true, 0x2::coin::value<T0>(&v4), 0, arg6, arg11, arg12);
        0x2::coin::destroy_zero<T0>(v6);
        let v8 = v7;
        let v9 = 0x2::coin::zero<T1>(arg12);
        let (v10, v11) = swap<T1, T2>(arg2, arg7, v9, v8, false, 0x2::coin::value<T2>(&v8), 0, arg8, arg11, arg12);
        let v12 = v10;
        if (arg10) {
            assert!(0x2::coin::value<T1>(&v12) > arg9, 3);
        };
        0x2::coin::destroy_zero<T2>(v11);
        0x2::balance::join<T1>(&mut arg1.balance, 0x2::coin::into_balance<T1>(v12));
    }

    public entry fun swap_b2a_a2c_c2b<T0, T1, T2>(arg0: &OwnerCap, arg1: &mut Shop<T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: u128, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg6: u128, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg8: u128, arg9: u64, arg10: bool, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::zero<T0>(arg12);
        let v1 = 0x2::coin::take<T1>(&mut arg1.balance, arg9, arg12);
        let (v2, v3) = swap<T0, T1>(arg2, arg3, v0, v1, false, arg9, 0, arg4, arg11, arg12);
        0x2::coin::destroy_zero<T1>(v3);
        let v4 = v2;
        let v5 = 0x2::coin::zero<T2>(arg12);
        let (v6, v7) = swap<T0, T2>(arg2, arg5, v4, v5, true, 0x2::coin::value<T0>(&v4), 0, arg6, arg11, arg12);
        0x2::coin::destroy_zero<T0>(v6);
        let v8 = v7;
        let v9 = 0x2::coin::zero<T1>(arg12);
        let (v10, v11) = swap<T2, T1>(arg2, arg7, v8, v9, true, 0x2::coin::value<T2>(&v8), 0, arg8, arg11, arg12);
        let v12 = v11;
        if (arg10) {
            assert!(0x2::coin::value<T1>(&v12) > arg9, 3);
        };
        0x2::coin::destroy_zero<T2>(v10);
        0x2::balance::join<T1>(&mut arg1.balance, 0x2::coin::into_balance<T1>(v12));
    }

    public entry fun swap_b2a_c2a_b2c<T0, T1, T2>(arg0: &OwnerCap, arg1: &mut Shop<T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: u128, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg6: u128, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg8: u128, arg9: u64, arg10: bool, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::zero<T0>(arg12);
        let v1 = 0x2::coin::take<T1>(&mut arg1.balance, arg9, arg12);
        let (v2, v3) = swap<T0, T1>(arg2, arg3, v0, v1, false, arg9, 0, arg4, arg11, arg12);
        0x2::coin::destroy_zero<T1>(v3);
        let v4 = v2;
        let v5 = 0x2::coin::zero<T2>(arg12);
        let (v6, v7) = swap<T2, T0>(arg2, arg5, v5, v4, false, 0x2::coin::value<T0>(&v4), 0, arg6, arg11, arg12);
        0x2::coin::destroy_zero<T0>(v7);
        let v8 = v6;
        let v9 = 0x2::coin::zero<T1>(arg12);
        let (v10, v11) = swap<T1, T2>(arg2, arg7, v9, v8, false, 0x2::coin::value<T2>(&v8), 0, arg8, arg11, arg12);
        let v12 = v10;
        if (arg10) {
            assert!(0x2::coin::value<T1>(&v12) > arg9, 3);
        };
        0x2::coin::destroy_zero<T2>(v11);
        0x2::balance::join<T1>(&mut arg1.balance, 0x2::coin::into_balance<T1>(v12));
    }

    public entry fun swap_b2a_c2a_c2b<T0, T1, T2>(arg0: &OwnerCap, arg1: &mut Shop<T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: u128, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg6: u128, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg8: u128, arg9: u64, arg10: bool, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::zero<T0>(arg12);
        let v1 = 0x2::coin::take<T1>(&mut arg1.balance, arg9, arg12);
        let (v2, v3) = swap<T0, T1>(arg2, arg3, v0, v1, false, arg9, 0, arg4, arg11, arg12);
        0x2::coin::destroy_zero<T1>(v3);
        let v4 = v2;
        let v5 = 0x2::coin::zero<T2>(arg12);
        let (v6, v7) = swap<T2, T0>(arg2, arg5, v5, v4, false, 0x2::coin::value<T0>(&v4), 0, arg6, arg11, arg12);
        0x2::coin::destroy_zero<T0>(v7);
        let v8 = v6;
        let v9 = 0x2::coin::zero<T1>(arg12);
        let (v10, v11) = swap<T2, T1>(arg2, arg7, v8, v9, true, 0x2::coin::value<T2>(&v8), 0, arg8, arg11, arg12);
        let v12 = v11;
        if (arg10) {
            assert!(0x2::coin::value<T1>(&v12) > arg9, 3);
        };
        0x2::coin::destroy_zero<T2>(v10);
        0x2::balance::join<T1>(&mut arg1.balance, 0x2::coin::into_balance<T1>(v12));
    }

    public entry fun withdraw<T0>(arg0: &OwnerCap, arg1: &mut Shop<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.balance, 0x2::balance::value<T0>(&arg1.balance), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

