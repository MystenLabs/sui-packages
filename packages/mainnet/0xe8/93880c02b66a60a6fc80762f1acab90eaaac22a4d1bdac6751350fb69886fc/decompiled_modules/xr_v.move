module 0xe893880c02b66a60a6fc80762f1acab90eaaac22a4d1bdac6751350fb69886fc::xr_v {
    public fun vf0<T0, T1>(arg0: &mut 0xe893880c02b66a60a6fc80762f1acab90eaaac22a4d1bdac6751350fb69886fc::hz::Ht, arg1: &mut 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>, arg2: &0x2::clock::Clock, arg3: &0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::version::Version, arg4: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x1::option::Option<0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::FlashSwapReceipt>) {
        let v0 = 0xe893880c02b66a60a6fc80762f1acab90eaaac22a4d1bdac6751350fb69886fc::hz::bl(arg0, 0x2::object::id<0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>>(arg1), true);
        if (!0xe893880c02b66a60a6fc80762f1acab90eaaac22a4d1bdac6751350fb69886fc::hz::ia(arg0)) {
            return (0x2::balance::zero<T1>(), 0x1::option::none<0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::FlashSwapReceipt>())
        };
        let (v1, v2, v3) = 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::flash_swap<T0, T1>(arg1, true, true, v0, 4295048017, arg2, arg3, arg4);
        let v4 = v3;
        0x2::balance::destroy_zero<T0>(v1);
        let (v5, _) = 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::swap_receipt_debts(&v4);
        assert!(v5 == v0, 159);
        (v2, 0x1::option::some<0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::FlashSwapReceipt>(v4))
    }

    public fun vf1<T0, T1>(arg0: &mut 0xe893880c02b66a60a6fc80762f1acab90eaaac22a4d1bdac6751350fb69886fc::hz::Ht, arg1: &mut 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>, arg2: &0x2::clock::Clock, arg3: &0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::version::Version, arg4: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x1::option::Option<0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::FlashSwapReceipt>) {
        let v0 = 0xe893880c02b66a60a6fc80762f1acab90eaaac22a4d1bdac6751350fb69886fc::hz::bl(arg0, 0x2::object::id<0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>>(arg1), false);
        if (!0xe893880c02b66a60a6fc80762f1acab90eaaac22a4d1bdac6751350fb69886fc::hz::ia(arg0)) {
            return (0x2::balance::zero<T0>(), 0x1::option::none<0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::FlashSwapReceipt>())
        };
        let (v1, v2, v3) = 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::flash_swap<T0, T1>(arg1, false, true, v0, 79226673515401279992447579054, arg2, arg3, arg4);
        let v4 = v3;
        0x2::balance::destroy_zero<T1>(v2);
        let (_, v6) = 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::swap_receipt_debts(&v4);
        assert!(v6 == v0, 159);
        (v1, 0x1::option::some<0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::FlashSwapReceipt>(v4))
    }

    public fun vg0<T0, T1>(arg0: &0xe893880c02b66a60a6fc80762f1acab90eaaac22a4d1bdac6751350fb69886fc::hz::Ht, arg1: &mut 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>, arg2: 0x1::option::Option<0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::FlashSwapReceipt>, arg3: 0x2::balance::Balance<T0>, arg4: &0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::version::Version, arg5: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        if (!0xe893880c02b66a60a6fc80762f1acab90eaaac22a4d1bdac6751350fb69886fc::hz::ia(arg0)) {
            assert!(0x1::option::is_none<0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::FlashSwapReceipt>(&arg2), 160);
            0x1::option::destroy_none<0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::FlashSwapReceipt>(arg2);
            return arg3
        };
        assert!(0x1::option::is_some<0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::FlashSwapReceipt>(&arg2), 160);
        let v0 = 0x1::option::destroy_some<0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::FlashSwapReceipt>(arg2);
        let (v1, _) = 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::swap_receipt_debts(&v0);
        0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::repay_flash_swap<T0, T1>(arg1, v0, 0xe893880c02b66a60a6fc80762f1acab90eaaac22a4d1bdac6751350fb69886fc::hz::tk<T0>(&mut arg3, v1), 0x2::balance::zero<T1>(), arg4, arg5);
        arg3
    }

    public fun vg1<T0, T1>(arg0: &0xe893880c02b66a60a6fc80762f1acab90eaaac22a4d1bdac6751350fb69886fc::hz::Ht, arg1: &mut 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>, arg2: 0x1::option::Option<0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::FlashSwapReceipt>, arg3: 0x2::balance::Balance<T1>, arg4: &0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::version::Version, arg5: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        if (!0xe893880c02b66a60a6fc80762f1acab90eaaac22a4d1bdac6751350fb69886fc::hz::ia(arg0)) {
            assert!(0x1::option::is_none<0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::FlashSwapReceipt>(&arg2), 160);
            0x1::option::destroy_none<0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::FlashSwapReceipt>(arg2);
            return arg3
        };
        assert!(0x1::option::is_some<0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::FlashSwapReceipt>(&arg2), 160);
        let v0 = 0x1::option::destroy_some<0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::FlashSwapReceipt>(arg2);
        let (_, v2) = 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::swap_receipt_debts(&v0);
        0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::repay_flash_swap<T0, T1>(arg1, v0, 0x2::balance::zero<T0>(), 0xe893880c02b66a60a6fc80762f1acab90eaaac22a4d1bdac6751350fb69886fc::hz::tk<T1>(&mut arg3, v2), arg4, arg5);
        arg3
    }

    public fun vs0<T0, T1>(arg0: &mut 0xe893880c02b66a60a6fc80762f1acab90eaaac22a4d1bdac6751350fb69886fc::hz::Ht, arg1: &mut 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock, arg4: &0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::version::Version, arg5: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        0xe893880c02b66a60a6fc80762f1acab90eaaac22a4d1bdac6751350fb69886fc::hz::bl(arg0, 0x2::object::id<0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>>(arg1), true);
        if (!0xe893880c02b66a60a6fc80762f1acab90eaaac22a4d1bdac6751350fb69886fc::hz::ia(arg0)) {
            0x2::balance::destroy_zero<T0>(arg2);
            return 0x2::balance::zero<T1>()
        };
        let v0 = 0x2::balance::value<T0>(&arg2);
        let (v1, v2, v3) = 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::flash_swap<T0, T1>(arg1, true, true, v0, 4295048017, arg3, arg4, arg5);
        let v4 = v3;
        0x2::balance::destroy_zero<T0>(v1);
        let (v5, _) = 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::swap_receipt_debts(&v4);
        assert!(v5 == v0, 159);
        0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::repay_flash_swap<T0, T1>(arg1, v4, arg2, 0x2::balance::zero<T1>(), arg4, arg5);
        v2
    }

    public fun vs1<T0, T1>(arg0: &mut 0xe893880c02b66a60a6fc80762f1acab90eaaac22a4d1bdac6751350fb69886fc::hz::Ht, arg1: &mut 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T1>, arg3: &0x2::clock::Clock, arg4: &0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::version::Version, arg5: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0xe893880c02b66a60a6fc80762f1acab90eaaac22a4d1bdac6751350fb69886fc::hz::bl(arg0, 0x2::object::id<0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>>(arg1), false);
        if (!0xe893880c02b66a60a6fc80762f1acab90eaaac22a4d1bdac6751350fb69886fc::hz::ia(arg0)) {
            0x2::balance::destroy_zero<T1>(arg2);
            return 0x2::balance::zero<T0>()
        };
        let v0 = 0x2::balance::value<T1>(&arg2);
        let (v1, v2, v3) = 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::flash_swap<T0, T1>(arg1, false, true, v0, 79226673515401279992447579054, arg3, arg4, arg5);
        let v4 = v3;
        0x2::balance::destroy_zero<T1>(v2);
        let (_, v6) = 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::swap_receipt_debts(&v4);
        assert!(v6 == v0, 159);
        0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::repay_flash_swap<T0, T1>(arg1, v4, 0x2::balance::zero<T0>(), arg2, arg4, arg5);
        v1
    }

    // decompiled from Move bytecode v7
}

