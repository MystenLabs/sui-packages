module 0x118bc8023aa31c0a8b9ff8028f6ad31fe71052dc3fcbd2fa8bdc15faf05d044d::adaptor {
    struct CetusAdaptor has drop {
        dummy_field: bool,
    }

    struct CetusSwapped has copy, drop {
        a2b: bool,
        amount_in: u64,
        amount_out: u64,
    }

    fun credit_or_destroy_balance<T0: drop, T1>(arg0: &mut 0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::wallet::Wallet, arg1: 0x2::balance::Balance<T1>, arg2: T0, arg3: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T1>(&arg1) == 0) {
            0x2::balance::destroy_zero<T1>(arg1);
        } else {
            0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::wallet::receive_from_service<T0, T1>(arg0, 0x2::coin::from_balance<T1>(arg1, arg3), arg2);
        };
    }

    public fun swap_a_to_b<T0, T1>(arg0: &mut 0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::wallet::Wallet, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: u64, arg4: u64, arg5: u128, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 > 0, 0);
        let v0 = CetusAdaptor{dummy_field: false};
        let (v1, v2) = 0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::intent::validate_and_swap_out<CetusAdaptor, T0, T1>(arg0, 0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::intent::request_swap<CetusAdaptor, T0, T1>(v0, arg3, arg4), arg7);
        let v3 = 0x2::coin::into_balance<T0>(v1);
        let (v4, v5, v6) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, true, true, arg3, arg5, arg6);
        let v7 = v6;
        0x2::balance::join<T0>(&mut v3, v4);
        let v8 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v7);
        assert!(v8 <= 0x2::balance::value<T0>(&v3), 1);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::split<T0>(&mut v3, v8), 0x2::balance::zero<T1>(), v7);
        let v9 = 0x2::coin::from_balance<T1>(v5, arg7);
        let v10 = 0x2::coin::value<T1>(&v9);
        let v11 = CetusAdaptor{dummy_field: false};
        0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::intent::verify_swap_and_credit<CetusAdaptor, T0, T1>(arg0, v2, 0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::intent::create_swap_receipt<CetusAdaptor, T0, T1>(v11, arg3, v10), v9);
        let v12 = CetusAdaptor{dummy_field: false};
        credit_or_destroy_balance<CetusAdaptor, T0>(arg0, v3, v12, arg7);
        let v13 = CetusSwapped{
            a2b        : true,
            amount_in  : arg3,
            amount_out : v10,
        };
        0x2::event::emit<CetusSwapped>(v13);
    }

    public fun swap_b_to_a<T0, T1>(arg0: &mut 0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::wallet::Wallet, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: u64, arg4: u64, arg5: u128, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 > 0, 0);
        let v0 = CetusAdaptor{dummy_field: false};
        let (v1, v2) = 0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::intent::validate_and_swap_out<CetusAdaptor, T1, T0>(arg0, 0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::intent::request_swap<CetusAdaptor, T1, T0>(v0, arg3, arg4), arg7);
        let v3 = 0x2::coin::into_balance<T1>(v1);
        let (v4, v5, v6) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, false, true, arg3, arg5, arg6);
        let v7 = v6;
        0x2::balance::join<T1>(&mut v3, v5);
        let v8 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v7);
        assert!(v8 <= 0x2::balance::value<T1>(&v3), 1);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v3, v8), v7);
        let v9 = 0x2::coin::from_balance<T0>(v4, arg7);
        let v10 = 0x2::coin::value<T0>(&v9);
        let v11 = CetusAdaptor{dummy_field: false};
        0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::intent::verify_swap_and_credit<CetusAdaptor, T1, T0>(arg0, v2, 0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::intent::create_swap_receipt<CetusAdaptor, T1, T0>(v11, arg3, v10), v9);
        let v12 = CetusAdaptor{dummy_field: false};
        credit_or_destroy_balance<CetusAdaptor, T1>(arg0, v3, v12, arg7);
        let v13 = CetusSwapped{
            a2b        : false,
            amount_in  : arg3,
            amount_out : v10,
        };
        0x2::event::emit<CetusSwapped>(v13);
    }

    // decompiled from Move bytecode v7
}

