module 0x21388b23a886b548f8bcaf5fe19ea31bf2e47cef76b4c96904c104522fbdb47f::para {
    struct AdminCapability has key {
        id: 0x2::object::UID,
    }

    struct Output has copy, drop {
        amount: u64,
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

    public fun flash_loan<T0>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : SwapReceipt<T0, T0, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::FlashLoan<T0>> {
        let (v0, v1) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::flash_loan::borrow_flash_loan<T0>(arg0, arg1, arg2, arg3);
        let v2 = v1;
        let v3 = 0x2::coin::into_balance<T0>(v0);
        assert!(0x2::balance::value<T0>(&v3) == arg2, 101);
        SwapReceipt<T0, T0, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::FlashLoan<T0>>{
            flash_loan_receipt : v2,
            balance_a          : v3,
            balance_b          : 0x2::balance::zero<T0>(),
            repay_amount       : 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::flash_loan_loan_amount<T0>(&v2) + 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::flash_loan_fee<T0>(&v2),
            a2b                : false,
        }
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

    public fun repay<T0>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg2: 0x2::balance::Balance<T0>, arg3: SwapReceipt<T0, T0, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::FlashLoan<T0>>, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let SwapReceipt {
            flash_loan_receipt : v0,
            balance_a          : v1,
            balance_b          : v2,
            repay_amount       : v3,
            a2b                : _,
        } = arg3;
        0x2::balance::destroy_zero<T0>(v1);
        0x2::balance::destroy_zero<T0>(v2);
        assert!(0x2::balance::value<T0>(&arg2) >= v3, 401);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::flash_loan::repay_flash_loan<T0>(arg0, arg1, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg2, v3), arg5), v0, arg5);
        if (0x2::balance::value<T0>(&arg2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg2, arg5), arg4);
        } else {
            0x2::balance::destroy_zero<T0>(arg2);
        };
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

    public fun show_balance<T0>(arg0: 0x2::balance::Balance<T0>) : 0x2::balance::Balance<T0> {
        let v0 = Output{amount: 0x2::balance::value<T0>(&arg0)};
        0x2::event::emit<Output>(v0);
        arg0
    }

    public fun swap_aftermath_a_b<T0, T1, T2>(arg0: &mut 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T2>, arg1: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry, arg2: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg3: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg4: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg5: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg6: 0x2::balance::Balance<T0>, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let v0 = 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::swap::swap_exact_in<T2, T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::from_balance<T0>(arg6, arg9), arg7, arg8, arg9);
        assert!(0x2::coin::value<T1>(&v0) >= arg7, 100);
        0x2::coin::into_balance<T1>(v0)
    }

    public fun swap_aftermath_b_a<T0, T1, T2>(arg0: &mut 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T2>, arg1: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry, arg2: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg3: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg4: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg5: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg6: 0x2::balance::Balance<T1>, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::swap::swap_exact_in<T2, T1, T0>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::from_balance<T1>(arg6, arg9), arg7, arg8, arg9);
        assert!(0x2::coin::value<T0>(&v0) >= arg7, 100);
        0x2::coin::into_balance<T0>(v0)
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

    public fun swap_flowx_v2_a_b<T0, T1>(arg0: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg1: 0x2::balance::Balance<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        0x2::coin::into_balance<T1>(0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::router::swap_exact_input_direct<T0, T1>(arg0, 0x2::coin::from_balance<T0>(arg1, arg2), arg2))
    }

    public fun swap_flowx_v2_b_a<T0, T1>(arg0: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg1: 0x2::balance::Balance<T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0x2::coin::into_balance<T0>(0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::router::swap_exact_input_direct<T1, T0>(arg0, 0x2::coin::from_balance<T1>(arg1, arg2), arg2))
    }

    public fun swap_flowx_v3_a_b<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg2: u64, arg3: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg4: 0x2::balance::Balance<T0>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::swap_router::swap_exact_x_to_y<T0, T1>(0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::borrow_mut_pool<T0, T1>(arg1, arg2), 0x2::coin::from_balance<T0>(arg4, arg5), 0, arg3, arg0, arg5)
    }

    public fun swap_flowx_v3_b_a<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg2: u64, arg3: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg4: 0x2::balance::Balance<T1>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::swap_router::swap_exact_y_to_x<T0, T1>(0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::borrow_mut_pool<T0, T1>(arg1, arg2), 0x2::coin::from_balance<T1>(arg4, arg5), 0, arg3, arg0, arg5)
    }

    public fun swap_kriya_v3_a_b<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg2: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg3: 0x2::balance::Balance<T0>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let (v0, v1, v2) = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::flash_swap<T0, T1>(arg1, true, true, 0x2::balance::value<T0>(&arg3), 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::sqrt_price<T0, T1>(arg1) / 10, arg0, arg2, arg4);
        0x2::balance::destroy_zero<T0>(v0);
        0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::repay_flash_swap<T0, T1>(arg1, v2, arg3, 0x2::balance::zero<T1>(), arg2, arg4);
        v1
    }

    public fun swap_kriya_v3_b_a<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg2: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg3: 0x2::balance::Balance<T1>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let (v0, v1, v2) = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::flash_swap<T0, T1>(arg1, false, true, 0x2::balance::value<T1>(&arg3), 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::sqrt_price<T0, T1>(arg1) * 10, arg0, arg2, arg4);
        0x2::balance::destroy_zero<T1>(v1);
        0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::repay_flash_swap<T0, T1>(arg1, v2, 0x2::balance::zero<T0>(), arg3, arg2, arg4);
        v0
    }

    public fun swap_kriyaswap_a_b<T0, T1>(arg0: &mut 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        0x2::coin::into_balance<T1>(0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::swap_token_x<T0, T1>(arg0, 0x2::coin::from_balance<T0>(arg1, arg2), 0x2::balance::value<T0>(&arg1), 0, arg2))
    }

    public fun swap_kriyaswap_b_a<T0, T1>(arg0: &mut 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>, arg1: 0x2::balance::Balance<T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0x2::coin::into_balance<T0>(0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::swap_token_y<T0, T1>(arg0, 0x2::coin::from_balance<T1>(arg1, arg2), 0x2::balance::value<T1>(&arg1), 0, arg2))
    }

    public fun swap_turbos_a_b<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: 0x2::balance::Balance<T0>, arg2: &0x2::clock::Clock, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let v0 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v0, 0x2::coin::from_balance<T0>(arg1, arg4));
        let (v1, v2) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_a_b_with_return_<T0, T1, T2>(arg0, v0, 0x2::balance::value<T0>(&arg1), 0, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T0, T1, T2>(arg0) / 10, true, 0x2::tx_context::sender(arg4), 3000000000000, arg2, arg3, arg4);
        0x2::balance::destroy_zero<T0>(0x2::coin::into_balance<T0>(v2));
        0x2::coin::into_balance<T1>(v1)
    }

    public fun swap_turbos_b_a<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: 0x2::balance::Balance<T1>, arg2: &0x2::clock::Clock, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = 0x1::vector::empty<0x2::coin::Coin<T1>>();
        0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut v0, 0x2::coin::from_balance<T1>(arg1, arg4));
        let (v1, v2) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_b_a_with_return_<T0, T1, T2>(arg0, v0, 0x2::balance::value<T1>(&arg1), 0, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T0, T1, T2>(arg0) * 10, true, 0x2::tx_context::sender(arg4), 3000000000000, arg2, arg3, arg4);
        0x2::balance::destroy_zero<T1>(0x2::coin::into_balance<T1>(v2));
        0x2::coin::into_balance<T0>(v1)
    }

    public fun take_balance_a_to_receipt<T0, T1, T2>(arg0: &mut SwapReceipt<T0, T1, T2>, arg1: 0x2::balance::Balance<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Output{amount: 0x2::balance::value<T0>(&arg1)};
        0x2::event::emit<Output>(v0);
        0x2::balance::join<T0>(&mut arg0.balance_a, arg1);
    }

    public fun take_balance_b_to_receipt<T0, T1, T2>(arg0: &mut SwapReceipt<T0, T1, T2>, arg1: 0x2::balance::Balance<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Output{amount: 0x2::balance::value<T1>(&arg1)};
        0x2::event::emit<Output>(v0);
        0x2::balance::join<T1>(&mut arg0.balance_b, arg1);
    }

    // decompiled from Move bytecode v6
}

