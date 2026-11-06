module 0x552c5324a0d97bef3ca8fd20cdd1233afd844474a972d433b2be1fbc06b92462::cetus {
    struct Loan {
        receipt: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashLoanReceipt,
        fee: u64,
    }

    public fun borrow_a<T0, T1>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T0>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig) : (0x2::balance::Balance<T0>, Loan) {
        let v0 = 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::open_loan<T0>(arg0);
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg2, arg1, true, v0);
        0x2::balance::destroy_zero<T1>(v2);
        let v4 = Loan{
            receipt : v3,
            fee     : loan_fee<T0, T1>(arg1, v0),
        };
        (v1, v4)
    }

    public fun borrow_b<T0, T1>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T1>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig) : (0x2::balance::Balance<T1>, Loan) {
        let v0 = 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::open_loan<T1>(arg0);
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg2, arg1, false, v0);
        0x2::balance::destroy_zero<T0>(v1);
        let v4 = Loan{
            receipt : v3,
            fee     : loan_fee<T0, T1>(arg1, v0),
        };
        (v2, v4)
    }

    public fun flash_a2b<T0, T1>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T0>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &0x2::clock::Clock) : (0x2::balance::Balance<T1>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>) {
        let v0 = 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::open_loan<T0>(arg0);
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg2, arg1, true, true, v0, 4295048016, arg3);
        let v4 = v3;
        let v5 = v2;
        0x2::balance::destroy_zero<T0>(v1);
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v4) == v0, 2);
        0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::record_leg<T0>(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1), true, 0x2::balance::value<T1>(&v5));
        (v5, v4)
    }

    public fun flash_a2b_limit<T0, T1>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T0>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &0x2::clock::Clock, arg4: u128, arg5: bool) : (0x2::balance::Balance<T1>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>) {
        let v0 = 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::open_loan<T0>(arg0);
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg2, arg1, true, true, v0, arg4, arg3);
        let v4 = v3;
        let v5 = v2;
        0x2::balance::destroy_zero<T0>(v1);
        let v6 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v4);
        let v7 = if (v6 > 0) {
            if (v6 <= v0) {
                !arg5 || v6 == v0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v7, 2);
        assert!(0x2::balance::value<T1>(&v5) > 0, 1);
        0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::record_leg<T0>(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1), true, 0x2::balance::value<T1>(&v5));
        (v5, v4)
    }

    public fun flash_a2b_partner<T0, T1>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T0>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg4: &0x2::clock::Clock) : (0x2::balance::Balance<T1>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>) {
        let v0 = 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::open_loan<T0>(arg0);
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap_with_partner<T0, T1>(arg2, arg1, arg3, true, true, v0, 4295048016, arg4);
        let v4 = v3;
        let v5 = v2;
        0x2::balance::destroy_zero<T0>(v1);
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v4) == v0, 2);
        0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::record_leg<T0>(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1), true, 0x2::balance::value<T1>(&v5));
        (v5, v4)
    }

    public fun flash_a2b_partner_limit<T0, T1>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T0>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg4: &0x2::clock::Clock, arg5: u128, arg6: bool) : (0x2::balance::Balance<T1>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>) {
        let v0 = 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::open_loan<T0>(arg0);
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap_with_partner<T0, T1>(arg2, arg1, arg3, true, true, v0, arg5, arg4);
        let v4 = v3;
        let v5 = v2;
        0x2::balance::destroy_zero<T0>(v1);
        let v6 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v4);
        let v7 = if (v6 > 0) {
            if (v6 <= v0) {
                !arg6 || v6 == v0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v7, 2);
        assert!(0x2::balance::value<T1>(&v5) > 0, 1);
        0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::record_leg<T0>(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1), true, 0x2::balance::value<T1>(&v5));
        (v5, v4)
    }

    public fun flash_a2b_partner_relative_limit<T0, T1>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T0>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg4: &0x2::clock::Clock, arg5: u128, arg6: u128, arg7: u128, arg8: bool) : (0x2::balance::Balance<T1>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>) {
        let v0 = 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::clmm_limit::relative(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1), true, arg5, arg6, arg7);
        flash_a2b_partner_limit<T0, T1>(arg0, arg1, arg2, arg3, arg4, v0, arg8)
    }

    public fun flash_a2b_relative_limit<T0, T1>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T0>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &0x2::clock::Clock, arg4: u128, arg5: u128, arg6: u128, arg7: bool) : (0x2::balance::Balance<T1>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>) {
        let v0 = 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::clmm_limit::relative(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1), true, arg4, arg5, arg6);
        flash_a2b_limit<T0, T1>(arg0, arg1, arg2, arg3, v0, arg7)
    }

    public fun flash_b2a<T0, T1>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T1>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>) {
        let v0 = 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::open_loan<T1>(arg0);
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg2, arg1, false, true, v0, 79226673515401279992447579055, arg3);
        let v4 = v3;
        let v5 = v1;
        0x2::balance::destroy_zero<T1>(v2);
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v4) == v0, 2);
        0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::record_leg<T1>(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1), false, 0x2::balance::value<T0>(&v5));
        (v5, v4)
    }

    public fun flash_b2a_limit<T0, T1>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T1>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &0x2::clock::Clock, arg4: u128, arg5: bool) : (0x2::balance::Balance<T0>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>) {
        let v0 = 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::open_loan<T1>(arg0);
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg2, arg1, false, true, v0, arg4, arg3);
        let v4 = v3;
        let v5 = v1;
        0x2::balance::destroy_zero<T1>(v2);
        let v6 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v4);
        let v7 = if (v6 > 0) {
            if (v6 <= v0) {
                !arg5 || v6 == v0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v7, 2);
        assert!(0x2::balance::value<T0>(&v5) > 0, 1);
        0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::record_leg<T1>(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1), false, 0x2::balance::value<T0>(&v5));
        (v5, v4)
    }

    public fun flash_b2a_partner<T0, T1>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T1>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg4: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>) {
        let v0 = 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::open_loan<T1>(arg0);
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap_with_partner<T0, T1>(arg2, arg1, arg3, false, true, v0, 79226673515401279992447579055, arg4);
        let v4 = v3;
        let v5 = v1;
        0x2::balance::destroy_zero<T1>(v2);
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v4) == v0, 2);
        0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::record_leg<T1>(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1), false, 0x2::balance::value<T0>(&v5));
        (v5, v4)
    }

    public fun flash_b2a_partner_limit<T0, T1>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T1>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg4: &0x2::clock::Clock, arg5: u128, arg6: bool) : (0x2::balance::Balance<T0>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>) {
        let v0 = 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::open_loan<T1>(arg0);
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap_with_partner<T0, T1>(arg2, arg1, arg3, false, true, v0, arg5, arg4);
        let v4 = v3;
        let v5 = v1;
        0x2::balance::destroy_zero<T1>(v2);
        let v6 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v4);
        let v7 = if (v6 > 0) {
            if (v6 <= v0) {
                !arg6 || v6 == v0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v7, 2);
        assert!(0x2::balance::value<T0>(&v5) > 0, 1);
        0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::record_leg<T1>(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1), false, 0x2::balance::value<T0>(&v5));
        (v5, v4)
    }

    public fun flash_b2a_partner_relative_limit<T0, T1>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T1>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg4: &0x2::clock::Clock, arg5: u128, arg6: u128, arg7: u128, arg8: bool) : (0x2::balance::Balance<T0>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>) {
        let v0 = 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::clmm_limit::relative(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1), false, arg5, arg6, arg7);
        flash_b2a_partner_limit<T0, T1>(arg0, arg1, arg2, arg3, arg4, v0, arg8)
    }

    public fun flash_b2a_relative_limit<T0, T1>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T1>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &0x2::clock::Clock, arg4: u128, arg5: u128, arg6: u128, arg7: bool) : (0x2::balance::Balance<T0>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>) {
        let v0 = 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::clmm_limit::relative(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1), false, arg4, arg5, arg6);
        flash_b2a_limit<T0, T1>(arg0, arg1, arg2, arg3, v0, arg7)
    }

    fun loan_fee<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: u64) : u64 {
        let v0 = (arg1 as u128) * (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::fee_rate<T0, T1>(arg0) as u128);
        let v1 = if (v0 % 1000000 > 0) {
            1
        } else {
            0
        };
        ((v0 / 1000000 + v1) as u64)
    }

    public fun quote<T0, T1, T2>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T0>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg2: bool) {
        let v0 = vector[];
        let v1 = 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::quote_inputs<T0>(arg0);
        0x1::vector::reverse<u64>(&mut v1);
        let v2 = 0;
        while (v2 < 0x1::vector::length<u64>(&v1)) {
            0x1::vector::push_back<u64>(&mut v0, simulate<T1, T2>(arg1, 0x1::vector::pop_back<u64>(&mut v1), arg2));
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<u64>(v1);
        0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::record_quote<T0>(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg1), arg2, v0, vector[], vector[]);
    }

    public fun repay_a2b<T0, T1>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T0>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: 0x2::balance::Balance<T0>, arg4: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>) : 0x2::balance::Balance<T0> {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg2, arg1, 0x2::balance::split<T0>(&mut arg3, 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::close_loan<T0>(arg0, &mut arg3)), 0x2::balance::zero<T1>(), arg4);
        arg3
    }

    public fun repay_a2b_limit<T0, T1>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T0>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: 0x2::balance::Balance<T0>, arg4: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>) : 0x2::balance::Balance<T0> {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg2, arg1, 0x2::balance::split<T0>(&mut arg3, 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::close_flash_loan<T0>(arg0, &mut arg3, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&arg4))), 0x2::balance::zero<T1>(), arg4);
        arg3
    }

    public fun repay_a2b_partner<T0, T1>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T0>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg4: 0x2::balance::Balance<T0>, arg5: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>) : 0x2::balance::Balance<T0> {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap_with_partner<T0, T1>(arg2, arg1, arg3, 0x2::balance::split<T0>(&mut arg4, 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::close_loan<T0>(arg0, &mut arg4)), 0x2::balance::zero<T1>(), arg5);
        arg4
    }

    public fun repay_a2b_partner_limit<T0, T1>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T0>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg4: 0x2::balance::Balance<T0>, arg5: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>) : 0x2::balance::Balance<T0> {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap_with_partner<T0, T1>(arg2, arg1, arg3, 0x2::balance::split<T0>(&mut arg4, 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::close_flash_loan<T0>(arg0, &mut arg4, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&arg5))), 0x2::balance::zero<T1>(), arg5);
        arg4
    }

    public fun repay_b2a<T0, T1>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T1>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: 0x2::balance::Balance<T1>, arg4: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>) : 0x2::balance::Balance<T1> {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg2, arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg3, 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::close_loan<T1>(arg0, &mut arg3)), arg4);
        arg3
    }

    public fun repay_b2a_limit<T0, T1>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T1>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: 0x2::balance::Balance<T1>, arg4: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>) : 0x2::balance::Balance<T1> {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg2, arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg3, 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::close_flash_loan<T1>(arg0, &mut arg3, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&arg4))), arg4);
        arg3
    }

    public fun repay_b2a_partner<T0, T1>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T1>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg4: 0x2::balance::Balance<T1>, arg5: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>) : 0x2::balance::Balance<T1> {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap_with_partner<T0, T1>(arg2, arg1, arg3, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg4, 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::close_loan<T1>(arg0, &mut arg4)), arg5);
        arg4
    }

    public fun repay_b2a_partner_limit<T0, T1>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T1>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg4: 0x2::balance::Balance<T1>, arg5: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>) : 0x2::balance::Balance<T1> {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap_with_partner<T0, T1>(arg2, arg1, arg3, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg4, 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::close_flash_loan<T1>(arg0, &mut arg4, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&arg5))), arg5);
        arg4
    }

    public fun repay_loan_a<T0, T1>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T0>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: 0x2::balance::Balance<T0>, arg4: Loan) : 0x2::balance::Balance<T0> {
        let Loan {
            receipt : v0,
            fee     : v1,
        } = arg4;
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg2, arg1, 0x2::balance::split<T0>(&mut arg3, 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::close_loan<T0>(arg0, &mut arg3) + v1), 0x2::balance::zero<T1>(), v0);
        arg3
    }

    public fun repay_loan_b<T0, T1>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T1>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: 0x2::balance::Balance<T1>, arg4: Loan) : 0x2::balance::Balance<T1> {
        let Loan {
            receipt : v0,
            fee     : v1,
        } = arg4;
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg2, arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg3, 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::close_loan<T1>(arg0, &mut arg3) + v1), v0);
        arg3
    }

    fun simulate<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: u64, arg2: bool) : u64 {
        if (arg1 == 0) {
            return 0
        };
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, T1>(arg0, arg2, true, arg1);
        if (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_is_exceed(&v0)) {
            return 0
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v0)
    }

    public fun swap_a2b<T0, T1, T2>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T0>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &0x2::clock::Clock, arg4: 0x2::balance::Balance<T1>) : (0x2::balance::Balance<T2>, 0x2::balance::Balance<T1>) {
        let v0 = 0x2::balance::value<T1>(&arg4);
        assert!(v0 > 0, 1);
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T2>(arg2, arg1, true, true, v0, 4295048016, arg3);
        let v4 = v3;
        let v5 = v2;
        0x2::balance::destroy_zero<T1>(v1);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T2>(arg2, arg1, 0x2::balance::split<T1>(&mut arg4, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T2>(&v4)), 0x2::balance::zero<T2>(), v4);
        0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::record_leg<T0>(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg1), true, 0x2::balance::value<T2>(&v5));
        (v5, arg4)
    }

    public fun swap_a2b_limit<T0, T1, T2>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T0>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &0x2::clock::Clock, arg4: 0x2::balance::Balance<T1>, arg5: u128, arg6: bool) : (0x2::balance::Balance<T2>, 0x2::balance::Balance<T1>) {
        let v0 = 0x2::balance::value<T1>(&arg4);
        assert!(v0 > 0, 1);
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T2>(arg2, arg1, true, true, v0, arg5, arg3);
        let v4 = v3;
        let v5 = v2;
        0x2::balance::destroy_zero<T1>(v1);
        let v6 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T2>(&v4);
        let v7 = if (v6 > 0) {
            if (v6 <= v0) {
                !arg6 || v6 == v0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v7, 2);
        assert!(0x2::balance::value<T2>(&v5) > 0, 1);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T2>(arg2, arg1, 0x2::balance::split<T1>(&mut arg4, v6), 0x2::balance::zero<T2>(), v4);
        0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::record_leg<T0>(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg1), true, 0x2::balance::value<T2>(&v5));
        (v5, arg4)
    }

    public fun swap_a2b_partner<T0, T1, T2>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T0>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg4: &0x2::clock::Clock, arg5: 0x2::balance::Balance<T1>) : (0x2::balance::Balance<T2>, 0x2::balance::Balance<T1>) {
        let v0 = 0x2::balance::value<T1>(&arg5);
        assert!(v0 > 0, 1);
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap_with_partner<T1, T2>(arg2, arg1, arg3, true, true, v0, 4295048016, arg4);
        let v4 = v3;
        let v5 = v2;
        0x2::balance::destroy_zero<T1>(v1);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap_with_partner<T1, T2>(arg2, arg1, arg3, 0x2::balance::split<T1>(&mut arg5, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T2>(&v4)), 0x2::balance::zero<T2>(), v4);
        0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::record_leg<T0>(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg1), true, 0x2::balance::value<T2>(&v5));
        (v5, arg5)
    }

    public fun swap_a2b_partner_limit<T0, T1, T2>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T0>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg4: &0x2::clock::Clock, arg5: 0x2::balance::Balance<T1>, arg6: u128, arg7: bool) : (0x2::balance::Balance<T2>, 0x2::balance::Balance<T1>) {
        let v0 = 0x2::balance::value<T1>(&arg5);
        assert!(v0 > 0, 1);
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap_with_partner<T1, T2>(arg2, arg1, arg3, true, true, v0, arg6, arg4);
        let v4 = v3;
        let v5 = v2;
        0x2::balance::destroy_zero<T1>(v1);
        let v6 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T2>(&v4);
        let v7 = if (v6 > 0) {
            if (v6 <= v0) {
                !arg7 || v6 == v0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v7, 2);
        assert!(0x2::balance::value<T2>(&v5) > 0, 1);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap_with_partner<T1, T2>(arg2, arg1, arg3, 0x2::balance::split<T1>(&mut arg5, v6), 0x2::balance::zero<T2>(), v4);
        0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::record_leg<T0>(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg1), true, 0x2::balance::value<T2>(&v5));
        (v5, arg5)
    }

    public fun swap_a2b_partner_relative_limit<T0, T1, T2>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T0>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg4: &0x2::clock::Clock, arg5: 0x2::balance::Balance<T1>, arg6: u128, arg7: u128, arg8: u128, arg9: bool) : (0x2::balance::Balance<T2>, 0x2::balance::Balance<T1>) {
        let v0 = 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::clmm_limit::relative(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T1, T2>(arg1), true, arg6, arg7, arg8);
        swap_a2b_partner_limit<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, v0, arg9)
    }

    public fun swap_a2b_relative_limit<T0, T1, T2>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T0>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &0x2::clock::Clock, arg4: 0x2::balance::Balance<T1>, arg5: u128, arg6: u128, arg7: u128, arg8: bool) : (0x2::balance::Balance<T2>, 0x2::balance::Balance<T1>) {
        let v0 = 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::clmm_limit::relative(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T1, T2>(arg1), true, arg5, arg6, arg7);
        swap_a2b_limit<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, v0, arg8)
    }

    public fun swap_b2a<T0, T1, T2>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T0>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &0x2::clock::Clock, arg4: 0x2::balance::Balance<T2>) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T2>) {
        let v0 = 0x2::balance::value<T2>(&arg4);
        assert!(v0 > 0, 1);
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T2>(arg2, arg1, false, true, v0, 79226673515401279992447579055, arg3);
        let v4 = v3;
        let v5 = v1;
        0x2::balance::destroy_zero<T2>(v2);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T2>(arg2, arg1, 0x2::balance::zero<T1>(), 0x2::balance::split<T2>(&mut arg4, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T2>(&v4)), v4);
        0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::record_leg<T0>(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg1), false, 0x2::balance::value<T1>(&v5));
        (v5, arg4)
    }

    public fun swap_b2a_limit<T0, T1, T2>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T0>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &0x2::clock::Clock, arg4: 0x2::balance::Balance<T2>, arg5: u128, arg6: bool) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T2>) {
        let v0 = 0x2::balance::value<T2>(&arg4);
        assert!(v0 > 0, 1);
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T2>(arg2, arg1, false, true, v0, arg5, arg3);
        let v4 = v3;
        let v5 = v1;
        0x2::balance::destroy_zero<T2>(v2);
        let v6 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T2>(&v4);
        let v7 = if (v6 > 0) {
            if (v6 <= v0) {
                !arg6 || v6 == v0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v7, 2);
        assert!(0x2::balance::value<T1>(&v5) > 0, 1);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T2>(arg2, arg1, 0x2::balance::zero<T1>(), 0x2::balance::split<T2>(&mut arg4, v6), v4);
        0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::record_leg<T0>(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg1), false, 0x2::balance::value<T1>(&v5));
        (v5, arg4)
    }

    public fun swap_b2a_partner<T0, T1, T2>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T0>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg4: &0x2::clock::Clock, arg5: 0x2::balance::Balance<T2>) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T2>) {
        let v0 = 0x2::balance::value<T2>(&arg5);
        assert!(v0 > 0, 1);
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap_with_partner<T1, T2>(arg2, arg1, arg3, false, true, v0, 79226673515401279992447579055, arg4);
        let v4 = v3;
        let v5 = v1;
        0x2::balance::destroy_zero<T2>(v2);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap_with_partner<T1, T2>(arg2, arg1, arg3, 0x2::balance::zero<T1>(), 0x2::balance::split<T2>(&mut arg5, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T2>(&v4)), v4);
        0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::record_leg<T0>(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg1), false, 0x2::balance::value<T1>(&v5));
        (v5, arg5)
    }

    public fun swap_b2a_partner_limit<T0, T1, T2>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T0>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg4: &0x2::clock::Clock, arg5: 0x2::balance::Balance<T2>, arg6: u128, arg7: bool) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T2>) {
        let v0 = 0x2::balance::value<T2>(&arg5);
        assert!(v0 > 0, 1);
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap_with_partner<T1, T2>(arg2, arg1, arg3, false, true, v0, arg6, arg4);
        let v4 = v3;
        let v5 = v1;
        0x2::balance::destroy_zero<T2>(v2);
        let v6 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T2>(&v4);
        let v7 = if (v6 > 0) {
            if (v6 <= v0) {
                !arg7 || v6 == v0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v7, 2);
        assert!(0x2::balance::value<T1>(&v5) > 0, 1);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap_with_partner<T1, T2>(arg2, arg1, arg3, 0x2::balance::zero<T1>(), 0x2::balance::split<T2>(&mut arg5, v6), v4);
        0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::record_leg<T0>(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg1), false, 0x2::balance::value<T1>(&v5));
        (v5, arg5)
    }

    public fun swap_b2a_partner_relative_limit<T0, T1, T2>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T0>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg4: &0x2::clock::Clock, arg5: 0x2::balance::Balance<T2>, arg6: u128, arg7: u128, arg8: u128, arg9: bool) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T2>) {
        let v0 = 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::clmm_limit::relative(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T1, T2>(arg1), false, arg6, arg7, arg8);
        swap_b2a_partner_limit<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, v0, arg9)
    }

    public fun swap_b2a_relative_limit<T0, T1, T2>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T0>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &0x2::clock::Clock, arg4: 0x2::balance::Balance<T2>, arg5: u128, arg6: u128, arg7: u128, arg8: bool) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T2>) {
        let v0 = 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::clmm_limit::relative(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T1, T2>(arg1), false, arg5, arg6, arg7);
        swap_b2a_limit<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, v0, arg8)
    }

    // decompiled from Move bytecode v7
}

