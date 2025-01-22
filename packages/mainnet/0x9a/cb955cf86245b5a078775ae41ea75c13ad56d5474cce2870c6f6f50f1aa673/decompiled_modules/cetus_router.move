module 0x9acb955cf86245b5a078775ae41ea75c13ad56d5474cce2870c6f6f50f1aa673::cetus_router {
    struct FeeObject has key {
        id: 0x2::object::UID,
        buy_fee: u64,
        sell_fee: u64,
        admin: address,
    }

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

    public entry fun buy_exact_in<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: u128, arg6: &0x2::clock::Clock, arg7: bool, arg8: 0x1::string::String, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg7) {
            0x2::coin::value<T0>(&arg2)
        } else {
            0x2::coin::value<T1>(&arg3)
        };
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, arg7, true, v0, arg5, arg6);
        let v4 = v3;
        let v5 = v2;
        let v6 = v1;
        let v7 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v4);
        assert!(v7 == v0, 3);
        let (v8, v9, v10) = if (arg7) {
            (0x2::balance::value<T1>(&v5), 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg2, v7, arg9)), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::value<T0>(&v6), 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg3, v7, arg9)))
        };
        assert!(v8 >= arg4, 1);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, v9, v10, v4);
        0x2::coin::join<T0>(&mut arg2, 0x2::coin::from_balance<T0>(v6, arg9));
        0x2::coin::join<T1>(&mut arg3, 0x2::coin::from_balance<T1>(v5, arg9));
        0x9acb955cf86245b5a078775ae41ea75c13ad56d5474cce2870c6f6f50f1aa673::utils::send_coin<T0>(arg2, 0x2::tx_context::sender(arg9));
        0x9acb955cf86245b5a078775ae41ea75c13ad56d5474cce2870c6f6f50f1aa673::utils::send_coin<T1>(arg3, 0x2::tx_context::sender(arg9));
        if (arg7) {
            let v11 = BuyEvent<T1>{
                recipient  : 0x2::tx_context::sender(arg9),
                amount_in  : v0,
                amount_out : v8,
            };
            0x2::event::emit<BuyEvent<T1>>(v11);
        } else {
            let v12 = BuyEvent<T0>{
                recipient  : 0x2::tx_context::sender(arg9),
                amount_in  : v0,
                amount_out : v8,
            };
            0x2::event::emit<BuyEvent<T0>>(v12);
        };
        let v13 = OrderCompletedEvent{order_id: arg8};
        0x2::event::emit<OrderCompletedEvent>(v13);
    }

    public fun buy_exact_in_first_return<T0>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x2::sui::SUI, T0>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: 0x1::string::String, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= arg3, 3);
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<0x2::sui::SUI, T0>(arg0, arg1, true, true, arg3, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price(), arg5);
        let v3 = v2;
        let v4 = v1;
        0x9acb955cf86245b5a078775ae41ea75c13ad56d5474cce2870c6f6f50f1aa673::utils::send_balance<0x2::sui::SUI>(v0, 0x2::tx_context::sender(arg7), arg7);
        let v5 = 0x2::balance::value<T0>(&v4);
        assert!(v5 >= arg4, 1);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<0x2::sui::SUI, T0>(arg0, arg1, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<0x2::sui::SUI, T0>(&v3), arg7)), 0x2::balance::zero<T0>(), v3);
        0x9acb955cf86245b5a078775ae41ea75c13ad56d5474cce2870c6f6f50f1aa673::utils::send_coin<0x2::sui::SUI>(arg2, 0x2::tx_context::sender(arg7));
        let v6 = BuyEvent<T0>{
            recipient  : 0x2::tx_context::sender(arg7),
            amount_in  : arg3,
            amount_out : v5,
        };
        0x2::event::emit<BuyEvent<T0>>(v6);
        let v7 = OrderCompletedEvent{order_id: arg6};
        0x2::event::emit<OrderCompletedEvent>(v7);
        0x2::coin::from_balance<T0>(v4, arg7)
    }

    public fun buy_exact_in_second_return<T0>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: 0x1::string::String, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= arg3, 3);
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, 0x2::sui::SUI>(arg0, arg1, false, true, arg3, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price(), arg5);
        let v3 = v2;
        let v4 = v0;
        0x9acb955cf86245b5a078775ae41ea75c13ad56d5474cce2870c6f6f50f1aa673::utils::send_balance<0x2::sui::SUI>(v1, 0x2::tx_context::sender(arg7), arg7);
        let v5 = 0x2::balance::value<T0>(&v4);
        assert!(v5 >= arg4, 1);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, 0x2::sui::SUI>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, 0x2::sui::SUI>(&v3), arg7)), v3);
        0x9acb955cf86245b5a078775ae41ea75c13ad56d5474cce2870c6f6f50f1aa673::utils::send_coin<0x2::sui::SUI>(arg2, 0x2::tx_context::sender(arg7));
        let v6 = BuyEvent<T0>{
            recipient  : 0x2::tx_context::sender(arg7),
            amount_in  : arg3,
            amount_out : v5,
        };
        0x2::event::emit<BuyEvent<T0>>(v6);
        let v7 = OrderCompletedEvent{order_id: arg6};
        0x2::event::emit<OrderCompletedEvent>(v7);
        0x2::coin::from_balance<T0>(v4, arg7)
    }

    public entry fun change_admin(arg0: &AdminCap, arg1: &mut FeeObject, arg2: address) {
        arg1.admin = arg2;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = FeeObject{
            id       : 0x2::object::new(arg0),
            buy_fee  : 100,
            sell_fee : 100,
            admin    : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<FeeObject>(v1);
    }

    public entry fun sell_exact_in<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: u128, arg6: &0x2::clock::Clock, arg7: bool, arg8: 0x1::string::String, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg7) {
            0x2::coin::value<T0>(&arg2)
        } else {
            0x2::coin::value<T1>(&arg3)
        };
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, arg7, true, v0, arg5, arg6);
        let v4 = v3;
        let v5 = v2;
        let v6 = v1;
        let v7 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v4);
        assert!(v7 == v0, 3);
        let (v8, v9, v10) = if (arg7) {
            (0x2::balance::value<T1>(&v5), 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg2, v7, arg9)), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::value<T0>(&v6), 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg3, v7, arg9)))
        };
        assert!(v8 >= arg4, 1);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, v9, v10, v4);
        0x2::coin::join<T0>(&mut arg2, 0x2::coin::from_balance<T0>(v6, arg9));
        0x2::coin::join<T1>(&mut arg3, 0x2::coin::from_balance<T1>(v5, arg9));
        0x9acb955cf86245b5a078775ae41ea75c13ad56d5474cce2870c6f6f50f1aa673::utils::send_coin<T0>(arg2, 0x2::tx_context::sender(arg9));
        0x9acb955cf86245b5a078775ae41ea75c13ad56d5474cce2870c6f6f50f1aa673::utils::send_coin<T1>(arg3, 0x2::tx_context::sender(arg9));
        if (arg7) {
            let v11 = SellEvent<T0>{
                recipient  : 0x2::tx_context::sender(arg9),
                amount_in  : v0,
                amount_out : v8,
            };
            0x2::event::emit<SellEvent<T0>>(v11);
        } else {
            let v12 = SellEvent<T1>{
                recipient  : 0x2::tx_context::sender(arg9),
                amount_in  : v0,
                amount_out : v8,
            };
            0x2::event::emit<SellEvent<T1>>(v12);
        };
        let v13 = OrderCompletedEvent{order_id: arg8};
        0x2::event::emit<OrderCompletedEvent>(v13);
    }

    public fun sell_exact_in_return_with_x_quote<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: 0x1::string::String, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, true, arg3, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price(), arg5);
        let v3 = v2;
        let v4 = v0;
        let v5 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3);
        assert!(v5 == arg3, 3);
        let v6 = 0x2::balance::value<T0>(&v4);
        assert!(v6 >= arg4, 1);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg2, v5, arg7)), v3);
        0x2::coin::join<T1>(&mut arg2, 0x2::coin::from_balance<T1>(v1, arg7));
        0x9acb955cf86245b5a078775ae41ea75c13ad56d5474cce2870c6f6f50f1aa673::utils::send_coin<T1>(arg2, 0x2::tx_context::sender(arg7));
        let v7 = SellEvent<T1>{
            recipient  : 0x2::tx_context::sender(arg7),
            amount_in  : arg3,
            amount_out : v6,
        };
        0x2::event::emit<SellEvent<T1>>(v7);
        let v8 = OrderCompletedEvent{order_id: arg6};
        0x2::event::emit<OrderCompletedEvent>(v8);
        0x2::coin::from_balance<T0>(v4, arg7)
    }

    public fun sell_exact_in_return_with_y_quote<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: 0x1::string::String, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, true, arg3, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price(), arg5);
        let v3 = v2;
        let v4 = v1;
        let v5 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3);
        assert!(v5 == arg3, 3);
        let v6 = 0x2::balance::value<T1>(&v4);
        assert!(v6 >= arg4, 1);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg2, v5, arg7)), 0x2::balance::zero<T1>(), v3);
        0x2::coin::join<T0>(&mut arg2, 0x2::coin::from_balance<T0>(v0, arg7));
        0x9acb955cf86245b5a078775ae41ea75c13ad56d5474cce2870c6f6f50f1aa673::utils::send_coin<T0>(arg2, 0x2::tx_context::sender(arg7));
        let v7 = SellEvent<T1>{
            recipient  : 0x2::tx_context::sender(arg7),
            amount_in  : arg3,
            amount_out : v6,
        };
        0x2::event::emit<SellEvent<T1>>(v7);
        let v8 = OrderCompletedEvent{order_id: arg6};
        0x2::event::emit<OrderCompletedEvent>(v8);
        0x2::coin::from_balance<T1>(v4, arg7)
    }

    // decompiled from Move bytecode v6
}

