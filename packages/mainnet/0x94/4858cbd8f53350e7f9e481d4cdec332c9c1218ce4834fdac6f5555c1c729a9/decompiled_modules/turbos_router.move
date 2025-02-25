module 0x944858cbd8f53350e7f9e481d4cdec332c9c1218ce4834fdac6f5555c1c729a9::turbos_router {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct BuyEvent<phantom T0> has copy, drop {
        recipient: address,
        amount_in: u64,
        amount_out: u64,
    }

    struct SellEvent<phantom T0> has copy, drop {
        recipient: address,
        amount_in: u64,
        amount_out: u64,
    }

    struct OrderCompletedEvent has copy, drop {
        order_id: 0x1::string::String,
    }

    public entry fun buy_exact_in<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u128, arg5: u64, arg6: &0x2::clock::Clock, arg7: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg8: bool, arg9: 0x1::string::String, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg8) {
            0x2::coin::value<T0>(&arg1)
        } else {
            0x2::coin::value<T1>(&arg2)
        };
        if (arg8) {
            let v1 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
            0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v1, arg1);
            let (v2, v3) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_a_b_with_return_<T0, T1, T2>(arg0, v1, v0, arg3, arg4, true, 0x2::tx_context::sender(arg10), arg5, arg6, arg7, arg10);
            let v4 = v2;
            let v5 = 0x2::coin::value<T1>(&v4);
            0x944858cbd8f53350e7f9e481d4cdec332c9c1218ce4834fdac6f5555c1c729a9::utils::send_coin<T0>(v3, 0x2::tx_context::sender(arg10));
            0x944858cbd8f53350e7f9e481d4cdec332c9c1218ce4834fdac6f5555c1c729a9::utils::send_coin<T1>(v4, 0x2::tx_context::sender(arg10));
            0x944858cbd8f53350e7f9e481d4cdec332c9c1218ce4834fdac6f5555c1c729a9::utils::send_coin<T1>(arg2, 0x2::tx_context::sender(arg10));
            assert!(v5 >= arg3, 4);
            let v6 = BuyEvent<T1>{
                recipient  : 0x2::tx_context::sender(arg10),
                amount_in  : v0,
                amount_out : v5,
            };
            0x2::event::emit<BuyEvent<T1>>(v6);
        } else {
            let v7 = 0x1::vector::empty<0x2::coin::Coin<T1>>();
            0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut v7, arg2);
            let (v8, v9) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_b_a_with_return_<T0, T1, T2>(arg0, v7, v0, arg3, arg4, true, 0x2::tx_context::sender(arg10), arg5, arg6, arg7, arg10);
            let v10 = v8;
            let v11 = 0x2::coin::value<T0>(&v10);
            assert!(v11 >= arg3, 4);
            0x944858cbd8f53350e7f9e481d4cdec332c9c1218ce4834fdac6f5555c1c729a9::utils::send_coin<T1>(v9, 0x2::tx_context::sender(arg10));
            0x944858cbd8f53350e7f9e481d4cdec332c9c1218ce4834fdac6f5555c1c729a9::utils::send_coin<T0>(v10, 0x2::tx_context::sender(arg10));
            0x944858cbd8f53350e7f9e481d4cdec332c9c1218ce4834fdac6f5555c1c729a9::utils::send_coin<T0>(arg1, 0x2::tx_context::sender(arg10));
            let v12 = BuyEvent<T0>{
                recipient  : 0x2::tx_context::sender(arg10),
                amount_in  : v0,
                amount_out : v11,
            };
            0x2::event::emit<BuyEvent<T0>>(v12);
        };
        let v13 = OrderCompletedEvent{order_id: arg9};
        0x2::event::emit<OrderCompletedEvent>(v13);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun sell_exact_in<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: u128, arg6: u64, arg7: &0x2::clock::Clock, arg8: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg9: bool, arg10: 0x1::string::String, arg11: &mut 0x2::tx_context::TxContext) {
        if (arg9) {
            assert!(0x2::coin::value<T0>(&arg1) >= arg3, 3);
            let v0 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
            0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v0, arg1);
            let (v1, v2) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_a_b_with_return_<T0, T1, T2>(arg0, v0, arg3, arg4, arg5, true, 0x2::tx_context::sender(arg11), arg6, arg7, arg8, arg11);
            let v3 = v1;
            let v4 = 0x2::coin::value<T1>(&v3);
            assert!(v4 >= arg4, 4);
            0x944858cbd8f53350e7f9e481d4cdec332c9c1218ce4834fdac6f5555c1c729a9::utils::send_coin<T1>(v3, 0x2::tx_context::sender(arg11));
            0x944858cbd8f53350e7f9e481d4cdec332c9c1218ce4834fdac6f5555c1c729a9::utils::send_coin<T0>(v2, 0x2::tx_context::sender(arg11));
            0x944858cbd8f53350e7f9e481d4cdec332c9c1218ce4834fdac6f5555c1c729a9::utils::send_coin<T1>(arg2, 0x2::tx_context::sender(arg11));
            let v5 = SellEvent<T0>{
                recipient  : 0x2::tx_context::sender(arg11),
                amount_in  : arg3,
                amount_out : v4,
            };
            0x2::event::emit<SellEvent<T0>>(v5);
        } else {
            assert!(0x2::coin::value<T1>(&arg2) >= arg3, 3);
            let v6 = 0x1::vector::empty<0x2::coin::Coin<T1>>();
            0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut v6, arg2);
            let (v7, v8) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_b_a_with_return_<T0, T1, T2>(arg0, v6, arg3, arg4, arg5, true, 0x2::tx_context::sender(arg11), arg6, arg7, arg8, arg11);
            let v9 = v7;
            let v10 = 0x2::coin::value<T0>(&v9);
            assert!(v10 >= arg4, 4);
            0x944858cbd8f53350e7f9e481d4cdec332c9c1218ce4834fdac6f5555c1c729a9::utils::send_coin<T0>(v9, 0x2::tx_context::sender(arg11));
            0x944858cbd8f53350e7f9e481d4cdec332c9c1218ce4834fdac6f5555c1c729a9::utils::send_coin<T1>(v8, 0x2::tx_context::sender(arg11));
            0x944858cbd8f53350e7f9e481d4cdec332c9c1218ce4834fdac6f5555c1c729a9::utils::send_coin<T0>(arg1, 0x2::tx_context::sender(arg11));
            let v11 = SellEvent<T1>{
                recipient  : 0x2::tx_context::sender(arg11),
                amount_in  : arg3,
                amount_out : v10,
            };
            0x2::event::emit<SellEvent<T1>>(v11);
        };
        let v12 = OrderCompletedEvent{order_id: arg10};
        0x2::event::emit<OrderCompletedEvent>(v12);
    }

    // decompiled from Move bytecode v6
}

