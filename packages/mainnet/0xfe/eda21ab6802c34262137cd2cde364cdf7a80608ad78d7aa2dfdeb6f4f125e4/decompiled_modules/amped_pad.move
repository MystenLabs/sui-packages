module 0xfeeda21ab6802c34262137cd2cde364cdf7a80608ad78d7aa2dfdeb6f4f125e4::amped_pad {
    struct AmpedVenue has drop {
        dummy_field: bool,
    }

    public fun place_buy<T0>(arg0: &0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::VenueRegistry, arg1: &0xf332e48e1c3ca49e806ebd3cbca0fdb6de213f5906503cffdd7d74a9f28da3e1::pool::Pool<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg3: 0x2::object::ID, arg4: &0x2::coin::CoinMetadata<T0>, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: u128, arg7: bool, arg8: u64, arg9: 0x1::option::Option<address>, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        assert_bridge(arg2);
        let v0 = AmpedVenue{dummy_field: false};
        0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::place_buy<T0, AmpedVenue>(v0, arg0, 0x2::object::id<0xf332e48e1c3ca49e806ebd3cbca0fdb6de213f5906503cffdd7d74a9f28da3e1::pool::Pool<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(arg1), arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    public fun place_buy_currency<T0>(arg0: &0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::VenueRegistry, arg1: &0xf332e48e1c3ca49e806ebd3cbca0fdb6de213f5906503cffdd7d74a9f28da3e1::pool::Pool<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg3: 0x2::object::ID, arg4: &0x2::coin_registry::Currency<T0>, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: u128, arg7: bool, arg8: u64, arg9: 0x1::option::Option<address>, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        assert_bridge(arg2);
        let v0 = AmpedVenue{dummy_field: false};
        0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::place_buy_currency<T0, AmpedVenue>(v0, arg0, 0x2::object::id<0xf332e48e1c3ca49e806ebd3cbca0fdb6de213f5906503cffdd7d74a9f28da3e1::pool::Pool<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(arg1), arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    public fun place_sell<T0>(arg0: &0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::VenueRegistry, arg1: &0xf332e48e1c3ca49e806ebd3cbca0fdb6de213f5906503cffdd7d74a9f28da3e1::pool::Pool<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg3: 0x2::object::ID, arg4: &0x2::coin::CoinMetadata<T0>, arg5: 0x2::coin::Coin<T0>, arg6: u128, arg7: bool, arg8: u64, arg9: 0x1::option::Option<address>, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        assert_bridge(arg2);
        let v0 = AmpedVenue{dummy_field: false};
        0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::place_sell<T0, AmpedVenue>(v0, arg0, 0x2::object::id<0xf332e48e1c3ca49e806ebd3cbca0fdb6de213f5906503cffdd7d74a9f28da3e1::pool::Pool<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(arg1), arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    public fun place_sell_currency<T0>(arg0: &0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::VenueRegistry, arg1: &0xf332e48e1c3ca49e806ebd3cbca0fdb6de213f5906503cffdd7d74a9f28da3e1::pool::Pool<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg3: 0x2::object::ID, arg4: &0x2::coin_registry::Currency<T0>, arg5: 0x2::coin::Coin<T0>, arg6: u128, arg7: bool, arg8: u64, arg9: 0x1::option::Option<address>, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        assert_bridge(arg2);
        let v0 = AmpedVenue{dummy_field: false};
        0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::place_sell_currency<T0, AmpedVenue>(v0, arg0, 0x2::object::id<0xf332e48e1c3ca49e806ebd3cbca0fdb6de213f5906503cffdd7d74a9f28da3e1::pool::Pool<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(arg1), arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    fun assert_bridge(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>) {
        assert!(0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(arg0) == @0x15dbcac854b1fc68fc9467dbd9ab34270447aabd8cc0e04a5864d95ccb86b74a, 0);
    }

    fun assert_dca_price(arg0: u128, arg1: u128, arg2: u128) {
        assert!(arg1 == 0 || arg0 >= arg1, 4);
        assert!(arg2 == 0 || arg0 <= arg2, 4);
    }

    fun assert_limit(arg0: u128, arg1: u128, arg2: bool) {
        assert!(arg2 && arg0 >= arg1 || arg0 <= arg1, 3);
    }

    fun basket_nav_bytes(arg0: vector<u8>, arg1: 0x2::object::ID, arg2: u64, arg3: u64) : u64 {
        assert!(0x1::vector::length<u8>(&arg0) >= 61, 6);
        let v0 = 0x1::bcs::to_bytes<0x2::object::ID>(&arg1);
        let v1 = 0;
        while (v1 < 32) {
            assert!(*0x1::vector::borrow<u8>(&arg0, v1) == *0x1::vector::borrow<u8>(&v0, v1), 6);
            v1 = v1 + 1;
        };
        assert!(bcs_u64(&arg0, 32) == arg2, 6);
        let v2 = (*0x1::vector::borrow<u8>(&arg0, 56) as u64);
        let v3 = if (v2 > 0) {
            if (v2 <= 4) {
                bcs_u64(&arg0, 40) == v2
            } else {
                false
            }
        } else {
            false
        };
        assert!(v3, 6);
        assert!(0x1::vector::length<u8>(&arg0) == 61 + 26 * v2, 6);
        let v4 = 57 + 8 * v2;
        let v5 = v4 + 1 + 8 * v2;
        let v6 = v5 + 1 + 8 * v2;
        let v7 = if ((*0x1::vector::borrow<u8>(&arg0, v4) as u64) == v2) {
            if ((*0x1::vector::borrow<u8>(&arg0, v5) as u64) == v2) {
                if ((*0x1::vector::borrow<u8>(&arg0, v6) as u64) == v2) {
                    (*0x1::vector::borrow<u8>(&arg0, v6 + 1 + v2) as u64) == v2
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v7, 6);
        let v8 = arg3 + bcs_u64(&arg0, 48);
        v1 = 0;
        while (v1 < v2) {
            v8 = v8 + bcs_u64(&arg0, 57 + 8 * v1);
            v1 = v1 + 1;
        };
        v8
    }

    fun basket_spot_price<T0>(arg0: &0xf332e48e1c3ca49e806ebd3cbca0fdb6de213f5906503cffdd7d74a9f28da3e1::basket::BasketPool<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg1: &0xf332e48e1c3ca49e806ebd3cbca0fdb6de213f5906503cffdd7d74a9f28da3e1::basket::Valuation, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg3: u8) : u128 {
        let (v0, v1, v2, v3, _, _, v6) = 0xf332e48e1c3ca49e806ebd3cbca0fdb6de213f5906503cffdd7d74a9f28da3e1::basket::state<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg0);
        sui_price_scaled_from_usdc(curve_usdc_price_scaled(v0, v1, v2, basket_nav_bytes(0x1::bcs::to_bytes<0xf332e48e1c3ca49e806ebd3cbca0fdb6de213f5906503cffdd7d74a9f28da3e1::basket::Valuation>(arg1), 0x2::object::id<0xf332e48e1c3ca49e806ebd3cbca0fdb6de213f5906503cffdd7d74a9f28da3e1::basket::BasketPool<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(arg0), v6, v3), arg3), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2))
    }

    fun bcs_u64(arg0: &vector<u8>, arg1: u64) : u64 {
        assert!(0x1::vector::length<u8>(arg0) >= arg1 + 8, 6);
        let v0 = 0;
        let v1 = 1;
        let v2 = 0;
        while (v2 < 8) {
            v0 = v0 + (*0x1::vector::borrow<u8>(arg0, arg1 + v2) as u64) * v1;
            if (v2 < 7) {
                v1 = v1 * 256;
            };
            v2 = v2 + 1;
        };
        v0
    }

    fun bridge_sell(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg2: 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg3: &0x2::clock::Clock) : 0x2::balance::Balance<0x2::sui::SUI> {
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg3, arg0, arg1, false, true, 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg2), 79226673515401279992447579054);
        let v3 = v2;
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg0, arg1, 0x2::balance::zero<0x2::sui::SUI>(), 0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg2, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v3)), v3);
        0x2::balance::destroy_zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2);
        0x2::balance::destroy_zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v1);
        v0
    }

    fun curve_usdc_price_scaled(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u8) : u256 {
        assert!(arg1 > 0 && arg0 >= arg2, 6);
        let v0 = arg0 - arg2;
        let v1 = if (v0 == 0) {
            (arg0 as u256) * pow10(arg4) * 1000000000000 / (arg1 as u256)
        } else {
            assert!(arg3 > 0, 6);
            (arg0 as u256) * (arg3 as u256) * pow10(arg4) * 1000000000000 / (arg1 as u256) * (v0 as u256)
        };
        assert!(v1 > 0, 6);
        v1
    }

    public fun fill_basket_buy<T0>(arg0: 0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::VenueOrder<T0>, arg1: 0xf332e48e1c3ca49e806ebd3cbca0fdb6de213f5906503cffdd7d74a9f28da3e1::basket::Valuation, arg2: &0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::VenueRegistry, arg3: &mut 0xf332e48e1c3ca49e806ebd3cbca0fdb6de213f5906503cffdd7d74a9f28da3e1::basket::BasketPool<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::config::Config, arg7: &mut 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::fees::FeeVault, arg8: &0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::referral::ReferralRegistry, arg9: &0xf332e48e1c3ca49e806ebd3cbca0fdb6de213f5906503cffdd7d74a9f28da3e1::config::Config, arg10: &mut 0xf332e48e1c3ca49e806ebd3cbca0fdb6de213f5906503cffdd7d74a9f28da3e1::config::Treasury<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg11: &mut 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::referral::Registry, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        assert_bridge(arg4);
        assert!(0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::is_buy<T0>(&arg0) && 0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::venue_id<T0>(&arg0) == 0x2::object::id<0xf332e48e1c3ca49e806ebd3cbca0fdb6de213f5906503cffdd7d74a9f28da3e1::basket::BasketPool<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(arg3), 1);
        let v0 = 0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::trigger_price<T0>(&arg0);
        let v1 = AmpedVenue{dummy_field: false};
        let (v2, v3, v4) = 0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::begin_fill<T0, AmpedVenue>(arg0, arg2, v1, 0x2::object::id<0xf332e48e1c3ca49e806ebd3cbca0fdb6de213f5906503cffdd7d74a9f28da3e1::basket::BasketPool<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(arg3), v0, arg6, arg7, arg8, arg12, arg13);
        let v5 = v2;
        0x2::balance::destroy_zero<T0>(v3);
        let v6 = 0x2::balance::value<0x2::sui::SUI>(&v5);
        let (v7, v8, v9) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg12, arg5, arg4, true, true, v6, 4295048017);
        let v10 = v9;
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg5, arg4, 0x2::balance::split<0x2::sui::SUI>(&mut v5, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v10)), 0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(), v10);
        0x2::balance::join<0x2::sui::SUI>(&mut v5, v7);
        let v11 = v6 - 0x2::balance::value<0x2::sui::SUI>(&v5);
        let v12 = 0x2::coin::into_balance<T0>(0xf332e48e1c3ca49e806ebd3cbca0fdb6de213f5906503cffdd7d74a9f28da3e1::basket::buy<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1, arg3, arg9, arg10, arg11, 0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v8, arg13), 1, 0x1::option::none<address>(), arg12, arg13));
        assert!(0x2::balance::value<T0>(&v12) > 0 && v11 > 0, 1);
        assert_limit(realized_price(v11, 0x2::balance::value<T0>(&v12), 0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::decimals<T0>(&arg0)), v0, 0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::above<T0>(&arg0));
        0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::settle_fill<T0>(v4, v5, v12, arg6, arg7, arg13);
    }

    public fun fill_basket_sell<T0>(arg0: 0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::VenueOrder<T0>, arg1: 0xf332e48e1c3ca49e806ebd3cbca0fdb6de213f5906503cffdd7d74a9f28da3e1::basket::Valuation, arg2: &0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::VenueRegistry, arg3: &mut 0xf332e48e1c3ca49e806ebd3cbca0fdb6de213f5906503cffdd7d74a9f28da3e1::basket::BasketPool<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::config::Config, arg7: &mut 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::fees::FeeVault, arg8: &0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::referral::ReferralRegistry, arg9: &0xf332e48e1c3ca49e806ebd3cbca0fdb6de213f5906503cffdd7d74a9f28da3e1::config::Config, arg10: &mut 0xf332e48e1c3ca49e806ebd3cbca0fdb6de213f5906503cffdd7d74a9f28da3e1::config::Treasury<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg11: &mut 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::referral::Registry, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        assert_bridge(arg4);
        assert!(!0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::is_buy<T0>(&arg0) && 0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::venue_id<T0>(&arg0) == 0x2::object::id<0xf332e48e1c3ca49e806ebd3cbca0fdb6de213f5906503cffdd7d74a9f28da3e1::basket::BasketPool<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(arg3), 1);
        let v0 = 0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::trigger_price<T0>(&arg0);
        let v1 = AmpedVenue{dummy_field: false};
        let (v2, v3, v4) = 0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::begin_fill<T0, AmpedVenue>(arg0, arg2, v1, 0x2::object::id<0xf332e48e1c3ca49e806ebd3cbca0fdb6de213f5906503cffdd7d74a9f28da3e1::basket::BasketPool<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(arg3), v0, arg6, arg7, arg8, arg12, arg13);
        let v5 = v3;
        0x2::balance::destroy_zero<0x2::sui::SUI>(v2);
        let v6 = 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0xf332e48e1c3ca49e806ebd3cbca0fdb6de213f5906503cffdd7d74a9f28da3e1::basket::sell<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1, arg3, arg9, arg10, arg11, 0x2::coin::from_balance<T0>(v5, arg13), 1, 0x1::option::none<address>(), arg13));
        let (v7, v8, v9) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg12, arg5, arg4, false, true, 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v6), 79226673515401279992447579054);
        let v10 = v9;
        let v11 = v7;
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg5, arg4, 0x2::balance::zero<0x2::sui::SUI>(), 0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut v6, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v10)), v10);
        0x2::balance::destroy_zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v6);
        0x2::balance::destroy_zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v8);
        assert_limit(realized_price(0x2::balance::value<0x2::sui::SUI>(&v11), 0x2::balance::value<T0>(&v5), 0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::decimals<T0>(&arg0)), v0, 0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::above<T0>(&arg0));
        0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::settle_fill<T0>(v4, v11, 0x2::balance::zero<T0>(), arg6, arg7, arg13);
    }

    public fun fill_basket_step<T0>(arg0: &mut 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::automation::AutomationOrder<T0>, arg1: 0xf332e48e1c3ca49e806ebd3cbca0fdb6de213f5906503cffdd7d74a9f28da3e1::basket::Valuation, arg2: u64, arg3: &0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::VenueRegistry, arg4: &mut 0xf332e48e1c3ca49e806ebd3cbca0fdb6de213f5906503cffdd7d74a9f28da3e1::basket::BasketPool<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg6: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg7: &0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::config::Config, arg8: &mut 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::fees::FeeVault, arg9: &0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::referral::ReferralRegistry, arg10: &0xf332e48e1c3ca49e806ebd3cbca0fdb6de213f5906503cffdd7d74a9f28da3e1::config::Config, arg11: &mut 0xf332e48e1c3ca49e806ebd3cbca0fdb6de213f5906503cffdd7d74a9f28da3e1::config::Treasury<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg12: &mut 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::referral::Registry, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        assert_bridge(arg5);
        assert!(0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::is_approved<AmpedVenue>(arg3), 5);
        let v0 = 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::automation::decimals<T0>(arg0);
        let v1 = AmpedVenue{dummy_field: false};
        let (v2, v3, v4) = 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::automation::begin_step<T0, AmpedVenue>(arg0, v1, 0x2::object::id<0xf332e48e1c3ca49e806ebd3cbca0fdb6de213f5906503cffdd7d74a9f28da3e1::basket::BasketPool<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(arg4), basket_spot_price<T0>(arg4, &arg1, arg5, v0), arg2, arg7, arg8, arg9, arg13, arg14);
        let v5 = v3;
        let v6 = v2;
        if (0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::automation::is_buy<T0>(arg0)) {
            0x2::balance::destroy_zero<T0>(v5);
            let v7 = 0x2::balance::value<0x2::sui::SUI>(&v6);
            let (v8, v9, v10) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg13, arg6, arg5, true, true, v7, 4295048017);
            let v11 = v10;
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg6, arg5, 0x2::balance::split<0x2::sui::SUI>(&mut v6, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v11)), 0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(), v11);
            0x2::balance::join<0x2::sui::SUI>(&mut v6, v8);
            let v12 = 0x2::coin::into_balance<T0>(0xf332e48e1c3ca49e806ebd3cbca0fdb6de213f5906503cffdd7d74a9f28da3e1::basket::buy<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1, arg4, arg10, arg11, arg12, 0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v9, arg14), 1, 0x1::option::none<address>(), arg13, arg14));
            assert_dca_price(realized_price(v7 - 0x2::balance::value<0x2::sui::SUI>(&v6), 0x2::balance::value<T0>(&v12), v0), 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::automation::min_price<T0>(arg0), 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::automation::max_price<T0>(arg0));
            0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::automation::settle_step<T0>(v4, v6, v12, arg7, arg8, arg14);
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v6);
            let v13 = bridge_sell(arg6, arg5, 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0xf332e48e1c3ca49e806ebd3cbca0fdb6de213f5906503cffdd7d74a9f28da3e1::basket::sell<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1, arg4, arg10, arg11, arg12, 0x2::coin::from_balance<T0>(v5, arg14), 1, 0x1::option::none<address>(), arg14)), arg13);
            assert_limit(realized_price(0x2::balance::value<0x2::sui::SUI>(&v13), 0x2::balance::value<T0>(&v5), v0), 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::automation::trigger_price<T0>(arg0, arg2), 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::automation::above<T0>(arg0, arg2));
            0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::automation::settle_step<T0>(v4, v13, 0x2::balance::zero<T0>(), arg7, arg8, arg14);
        };
    }

    public fun fill_buy<T0>(arg0: 0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::VenueOrder<T0>, arg1: &0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::VenueRegistry, arg2: &mut 0xf332e48e1c3ca49e806ebd3cbca0fdb6de213f5906503cffdd7d74a9f28da3e1::pool::Pool<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::config::Config, arg6: &mut 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::fees::FeeVault, arg7: &0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::referral::ReferralRegistry, arg8: &0xf332e48e1c3ca49e806ebd3cbca0fdb6de213f5906503cffdd7d74a9f28da3e1::config::Config, arg9: &mut 0xf332e48e1c3ca49e806ebd3cbca0fdb6de213f5906503cffdd7d74a9f28da3e1::config::Treasury<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg10: &mut 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::referral::Registry, arg11: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg12: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg13: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg14: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        assert_bridge(arg3);
        assert!(0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::is_buy<T0>(&arg0), 1);
        assert!(0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::venue_id<T0>(&arg0) == 0x2::object::id<0xf332e48e1c3ca49e806ebd3cbca0fdb6de213f5906503cffdd7d74a9f28da3e1::pool::Pool<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(arg2), 1);
        let v0 = 0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::trigger_price<T0>(&arg0);
        let v1 = AmpedVenue{dummy_field: false};
        let (v2, v3, v4) = 0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::begin_fill<T0, AmpedVenue>(arg0, arg1, v1, 0x2::object::id<0xf332e48e1c3ca49e806ebd3cbca0fdb6de213f5906503cffdd7d74a9f28da3e1::pool::Pool<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(arg2), v0, arg5, arg6, arg7, arg15, arg16);
        let v5 = v2;
        0x2::balance::destroy_zero<T0>(v3);
        let v6 = 0x2::balance::value<0x2::sui::SUI>(&v5);
        let (v7, v8, v9) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg15, arg4, arg3, true, true, v6, 4295048017);
        let v10 = v9;
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg4, arg3, 0x2::balance::split<0x2::sui::SUI>(&mut v5, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v10)), 0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(), v10);
        0x2::balance::join<0x2::sui::SUI>(&mut v5, v7);
        let v11 = v6 - 0x2::balance::value<0x2::sui::SUI>(&v5);
        let v12 = 0x2::coin::into_balance<T0>(0xf332e48e1c3ca49e806ebd3cbca0fdb6de213f5906503cffdd7d74a9f28da3e1::pool::buy<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, arg8, arg9, arg10, arg11, arg12, arg13, arg14, 0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v8, arg16), 1, 0x1::option::none<address>(), arg15, arg16));
        assert!(0x2::balance::value<T0>(&v12) > 0 && v11 > 0, 1);
        assert_limit(realized_price(v11, 0x2::balance::value<T0>(&v12), 0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::decimals<T0>(&arg0)), v0, 0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::above<T0>(&arg0));
        0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::settle_fill<T0>(v4, v5, v12, arg5, arg6, arg16);
    }

    public fun fill_pool_step<T0>(arg0: &mut 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::automation::AutomationOrder<T0>, arg1: u64, arg2: &0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::VenueRegistry, arg3: &mut 0xf332e48e1c3ca49e806ebd3cbca0fdb6de213f5906503cffdd7d74a9f28da3e1::pool::Pool<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::config::Config, arg7: &mut 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::fees::FeeVault, arg8: &0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::referral::ReferralRegistry, arg9: &0xf332e48e1c3ca49e806ebd3cbca0fdb6de213f5906503cffdd7d74a9f28da3e1::config::Config, arg10: &mut 0xf332e48e1c3ca49e806ebd3cbca0fdb6de213f5906503cffdd7d74a9f28da3e1::config::Treasury<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg11: &mut 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::referral::Registry, arg12: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg13: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg14: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg15: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg16: &0x2::clock::Clock, arg17: &mut 0x2::tx_context::TxContext) {
        assert_bridge(arg4);
        assert!(0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::is_approved<AmpedVenue>(arg2), 5);
        let v0 = 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::automation::decimals<T0>(arg0);
        let v1 = AmpedVenue{dummy_field: false};
        let (v2, v3, v4) = 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::automation::begin_step<T0, AmpedVenue>(arg0, v1, 0x2::object::id<0xf332e48e1c3ca49e806ebd3cbca0fdb6de213f5906503cffdd7d74a9f28da3e1::pool::Pool<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(arg3), pool_spot_price<T0>(arg3, arg4, arg9, arg12, arg13, arg14, arg15, arg16, v0), arg1, arg6, arg7, arg8, arg16, arg17);
        let v5 = v3;
        let v6 = v2;
        if (0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::automation::is_buy<T0>(arg0)) {
            0x2::balance::destroy_zero<T0>(v5);
            let v7 = 0x2::balance::value<0x2::sui::SUI>(&v6);
            let (v8, v9, v10) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg16, arg5, arg4, true, true, v7, 4295048017);
            let v11 = v10;
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg5, arg4, 0x2::balance::split<0x2::sui::SUI>(&mut v6, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v11)), 0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(), v11);
            0x2::balance::join<0x2::sui::SUI>(&mut v6, v8);
            let v12 = 0x2::coin::into_balance<T0>(0xf332e48e1c3ca49e806ebd3cbca0fdb6de213f5906503cffdd7d74a9f28da3e1::pool::buy<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg3, arg9, arg10, arg11, arg12, arg13, arg14, arg15, 0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v9, arg17), 1, 0x1::option::none<address>(), arg16, arg17));
            assert_dca_price(realized_price(v7 - 0x2::balance::value<0x2::sui::SUI>(&v6), 0x2::balance::value<T0>(&v12), v0), 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::automation::min_price<T0>(arg0), 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::automation::max_price<T0>(arg0));
            0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::automation::settle_step<T0>(v4, v6, v12, arg6, arg7, arg17);
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v6);
            let v13 = bridge_sell(arg5, arg4, 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0xf332e48e1c3ca49e806ebd3cbca0fdb6de213f5906503cffdd7d74a9f28da3e1::pool::sell<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg3, arg9, arg10, arg11, arg12, arg13, arg14, arg15, 0x2::coin::from_balance<T0>(v5, arg17), 1, 0x1::option::none<address>(), arg16, arg17)), arg16);
            assert_limit(realized_price(0x2::balance::value<0x2::sui::SUI>(&v13), 0x2::balance::value<T0>(&v5), v0), 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::automation::trigger_price<T0>(arg0, arg1), 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::automation::above<T0>(arg0, arg1));
            0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::automation::settle_step<T0>(v4, v13, 0x2::balance::zero<T0>(), arg6, arg7, arg17);
        };
    }

    public fun fill_sell<T0>(arg0: 0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::VenueOrder<T0>, arg1: &0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::VenueRegistry, arg2: &mut 0xf332e48e1c3ca49e806ebd3cbca0fdb6de213f5906503cffdd7d74a9f28da3e1::pool::Pool<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::config::Config, arg6: &mut 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::fees::FeeVault, arg7: &0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::referral::ReferralRegistry, arg8: &0xf332e48e1c3ca49e806ebd3cbca0fdb6de213f5906503cffdd7d74a9f28da3e1::config::Config, arg9: &mut 0xf332e48e1c3ca49e806ebd3cbca0fdb6de213f5906503cffdd7d74a9f28da3e1::config::Treasury<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg10: &mut 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::referral::Registry, arg11: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg12: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg13: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg14: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        assert_bridge(arg3);
        assert!(!0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::is_buy<T0>(&arg0), 1);
        assert!(0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::venue_id<T0>(&arg0) == 0x2::object::id<0xf332e48e1c3ca49e806ebd3cbca0fdb6de213f5906503cffdd7d74a9f28da3e1::pool::Pool<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(arg2), 1);
        let v0 = 0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::trigger_price<T0>(&arg0);
        let v1 = AmpedVenue{dummy_field: false};
        let (v2, v3, v4) = 0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::begin_fill<T0, AmpedVenue>(arg0, arg1, v1, 0x2::object::id<0xf332e48e1c3ca49e806ebd3cbca0fdb6de213f5906503cffdd7d74a9f28da3e1::pool::Pool<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(arg2), v0, arg5, arg6, arg7, arg15, arg16);
        let v5 = v3;
        0x2::balance::destroy_zero<0x2::sui::SUI>(v2);
        let v6 = 0x2::balance::value<T0>(&v5);
        let v7 = 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0xf332e48e1c3ca49e806ebd3cbca0fdb6de213f5906503cffdd7d74a9f28da3e1::pool::sell<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, arg8, arg9, arg10, arg11, arg12, arg13, arg14, 0x2::coin::from_balance<T0>(v5, arg16), 1, 0x1::option::none<address>(), arg15, arg16));
        assert!(0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v7) > 0 && v6 > 0, 1);
        let (v8, v9, v10) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg15, arg4, arg3, false, true, 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v7), 79226673515401279992447579054);
        let v11 = v10;
        let v12 = v8;
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg4, arg3, 0x2::balance::zero<0x2::sui::SUI>(), 0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut v7, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v11)), v11);
        0x2::balance::destroy_zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v7);
        0x2::balance::destroy_zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v9);
        assert_limit(realized_price(0x2::balance::value<0x2::sui::SUI>(&v12), v6, 0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::decimals<T0>(&arg0)), v0, 0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::above<T0>(&arg0));
        0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::settle_fill<T0>(v4, v12, 0x2::balance::zero<T0>(), arg5, arg6, arg16);
    }

    public fun place_basket_buy<T0>(arg0: &0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::VenueRegistry, arg1: &0xf332e48e1c3ca49e806ebd3cbca0fdb6de213f5906503cffdd7d74a9f28da3e1::basket::BasketPool<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg3: 0x2::object::ID, arg4: &0x2::coin::CoinMetadata<T0>, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: u128, arg7: bool, arg8: u64, arg9: 0x1::option::Option<address>, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        assert_bridge(arg2);
        let v0 = AmpedVenue{dummy_field: false};
        0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::place_buy<T0, AmpedVenue>(v0, arg0, 0x2::object::id<0xf332e48e1c3ca49e806ebd3cbca0fdb6de213f5906503cffdd7d74a9f28da3e1::basket::BasketPool<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(arg1), arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    public fun place_basket_buy_currency<T0>(arg0: &0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::VenueRegistry, arg1: &0xf332e48e1c3ca49e806ebd3cbca0fdb6de213f5906503cffdd7d74a9f28da3e1::basket::BasketPool<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg3: 0x2::object::ID, arg4: &0x2::coin_registry::Currency<T0>, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: u128, arg7: bool, arg8: u64, arg9: 0x1::option::Option<address>, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        assert_bridge(arg2);
        let v0 = AmpedVenue{dummy_field: false};
        0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::place_buy_currency<T0, AmpedVenue>(v0, arg0, 0x2::object::id<0xf332e48e1c3ca49e806ebd3cbca0fdb6de213f5906503cffdd7d74a9f28da3e1::basket::BasketPool<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(arg1), arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    public fun place_basket_dca<T0>(arg0: &0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::VenueRegistry, arg1: &0xf332e48e1c3ca49e806ebd3cbca0fdb6de213f5906503cffdd7d74a9f28da3e1::basket::BasketPool<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg3: 0x2::object::ID, arg4: &0x2::coin::CoinMetadata<T0>, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: u64, arg7: u64, arg8: u128, arg9: u128, arg10: u16, arg11: 0x1::option::Option<address>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        assert_bridge(arg2);
        assert!(0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::is_approved<AmpedVenue>(arg0), 5);
        0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::automation::place_dca<T0, AmpedVenue>(0x2::object::id<0xf332e48e1c3ca49e806ebd3cbca0fdb6de213f5906503cffdd7d74a9f28da3e1::basket::BasketPool<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(arg1), arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
    }

    public fun place_basket_dca_currency<T0>(arg0: &0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::VenueRegistry, arg1: &0xf332e48e1c3ca49e806ebd3cbca0fdb6de213f5906503cffdd7d74a9f28da3e1::basket::BasketPool<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg3: 0x2::object::ID, arg4: &0x2::coin_registry::Currency<T0>, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: u64, arg7: u64, arg8: u128, arg9: u128, arg10: u16, arg11: 0x1::option::Option<address>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        assert_bridge(arg2);
        assert!(0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::is_approved<AmpedVenue>(arg0), 5);
        0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::automation::place_dca_currency<T0, AmpedVenue>(0x2::object::id<0xf332e48e1c3ca49e806ebd3cbca0fdb6de213f5906503cffdd7d74a9f28da3e1::basket::BasketPool<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(arg1), arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
    }

    public fun place_basket_sell<T0>(arg0: &0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::VenueRegistry, arg1: &0xf332e48e1c3ca49e806ebd3cbca0fdb6de213f5906503cffdd7d74a9f28da3e1::basket::BasketPool<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg3: 0x2::object::ID, arg4: &0x2::coin::CoinMetadata<T0>, arg5: 0x2::coin::Coin<T0>, arg6: u128, arg7: bool, arg8: u64, arg9: 0x1::option::Option<address>, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        assert_bridge(arg2);
        let v0 = AmpedVenue{dummy_field: false};
        0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::place_sell<T0, AmpedVenue>(v0, arg0, 0x2::object::id<0xf332e48e1c3ca49e806ebd3cbca0fdb6de213f5906503cffdd7d74a9f28da3e1::basket::BasketPool<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(arg1), arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    public fun place_basket_sell_currency<T0>(arg0: &0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::VenueRegistry, arg1: &0xf332e48e1c3ca49e806ebd3cbca0fdb6de213f5906503cffdd7d74a9f28da3e1::basket::BasketPool<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg3: 0x2::object::ID, arg4: &0x2::coin_registry::Currency<T0>, arg5: 0x2::coin::Coin<T0>, arg6: u128, arg7: bool, arg8: u64, arg9: 0x1::option::Option<address>, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        assert_bridge(arg2);
        let v0 = AmpedVenue{dummy_field: false};
        0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::place_sell_currency<T0, AmpedVenue>(v0, arg0, 0x2::object::id<0xf332e48e1c3ca49e806ebd3cbca0fdb6de213f5906503cffdd7d74a9f28da3e1::basket::BasketPool<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(arg1), arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    public fun place_basket_strategy<T0>(arg0: &0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::VenueRegistry, arg1: &0xf332e48e1c3ca49e806ebd3cbca0fdb6de213f5906503cffdd7d74a9f28da3e1::basket::BasketPool<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg3: 0x2::object::ID, arg4: &0x2::coin::CoinMetadata<T0>, arg5: 0x2::coin::Coin<T0>, arg6: vector<u128>, arg7: vector<bool>, arg8: vector<u16>, arg9: vector<bool>, arg10: u16, arg11: 0x1::option::Option<address>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        assert_bridge(arg2);
        assert!(0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::is_approved<AmpedVenue>(arg0), 5);
        0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::automation::place_strategy<T0, AmpedVenue>(0x2::object::id<0xf332e48e1c3ca49e806ebd3cbca0fdb6de213f5906503cffdd7d74a9f28da3e1::basket::BasketPool<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(arg1), arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
    }

    public fun place_basket_strategy_currency<T0>(arg0: &0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::VenueRegistry, arg1: &0xf332e48e1c3ca49e806ebd3cbca0fdb6de213f5906503cffdd7d74a9f28da3e1::basket::BasketPool<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg3: 0x2::object::ID, arg4: &0x2::coin_registry::Currency<T0>, arg5: 0x2::coin::Coin<T0>, arg6: vector<u128>, arg7: vector<bool>, arg8: vector<u16>, arg9: vector<bool>, arg10: u16, arg11: 0x1::option::Option<address>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        assert_bridge(arg2);
        assert!(0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::is_approved<AmpedVenue>(arg0), 5);
        0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::automation::place_strategy_currency<T0, AmpedVenue>(0x2::object::id<0xf332e48e1c3ca49e806ebd3cbca0fdb6de213f5906503cffdd7d74a9f28da3e1::basket::BasketPool<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(arg1), arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
    }

    public fun place_pool_dca<T0>(arg0: &0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::VenueRegistry, arg1: &0xf332e48e1c3ca49e806ebd3cbca0fdb6de213f5906503cffdd7d74a9f28da3e1::pool::Pool<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg3: 0x2::object::ID, arg4: &0x2::coin::CoinMetadata<T0>, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: u64, arg7: u64, arg8: u128, arg9: u128, arg10: u16, arg11: 0x1::option::Option<address>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        assert_bridge(arg2);
        assert!(0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::is_approved<AmpedVenue>(arg0), 5);
        0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::automation::place_dca<T0, AmpedVenue>(0x2::object::id<0xf332e48e1c3ca49e806ebd3cbca0fdb6de213f5906503cffdd7d74a9f28da3e1::pool::Pool<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(arg1), arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
    }

    public fun place_pool_dca_currency<T0>(arg0: &0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::VenueRegistry, arg1: &0xf332e48e1c3ca49e806ebd3cbca0fdb6de213f5906503cffdd7d74a9f28da3e1::pool::Pool<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg3: 0x2::object::ID, arg4: &0x2::coin_registry::Currency<T0>, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: u64, arg7: u64, arg8: u128, arg9: u128, arg10: u16, arg11: 0x1::option::Option<address>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        assert_bridge(arg2);
        assert!(0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::is_approved<AmpedVenue>(arg0), 5);
        0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::automation::place_dca_currency<T0, AmpedVenue>(0x2::object::id<0xf332e48e1c3ca49e806ebd3cbca0fdb6de213f5906503cffdd7d74a9f28da3e1::pool::Pool<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(arg1), arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
    }

    public fun place_pool_strategy<T0>(arg0: &0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::VenueRegistry, arg1: &0xf332e48e1c3ca49e806ebd3cbca0fdb6de213f5906503cffdd7d74a9f28da3e1::pool::Pool<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg3: 0x2::object::ID, arg4: &0x2::coin::CoinMetadata<T0>, arg5: 0x2::coin::Coin<T0>, arg6: vector<u128>, arg7: vector<bool>, arg8: vector<u16>, arg9: vector<bool>, arg10: u16, arg11: 0x1::option::Option<address>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        assert_bridge(arg2);
        assert!(0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::is_approved<AmpedVenue>(arg0), 5);
        0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::automation::place_strategy<T0, AmpedVenue>(0x2::object::id<0xf332e48e1c3ca49e806ebd3cbca0fdb6de213f5906503cffdd7d74a9f28da3e1::pool::Pool<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(arg1), arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
    }

    public fun place_pool_strategy_currency<T0>(arg0: &0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::VenueRegistry, arg1: &0xf332e48e1c3ca49e806ebd3cbca0fdb6de213f5906503cffdd7d74a9f28da3e1::pool::Pool<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg3: 0x2::object::ID, arg4: &0x2::coin_registry::Currency<T0>, arg5: 0x2::coin::Coin<T0>, arg6: vector<u128>, arg7: vector<bool>, arg8: vector<u16>, arg9: vector<bool>, arg10: u16, arg11: 0x1::option::Option<address>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        assert_bridge(arg2);
        assert!(0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::is_approved<AmpedVenue>(arg0), 5);
        0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::automation::place_strategy_currency<T0, AmpedVenue>(0x2::object::id<0xf332e48e1c3ca49e806ebd3cbca0fdb6de213f5906503cffdd7d74a9f28da3e1::pool::Pool<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(arg1), arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
    }

    fun pool_spot_price<T0>(arg0: &0xf332e48e1c3ca49e806ebd3cbca0fdb6de213f5906503cffdd7d74a9f28da3e1::pool::Pool<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg2: &0xf332e48e1c3ca49e806ebd3cbca0fdb6de213f5906503cffdd7d74a9f28da3e1::config::Config, arg3: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg4: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg6: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg7: &0x2::clock::Clock, arg8: u8) : u128 {
        let (v0, v1, v2, _, _, _) = 0xf332e48e1c3ca49e806ebd3cbca0fdb6de213f5906503cffdd7d74a9f28da3e1::pool::state<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg0);
        let (v6, _, _, _, _, _, _, v13) = 0xf332e48e1c3ca49e806ebd3cbca0fdb6de213f5906503cffdd7d74a9f28da3e1::pool::basket<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg0, arg3, arg4, arg5, arg6, 0xf332e48e1c3ca49e806ebd3cbca0fdb6de213f5906503cffdd7d74a9f28da3e1::config::max_oracle_age_ms(0xf332e48e1c3ca49e806ebd3cbca0fdb6de213f5906503cffdd7d74a9f28da3e1::config::params(arg2)), arg7);
        assert!(!v13, 7);
        sui_price_scaled_from_usdc(curve_usdc_price_scaled(v0, v1, v2, v6, arg8), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1))
    }

    fun pow10(arg0: u8) : u256 {
        let v0 = 1;
        let v1 = 0;
        while (v1 < arg0) {
            v0 = v0 * 10;
            v1 = v1 + 1;
        };
        v0
    }

    fun realized_price(arg0: u64, arg1: u64, arg2: u8) : u128 {
        assert!(arg0 > 0 && arg1 > 0, 1);
        let v0 = (arg0 as u256) * pow10(arg2) * 1000000000000 / (arg1 as u256);
        assert!(v0 > 0 && v0 <= 340282366920938463444927863358058659840, 2);
        (v0 as u128)
    }

    fun sui_price_scaled_from_usdc(arg0: u256, arg1: u128) : u128 {
        assert!(arg1 > 0, 0);
        let v0 = 340282366920938463463374607431768211456 / (arg1 as u256) * (arg1 as u256);
        assert!(v0 > 0, 0);
        let v1 = arg0 * v0;
        assert!(v1 > 0 && v1 <= 340282366920938463444927863358058659840, 2);
        (v1 as u128)
    }

    // decompiled from Move bytecode v7
}

