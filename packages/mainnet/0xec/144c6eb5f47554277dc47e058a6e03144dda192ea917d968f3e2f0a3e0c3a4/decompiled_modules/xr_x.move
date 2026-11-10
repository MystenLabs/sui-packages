module 0xec144c6eb5f47554277dc47e058a6e03144dda192ea917d968f3e2f0a3e0c3a4::xr_x {
    fun b<T0, T1>(arg0: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg1: 0x2::object::ID, arg2: u64) : &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::Pool<T0, T1> {
        let v0 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::borrow_mut_pool<T0, T1>(arg0, arg2);
        assert!(0x2::object::id<0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::Pool<T0, T1>>(v0) == arg1, 184);
        v0
    }

    public fun xf0<T0, T1>(arg0: &mut 0xec144c6eb5f47554277dc47e058a6e03144dda192ea917d968f3e2f0a3e0c3a4::hz::Ht, arg1: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg2: 0x2::object::ID, arg3: u64, arg4: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x1::option::Option<0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::SwapReceipt>) {
        let v0 = b<T0, T1>(arg1, arg2, arg3);
        let v1 = 0xec144c6eb5f47554277dc47e058a6e03144dda192ea917d968f3e2f0a3e0c3a4::hz::bl(arg0, 0x2::object::id<0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::Pool<T0, T1>>(v0), true);
        if (!0xec144c6eb5f47554277dc47e058a6e03144dda192ea917d968f3e2f0a3e0c3a4::hz::ia(arg0)) {
            return (0x2::balance::zero<T1>(), 0x1::option::none<0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::SwapReceipt>())
        };
        let (v2, v3, v4) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::swap<T0, T1>(v0, true, true, v1, 4295048017, arg4, arg5, arg6);
        let v5 = v4;
        0x2::balance::destroy_zero<T0>(v2);
        let (v6, v7) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::swap_receipt_debts(&v5);
        assert!(v6 == v1 && v7 == 0, 159);
        (v3, 0x1::option::some<0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::SwapReceipt>(v5))
    }

    public fun xf1<T0, T1>(arg0: &mut 0xec144c6eb5f47554277dc47e058a6e03144dda192ea917d968f3e2f0a3e0c3a4::hz::Ht, arg1: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg2: 0x2::object::ID, arg3: u64, arg4: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x1::option::Option<0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::SwapReceipt>) {
        let v0 = b<T0, T1>(arg1, arg2, arg3);
        let v1 = 0xec144c6eb5f47554277dc47e058a6e03144dda192ea917d968f3e2f0a3e0c3a4::hz::bl(arg0, 0x2::object::id<0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::Pool<T0, T1>>(v0), false);
        if (!0xec144c6eb5f47554277dc47e058a6e03144dda192ea917d968f3e2f0a3e0c3a4::hz::ia(arg0)) {
            return (0x2::balance::zero<T0>(), 0x1::option::none<0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::SwapReceipt>())
        };
        let (v2, v3, v4) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::swap<T0, T1>(v0, false, true, v1, 79226673515401279992447579054, arg4, arg5, arg6);
        let v5 = v4;
        0x2::balance::destroy_zero<T1>(v3);
        let (v6, v7) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::swap_receipt_debts(&v5);
        assert!(v6 == 0 && v7 == v1, 159);
        (v2, 0x1::option::some<0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::SwapReceipt>(v5))
    }

    public fun xg0<T0, T1>(arg0: &0xec144c6eb5f47554277dc47e058a6e03144dda192ea917d968f3e2f0a3e0c3a4::hz::Ht, arg1: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg2: 0x2::object::ID, arg3: u64, arg4: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg5: 0x1::option::Option<0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::SwapReceipt>, arg6: 0x2::balance::Balance<T0>, arg7: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        if (!0xec144c6eb5f47554277dc47e058a6e03144dda192ea917d968f3e2f0a3e0c3a4::hz::ia(arg0)) {
            assert!(0x1::option::is_none<0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::SwapReceipt>(&arg5), 160);
            0x1::option::destroy_none<0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::SwapReceipt>(arg5);
            return arg6
        };
        assert!(0x1::option::is_some<0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::SwapReceipt>(&arg5), 160);
        let v0 = 0x1::option::destroy_some<0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::SwapReceipt>(arg5);
        let (v1, _) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::swap_receipt_debts(&v0);
        0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::pay<T0, T1>(b<T0, T1>(arg1, arg2, arg3), v0, 0xec144c6eb5f47554277dc47e058a6e03144dda192ea917d968f3e2f0a3e0c3a4::hz::tk<T0>(&mut arg6, v1), 0x2::balance::zero<T1>(), arg4, arg7);
        arg6
    }

    public fun xg1<T0, T1>(arg0: &0xec144c6eb5f47554277dc47e058a6e03144dda192ea917d968f3e2f0a3e0c3a4::hz::Ht, arg1: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg2: 0x2::object::ID, arg3: u64, arg4: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg5: 0x1::option::Option<0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::SwapReceipt>, arg6: 0x2::balance::Balance<T1>, arg7: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        if (!0xec144c6eb5f47554277dc47e058a6e03144dda192ea917d968f3e2f0a3e0c3a4::hz::ia(arg0)) {
            assert!(0x1::option::is_none<0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::SwapReceipt>(&arg5), 160);
            0x1::option::destroy_none<0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::SwapReceipt>(arg5);
            return arg6
        };
        assert!(0x1::option::is_some<0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::SwapReceipt>(&arg5), 160);
        let v0 = 0x1::option::destroy_some<0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::SwapReceipt>(arg5);
        let (_, v2) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::swap_receipt_debts(&v0);
        0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::pay<T0, T1>(b<T0, T1>(arg1, arg2, arg3), v0, 0x2::balance::zero<T0>(), 0xec144c6eb5f47554277dc47e058a6e03144dda192ea917d968f3e2f0a3e0c3a4::hz::tk<T1>(&mut arg6, v2), arg4, arg7);
        arg6
    }

    public fun xs0<T0, T1>(arg0: &mut 0xec144c6eb5f47554277dc47e058a6e03144dda192ea917d968f3e2f0a3e0c3a4::hz::Ht, arg1: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg2: 0x2::object::ID, arg3: u64, arg4: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg5: 0x2::balance::Balance<T0>, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let v0 = b<T0, T1>(arg1, arg2, arg3);
        0xec144c6eb5f47554277dc47e058a6e03144dda192ea917d968f3e2f0a3e0c3a4::hz::bl(arg0, 0x2::object::id<0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::Pool<T0, T1>>(v0), true);
        if (!0xec144c6eb5f47554277dc47e058a6e03144dda192ea917d968f3e2f0a3e0c3a4::hz::ia(arg0)) {
            0x2::balance::destroy_zero<T0>(arg5);
            return 0x2::balance::zero<T1>()
        };
        let v1 = 0x2::balance::value<T0>(&arg5);
        let (v2, v3, v4) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::swap<T0, T1>(v0, true, true, v1, 4295048017, arg4, arg6, arg7);
        let v5 = v4;
        0x2::balance::destroy_zero<T0>(v2);
        let (v6, v7) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::swap_receipt_debts(&v5);
        assert!(v6 == v1 && v7 == 0, 159);
        0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::pay<T0, T1>(v0, v5, arg5, 0x2::balance::zero<T1>(), arg4, arg7);
        v3
    }

    public fun xs1<T0, T1>(arg0: &mut 0xec144c6eb5f47554277dc47e058a6e03144dda192ea917d968f3e2f0a3e0c3a4::hz::Ht, arg1: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg2: 0x2::object::ID, arg3: u64, arg4: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg5: 0x2::balance::Balance<T1>, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = b<T0, T1>(arg1, arg2, arg3);
        0xec144c6eb5f47554277dc47e058a6e03144dda192ea917d968f3e2f0a3e0c3a4::hz::bl(arg0, 0x2::object::id<0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::Pool<T0, T1>>(v0), false);
        if (!0xec144c6eb5f47554277dc47e058a6e03144dda192ea917d968f3e2f0a3e0c3a4::hz::ia(arg0)) {
            0x2::balance::destroy_zero<T1>(arg5);
            return 0x2::balance::zero<T0>()
        };
        let v1 = 0x2::balance::value<T1>(&arg5);
        let (v2, v3, v4) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::swap<T0, T1>(v0, false, true, v1, 79226673515401279992447579054, arg4, arg6, arg7);
        let v5 = v4;
        0x2::balance::destroy_zero<T1>(v3);
        let (v6, v7) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::swap_receipt_debts(&v5);
        assert!(v6 == 0 && v7 == v1, 159);
        0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::pay<T0, T1>(v0, v5, 0x2::balance::zero<T0>(), arg5, arg4, arg7);
        v2
    }

    // decompiled from Move bytecode v7
}

