module 0x76aefc8ce3f6d0767fd1c2abbcac651ca5955488ade3ff59bd8aa223828b185c::momentum {
    fun assert_market<T0>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, T0>, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version) {
        assert_native_usdc<T0>();
        assert!(0x2::object::id_address<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, T0>>(arg0) == @0x455cf8d2ac91e7cb883f515874af750ed3cd18195c970b7a2d46235ac2b0c388, 0);
        assert!(0x2::object::id_address<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version>(arg1) == @0x2375a0b1ec12010aaea3b2545acfa2ad34cfbba03ce4b59f4c39e1e25eed1b2a, 1);
    }

    public fun assert_native_usdc<T0>() {
        assert!(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())) == b"dba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC", 2);
    }

    public fun buy_exact_usdc<T0>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, T0>, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: u64, arg5: u64, arg6: u128, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<0x2::sui::SUI>, u64) {
        assert_market<T0>(arg0, arg1);
        assert!(arg4 > 0 && arg5 > 0, 3);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) >= arg5, 5);
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<0x2::sui::SUI, T0>(arg0, true, false, arg4, arg6, arg2, arg1, arg7);
        let v3 = v2;
        let v4 = v1;
        let v5 = v0;
        let (v6, v7) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v3);
        let v8 = if (0x2::balance::value<0x2::sui::SUI>(&v5) == 0) {
            if (0x2::balance::value<T0>(&v4) == arg4) {
                if (v7 == 0) {
                    v6 > 0
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v8, 4);
        assert!(v6 <= arg5, 5);
        0x2::balance::destroy_zero<0x2::sui::SUI>(v5);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<0x2::sui::SUI, T0>(arg0, v3, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg3, v6, arg7)), 0x2::balance::zero<T0>(), arg1, arg7);
        (0x2::coin::from_balance<T0>(v4, arg7), arg3, v6)
    }

    public fun pool_id() : 0x2::object::ID {
        0x2::object::id_from_address(@0x455cf8d2ac91e7cb883f515874af750ed3cd18195c970b7a2d46235ac2b0c388)
    }

    public fun sell_exact_usdc<T0>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, T0>, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: u128, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert_market<T0>(arg0, arg1);
        let v0 = 0x2::coin::value<T0>(&arg3);
        assert!(v0 > 0 && arg4 > 0, 3);
        let (v1, v2, v3) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<0x2::sui::SUI, T0>(arg0, false, true, v0, arg5, arg2, arg1, arg6);
        let v4 = v3;
        let v5 = v2;
        let v6 = v1;
        let (v7, v8) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v4);
        let v9 = if (0x2::balance::value<T0>(&v5) == 0) {
            if (v8 == v0) {
                v7 == 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v9, 4);
        assert!(0x2::balance::value<0x2::sui::SUI>(&v6) >= arg4, 6);
        0x2::balance::destroy_zero<T0>(v5);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<0x2::sui::SUI, T0>(arg0, v4, 0x2::balance::zero<0x2::sui::SUI>(), 0x2::coin::into_balance<T0>(arg3), arg1, arg6);
        0x2::coin::from_balance<0x2::sui::SUI>(v6, arg6)
    }

    // decompiled from Move bytecode v7
}

