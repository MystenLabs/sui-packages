module 0x688d2d57305a485bbe8cdcd5bdc94b76bb6a1868b3b10ae3a4c62d83cd277093::arb {
    struct AdminCapability has key {
        id: 0x2::object::UID,
    }

    struct NoopReceipt has drop {
        dummy_field: bool,
    }

    struct SwapReceipt<phantom T0, phantom T1, T2> {
        flash_loan_receipt: T2,
        balance_a: 0x2::balance::Balance<T0>,
        balance_b: 0x2::balance::Balance<T1>,
        repay_amount: u64,
        a2b: bool,
    }

    public fun flash_swap_cetus<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: bool, arg4: u64, arg5: u64, arg6: u128, arg7: &mut 0x2::tx_context::TxContext) : SwapReceipt<T0, T1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>> {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, arg3, true, arg4, arg6, arg0);
        let v3 = v2;
        let v4 = v1;
        let v5 = v0;
        if (arg3) {
            assert!(0x2::balance::value<T0>(&v5) == 0, 102);
            assert!(0x2::balance::value<T1>(&v4) >= arg5, 100);
        } else {
            assert!(0x2::balance::value<T0>(&v5) >= arg5, 100);
            assert!(0x2::balance::value<T1>(&v4) == 0, 102);
        };
        let v6 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3);
        assert!(arg4 == v6, 101);
        SwapReceipt<T0, T1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>>{
            flash_loan_receipt : v3,
            balance_a          : v5,
            balance_b          : v4,
            repay_amount       : v6,
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

    public fun repay_cetus<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: SwapReceipt<T0, T1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let SwapReceipt {
            flash_loan_receipt : v0,
            balance_a          : v1,
            balance_b          : v2,
            repay_amount       : v3,
            a2b                : v4,
        } = arg2;
        let v5 = v3;
        let v6 = v2;
        let v7 = v1;
        let v8 = 0x2::balance::zero<T0>();
        let v9 = 0x2::balance::zero<T1>();
        if (v4) {
            let v10 = 0x2::balance::value<T0>(&v7);
            0x1::debug::print<u64>(&v10);
            0x1::debug::print<u64>(&v5);
            assert!(0x2::balance::value<T0>(&v7) >= v5, 401);
            0x2::balance::destroy_zero<T1>(v6);
            0x2::balance::join<T0>(&mut v8, 0x2::balance::split<T0>(&mut v7, v5));
            if (0x2::balance::value<T0>(&v7) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v7, arg4), arg3);
            } else {
                0x2::balance::destroy_zero<T0>(v7);
            };
        } else {
            let v11 = 0x2::balance::value<T1>(&v6);
            0x1::debug::print<u64>(&v11);
            0x1::debug::print<u64>(&v5);
            0x2::balance::destroy_zero<T0>(v7);
            assert!(0x2::balance::value<T1>(&v6) >= v5, 401);
            0x2::balance::join<T1>(&mut v9, 0x2::balance::split<T1>(&mut v6, v5));
            if (0x2::balance::value<T1>(&v6) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v6, arg4), arg3);
            } else {
                0x2::balance::destroy_zero<T1>(v6);
            };
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, v8, v9, v0);
    }

    public fun swap_cetus_a_b<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: 0x2::balance::Balance<T0>, arg4: u64, arg5: u128, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, true, true, 0x2::balance::value<T0>(&arg3), arg5, arg0);
        let v3 = v2;
        let v4 = v1;
        let v5 = v0;
        assert!(0x2::balance::value<T1>(&v4) >= arg4, 100);
        assert!(0x2::balance::value<T0>(&arg3) == 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3), 101);
        assert!(0x2::balance::value<T0>(&v5) == 0, 102);
        0x2::balance::destroy_zero<T0>(v5);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, arg3, 0x2::balance::zero<T1>(), v3);
        v4
    }

    public fun swap_cetus_b_a<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: 0x2::balance::Balance<T1>, arg4: u64, arg5: u128, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, false, true, 0x2::balance::value<T1>(&arg3), arg5, arg0);
        let v3 = v2;
        let v4 = v1;
        let v5 = v0;
        assert!(0x2::balance::value<T0>(&v5) >= arg4, 100);
        assert!(0x2::balance::value<T1>(&arg3) == 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3), 101);
        assert!(0x2::balance::value<T1>(&v4) == 0, 102);
        0x2::balance::destroy_zero<T1>(v4);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::zero<T0>(), arg3, v3);
        v5
    }

    public fun swap_kriyaswap_a_b<T0, T1>(arg0: &mut 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let v0 = 0x2::coin::into_balance<T1>(0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::swap_token_x<T0, T1>(arg0, 0x2::coin::from_balance<T0>(arg1, arg3), 0x2::balance::value<T0>(&arg1), arg2, arg3));
        assert!(0x2::balance::value<T1>(&v0) >= arg2, 100);
        v0
    }

    public fun swap_kriyaswap_b_a<T0, T1>(arg0: &mut 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>, arg1: 0x2::balance::Balance<T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::coin::into_balance<T0>(0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::swap_token_y<T0, T1>(arg0, 0x2::coin::from_balance<T1>(arg1, arg3), 0x2::balance::value<T1>(&arg1), arg2, arg3));
        assert!(0x2::balance::value<T0>(&v0) >= arg2, 100);
        v0
    }

    public fun swap_suiswap_a_b<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let v0 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v0, 0x2::coin::from_balance<T0>(arg2, arg4));
        let (v1, v2) = 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::do_swap_x_to_y_direct<T0, T1>(arg1, v0, 0x2::balance::value<T0>(&arg2), arg0, arg4);
        let v3 = 0x2::coin::into_balance<T0>(v1);
        let v4 = 0x2::coin::into_balance<T1>(v2);
        assert!(0x2::balance::value<T1>(&v4) >= arg3, 100);
        assert!(0x2::balance::value<T0>(&v3) == 0, 102);
        0x2::balance::destroy_zero<T0>(v3);
        v4
    }

    public fun swap_suiswap_b_a<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T1>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = 0x1::vector::empty<0x2::coin::Coin<T1>>();
        0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut v0, 0x2::coin::from_balance<T1>(arg2, arg4));
        let (v1, v2) = 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::do_swap_y_to_x_direct<T0, T1>(arg1, v0, 0x2::balance::value<T1>(&arg2), arg0, arg4);
        let v3 = 0x2::coin::into_balance<T0>(v2);
        let v4 = 0x2::coin::into_balance<T1>(v1);
        assert!(0x2::balance::value<T0>(&v3) >= arg3, 100);
        assert!(0x2::balance::value<T1>(&v4) == 0, 102);
        0x2::balance::destroy_zero<T1>(v4);
        v3
    }

    public fun take_balance_a_to_receipt<T0, T1, T2>(arg0: &mut SwapReceipt<T0, T1, T2>, arg1: 0x2::balance::Balance<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<T0>(&mut arg0.balance_a, arg1);
    }

    public fun take_balance_b_to_receipt<T0, T1, T2>(arg0: &mut SwapReceipt<T0, T1, T2>, arg1: 0x2::balance::Balance<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<T1>(&mut arg0.balance_b, arg1);
    }

    public fun transfer_admin_capability(arg0: &mut 0x2::tx_context::TxContext, arg1: AdminCapability, arg2: address) {
        0x2::transfer::transfer<AdminCapability>(arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

