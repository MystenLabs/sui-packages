module 0x73e357606f89c8ccaeea197dd0e4c22d23b8b65de00b36079e85a7f7b58710a::cetus_router {
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

    struct FeeCollectedEvent has copy, drop {
        recipient: address,
        amount: u64,
    }

    public entry fun buy_exact_in<T0, T1>(arg0: &FeeObject, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: u64, arg6: u64, arg7: u128, arg8: &0x2::clock::Clock, arg9: bool, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = arg5 * arg0.buy_fee / 10000;
        let v1 = arg5 - v0;
        if (arg9) {
            0x996c4d9480708fb8b92aa7acf819fb0497b5ec8e65ba06601cae2fb6db3312c3::utils::send_coin<T0>(0x2::coin::split<T0>(&mut arg3, v0, arg10), arg0.admin);
        } else {
            0x996c4d9480708fb8b92aa7acf819fb0497b5ec8e65ba06601cae2fb6db3312c3::utils::send_coin<T1>(0x2::coin::split<T1>(&mut arg4, v0, arg10), arg0.admin);
        };
        let (v2, v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, arg9, true, v1, arg7, arg8);
        let v5 = v4;
        let v6 = v3;
        let v7 = v2;
        let v8 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v5);
        assert!(v8 == v1, 3);
        let (v9, v10, v11) = if (arg9) {
            (0x2::balance::value<T1>(&v6), 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg3, v8, arg10)), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::value<T0>(&v7), 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg4, v8, arg10)))
        };
        assert!(v9 >= arg6, 1);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, v10, v11, v5);
        0x2::coin::join<T0>(&mut arg3, 0x2::coin::from_balance<T0>(v7, arg10));
        0x2::coin::join<T1>(&mut arg4, 0x2::coin::from_balance<T1>(v6, arg10));
        0x996c4d9480708fb8b92aa7acf819fb0497b5ec8e65ba06601cae2fb6db3312c3::utils::send_coin<T0>(arg3, 0x2::tx_context::sender(arg10));
        0x996c4d9480708fb8b92aa7acf819fb0497b5ec8e65ba06601cae2fb6db3312c3::utils::send_coin<T1>(arg4, 0x2::tx_context::sender(arg10));
        if (arg9) {
            let v12 = BuyEvent<T1>{
                recipient  : 0x2::tx_context::sender(arg10),
                amount_in  : v1,
                amount_out : v9,
            };
            0x2::event::emit<BuyEvent<T1>>(v12);
        } else {
            let v13 = BuyEvent<T0>{
                recipient  : 0x2::tx_context::sender(arg10),
                amount_in  : v1,
                amount_out : v9,
            };
            0x2::event::emit<BuyEvent<T0>>(v13);
        };
        let v14 = FeeCollectedEvent{
            recipient : arg0.admin,
            amount    : v0,
        };
        0x2::event::emit<FeeCollectedEvent>(v14);
    }

    public entry fun change_admin(arg0: &AdminCap, arg1: &mut FeeObject, arg2: address) {
        arg1.admin = arg2;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = FeeObject{
            id       : 0x2::object::new(arg0),
            buy_fee  : 90,
            sell_fee : 90,
            admin    : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<FeeObject>(v1);
    }

    public entry fun sell_exact_in<T0, T1>(arg0: &FeeObject, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: u64, arg6: u64, arg7: u128, arg8: &0x2::clock::Clock, arg9: bool, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, arg9, true, arg5, arg7, arg8);
        let v3 = v2;
        let v4 = v1;
        let v5 = v0;
        let v6 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3);
        assert!(v6 == arg5, 3);
        let (v7, v8, v9) = if (arg9) {
            (0x2::balance::value<T1>(&v4), 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg3, v6, arg10)), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::value<T0>(&v5), 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg4, v6, arg10)))
        };
        let v10 = v7 * arg0.sell_fee / 10000;
        if (arg9) {
            0x996c4d9480708fb8b92aa7acf819fb0497b5ec8e65ba06601cae2fb6db3312c3::utils::send_coin<T1>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v4, v10), arg10), arg0.admin);
        } else {
            0x996c4d9480708fb8b92aa7acf819fb0497b5ec8e65ba06601cae2fb6db3312c3::utils::send_coin<T0>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v5, v10), arg10), arg0.admin);
        };
        assert!(v7 >= arg6, 1);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, v8, v9, v3);
        0x2::coin::join<T0>(&mut arg3, 0x2::coin::from_balance<T0>(v5, arg10));
        0x2::coin::join<T1>(&mut arg4, 0x2::coin::from_balance<T1>(v4, arg10));
        0x996c4d9480708fb8b92aa7acf819fb0497b5ec8e65ba06601cae2fb6db3312c3::utils::send_coin<T0>(arg3, 0x2::tx_context::sender(arg10));
        0x996c4d9480708fb8b92aa7acf819fb0497b5ec8e65ba06601cae2fb6db3312c3::utils::send_coin<T1>(arg4, 0x2::tx_context::sender(arg10));
        if (arg9) {
            let v11 = SellEvent<T0>{
                recipient  : 0x2::tx_context::sender(arg10),
                amount_in  : arg5,
                amount_out : v7 - v10,
            };
            0x2::event::emit<SellEvent<T0>>(v11);
        } else {
            let v12 = SellEvent<T1>{
                recipient  : 0x2::tx_context::sender(arg10),
                amount_in  : arg5,
                amount_out : v7 - v10,
            };
            0x2::event::emit<SellEvent<T1>>(v12);
        };
        let v13 = FeeCollectedEvent{
            recipient : arg0.admin,
            amount    : v10,
        };
        0x2::event::emit<FeeCollectedEvent>(v13);
    }

    public entry fun sell_exact_out<T0, T1>(arg0: &FeeObject, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: u64, arg6: u64, arg7: u128, arg8: &0x2::clock::Clock, arg9: bool, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, arg9, false, arg5, arg7, arg8);
        let v3 = v2;
        let v4 = v1;
        let v5 = v0;
        let v6 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3);
        assert!(v6 <= arg6, 2);
        let (v7, v8, v9) = if (arg9) {
            assert!(0x2::coin::value<T0>(&arg3) >= v6, 4);
            (0x2::balance::value<T1>(&v4), 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg3, v6, arg10)), 0x2::balance::zero<T1>())
        } else {
            assert!(0x2::coin::value<T1>(&arg4) >= v6, 4);
            (0x2::balance::value<T0>(&v5), 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg4, v6, arg10)))
        };
        let v10 = v7 * arg0.sell_fee / 10000;
        if (arg9) {
            0x996c4d9480708fb8b92aa7acf819fb0497b5ec8e65ba06601cae2fb6db3312c3::utils::send_coin<T1>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v4, v10), arg10), arg0.admin);
        } else {
            0x996c4d9480708fb8b92aa7acf819fb0497b5ec8e65ba06601cae2fb6db3312c3::utils::send_coin<T0>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v5, v10), arg10), arg0.admin);
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, v8, v9, v3);
        0x2::coin::join<T0>(&mut arg3, 0x2::coin::from_balance<T0>(v5, arg10));
        0x2::coin::join<T1>(&mut arg4, 0x2::coin::from_balance<T1>(v4, arg10));
        0x996c4d9480708fb8b92aa7acf819fb0497b5ec8e65ba06601cae2fb6db3312c3::utils::send_coin<T0>(arg3, 0x2::tx_context::sender(arg10));
        0x996c4d9480708fb8b92aa7acf819fb0497b5ec8e65ba06601cae2fb6db3312c3::utils::send_coin<T1>(arg4, 0x2::tx_context::sender(arg10));
        if (arg9) {
            let v11 = SellEvent<T0>{
                recipient  : 0x2::tx_context::sender(arg10),
                amount_in  : v6,
                amount_out : v7 - v10,
            };
            0x2::event::emit<SellEvent<T0>>(v11);
        } else {
            let v12 = SellEvent<T1>{
                recipient  : 0x2::tx_context::sender(arg10),
                amount_in  : v6,
                amount_out : v7 - v10,
            };
            0x2::event::emit<SellEvent<T1>>(v12);
        };
        let v13 = FeeCollectedEvent{
            recipient : arg0.admin,
            amount    : v10,
        };
        0x2::event::emit<FeeCollectedEvent>(v13);
    }

    // decompiled from Move bytecode v6
}

