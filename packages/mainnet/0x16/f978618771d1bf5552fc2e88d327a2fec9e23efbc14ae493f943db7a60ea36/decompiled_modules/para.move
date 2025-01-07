module 0x16f978618771d1bf5552fc2e88d327a2fec9e23efbc14ae493f943db7a60ea36::para {
    struct AdminCapability has key {
        id: 0x2::object::UID,
    }

    struct SwapReceipt<phantom T0, phantom T1, T2> {
        flash_loan_receipt: T2,
        balance_a: 0x2::balance::Balance<T0>,
        balance_b: 0x2::balance::Balance<T1>,
        repay_amount: u64,
        a2b: bool,
    }

    public fun addAdminCapability(arg0: &AdminCapability, arg1: &mut 0x2::tx_context::TxContext, arg2: address) {
        let v0 = AdminCapability{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCapability>(v0, arg2);
    }

    public fun flash_swap_cetus<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: bool, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : SwapReceipt<T0, T1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>> {
        let v0 = if (arg3) {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg2) / 10
        } else {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg2) * 10
        };
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, arg3, true, arg4, v0, arg0);
        let v4 = v3;
        let v5 = v2;
        let v6 = v1;
        if (arg3) {
            assert!(0x2::balance::value<T0>(&v6) == 0, 102);
        } else {
            assert!(0x2::balance::value<T1>(&v5) == 0, 102);
        };
        let v7 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v4);
        assert!(arg4 == v7, 101);
        SwapReceipt<T0, T1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>>{
            flash_loan_receipt : v4,
            balance_a          : v6,
            balance_b          : v5,
            repay_amount       : v7,
            a2b                : arg3,
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCapability{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCapability>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun move_balance_a_from_receipt<T0, T1, T2>(arg0: &mut SwapReceipt<T0, T1, T2>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0x2::balance::withdraw_all<T0>(&mut arg0.balance_a)
    }

    public fun move_balance_b_from_receipt<T0, T1, T2>(arg0: &mut SwapReceipt<T0, T1, T2>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        0x2::balance::withdraw_all<T1>(&mut arg0.balance_b)
    }

    public fun repay_cetus_flash_swap<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: SwapReceipt<T0, T1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let SwapReceipt {
            flash_loan_receipt : v0,
            balance_a          : v1,
            balance_b          : v2,
            repay_amount       : v3,
            a2b                : v4,
        } = arg2;
        let v5 = v2;
        let v6 = v1;
        let v7 = 0x2::balance::zero<T0>();
        let v8 = 0x2::balance::zero<T1>();
        if (v4) {
            assert!(0x2::balance::value<T0>(&v6) >= v3, 401);
            0x2::balance::destroy_zero<T1>(v5);
            0x2::balance::join<T0>(&mut v7, 0x2::balance::split<T0>(&mut v6, v3));
            if (0x2::balance::value<T0>(&v6) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v6, arg4), arg3);
            } else {
                0x2::balance::destroy_zero<T0>(v6);
            };
        } else {
            0x2::balance::destroy_zero<T0>(v6);
            assert!(0x2::balance::value<T1>(&v5) >= v3, 401);
            0x2::balance::join<T1>(&mut v8, 0x2::balance::split<T1>(&mut v5, v3));
            if (0x2::balance::value<T1>(&v5) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v5, arg4), arg3);
            } else {
                0x2::balance::destroy_zero<T1>(v5);
            };
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, v7, v8, v0);
    }

    public fun swap_cetus_a_b<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: 0x2::balance::Balance<T0>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, true, true, 0x2::balance::value<T0>(&arg3), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg2) / 10, arg0);
        let v3 = v2;
        let v4 = v0;
        assert!(0x2::balance::value<T0>(&arg3) == 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3), 101);
        assert!(0x2::balance::value<T0>(&v4) == 0, 102);
        0x2::balance::destroy_zero<T0>(v4);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, arg3, 0x2::balance::zero<T1>(), v3);
        v1
    }

    public fun swap_cetus_b_a<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: 0x2::balance::Balance<T1>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, false, true, 0x2::balance::value<T1>(&arg3), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg2) * 10, arg0);
        let v3 = v2;
        let v4 = v1;
        assert!(0x2::balance::value<T1>(&arg3) == 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3), 101);
        assert!(0x2::balance::value<T1>(&v4) == 0, 102);
        0x2::balance::destroy_zero<T1>(v4);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::zero<T0>(), arg3, v3);
        v0
    }

    // decompiled from Move bytecode v6
}

