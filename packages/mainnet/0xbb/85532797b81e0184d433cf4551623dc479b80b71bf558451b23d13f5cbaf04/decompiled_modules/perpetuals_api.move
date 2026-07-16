module 0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::perpetuals_api {
    public(friend) fun allocate_collateral_to_position<T0, T1>(arg0: &mut 0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::Vault<T0, T1>, arg1: &mut 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::account::Account<T1>, arg2: &mut 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::ClearingHouse<T1>, arg3: u64, arg4: &0x2::clock::Clock) {
        0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::assert_package_version<T0, T1>(arg0);
        0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::assert_vault_is_not_paused<T0, T1>(arg0, arg4);
        assert!(arg3 <= 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::account::collateral_balance<T1>(arg1), 0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::errors::not_enough_collateral_balance());
        0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::allocate_collateral<T1, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(arg2, 0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::account_cap<T0, T1>(arg0), arg1, arg3);
        let v0 = arg2;
        let v1 = 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::position<T1>(v0, 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::account::account_id<T1>(arg1));
        let (v2, _) = 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::base_and_quote_amounts(v1);
        let v4 = if (0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::to_balance(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::abs(0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::collateral(v1)), 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::market::scaling_factor(0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::market_params<T1>(v0))) == 0) {
            if (v2 == 0) {
                0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::pending_order_count(v1) == 0
            } else {
                false
            }
        } else {
            false
        };
        let v5 = 0x2::object::id<0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::ClearingHouse<T1>>(v0);
        let v6 = 0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::ch_ids_mut<T0, T1>(arg0);
        if (v4) {
            let v7 = 0;
            let v8;
            while (v7 < 0x1::vector::length<0x2::object::ID>(v6)) {
                if (*0x1::vector::borrow<0x2::object::ID>(v6, v7) == v5) {
                    v8 = 0x1::option::some<u64>(v7);
                    /* label 16 */
                    if (0x1::option::is_some<u64>(&v8)) {
                        0x1::vector::remove<0x2::object::ID>(v6, 0x1::option::destroy_some<u64>(v8));
                    } else {
                        0x1::option::destroy_none<u64>(v8);
                    };
                    /* label 20 */
                    return
                };
                v7 = v7 + 1;
            };
            v8 = 0x1::option::none<u64>();
            /* goto 16 */
        } else {
            let v9 = 0;
            let v10;
            while (v9 < 0x1::vector::length<0x2::object::ID>(v6)) {
                if (*0x1::vector::borrow<0x2::object::ID>(v6, v9) == v5) {
                    v10 = 0x1::option::some<u64>(v9);
                    /* label 27 */
                    if (0x1::option::is_none<u64>(&v10)) {
                        0x1::vector::push_back<0x2::object::ID>(v6, v5);
                        assert!(0x1::vector::length<0x2::object::ID>(v6) <= 0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::max_markets_in_vault<T0, T1>(arg0), 0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::errors::max_markets_exceeded());
                        /* goto 20 */
                    } else {
                        return
                    };
                } else {
                    v9 = v9 + 1;
                };
            };
            v10 = 0x1::option::none<u64>();
            /* goto 27 */
        };
    }

    fun assert_pending_orders_within_limit<T0, T1>(arg0: &0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::Vault<T0, T1>, arg1: &0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::ClearingHouse<T1>, arg2: u64) {
        assert!(0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::pending_order_count(0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::position<T1>(arg1, arg2)) <= 0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::max_pending_orders_per_position<T0, T1>(arg0), 0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::errors::max_pending_orders_exceeded());
    }

    public(friend) fun cancel_orders<T0, T1>(arg0: &mut 0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::Vault<T0, T1>, arg1: &0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::account::Account<T1>, arg2: &mut 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::ClearingHouse<T1>, arg3: &vector<u128>, arg4: &0x2::clock::Clock) {
        0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::assert_package_version<T0, T1>(arg0);
        0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::assert_vault_is_not_paused<T0, T1>(arg0, arg4);
        let v0 = vector[];
        let v1 = 0;
        while (v1 < 0x1::vector::length<u128>(arg3)) {
            0x1::vector::push_back<u128>(&mut v0, *0x1::vector::borrow<u128>(arg3, v1));
            v1 = v1 + 1;
        };
        0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::cancel_orders<T1, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(arg2, 0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::account_cap<T0, T1>(arg0), arg1, v0);
        if (0x1::vector::length<u128>(arg3) != 0) {
            let v2 = arg2;
            let v3 = 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::position<T1>(v2, 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::account::account_id<T1>(arg1));
            let (v4, _) = 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::base_and_quote_amounts(v3);
            let v6 = if (0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::to_balance(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::abs(0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::collateral(v3)), 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::market::scaling_factor(0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::market_params<T1>(v2))) == 0) {
                if (v4 == 0) {
                    0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::pending_order_count(v3) == 0
                } else {
                    false
                }
            } else {
                false
            };
            let v7 = 0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::ch_ids_mut<T0, T1>(arg0);
            if (v6) {
                let v8 = 0;
                /* label 15 */
                while (v8 < 0x1::vector::length<0x2::object::ID>(v7)) {
                    if (*0x1::vector::borrow<0x2::object::ID>(v7, v8) == 0x2::object::id<0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::ClearingHouse<T1>>(v2)) {
                        /* label 18 */
                        let v9 = 0x1::option::some<u64>(v8);
                        if (0x1::option::is_some<u64>(&v9)) {
                            0x1::vector::remove<0x2::object::ID>(v7, 0x1::option::destroy_some<u64>(v9));
                            return
                        } else {
                            0x1::option::destroy_none<u64>(v9);
                            return
                        };
                    } else {
                        /* goto 23 */
                    };
                };
            } else {
                /* goto 25 */
            };
        };
        /* label 22 */
        return
        /* label 23 */
        /* goto 15 */
        continue;
        /* goto 18 */
        /* label 25 */
        let v10 = 0;
        let v11;
        while (v10 < 0x1::vector::length<0x2::object::ID>(((/*raw:*//*undefined:73*/undefined)))) {
            if (*0x1::vector::borrow<0x2::object::ID>(((/*raw:*//*undefined:73*/undefined)), v10) == ((/*raw:*//*undefined:72*/undefined))) {
                v11 = 0x1::option::some<u64>(v10);
                /* label 29 */
                if (0x1::option::is_none<u64>(&v11)) {
                    0x1::vector::push_back<0x2::object::ID>(((/*raw:*//*undefined:73*/undefined)), ((/*raw:*//*undefined:72*/undefined)));
                    assert!(0x1::vector::length<0x2::object::ID>(((/*raw:*//*undefined:73*/undefined))) <= 0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::max_markets_in_vault<T0, T1>(arg0), 0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::errors::max_markets_exceeded());
                    /* goto 22 */
                } else {
                    return
                };
            } else {
                v10 = v10 + 1;
            };
        };
        v11 = 0x1::option::none<u64>();
        /* goto 29 */
    }

    public(friend) fun cancel_twap_order<T0, T1>(arg0: &mut 0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::Vault<T0, T1>, arg1: &mut 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::account::Account<T1>, arg2: &mut 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::ClearingHouse<T1>, arg3: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::PriceFeedStorage, arg4: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::PriceFeedStorage, arg5: &0x2::clock::Clock, arg6: 0x2::object::ID, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::assert_package_version<T0, T1>(arg0);
        0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::assert_vault_is_not_paused<T0, T1>(arg0, arg5);
        0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::assert_account_has_vault_authority<T0, T1>(arg0, arg1);
        let v0 = 0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::executor<T0, T1>(arg0, arg7);
        let v1 = 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::account::account_id<T1>(arg1);
        if (0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::exists_position<T1>(arg2, v1)) {
            let v2 = arg2;
            let v3 = 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::position<T1>(v2, v1);
            let (v4, _) = 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::base_and_quote_amounts(v3);
            let v6 = if (0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::to_balance(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::abs(0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::collateral(v3)), 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::market::scaling_factor(0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::market_params<T1>(v2))) == 0) {
                if (v4 == 0) {
                    0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::pending_order_count(v3) == 0
                } else {
                    false
                }
            } else {
                false
            };
            let v7 = 0x2::object::id<0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::ClearingHouse<T1>>(v2);
            let v8 = 0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::ch_ids_mut<T0, T1>(arg0);
            if (v6) {
                /* goto 22 */
            } else {
                let v9 = 0;
                /* label 12 */
                while (v9 < 0x1::vector::length<0x2::object::ID>(v8)) {
                    if (*0x1::vector::borrow<0x2::object::ID>(v8, v9) == v7) {
                        /* label 15 */
                        let v10 = 0x1::option::some<u64>(v9);
                        if (0x1::option::is_none<u64>(&v10)) {
                            0x1::vector::push_back<0x2::object::ID>(v8, v7);
                            assert!(0x1::vector::length<0x2::object::ID>(v8) <= 0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::max_markets_in_vault<T0, T1>(arg0), 0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::errors::max_markets_exceeded());
                            /* goto 19 */
                        } else {
                            return 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::twap_orders::cancel<T1>(arg1, arg2, arg3, arg4, arg6, arg5, &v0, arg7)
                        };
                    } else {
                        /* goto 20 */
                    };
                };
            };
        };
        /* label 19 */
        return 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::twap_orders::cancel<T1>(arg1, arg2, arg3, arg4, arg6, arg5, &v0, arg7)
        /* label 20 */
        /* goto 12 */
        continue;
        /* goto 15 */
        /* label 22 */
        let v11 = 0;
        let v12;
        while (v11 < 0x1::vector::length<0x2::object::ID>(((/*raw:*//*undefined:66*/undefined)))) {
            if (*0x1::vector::borrow<0x2::object::ID>(((/*raw:*//*undefined:66*/undefined)), v11) == ((/*raw:*//*undefined:65*/undefined))) {
                v12 = 0x1::option::some<u64>(v11);
                /* label 26 */
                if (0x1::option::is_some<u64>(&v12)) {
                    0x1::vector::remove<0x2::object::ID>(((/*raw:*//*undefined:66*/undefined)), 0x1::option::destroy_some<u64>(v12));
                    return 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::twap_orders::cancel<T1>(arg1, arg2, arg3, arg4, arg6, arg5, &v0, arg7)
                } else {
                    0x1::option::destroy_none<u64>(v12);
                    return 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::twap_orders::cancel<T1>(arg1, arg2, arg3, arg4, arg6, arg5, &v0, arg7)
                };
            } else {
                v11 = v11 + 1;
            };
        };
        v12 = 0x1::option::none<u64>();
        /* goto 26 */
    }

    public(friend) fun close_position_at_settlement_prices<T0, T1>(arg0: &mut 0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::Vault<T0, T1>, arg1: &mut 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::account::Account<T1>, arg2: &mut 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::ClearingHouse<T1>, arg3: &vector<u128>) {
        0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::assert_package_version<T0, T1>(arg0);
        0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::assert_vault_is_not_admin_paused<T0, T1>(arg0);
        0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::assert_account_has_vault_authority<T0, T1>(arg0, arg1);
        0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::close_position_at_settlement_prices<T1>(arg2, arg1, arg3);
        let v0 = arg2;
        let v1 = 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::position<T1>(v0, 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::account::account_id<T1>(arg1));
        let (v2, _) = 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::base_and_quote_amounts(v1);
        let v4 = if (0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::to_balance(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::abs(0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::collateral(v1)), 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::market::scaling_factor(0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::market_params<T1>(v0))) == 0) {
            if (v2 == 0) {
                0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::pending_order_count(v1) == 0
            } else {
                false
            }
        } else {
            false
        };
        let v5 = 0x2::object::id<0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::ClearingHouse<T1>>(v0);
        let v6 = 0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::ch_ids_mut<T0, T1>(arg0);
        if (v4) {
            let v7 = 0;
            let v8;
            while (v7 < 0x1::vector::length<0x2::object::ID>(v6)) {
                if (*0x1::vector::borrow<0x2::object::ID>(v6, v7) == v5) {
                    v8 = 0x1::option::some<u64>(v7);
                    /* label 13 */
                    if (0x1::option::is_some<u64>(&v8)) {
                        0x1::vector::remove<0x2::object::ID>(v6, 0x1::option::destroy_some<u64>(v8));
                    } else {
                        0x1::option::destroy_none<u64>(v8);
                    };
                    /* label 17 */
                    return
                };
                v7 = v7 + 1;
            };
            v8 = 0x1::option::none<u64>();
            /* goto 13 */
        } else {
            let v9 = 0;
            let v10;
            while (v9 < 0x1::vector::length<0x2::object::ID>(v6)) {
                if (*0x1::vector::borrow<0x2::object::ID>(v6, v9) == v5) {
                    v10 = 0x1::option::some<u64>(v9);
                    /* label 24 */
                    if (0x1::option::is_none<u64>(&v10)) {
                        0x1::vector::push_back<0x2::object::ID>(v6, v5);
                        assert!(0x1::vector::length<0x2::object::ID>(v6) <= 0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::max_markets_in_vault<T0, T1>(arg0), 0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::errors::max_markets_exceeded());
                        /* goto 17 */
                    } else {
                        return
                    };
                } else {
                    v9 = v9 + 1;
                };
            };
            v10 = 0x1::option::none<u64>();
            /* goto 24 */
        };
    }

    public(friend) fun create_market_position<T0, T1>(arg0: &0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::Vault<T0, T1>, arg1: &0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::account::Account<T1>, arg2: &mut 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::ClearingHouse<T1>) {
        0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::assert_package_version<T0, T1>(arg0);
        0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::assert_vault_is_not_admin_paused<T0, T1>(arg0);
        let v0 = 0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::account_cap<T0, T1>(arg0);
        if (!0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::exists_position<T1>(arg2, 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::account::account_id<T1>(arg1))) {
            0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::create_market_position<T1, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(arg2, v0, arg1);
        };
    }

    public(friend) fun create_stop_order_ticket<T0, T1>(arg0: &0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::Vault<T0, T1>, arg1: &mut 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::account::Account<T1>, arg2: &0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::registry::Registry, arg3: vector<address>, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: u64, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::assert_package_version<T0, T1>(arg0);
        0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::assert_vault_is_not_admin_paused<T0, T1>(arg0);
        0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::stop_orders::create_stop_order_ticket<T1, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(arg1, 0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::account_cap<T0, T1>(arg0), arg2, arg3, 0x1::option::some<address>(0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::execution_domain<T0, T1>(arg0)), arg4, arg5, arg6, arg7)
    }

    public(friend) fun create_twap_order_ticket<T0, T1>(arg0: &0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::Vault<T0, T1>, arg1: &mut 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::account::Account<T1>, arg2: &0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::ClearingHouse<T1>, arg3: vector<address>, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::assert_package_version<T0, T1>(arg0);
        0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::assert_vault_is_not_admin_paused<T0, T1>(arg0);
        0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::assert_account_has_vault_authority<T0, T1>(arg0, arg1);
        0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::twap_orders::create_twap_order_ticket<T1, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(arg1, 0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::account_cap<T0, T1>(arg0), arg2, arg3, 0x1::option::some<address>(0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::execution_domain<T0, T1>(arg0)), arg4, arg5, arg6)
    }

    public(friend) fun deallocate_collateral_from_position<T0, T1>(arg0: &mut 0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::Vault<T0, T1>, arg1: &mut 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::account::Account<T1>, arg2: &mut 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::ClearingHouse<T1>, arg3: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::PriceFeedStorage, arg4: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::PriceFeedStorage, arg5: 0x1::option::Option<u64>, arg6: &0x2::clock::Clock) {
        0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::assert_package_version<T0, T1>(arg0);
        0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::assert_vault_is_not_paused<T0, T1>(arg0, arg6);
        if (0x1::option::is_some<u64>(&arg5)) {
            0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::deallocate_collateral<T1, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(arg2, 0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::account_cap<T0, T1>(arg0), arg1, arg3, arg4, 0x1::option::destroy_some<u64>(arg5), arg6);
        } else {
            0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::deallocate_free_collateral<T1, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(arg2, 0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::account_cap<T0, T1>(arg0), arg1, arg3, arg4, arg6);
        };
        let v0 = arg2;
        let v1 = 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::position<T1>(v0, 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::account::account_id<T1>(arg1));
        let (v2, _) = 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::base_and_quote_amounts(v1);
        let v4 = if (0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::to_balance(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::abs(0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::collateral(v1)), 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::market::scaling_factor(0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::market_params<T1>(v0))) == 0) {
            if (v2 == 0) {
                0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::pending_order_count(v1) == 0
            } else {
                false
            }
        } else {
            false
        };
        let v5 = 0x2::object::id<0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::ClearingHouse<T1>>(v0);
        let v6 = 0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::ch_ids_mut<T0, T1>(arg0);
        if (v4) {
            let v7 = 0;
            let v8;
            while (v7 < 0x1::vector::length<0x2::object::ID>(v6)) {
                if (*0x1::vector::borrow<0x2::object::ID>(v6, v7) == v5) {
                    v8 = 0x1::option::some<u64>(v7);
                    /* label 16 */
                    if (0x1::option::is_some<u64>(&v8)) {
                        0x1::vector::remove<0x2::object::ID>(v6, 0x1::option::destroy_some<u64>(v8));
                    } else {
                        0x1::option::destroy_none<u64>(v8);
                    };
                    /* label 20 */
                    return
                };
                v7 = v7 + 1;
            };
            v8 = 0x1::option::none<u64>();
            /* goto 16 */
        } else {
            let v9 = 0;
            let v10;
            while (v9 < 0x1::vector::length<0x2::object::ID>(v6)) {
                if (*0x1::vector::borrow<0x2::object::ID>(v6, v9) == v5) {
                    v10 = 0x1::option::some<u64>(v9);
                    /* label 27 */
                    if (0x1::option::is_none<u64>(&v10)) {
                        0x1::vector::push_back<0x2::object::ID>(v6, v5);
                        assert!(0x1::vector::length<0x2::object::ID>(v6) <= 0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::max_markets_in_vault<T0, T1>(arg0), 0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::errors::max_markets_exceeded());
                        /* goto 20 */
                    } else {
                        return
                    };
                } else {
                    v9 = v9 + 1;
                };
            };
            v10 = 0x1::option::none<u64>();
            /* goto 27 */
        };
    }

    public(friend) fun delete_stop_order_ticket<T0, T1>(arg0: &0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::Vault<T0, T1>, arg1: &mut 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::account::Account<T1>, arg2: &0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::registry::Registry, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::assert_package_version<T0, T1>(arg0);
        0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::assert_vault_is_not_admin_paused<T0, T1>(arg0);
        0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::assert_account_has_vault_authority<T0, T1>(arg0, arg1);
        let v0 = 0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::executor<T0, T1>(arg0, arg4);
        0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::stop_orders::cancel_stop_order_ticket<T1>(arg1, arg2, arg3, &v0, arg4)
    }

    public(friend) fun edit_stop_order_ticket_details<T0, T1>(arg0: &0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::Vault<T0, T1>, arg1: &mut 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::account::Account<T1>, arg2: &0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::registry::Registry, arg3: 0x2::object::ID, arg4: vector<u8>) {
        0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::assert_package_version<T0, T1>(arg0);
        0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::assert_vault_is_not_admin_paused<T0, T1>(arg0);
        0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::stop_orders::edit_stop_order_ticket_details<T1, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(arg1, 0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::account_cap<T0, T1>(arg0), arg2, arg3, arg4);
    }

    public(friend) fun edit_stop_order_ticket_executors<T0, T1>(arg0: &0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::Vault<T0, T1>, arg1: &mut 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::account::Account<T1>, arg2: &0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::registry::Registry, arg3: 0x2::object::ID, arg4: vector<address>) {
        0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::assert_package_version<T0, T1>(arg0);
        0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::assert_vault_is_not_admin_paused<T0, T1>(arg0);
        0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::stop_orders::edit_stop_order_ticket_executors<T1, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(arg1, 0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::account_cap<T0, T1>(arg0), arg2, arg3, arg4);
    }

    public(friend) fun edit_twap_order_ticket_details<T0, T1>(arg0: &0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::Vault<T0, T1>, arg1: &mut 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::account::Account<T1>, arg2: &0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::registry::Registry, arg3: 0x2::object::ID, arg4: vector<u8>) {
        0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::assert_package_version<T0, T1>(arg0);
        0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::assert_vault_is_not_admin_paused<T0, T1>(arg0);
        0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::assert_account_has_vault_authority<T0, T1>(arg0, arg1);
        0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::twap_orders::set_details<T1, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(arg1, 0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::account_cap<T0, T1>(arg0), arg2, arg3, arg4);
    }

    public(friend) fun edit_twap_order_ticket_executors<T0, T1>(arg0: &0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::Vault<T0, T1>, arg1: &mut 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::account::Account<T1>, arg2: &0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::registry::Registry, arg3: 0x2::object::ID, arg4: vector<address>) {
        0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::assert_package_version<T0, T1>(arg0);
        0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::assert_vault_is_not_admin_paused<T0, T1>(arg0);
        0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::assert_account_has_vault_authority<T0, T1>(arg0, arg1);
        0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::twap_orders::set_executors<T1, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(arg1, 0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::account_cap<T0, T1>(arg0), arg2, arg3, arg4);
    }

    public(friend) fun end_perpetuals_session<T0, T1>(arg0: &mut 0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::Vault<T0, T1>, arg1: &mut 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::account::Account<T1>, arg2: 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::SessionHotPotato<T1>, arg3: bool, arg4: bool) : 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::ClearingHouse<T1> {
        0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::assert_package_version<T0, T1>(arg0);
        0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::assert_vault_is_not_admin_paused<T0, T1>(arg0);
        0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::assert_account_has_vault_authority<T0, T1>(arg0, arg1);
        let (v0, _) = 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::end_session<T1, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(arg2, 0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::account_cap<T0, T1>(arg0), arg1, arg3, arg4);
        let v2 = v0;
        let v3 = 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::account::account_id<T1>(arg1);
        if (0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::exists_position<T1>(&v2, v3)) {
            assert_pending_orders_within_limit<T0, T1>(arg0, &v2, v3);
        };
        let v4 = &v2;
        let v5 = 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::position<T1>(v4, v3);
        let (v6, _) = 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::base_and_quote_amounts(v5);
        let v8 = if (0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::to_balance(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::abs(0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::collateral(v5)), 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::market::scaling_factor(0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::market_params<T1>(v4))) == 0) {
            if (v6 == 0) {
                0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::pending_order_count(v5) == 0
            } else {
                false
            }
        } else {
            false
        };
        let v9 = 0x2::object::id<0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::ClearingHouse<T1>>(v4);
        let v10 = 0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::ch_ids_mut<T0, T1>(arg0);
        if (v8) {
            let v11 = 0;
            let v12;
            while (v11 < 0x1::vector::length<0x2::object::ID>(v10)) {
                if (*0x1::vector::borrow<0x2::object::ID>(v10, v11) == v9) {
                    v12 = 0x1::option::some<u64>(v11);
                    /* label 26 */
                    if (0x1::option::is_some<u64>(&v12)) {
                        0x1::vector::remove<0x2::object::ID>(v10, 0x1::option::destroy_some<u64>(v12));
                        /* goto 19 */
                    } else {
                        0x1::option::destroy_none<u64>(v12);
                        /* goto 19 */
                    };
                } else {
                    v11 = v11 + 1;
                };
            };
            v12 = 0x1::option::none<u64>();
            /* goto 26 */
        } else {
            let v13 = 0;
            let v14;
            while (v13 < 0x1::vector::length<0x2::object::ID>(v10)) {
                if (*0x1::vector::borrow<0x2::object::ID>(v10, v13) == v9) {
                    v14 = 0x1::option::some<u64>(v13);
                    /* label 15 */
                    if (0x1::option::is_none<u64>(&v14)) {
                        0x1::vector::push_back<0x2::object::ID>(v10, v9);
                        assert!(0x1::vector::length<0x2::object::ID>(v10) <= 0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::max_markets_in_vault<T0, T1>(arg0), 0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::errors::max_markets_exceeded());
                    };
                    /* label 19 */
                    return v2
                };
                v13 = v13 + 1;
            };
            v14 = 0x1::option::none<u64>();
            /* goto 15 */
        };
    }

    public(friend) fun execute_twap_order<T0, T1>(arg0: &mut 0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::Vault<T0, T1>, arg1: 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::ClearingHouse<T1>, arg2: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::PriceFeedStorage, arg3: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::PriceFeedStorage, arg4: &0x2::clock::Clock, arg5: 0x2::object::ID, arg6: &mut 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::account::Account<T1>, arg7: &0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::twap_orders::TWAPOrderDetails, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : (0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::SessionSummary, 0x2::coin::Coin<0x2::sui::SUI>, 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::ClearingHouse<T1>) {
        0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::assert_package_version<T0, T1>(arg0);
        0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::assert_vault_is_not_paused<T0, T1>(arg0, arg4);
        0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::assert_account_has_vault_authority<T0, T1>(arg0, arg6);
        let v0 = 0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::executor<T0, T1>(arg0, arg9);
        let v1 = 0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::account_cap<T0, T1>(arg0);
        if (!0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::exists_position<T1>(&arg1, 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::account::account_id<T1>(arg6))) {
            0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::create_market_position<T1, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(&mut arg1, v1, arg6);
        };
        let (v2, v3, v4) = 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::twap_orders::execute<T1>(arg6, arg1, arg2, arg3, arg5, arg7, arg8, arg4, &v0, arg9);
        let v5 = v4;
        let v6 = &v5;
        let v7 = 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::position<T1>(v6, 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::account::account_id<T1>(arg6));
        let (v8, _) = 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::base_and_quote_amounts(v7);
        let v10 = if (0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::to_balance(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::abs(0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::collateral(v7)), 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::market::scaling_factor(0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::market_params<T1>(v6))) == 0) {
            if (v8 == 0) {
                0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::pending_order_count(v7) == 0
            } else {
                false
            }
        } else {
            false
        };
        let v11 = 0x2::object::id<0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::ClearingHouse<T1>>(v6);
        let v12 = 0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::ch_ids_mut<T0, T1>(arg0);
        if (v10) {
            let v13 = 0;
            let v14;
            while (v13 < 0x1::vector::length<0x2::object::ID>(v12)) {
                if (*0x1::vector::borrow<0x2::object::ID>(v12, v13) == v11) {
                    v14 = 0x1::option::some<u64>(v13);
                    /* label 27 */
                    if (0x1::option::is_some<u64>(&v14)) {
                        0x1::vector::remove<0x2::object::ID>(v12, 0x1::option::destroy_some<u64>(v14));
                        /* goto 20 */
                    } else {
                        0x1::option::destroy_none<u64>(v14);
                        /* goto 20 */
                    };
                } else {
                    v13 = v13 + 1;
                };
            };
            v14 = 0x1::option::none<u64>();
            /* goto 27 */
        } else {
            let v15 = 0;
            let v16;
            while (v15 < 0x1::vector::length<0x2::object::ID>(v12)) {
                if (*0x1::vector::borrow<0x2::object::ID>(v12, v15) == v11) {
                    v16 = 0x1::option::some<u64>(v15);
                    /* label 16 */
                    if (0x1::option::is_none<u64>(&v16)) {
                        0x1::vector::push_back<0x2::object::ID>(v12, v11);
                        assert!(0x1::vector::length<0x2::object::ID>(v12) <= 0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::max_markets_in_vault<T0, T1>(arg0), 0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::errors::max_markets_exceeded());
                    };
                    /* label 20 */
                    return (v2, v3, v5)
                };
                v15 = v15 + 1;
            };
            v16 = 0x1::option::none<u64>();
            /* goto 16 */
        };
    }

    public(friend) fun finalize_twap_order<T0, T1>(arg0: &mut 0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::Vault<T0, T1>, arg1: &mut 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::account::Account<T1>, arg2: &mut 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::ClearingHouse<T1>, arg3: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::PriceFeedStorage, arg4: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::PriceFeedStorage, arg5: &0x2::clock::Clock, arg6: 0x2::object::ID, arg7: &0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::twap_orders::TWAPOrderDetails, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::assert_package_version<T0, T1>(arg0);
        0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::assert_vault_is_not_paused<T0, T1>(arg0, arg5);
        0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::assert_account_has_vault_authority<T0, T1>(arg0, arg1);
        let v0 = 0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::executor<T0, T1>(arg0, arg8);
        let v1 = 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::account::account_id<T1>(arg1);
        if (0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::exists_position<T1>(arg2, v1)) {
            let v2 = arg2;
            let v3 = 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::position<T1>(v2, v1);
            let (v4, _) = 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::base_and_quote_amounts(v3);
            let v6 = if (0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::to_balance(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::abs(0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::collateral(v3)), 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::market::scaling_factor(0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::market_params<T1>(v2))) == 0) {
                if (v4 == 0) {
                    0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::pending_order_count(v3) == 0
                } else {
                    false
                }
            } else {
                false
            };
            let v7 = 0x2::object::id<0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::ClearingHouse<T1>>(v2);
            let v8 = 0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::ch_ids_mut<T0, T1>(arg0);
            if (v6) {
                /* goto 22 */
            } else {
                let v9 = 0;
                /* label 12 */
                while (v9 < 0x1::vector::length<0x2::object::ID>(v8)) {
                    if (*0x1::vector::borrow<0x2::object::ID>(v8, v9) == v7) {
                        /* label 15 */
                        let v10 = 0x1::option::some<u64>(v9);
                        if (0x1::option::is_none<u64>(&v10)) {
                            0x1::vector::push_back<0x2::object::ID>(v8, v7);
                            assert!(0x1::vector::length<0x2::object::ID>(v8) <= 0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::max_markets_in_vault<T0, T1>(arg0), 0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::errors::max_markets_exceeded());
                            /* goto 19 */
                        } else {
                            return 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::twap_orders::finalize<T1>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, &v0, arg8)
                        };
                    } else {
                        /* goto 20 */
                    };
                };
            };
        };
        /* label 19 */
        return 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::twap_orders::finalize<T1>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, &v0, arg8)
        /* label 20 */
        /* goto 12 */
        continue;
        /* goto 15 */
        /* label 22 */
        let v11 = 0;
        let v12;
        while (v11 < 0x1::vector::length<0x2::object::ID>(((/*raw:*//*undefined:67*/undefined)))) {
            if (*0x1::vector::borrow<0x2::object::ID>(((/*raw:*//*undefined:67*/undefined)), v11) == ((/*raw:*//*undefined:66*/undefined))) {
                v12 = 0x1::option::some<u64>(v11);
                /* label 26 */
                if (0x1::option::is_some<u64>(&v12)) {
                    0x1::vector::remove<0x2::object::ID>(((/*raw:*//*undefined:67*/undefined)), 0x1::option::destroy_some<u64>(v12));
                    return 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::twap_orders::finalize<T1>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, &v0, arg8)
                } else {
                    0x1::option::destroy_none<u64>(v12);
                    return 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::twap_orders::finalize<T1>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, &v0, arg8)
                };
            } else {
                v11 = v11 + 1;
            };
        };
        v12 = 0x1::option::none<u64>();
        /* goto 26 */
    }

    public(friend) fun liquidate<T0, T1>(arg0: &mut 0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::Vault<T0, T1>, arg1: &mut 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::account::Account<T1>, arg2: 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::ClearingHouse<T1>, arg3: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::PriceFeedStorage, arg4: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::PriceFeedStorage, arg5: u64, arg6: &vector<u128>, arg7: 0x1::option::Option<0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::account::IntegratorInfo>, arg8: &0x2::clock::Clock, arg9: &0x2::tx_context::TxContext) {
        0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::assert_package_version<T0, T1>(arg0);
        0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::assert_vault_is_not_paused<T0, T1>(arg0, arg8);
        let v0 = 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::start_session<T1, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(arg2, 0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::account_cap<T0, T1>(arg0), arg1, arg3, arg4, arg7, arg8, arg9);
        0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::liquidate<T1>(&mut v0, arg5, arg6);
        let (v1, _) = 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::end_session<T1, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(v0, 0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::account_cap<T0, T1>(arg0), arg1, false, false);
        let v3 = v1;
        let v4 = &v3;
        let v5 = 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::position<T1>(v4, 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::account::account_id<T1>(arg1));
        let (v6, _) = 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::base_and_quote_amounts(v5);
        let v8 = if (0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::to_balance(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::abs(0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::collateral(v5)), 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::market::scaling_factor(0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::market_params<T1>(v4))) == 0) {
            if (v6 == 0) {
                0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::pending_order_count(v5) == 0
            } else {
                false
            }
        } else {
            false
        };
        let v9 = 0x2::object::id<0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::ClearingHouse<T1>>(v4);
        let v10 = 0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::ch_ids_mut<T0, T1>(arg0);
        if (v8) {
            let v11 = 0;
            let v12;
            while (v11 < 0x1::vector::length<0x2::object::ID>(v10)) {
                if (*0x1::vector::borrow<0x2::object::ID>(v10, v11) == v9) {
                    v12 = 0x1::option::some<u64>(v11);
                    /* label 24 */
                    if (0x1::option::is_some<u64>(&v12)) {
                        0x1::vector::remove<0x2::object::ID>(v10, 0x1::option::destroy_some<u64>(v12));
                        /* goto 17 */
                    } else {
                        0x1::option::destroy_none<u64>(v12);
                        /* goto 17 */
                    };
                } else {
                    v11 = v11 + 1;
                };
            };
            v12 = 0x1::option::none<u64>();
            /* goto 24 */
        } else {
            let v13 = 0;
            let v14;
            while (v13 < 0x1::vector::length<0x2::object::ID>(v10)) {
                if (*0x1::vector::borrow<0x2::object::ID>(v10, v13) == v9) {
                    v14 = 0x1::option::some<u64>(v13);
                    /* label 13 */
                    if (0x1::option::is_none<u64>(&v14)) {
                        0x1::vector::push_back<0x2::object::ID>(v10, v9);
                        assert!(0x1::vector::length<0x2::object::ID>(v10) <= 0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::max_markets_in_vault<T0, T1>(arg0), 0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::errors::max_markets_exceeded());
                    };
                    /* label 17 */
                    share_clearing_house<T1>(v3);
                    return
                };
                v13 = v13 + 1;
            };
            v14 = 0x1::option::none<u64>();
            /* goto 13 */
        };
    }

    public(friend) fun place_limit_order<T0, T1>(arg0: &mut 0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::Vault<T0, T1>, arg1: &mut 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::account::Account<T1>, arg2: 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::ClearingHouse<T1>, arg3: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::PriceFeedStorage, arg4: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::PriceFeedStorage, arg5: bool, arg6: u64, arg7: u64, arg8: u64, arg9: 0x1::option::Option<u64>, arg10: bool, arg11: 0x1::option::Option<u64>, arg12: 0x1::option::Option<0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::account::IntegratorInfo>, arg13: &0x2::clock::Clock, arg14: &0x2::tx_context::TxContext) : (0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::ClearingHouse<T1>, 0x1::option::Option<u128>) {
        0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::assert_package_version<T0, T1>(arg0);
        0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::assert_vault_is_not_paused<T0, T1>(arg0, arg13);
        let v0 = 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::start_session<T1, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(arg2, 0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::account_cap<T0, T1>(arg0), arg1, arg3, arg4, arg12, arg13, arg14);
        let v1 = 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::place_limit_order<T1>(&mut v0, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
        let (v2, _) = 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::end_session<T1, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(v0, 0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::account_cap<T0, T1>(arg0), arg1, false, false);
        let v4 = v2;
        if (0x1::option::is_some<u128>(&v1)) {
            assert_pending_orders_within_limit<T0, T1>(arg0, &v4, 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::account::account_id<T1>(arg1));
        };
        let v5 = &v4;
        let v6 = 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::position<T1>(v5, 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::account::account_id<T1>(arg1));
        let (v7, _) = 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::base_and_quote_amounts(v6);
        let v9 = if (0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::to_balance(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::abs(0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::collateral(v6)), 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::market::scaling_factor(0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::market_params<T1>(v5))) == 0) {
            if (v7 == 0) {
                0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::pending_order_count(v6) == 0
            } else {
                false
            }
        } else {
            false
        };
        let v10 = 0x2::object::id<0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::ClearingHouse<T1>>(v5);
        let v11 = 0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::ch_ids_mut<T0, T1>(arg0);
        if (v9) {
            let v12 = 0;
            let v13;
            while (v12 < 0x1::vector::length<0x2::object::ID>(v11)) {
                if (*0x1::vector::borrow<0x2::object::ID>(v11, v12) == v10) {
                    v13 = 0x1::option::some<u64>(v12);
                    /* label 26 */
                    if (0x1::option::is_some<u64>(&v13)) {
                        0x1::vector::remove<0x2::object::ID>(v11, 0x1::option::destroy_some<u64>(v13));
                        /* goto 19 */
                    } else {
                        0x1::option::destroy_none<u64>(v13);
                        /* goto 19 */
                    };
                } else {
                    v12 = v12 + 1;
                };
            };
            v13 = 0x1::option::none<u64>();
            /* goto 26 */
        } else {
            let v14 = 0;
            let v15;
            while (v14 < 0x1::vector::length<0x2::object::ID>(v11)) {
                if (*0x1::vector::borrow<0x2::object::ID>(v11, v14) == v10) {
                    v15 = 0x1::option::some<u64>(v14);
                    /* label 15 */
                    if (0x1::option::is_none<u64>(&v15)) {
                        0x1::vector::push_back<0x2::object::ID>(v11, v10);
                        assert!(0x1::vector::length<0x2::object::ID>(v11) <= 0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::max_markets_in_vault<T0, T1>(arg0), 0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::errors::max_markets_exceeded());
                    };
                    /* label 19 */
                    return (v4, v1)
                };
                v14 = v14 + 1;
            };
            v15 = 0x1::option::none<u64>();
            /* goto 15 */
        };
    }

    public(friend) fun place_market_order<T0, T1>(arg0: &mut 0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::Vault<T0, T1>, arg1: &mut 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::account::Account<T1>, arg2: 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::ClearingHouse<T1>, arg3: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::PriceFeedStorage, arg4: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::PriceFeedStorage, arg5: bool, arg6: u64, arg7: bool, arg8: 0x1::option::Option<0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::account::IntegratorInfo>, arg9: &0x2::clock::Clock, arg10: &0x2::tx_context::TxContext) : 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::ClearingHouse<T1> {
        0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::assert_package_version<T0, T1>(arg0);
        0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::assert_vault_is_not_paused<T0, T1>(arg0, arg9);
        let v0 = 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::start_session<T1, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(arg2, 0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::account_cap<T0, T1>(arg0), arg1, arg3, arg4, arg8, arg9, arg10);
        0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::place_market_order<T1>(&mut v0, arg5, arg6, arg7);
        let (v1, _) = 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::end_session<T1, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(v0, 0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::account_cap<T0, T1>(arg0), arg1, false, false);
        let v3 = v1;
        let v4 = &v3;
        let v5 = 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::position<T1>(v4, 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::account::account_id<T1>(arg1));
        let (v6, _) = 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::base_and_quote_amounts(v5);
        let v8 = if (0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::to_balance(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::abs(0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::collateral(v5)), 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::market::scaling_factor(0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::market_params<T1>(v4))) == 0) {
            if (v6 == 0) {
                0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::pending_order_count(v5) == 0
            } else {
                false
            }
        } else {
            false
        };
        let v9 = 0x2::object::id<0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::ClearingHouse<T1>>(v4);
        let v10 = 0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::ch_ids_mut<T0, T1>(arg0);
        if (v8) {
            let v11 = 0;
            let v12;
            while (v11 < 0x1::vector::length<0x2::object::ID>(v10)) {
                if (*0x1::vector::borrow<0x2::object::ID>(v10, v11) == v9) {
                    v12 = 0x1::option::some<u64>(v11);
                    /* label 24 */
                    if (0x1::option::is_some<u64>(&v12)) {
                        0x1::vector::remove<0x2::object::ID>(v10, 0x1::option::destroy_some<u64>(v12));
                        /* goto 17 */
                    } else {
                        0x1::option::destroy_none<u64>(v12);
                        /* goto 17 */
                    };
                } else {
                    v11 = v11 + 1;
                };
            };
            v12 = 0x1::option::none<u64>();
            /* goto 24 */
        } else {
            let v13 = 0;
            let v14;
            while (v13 < 0x1::vector::length<0x2::object::ID>(v10)) {
                if (*0x1::vector::borrow<0x2::object::ID>(v10, v13) == v9) {
                    v14 = 0x1::option::some<u64>(v13);
                    /* label 13 */
                    if (0x1::option::is_none<u64>(&v14)) {
                        0x1::vector::push_back<0x2::object::ID>(v10, v9);
                        assert!(0x1::vector::length<0x2::object::ID>(v10) <= 0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::max_markets_in_vault<T0, T1>(arg0), 0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::errors::max_markets_exceeded());
                    };
                    /* label 17 */
                    return v3
                };
                v13 = v13 + 1;
            };
            v14 = 0x1::option::none<u64>();
            /* goto 13 */
        };
    }

    public(friend) fun place_stop_order_sltp<T0, T1>(arg0: &mut 0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::Vault<T0, T1>, arg1: 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::ClearingHouse<T1>, arg2: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::PriceFeedStorage, arg3: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::PriceFeedStorage, arg4: &0x2::clock::Clock, arg5: 0x2::object::ID, arg6: &mut 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::account::Account<T1>, arg7: 0x1::option::Option<u64>, arg8: bool, arg9: u8, arg10: 0x1::option::Option<u256>, arg11: 0x1::option::Option<u256>, arg12: bool, arg13: u64, arg14: u64, arg15: u64, arg16: vector<u8>, arg17: 0x1::option::Option<0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::account::IntegratorInfo>, arg18: &mut 0x2::tx_context::TxContext) : (0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::SessionSummary, 0x2::coin::Coin<0x2::sui::SUI>, 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::ClearingHouse<T1>) {
        0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::assert_package_version<T0, T1>(arg0);
        0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::assert_vault_is_not_paused<T0, T1>(arg0, arg4);
        0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::assert_account_has_vault_authority<T0, T1>(arg0, arg6);
        let v0 = 0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::executor<T0, T1>(arg0, arg18);
        let v1 = 0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::account_cap<T0, T1>(arg0);
        let v2 = 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::account::account_id<T1>(arg6);
        if (!0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::exists_position<T1>(&arg1, v2)) {
            0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::create_market_position<T1, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(&mut arg1, v1, arg6);
        };
        let (v3, v4, v5) = 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::stop_orders::place_stop_order_sltp<T1>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, &v0, arg18);
        let v6 = v5;
        if (arg8) {
            assert_pending_orders_within_limit<T0, T1>(arg0, &v6, v2);
        };
        let v7 = &v6;
        let v8 = 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::position<T1>(v7, v2);
        let (v9, _) = 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::base_and_quote_amounts(v8);
        let v11 = if (0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::to_balance(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::abs(0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::collateral(v8)), 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::market::scaling_factor(0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::market_params<T1>(v7))) == 0) {
            if (v9 == 0) {
                0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::pending_order_count(v8) == 0
            } else {
                false
            }
        } else {
            false
        };
        let v12 = 0x2::object::id<0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::ClearingHouse<T1>>(v7);
        let v13 = 0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::ch_ids_mut<T0, T1>(arg0);
        if (v11) {
            let v14 = 0;
            let v15;
            while (v14 < 0x1::vector::length<0x2::object::ID>(v13)) {
                if (*0x1::vector::borrow<0x2::object::ID>(v13, v14) == v12) {
                    v15 = 0x1::option::some<u64>(v14);
                    /* label 29 */
                    if (0x1::option::is_some<u64>(&v15)) {
                        0x1::vector::remove<0x2::object::ID>(v13, 0x1::option::destroy_some<u64>(v15));
                        /* goto 22 */
                    } else {
                        0x1::option::destroy_none<u64>(v15);
                        /* goto 22 */
                    };
                } else {
                    v14 = v14 + 1;
                };
            };
            v15 = 0x1::option::none<u64>();
            /* goto 29 */
        } else {
            let v16 = 0;
            let v17;
            while (v16 < 0x1::vector::length<0x2::object::ID>(v13)) {
                if (*0x1::vector::borrow<0x2::object::ID>(v13, v16) == v12) {
                    v17 = 0x1::option::some<u64>(v16);
                    /* label 18 */
                    if (0x1::option::is_none<u64>(&v17)) {
                        0x1::vector::push_back<0x2::object::ID>(v13, v12);
                        assert!(0x1::vector::length<0x2::object::ID>(v13) <= 0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::max_markets_in_vault<T0, T1>(arg0), 0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::errors::max_markets_exceeded());
                    };
                    /* label 22 */
                    return (v3, v4, v6)
                };
                v16 = v16 + 1;
            };
            v17 = 0x1::option::none<u64>();
            /* goto 18 */
        };
    }

    public(friend) fun place_stop_order_standalone<T0, T1>(arg0: &mut 0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::Vault<T0, T1>, arg1: 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::ClearingHouse<T1>, arg2: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::PriceFeedStorage, arg3: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::PriceFeedStorage, arg4: &0x2::clock::Clock, arg5: 0x2::object::ID, arg6: &mut 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::account::Account<T1>, arg7: 0x1::option::Option<u64>, arg8: bool, arg9: u8, arg10: u256, arg11: bool, arg12: bool, arg13: u64, arg14: u64, arg15: u64, arg16: bool, arg17: vector<u8>, arg18: 0x1::option::Option<0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::account::IntegratorInfo>, arg19: &mut 0x2::tx_context::TxContext) : (0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::SessionSummary, 0x2::coin::Coin<0x2::sui::SUI>, 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::ClearingHouse<T1>) {
        0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::assert_package_version<T0, T1>(arg0);
        0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::assert_vault_is_not_paused<T0, T1>(arg0, arg4);
        0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::assert_account_has_vault_authority<T0, T1>(arg0, arg6);
        let v0 = 0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::executor<T0, T1>(arg0, arg19);
        let v1 = 0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::account_cap<T0, T1>(arg0);
        let v2 = 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::account::account_id<T1>(arg6);
        if (!0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::exists_position<T1>(&arg1, v2)) {
            0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::create_market_position<T1, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(&mut arg1, v1, arg6);
        };
        let (v3, v4, v5) = 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::stop_orders::place_stop_order_standalone<T1>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, &v0, arg19);
        let v6 = v5;
        if (arg8) {
            assert_pending_orders_within_limit<T0, T1>(arg0, &v6, v2);
        };
        let v7 = &v6;
        let v8 = 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::position<T1>(v7, v2);
        let (v9, _) = 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::base_and_quote_amounts(v8);
        let v11 = if (0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::to_balance(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::abs(0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::collateral(v8)), 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::market::scaling_factor(0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::market_params<T1>(v7))) == 0) {
            if (v9 == 0) {
                0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::pending_order_count(v8) == 0
            } else {
                false
            }
        } else {
            false
        };
        let v12 = 0x2::object::id<0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::ClearingHouse<T1>>(v7);
        let v13 = 0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::ch_ids_mut<T0, T1>(arg0);
        if (v11) {
            let v14 = 0;
            let v15;
            while (v14 < 0x1::vector::length<0x2::object::ID>(v13)) {
                if (*0x1::vector::borrow<0x2::object::ID>(v13, v14) == v12) {
                    v15 = 0x1::option::some<u64>(v14);
                    /* label 29 */
                    if (0x1::option::is_some<u64>(&v15)) {
                        0x1::vector::remove<0x2::object::ID>(v13, 0x1::option::destroy_some<u64>(v15));
                        /* goto 22 */
                    } else {
                        0x1::option::destroy_none<u64>(v15);
                        /* goto 22 */
                    };
                } else {
                    v14 = v14 + 1;
                };
            };
            v15 = 0x1::option::none<u64>();
            /* goto 29 */
        } else {
            let v16 = 0;
            let v17;
            while (v16 < 0x1::vector::length<0x2::object::ID>(v13)) {
                if (*0x1::vector::borrow<0x2::object::ID>(v13, v16) == v12) {
                    v17 = 0x1::option::some<u64>(v16);
                    /* label 18 */
                    if (0x1::option::is_none<u64>(&v17)) {
                        0x1::vector::push_back<0x2::object::ID>(v13, v12);
                        assert!(0x1::vector::length<0x2::object::ID>(v13) <= 0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::max_markets_in_vault<T0, T1>(arg0), 0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::errors::max_markets_exceeded());
                    };
                    /* label 22 */
                    return (v3, v4, v6)
                };
                v16 = v16 + 1;
            };
            v17 = 0x1::option::none<u64>();
            /* goto 18 */
        };
    }

    public(friend) fun reconcile_clearing_house<T0, T1>(arg0: &mut 0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::Vault<T0, T1>, arg1: &0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::account::Account<T1>, arg2: &0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::ClearingHouse<T1>) {
        0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::assert_package_version<T0, T1>(arg0);
        0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::assert_vault_is_not_admin_paused<T0, T1>(arg0);
        0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::assert_account_has_vault_authority<T0, T1>(arg0, arg1);
        let v0 = 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::account::account_id<T1>(arg1);
        if (0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::exists_position<T1>(arg2, v0)) {
            let v1 = 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::position<T1>(arg2, v0);
            let (v2, _) = 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::base_and_quote_amounts(v1);
            let v4 = if (0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::to_balance(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::abs(0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::collateral(v1)), 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::market::scaling_factor(0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::market_params<T1>(arg2))) == 0) {
                if (v2 == 0) {
                    0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::pending_order_count(v1) == 0
                } else {
                    false
                }
            } else {
                false
            };
            let v5 = 0x2::object::id<0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::ClearingHouse<T1>>(arg2);
            let v6 = 0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::ch_ids_mut<T0, T1>(arg0);
            if (v4) {
                let v7 = 0;
                let v8;
                while (v7 < 0x1::vector::length<0x2::object::ID>(v6)) {
                    if (*0x1::vector::borrow<0x2::object::ID>(v6, v7) == v5) {
                        v8 = 0x1::option::some<u64>(v7);
                        /* label 14 */
                        if (0x1::option::is_some<u64>(&v8)) {
                            0x1::vector::remove<0x2::object::ID>(v6, 0x1::option::destroy_some<u64>(v8));
                        } else {
                            0x1::option::destroy_none<u64>(v8);
                        };
                        /* label 18 */
                        return
                    };
                    v7 = v7 + 1;
                };
                v8 = 0x1::option::none<u64>();
                /* goto 14 */
            } else {
                let v9 = 0;
                let v10;
                while (v9 < 0x1::vector::length<0x2::object::ID>(v6)) {
                    if (*0x1::vector::borrow<0x2::object::ID>(v6, v9) == v5) {
                        v10 = 0x1::option::some<u64>(v9);
                        /* label 25 */
                        if (0x1::option::is_none<u64>(&v10)) {
                            0x1::vector::push_back<0x2::object::ID>(v6, v5);
                            assert!(0x1::vector::length<0x2::object::ID>(v6) <= 0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::max_markets_in_vault<T0, T1>(arg0), 0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::errors::max_markets_exceeded());
                            /* goto 18 */
                        } else {
                            return
                        };
                    } else {
                        v9 = v9 + 1;
                    };
                };
                v10 = 0x1::option::none<u64>();
                /* goto 25 */
            };
        } else {
            let v11 = 0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::ch_ids_mut<T0, T1>(arg0);
            let v12 = 0;
            let v13;
            while (v12 < 0x1::vector::length<0x2::object::ID>(v11)) {
                if (*0x1::vector::borrow<0x2::object::ID>(v11, v12) == 0x2::object::id<0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::ClearingHouse<T1>>(arg2)) {
                    v13 = 0x1::option::some<u64>(v12);
                    /* label 35 */
                    if (0x1::option::is_some<u64>(&v13)) {
                        0x1::vector::remove<0x2::object::ID>(v11, 0x1::option::destroy_some<u64>(v13));
                        return
                    } else {
                        0x1::option::destroy_none<u64>(v13);
                        return
                    };
                } else {
                    v12 = v12 + 1;
                };
            };
            v13 = 0x1::option::none<u64>();
            /* goto 35 */
        };
    }

    public(friend) fun set_position_initial_margin_ratio<T0, T1>(arg0: &0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::Vault<T0, T1>, arg1: &0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::account::Account<T1>, arg2: &mut 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::ClearingHouse<T1>, arg3: u256) {
        0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::assert_package_version<T0, T1>(arg0);
        0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::assert_vault_is_not_admin_paused<T0, T1>(arg0);
        0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::set_position_initial_margin_ratio<T1, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(arg2, 0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::account_cap<T0, T1>(arg0), arg1, arg3);
    }

    fun share_clearing_house<T0>(arg0: 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::ClearingHouse<T0>) {
        0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::share<T0>(arg0);
    }

    public(friend) fun start_perpetuals_session<T0, T1>(arg0: &0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::Vault<T0, T1>, arg1: &mut 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::account::Account<T1>, arg2: 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::ClearingHouse<T1>, arg3: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::PriceFeedStorage, arg4: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::PriceFeedStorage, arg5: 0x1::option::Option<0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::account::IntegratorInfo>, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) : 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::SessionHotPotato<T1> {
        0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::assert_package_version<T0, T1>(arg0);
        0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::assert_vault_is_not_paused<T0, T1>(arg0, arg6);
        0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::start_session<T1, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(arg2, 0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::account_cap<T0, T1>(arg0), arg1, arg3, arg4, arg5, arg6, arg7)
    }

    public(friend) fun try_cancel_orders<T0, T1>(arg0: &mut 0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::Vault<T0, T1>, arg1: &0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::account::Account<T1>, arg2: &mut 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::ClearingHouse<T1>, arg3: &vector<u128>, arg4: &0x2::clock::Clock) : vector<bool> {
        0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::assert_package_version<T0, T1>(arg0);
        0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::assert_vault_is_not_paused<T0, T1>(arg0, arg4);
        let v0 = 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::try_cancel_orders<T1, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(arg2, 0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::account_cap<T0, T1>(arg0), arg1, arg3);
        let v1 = false;
        let v2 = &v0;
        let v3 = 0;
        while (v3 < 0x1::vector::length<bool>(v2)) {
            if (*0x1::vector::borrow<bool>(v2, v3)) {
                v1 = true;
            };
            v3 = v3 + 1;
        };
        if (v1) {
            let v4 = arg2;
            let v5 = 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::position<T1>(v4, 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::account::account_id<T1>(arg1));
            let (v6, _) = 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::base_and_quote_amounts(v5);
            let v8 = if (0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::to_balance(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::abs(0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::collateral(v5)), 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::market::scaling_factor(0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::market_params<T1>(v4))) == 0) {
                if (v6 == 0) {
                    0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::pending_order_count(v5) == 0
                } else {
                    false
                }
            } else {
                false
            };
            let v9 = 0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::ch_ids_mut<T0, T1>(arg0);
            if (v8) {
                let v10 = 0;
                /* label 18 */
                while (v10 < 0x1::vector::length<0x2::object::ID>(v9)) {
                    if (*0x1::vector::borrow<0x2::object::ID>(v9, v10) == 0x2::object::id<0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::ClearingHouse<T1>>(v4)) {
                        /* label 21 */
                        let v11 = 0x1::option::some<u64>(v10);
                        if (0x1::option::is_some<u64>(&v11)) {
                            0x1::vector::remove<0x2::object::ID>(v9, 0x1::option::destroy_some<u64>(v11));
                            /* goto 25 */
                        } else {
                            0x1::option::destroy_none<u64>(v11);
                            /* goto 25 */
                        };
                    } else {
                        /* goto 26 */
                    };
                };
            } else {
                /* goto 28 */
            };
        };
        /* label 25 */
        return v0
        /* label 26 */
        /* goto 18 */
        continue;
        /* goto 21 */
        /* label 28 */
        let v12 = 0;
        let v13;
        while (v12 < 0x1::vector::length<0x2::object::ID>(((/*raw:*//*undefined:69*/undefined)))) {
            if (*0x1::vector::borrow<0x2::object::ID>(((/*raw:*//*undefined:69*/undefined)), v12) == ((/*raw:*//*undefined:68*/undefined))) {
                v13 = 0x1::option::some<u64>(v12);
                /* label 32 */
                if (0x1::option::is_none<u64>(&v13)) {
                    0x1::vector::push_back<0x2::object::ID>(((/*raw:*//*undefined:69*/undefined)), ((/*raw:*//*undefined:68*/undefined)));
                    assert!(0x1::vector::length<0x2::object::ID>(((/*raw:*//*undefined:69*/undefined))) <= 0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::max_markets_in_vault<T0, T1>(arg0), 0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::errors::max_markets_exceeded());
                    /* goto 25 */
                } else {
                    /* goto 25 */
                };
            } else {
                v12 = v12 + 1;
            };
        };
        v13 = 0x1::option::none<u64>();
        /* goto 32 */
    }

    public(friend) fun user_cancel_twap_order<T0, T1>(arg0: &mut 0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::Vault<T0, T1>, arg1: &mut 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::account::Account<T1>, arg2: &mut 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::ClearingHouse<T1>, arg3: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::PriceFeedStorage, arg4: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::PriceFeedStorage, arg5: &0x2::clock::Clock, arg6: 0x2::object::ID, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::assert_package_version<T0, T1>(arg0);
        0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::assert_vault_is_not_paused<T0, T1>(arg0, arg5);
        0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::assert_account_has_vault_authority<T0, T1>(arg0, arg1);
        let v0 = 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::account::account_id<T1>(arg1);
        if (0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::exists_position<T1>(arg2, v0)) {
            let v1 = arg2;
            let v2 = 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::position<T1>(v1, v0);
            let (v3, _) = 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::base_and_quote_amounts(v2);
            let v5 = if (0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::to_balance(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::abs(0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::collateral(v2)), 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::market::scaling_factor(0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::market_params<T1>(v1))) == 0) {
                if (v3 == 0) {
                    0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::pending_order_count(v2) == 0
                } else {
                    false
                }
            } else {
                false
            };
            let v6 = 0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::ch_ids_mut<T0, T1>(arg0);
            if (v5) {
                let v7 = 0;
                /* label 12 */
                while (v7 < 0x1::vector::length<0x2::object::ID>(v6)) {
                    if (*0x1::vector::borrow<0x2::object::ID>(v6, v7) == 0x2::object::id<0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::ClearingHouse<T1>>(v1)) {
                        /* label 15 */
                        let v8 = 0x1::option::some<u64>(v7);
                        if (0x1::option::is_some<u64>(&v8)) {
                            0x1::vector::remove<0x2::object::ID>(v6, 0x1::option::destroy_some<u64>(v8));
                            return 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::twap_orders::user_cancel_twap_order<T1, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(arg1, 0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::account_cap<T0, T1>(arg0), arg2, arg3, arg4, arg6, arg5, arg7)
                        } else {
                            0x1::option::destroy_none<u64>(v8);
                            return 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::twap_orders::user_cancel_twap_order<T1, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(arg1, 0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::account_cap<T0, T1>(arg0), arg2, arg3, arg4, arg6, arg5, arg7)
                        };
                    } else {
                        /* goto 20 */
                    };
                };
            } else {
                /* goto 22 */
            };
        };
        /* label 19 */
        return 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::twap_orders::user_cancel_twap_order<T1, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(arg1, 0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::account_cap<T0, T1>(arg0), arg2, arg3, arg4, arg6, arg5, arg7)
        /* label 20 */
        /* goto 12 */
        continue;
        /* goto 15 */
        /* label 22 */
        let v9 = 0;
        let v10;
        while (v9 < 0x1::vector::length<0x2::object::ID>(((/*raw:*//*undefined:64*/undefined)))) {
            if (*0x1::vector::borrow<0x2::object::ID>(((/*raw:*//*undefined:64*/undefined)), v9) == ((/*raw:*//*undefined:63*/undefined))) {
                v10 = 0x1::option::some<u64>(v9);
                /* label 26 */
                if (0x1::option::is_none<u64>(&v10)) {
                    0x1::vector::push_back<0x2::object::ID>(((/*raw:*//*undefined:64*/undefined)), ((/*raw:*//*undefined:63*/undefined)));
                    assert!(0x1::vector::length<0x2::object::ID>(((/*raw:*//*undefined:64*/undefined))) <= 0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::max_markets_in_vault<T0, T1>(arg0), 0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::errors::max_markets_exceeded());
                    /* goto 19 */
                } else {
                    return 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::twap_orders::user_cancel_twap_order<T1, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(arg1, 0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::account_cap<T0, T1>(arg0), arg2, arg3, arg4, arg6, arg5, arg7)
                };
            } else {
                v9 = v9 + 1;
            };
        };
        v10 = 0x1::option::none<u64>();
        /* goto 26 */
    }

    public(friend) fun user_delete_stop_order_ticket<T0, T1>(arg0: &0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::Vault<T0, T1>, arg1: &mut 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::account::Account<T1>, arg2: &0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::registry::Registry, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::assert_package_version<T0, T1>(arg0);
        0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::assert_vault_is_not_admin_paused<T0, T1>(arg0);
        0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::stop_orders::cancel<T1, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(arg1, 0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::vault::account_cap<T0, T1>(arg0), arg2, arg3, arg4)
    }

    // decompiled from Move bytecode v7
}

