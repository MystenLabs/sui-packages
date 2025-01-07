module 0x329d354a3019015e46bba6a48ea3e211ebd435ccfdb9b1f6fb2d5983f5b4a213::z {
    struct Vault has store, key {
        id: 0x2::object::UID,
        admin: address,
        balance: 0x2::bag::Bag,
    }

    public entry fun a<T0, T1>(arg0: &mut Vault, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = false;
        let v1 = if (v0) {
            4295048016
        } else {
            79226673515401279992447579055
        };
        let (v2, v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, v0, true, arg4, v1, arg6);
        let v5 = v4;
        let v6 = v3;
        let v7 = v2;
        let v8 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v5);
        let v9 = if (v0) {
            0x2::balance::value<T1>(&v6)
        } else {
            0x2::balance::value<T0>(&v7)
        };
        assert!(v8 == arg4, 1);
        assert!(v9 >= arg5, 1);
        let (v10, v11) = if (v0) {
            (0x2::balance::zero<T0>(), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg3, v8, arg7)))
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, v10, v11, v5);
        0x2::coin::join<T1>(&mut arg3, 0x2::coin::from_balance<T1>(v6, arg7));
        send_coin<T1>(arg3, 0x2::tx_context::sender(arg7));
        let v12 = 0x1::type_name::get<T0>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&mut arg0.balance, v12)) {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balance, v12, 0x2::balance::zero<T0>());
        };
        0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balance, v12), v7);
    }

    public fun amount<T0>(arg0: &Vault) : u64 {
        0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.balance, 0x1::type_name::get<T0>()))
    }

    public entry fun b<T0, T1>(arg0: &mut Vault, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: bool, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg6) == arg0.admin, 100);
        let v0 = if (arg3) {
            4295048016
        } else {
            79226673515401279992447579055
        };
        let v1 = 0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.balance, 0x1::type_name::get<T0>()));
        let (v2, v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, arg3, true, v1, v0, arg5);
        let v5 = v4;
        let v6 = v3;
        let v7 = v2;
        let v8 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v5);
        let v9 = if (arg3) {
            0x2::balance::value<T1>(&v6)
        } else {
            0x2::balance::value<T0>(&v7)
        };
        assert!(v8 == v1, 1);
        assert!(v9 >= arg4, 1);
        let (v10, v11) = if (arg3) {
            (0x2::balance::split<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balance, 0x1::type_name::get<T0>()), v8), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::balance::split<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.balance, 0x1::type_name::get<T1>()), v8))
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, v10, v11, v5);
        send_coin<T0>(0x2::coin::from_balance<T0>(v7, arg6), 0x2::tx_context::sender(arg6));
        send_coin<T1>(0x2::coin::from_balance<T1>(v6, arg6), 0x2::tx_context::sender(arg6));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault{
            id      : 0x2::object::new(arg0),
            admin   : 0x2::tx_context::sender(arg0),
            balance : 0x2::bag::new(arg0),
        };
        0x2::transfer::public_share_object<Vault>(v0);
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

