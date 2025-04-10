module 0x6096dfdc1e59625c743254c55460e5dbba30caac05b116fb587b29b333c93ff5::my_module {
    struct CB has key {
        id: 0x2::object::UID,
        sui_balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    fun swap<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: bool, arg5: bool, arg6: u64, arg7: u64, arg8: u128, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, arg4, arg5, arg6, arg8, arg9);
        let v3 = v2;
        let v4 = v1;
        let v5 = v0;
        let v6 = if (arg4) {
            0x2::balance::value<T1>(&v4)
        } else {
            0x2::balance::value<T0>(&v5)
        };
        let (v7, v8) = if (arg4) {
            (0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3), arg10)), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg3, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3), arg10)))
        };
        assert!(v6 >= arg7, 3);
        0x2::coin::join<T1>(&mut arg3, 0x2::coin::from_balance<T1>(v4, arg10));
        0x2::coin::join<T0>(&mut arg2, 0x2::coin::from_balance<T0>(v5, arg10));
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, v7, v8, v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, @0xd7111154bb568a79ab46c6035c751344370a3975fe51fd516186afb2a6b51e2e);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg3, @0xd7111154bb568a79ab46c6035c751344370a3975fe51fd516186afb2a6b51e2e);
    }

    public entry fun c_go_ab<T0>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x2::sui::SUI, T0>, arg2: bool, arg3: u64, arg4: u64, arg5: u128, arg6: &0x2::clock::Clock, arg7: &mut CB, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg8) == @0xd7111154bb568a79ab46c6035c751344370a3975fe51fd516186afb2a6b51e2e, 2);
        let v0 = 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg7.sui_balance, 0x2::balance::value<0x2::sui::SUI>(&arg7.sui_balance)), arg8);
        let v1 = 0x2::coin::from_balance<T0>(0x2::balance::zero<T0>(), arg8);
        swap<0x2::sui::SUI, T0>(arg0, arg1, v0, v1, false, arg2, arg3, arg4, arg5, arg6, arg8);
    }

    public entry fun c_go_ba<T0>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg2: bool, arg3: u64, arg4: u64, arg5: u128, arg6: &0x2::clock::Clock, arg7: &mut CB, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg8) == @0xd7111154bb568a79ab46c6035c751344370a3975fe51fd516186afb2a6b51e2e, 2);
        let v0 = 0x2::coin::from_balance<T0>(0x2::balance::zero<T0>(), arg8);
        let v1 = 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg7.sui_balance, 0x2::balance::value<0x2::sui::SUI>(&arg7.sui_balance)), arg8);
        swap<T0, 0x2::sui::SUI>(arg0, arg1, v0, v1, false, arg2, arg3, arg4, arg5, arg6, arg8);
    }

    public entry fun get_out(arg0: &mut CB, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == @0xd7111154bb568a79ab46c6035c751344370a3975fe51fd516186afb2a6b51e2e, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_balance, 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance)), arg1), @0xd7111154bb568a79ab46c6035c751344370a3975fe51fd516186afb2a6b51e2e);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = CB{
            id          : 0x2::object::new(arg0),
            sui_balance : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<CB>(v0);
    }

    public entry fun to_in(arg0: &mut CB, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0xd7111154bb568a79ab46c6035c751344370a3975fe51fd516186afb2a6b51e2e, 2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    // decompiled from Move bytecode v6
}

