module 0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::perpetuals_api {
    public(friend) fun allocate_collateral_to_position<T0, T1>(arg0: &mut 0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::Vault<T0, T1>, arg1: &mut 0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::account::Account<T1>, arg2: &mut 0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::clearing_house::ClearingHouse<T1>, arg3: u64, arg4: &0x2::clock::Clock) {
        0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::assert_package_version<T0, T1>(arg0);
        0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::assert_vault_is_not_paused<T0, T1>(arg0, arg4);
        assert!(arg3 <= 0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::account::collateral_balance<T1>(arg1), 0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::errors::not_enough_collateral_balance());
        0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::clearing_house::allocate_collateral<T1, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(arg2, 0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::account_cap<T0, T1>(arg0), arg1, arg3);
        let v0 = arg2;
        let v1 = 0x2::object::id<0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::clearing_house::ClearingHouse<T1>>(v0);
        let v2 = 0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::ch_ids_mut<T0, T1>(arg0);
        if (0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::position_has_no_value<T1>(v0, 0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::account::account_id<T1>(arg1))) {
            let v3 = 0;
            let v4;
            while (v3 < 0x1::vector::length<0x2::object::ID>(v2)) {
                if (*0x1::vector::borrow<0x2::object::ID>(v2, v3) == v1) {
                    v4 = 0x1::option::some<u64>(v3);
                    /* label 9 */
                    if (0x1::option::is_some<u64>(&v4)) {
                        0x1::vector::remove<0x2::object::ID>(v2, 0x1::option::destroy_some<u64>(v4));
                    } else {
                        0x1::option::destroy_none<u64>(v4);
                    };
                    /* label 13 */
                    return
                };
                v3 = v3 + 1;
            };
            v4 = 0x1::option::none<u64>();
            /* goto 9 */
        } else {
            let v5 = 0;
            let v6;
            while (v5 < 0x1::vector::length<0x2::object::ID>(v2)) {
                if (*0x1::vector::borrow<0x2::object::ID>(v2, v5) == v1) {
                    v6 = 0x1::option::some<u64>(v5);
                    /* label 20 */
                    if (0x1::option::is_none<u64>(&v6)) {
                        0x1::vector::push_back<0x2::object::ID>(v2, v1);
                        assert!(0x1::vector::length<0x2::object::ID>(v2) <= 0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::max_markets_in_vault<T0, T1>(arg0), 0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::errors::max_markets_exceeded());
                        /* goto 13 */
                    } else {
                        return
                    };
                } else {
                    v5 = v5 + 1;
                };
            };
            v6 = 0x1::option::none<u64>();
            /* goto 20 */
        };
    }

    fun assert_pending_orders_within_limit<T0, T1>(arg0: &0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::Vault<T0, T1>, arg1: &0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::clearing_house::ClearingHouse<T1>, arg2: u64) {
        assert!(0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::pending_order_count(0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::clearing_house::position<T1>(arg1, arg2)) <= 0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::max_pending_orders_per_position<T0, T1>(arg0), 0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::errors::max_pending_orders_exceeded());
    }

    public(friend) fun cancel_orders<T0, T1>(arg0: &mut 0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::Vault<T0, T1>, arg1: &0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::account::Account<T1>, arg2: &mut 0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::clearing_house::ClearingHouse<T1>, arg3: &vector<u128>, arg4: &0x2::clock::Clock) {
        0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::assert_package_version<T0, T1>(arg0);
        0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::assert_vault_is_not_paused<T0, T1>(arg0, arg4);
        let v0 = vector[];
        let v1 = 0;
        while (v1 < 0x1::vector::length<u128>(arg3)) {
            0x1::vector::push_back<u128>(&mut v0, *0x1::vector::borrow<u128>(arg3, v1));
            v1 = v1 + 1;
        };
        0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::clearing_house::cancel_orders<T1, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(arg2, 0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::account_cap<T0, T1>(arg0), arg1, v0);
        if (0x1::vector::length<u128>(arg3) != 0) {
            let v2 = arg2;
            let v3 = 0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::ch_ids_mut<T0, T1>(arg0);
            if (0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::position_has_no_value<T1>(v2, 0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::account::account_id<T1>(arg1))) {
                let v4 = 0;
                /* label 8 */
                while (v4 < 0x1::vector::length<0x2::object::ID>(v3)) {
                    if (*0x1::vector::borrow<0x2::object::ID>(v3, v4) == 0x2::object::id<0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::clearing_house::ClearingHouse<T1>>(v2)) {
                        /* label 11 */
                        let v5 = 0x1::option::some<u64>(v4);
                        if (0x1::option::is_some<u64>(&v5)) {
                            0x1::vector::remove<0x2::object::ID>(v3, 0x1::option::destroy_some<u64>(v5));
                            return
                        } else {
                            0x1::option::destroy_none<u64>(v5);
                            return
                        };
                    } else {
                        /* goto 16 */
                    };
                };
            } else {
                /* goto 18 */
            };
        };
        /* label 15 */
        return
        /* label 16 */
        /* goto 8 */
        continue;
        /* goto 11 */
        /* label 18 */
        let v6 = 0;
        let v7;
        while (v6 < 0x1::vector::length<0x2::object::ID>(((/*raw:*//*undefined:53*/undefined)))) {
            if (*0x1::vector::borrow<0x2::object::ID>(((/*raw:*//*undefined:53*/undefined)), v6) == ((/*raw:*//*undefined:52*/undefined))) {
                v7 = 0x1::option::some<u64>(v6);
                /* label 22 */
                if (0x1::option::is_none<u64>(&v7)) {
                    0x1::vector::push_back<0x2::object::ID>(((/*raw:*//*undefined:53*/undefined)), ((/*raw:*//*undefined:52*/undefined)));
                    assert!(0x1::vector::length<0x2::object::ID>(((/*raw:*//*undefined:53*/undefined))) <= 0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::max_markets_in_vault<T0, T1>(arg0), 0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::errors::max_markets_exceeded());
                    /* goto 15 */
                } else {
                    return
                };
            } else {
                v6 = v6 + 1;
            };
        };
        v7 = 0x1::option::none<u64>();
        /* goto 22 */
    }

    public(friend) fun cancel_twap_order<T0, T1>(arg0: &mut 0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::Vault<T0, T1>, arg1: &mut 0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::account::Account<T1>, arg2: &mut 0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::clearing_house::ClearingHouse<T1>, arg3: &0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::price_feed_storage::PriceFeedStorage, arg4: &0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::price_feed_storage::PriceFeedStorage, arg5: &0x2::clock::Clock, arg6: 0x2::object::ID, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::assert_package_version<T0, T1>(arg0);
        0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::assert_vault_is_not_paused<T0, T1>(arg0, arg5);
        0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::assert_account_has_vault_authority<T0, T1>(arg0, arg1);
        let v0 = 0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::executor<T0, T1>(arg0, arg7);
        let v1 = 0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::account::account_id<T1>(arg1);
        if (0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::clearing_house::exists_position<T1>(arg2, v1)) {
            let v2 = arg2;
            let v3 = 0x2::object::id<0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::clearing_house::ClearingHouse<T1>>(v2);
            let v4 = 0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::ch_ids_mut<T0, T1>(arg0);
            if (0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::position_has_no_value<T1>(v2, v1)) {
                /* goto 15 */
            } else {
                let v5 = 0;
                /* label 5 */
                while (v5 < 0x1::vector::length<0x2::object::ID>(v4)) {
                    if (*0x1::vector::borrow<0x2::object::ID>(v4, v5) == v3) {
                        /* label 8 */
                        let v6 = 0x1::option::some<u64>(v5);
                        if (0x1::option::is_none<u64>(&v6)) {
                            0x1::vector::push_back<0x2::object::ID>(v4, v3);
                            assert!(0x1::vector::length<0x2::object::ID>(v4) <= 0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::max_markets_in_vault<T0, T1>(arg0), 0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::errors::max_markets_exceeded());
                            /* goto 12 */
                        } else {
                            return 0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::twap_orders::cancel<T1>(arg1, arg2, arg3, arg4, arg6, arg5, &v0, arg7)
                        };
                    } else {
                        /* goto 13 */
                    };
                };
            };
        };
        /* label 12 */
        return 0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::twap_orders::cancel<T1>(arg1, arg2, arg3, arg4, arg6, arg5, &v0, arg7)
        /* label 13 */
        /* goto 5 */
        continue;
        /* goto 8 */
        /* label 15 */
        let v7 = 0;
        let v8;
        while (v7 < 0x1::vector::length<0x2::object::ID>(((/*raw:*//*undefined:46*/undefined)))) {
            if (*0x1::vector::borrow<0x2::object::ID>(((/*raw:*//*undefined:46*/undefined)), v7) == ((/*raw:*//*undefined:45*/undefined))) {
                v8 = 0x1::option::some<u64>(v7);
                /* label 19 */
                if (0x1::option::is_some<u64>(&v8)) {
                    0x1::vector::remove<0x2::object::ID>(((/*raw:*//*undefined:46*/undefined)), 0x1::option::destroy_some<u64>(v8));
                    return 0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::twap_orders::cancel<T1>(arg1, arg2, arg3, arg4, arg6, arg5, &v0, arg7)
                } else {
                    0x1::option::destroy_none<u64>(v8);
                    return 0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::twap_orders::cancel<T1>(arg1, arg2, arg3, arg4, arg6, arg5, &v0, arg7)
                };
            } else {
                v7 = v7 + 1;
            };
        };
        v8 = 0x1::option::none<u64>();
        /* goto 19 */
    }

    public(friend) fun close_position_at_settlement_prices<T0, T1>(arg0: &mut 0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::Vault<T0, T1>, arg1: &mut 0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::account::Account<T1>, arg2: &mut 0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::clearing_house::ClearingHouse<T1>, arg3: &vector<u128>) {
        0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::assert_package_version<T0, T1>(arg0);
        0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::assert_vault_is_not_admin_paused<T0, T1>(arg0);
        0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::assert_account_has_vault_authority<T0, T1>(arg0, arg1);
        0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::clearing_house::close_position_at_settlement_prices<T1>(arg2, arg1, arg3);
        let v0 = arg2;
        let v1 = 0x2::object::id<0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::clearing_house::ClearingHouse<T1>>(v0);
        let v2 = 0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::ch_ids_mut<T0, T1>(arg0);
        if (0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::position_has_no_value<T1>(v0, 0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::account::account_id<T1>(arg1))) {
            let v3 = 0;
            let v4;
            while (v3 < 0x1::vector::length<0x2::object::ID>(v2)) {
                if (*0x1::vector::borrow<0x2::object::ID>(v2, v3) == v1) {
                    v4 = 0x1::option::some<u64>(v3);
                    /* label 6 */
                    if (0x1::option::is_some<u64>(&v4)) {
                        0x1::vector::remove<0x2::object::ID>(v2, 0x1::option::destroy_some<u64>(v4));
                    } else {
                        0x1::option::destroy_none<u64>(v4);
                    };
                    /* label 10 */
                    return
                };
                v3 = v3 + 1;
            };
            v4 = 0x1::option::none<u64>();
            /* goto 6 */
        } else {
            let v5 = 0;
            let v6;
            while (v5 < 0x1::vector::length<0x2::object::ID>(v2)) {
                if (*0x1::vector::borrow<0x2::object::ID>(v2, v5) == v1) {
                    v6 = 0x1::option::some<u64>(v5);
                    /* label 17 */
                    if (0x1::option::is_none<u64>(&v6)) {
                        0x1::vector::push_back<0x2::object::ID>(v2, v1);
                        assert!(0x1::vector::length<0x2::object::ID>(v2) <= 0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::max_markets_in_vault<T0, T1>(arg0), 0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::errors::max_markets_exceeded());
                        /* goto 10 */
                    } else {
                        return
                    };
                } else {
                    v5 = v5 + 1;
                };
            };
            v6 = 0x1::option::none<u64>();
            /* goto 17 */
        };
    }

    public(friend) fun create_market_position<T0, T1>(arg0: &0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::Vault<T0, T1>, arg1: &0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::account::Account<T1>, arg2: &mut 0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::clearing_house::ClearingHouse<T1>) {
        0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::assert_package_version<T0, T1>(arg0);
        0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::assert_vault_is_not_admin_paused<T0, T1>(arg0);
        let v0 = 0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::account_cap<T0, T1>(arg0);
        if (!0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::clearing_house::exists_position<T1>(arg2, 0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::account::account_id<T1>(arg1))) {
            0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::clearing_house::create_market_position<T1, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(arg2, v0, arg1);
        };
    }

    public(friend) fun create_stop_order_ticket<T0, T1>(arg0: &0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::Vault<T0, T1>, arg1: &mut 0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::account::Account<T1>, arg2: &0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::registry::Registry, arg3: vector<address>, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: u64, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::assert_package_version<T0, T1>(arg0);
        0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::assert_vault_is_not_admin_paused<T0, T1>(arg0);
        0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::stop_orders::create_stop_order_ticket<T1, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(arg1, 0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::account_cap<T0, T1>(arg0), arg2, arg3, 0x1::option::some<address>(0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::execution_domain<T0, T1>(arg0)), arg4, arg5, arg6, arg7)
    }

    public(friend) fun create_twap_order_ticket<T0, T1>(arg0: &0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::Vault<T0, T1>, arg1: &mut 0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::account::Account<T1>, arg2: &0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::clearing_house::ClearingHouse<T1>, arg3: vector<address>, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::assert_package_version<T0, T1>(arg0);
        0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::assert_vault_is_not_admin_paused<T0, T1>(arg0);
        0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::assert_account_has_vault_authority<T0, T1>(arg0, arg1);
        0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::twap_orders::create_twap_order_ticket<T1, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(arg1, 0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::account_cap<T0, T1>(arg0), arg2, arg3, 0x1::option::some<address>(0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::execution_domain<T0, T1>(arg0)), arg4, arg5, arg6)
    }

    public(friend) fun deallocate_collateral_from_position<T0, T1>(arg0: &mut 0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::Vault<T0, T1>, arg1: &mut 0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::account::Account<T1>, arg2: &mut 0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::clearing_house::ClearingHouse<T1>, arg3: &0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::price_feed_storage::PriceFeedStorage, arg4: &0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::price_feed_storage::PriceFeedStorage, arg5: 0x1::option::Option<u64>, arg6: &0x2::clock::Clock) {
        0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::assert_package_version<T0, T1>(arg0);
        0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::assert_vault_is_not_paused<T0, T1>(arg0, arg6);
        if (0x1::option::is_some<u64>(&arg5)) {
            0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::clearing_house::deallocate_collateral<T1, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(arg2, 0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::account_cap<T0, T1>(arg0), arg1, arg3, arg4, 0x1::option::destroy_some<u64>(arg5), arg6);
        } else {
            0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::clearing_house::deallocate_free_collateral<T1, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(arg2, 0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::account_cap<T0, T1>(arg0), arg1, arg3, arg4, arg6);
        };
        let v0 = arg2;
        let v1 = 0x2::object::id<0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::clearing_house::ClearingHouse<T1>>(v0);
        let v2 = 0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::ch_ids_mut<T0, T1>(arg0);
        if (0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::position_has_no_value<T1>(v0, 0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::account::account_id<T1>(arg1))) {
            let v3 = 0;
            let v4;
            while (v3 < 0x1::vector::length<0x2::object::ID>(v2)) {
                if (*0x1::vector::borrow<0x2::object::ID>(v2, v3) == v1) {
                    v4 = 0x1::option::some<u64>(v3);
                    /* label 20 */
                    if (0x1::option::is_some<u64>(&v4)) {
                        0x1::vector::remove<0x2::object::ID>(v2, 0x1::option::destroy_some<u64>(v4));
                        return
                    } else {
                        0x1::option::destroy_none<u64>(v4);
                        return
                    };
                } else {
                    v3 = v3 + 1;
                };
            };
            v4 = 0x1::option::none<u64>();
            /* goto 20 */
        } else {
            let v5 = 0;
            let v6;
            while (v5 < 0x1::vector::length<0x2::object::ID>(v2)) {
                if (*0x1::vector::borrow<0x2::object::ID>(v2, v5) == v1) {
                    v6 = 0x1::option::some<u64>(v5);
                    /* label 9 */
                    if (0x1::option::is_none<u64>(&v6)) {
                        0x1::vector::push_back<0x2::object::ID>(v2, v1);
                        assert!(0x1::vector::length<0x2::object::ID>(v2) <= 0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::max_markets_in_vault<T0, T1>(arg0), 0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::errors::max_markets_exceeded());
                    };
                    return
                };
                v5 = v5 + 1;
            };
            v6 = 0x1::option::none<u64>();
            /* goto 9 */
        };
    }

    public(friend) fun delete_stop_order_ticket<T0, T1>(arg0: &0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::Vault<T0, T1>, arg1: &mut 0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::account::Account<T1>, arg2: &0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::registry::Registry, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::assert_package_version<T0, T1>(arg0);
        0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::assert_vault_is_not_admin_paused<T0, T1>(arg0);
        0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::assert_account_has_vault_authority<T0, T1>(arg0, arg1);
        let v0 = 0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::executor<T0, T1>(arg0, arg4);
        0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::stop_orders::cancel_stop_order_ticket<T1>(arg1, arg2, arg3, &v0, arg4)
    }

    public(friend) fun edit_stop_order_ticket_details<T0, T1>(arg0: &0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::Vault<T0, T1>, arg1: &mut 0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::account::Account<T1>, arg2: &0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::registry::Registry, arg3: 0x2::object::ID, arg4: vector<u8>) {
        0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::assert_package_version<T0, T1>(arg0);
        0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::assert_vault_is_not_admin_paused<T0, T1>(arg0);
        0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::stop_orders::edit_stop_order_ticket_details<T1, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(arg1, 0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::account_cap<T0, T1>(arg0), arg2, arg3, arg4);
    }

    public(friend) fun edit_stop_order_ticket_executors<T0, T1>(arg0: &0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::Vault<T0, T1>, arg1: &mut 0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::account::Account<T1>, arg2: &0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::registry::Registry, arg3: 0x2::object::ID, arg4: vector<address>) {
        0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::assert_package_version<T0, T1>(arg0);
        0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::assert_vault_is_not_admin_paused<T0, T1>(arg0);
        0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::stop_orders::edit_stop_order_ticket_executors<T1, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(arg1, 0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::account_cap<T0, T1>(arg0), arg2, arg3, arg4);
    }

    public(friend) fun edit_twap_order_ticket_details<T0, T1>(arg0: &0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::Vault<T0, T1>, arg1: &mut 0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::account::Account<T1>, arg2: &0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::registry::Registry, arg3: 0x2::object::ID, arg4: vector<u8>) {
        0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::assert_package_version<T0, T1>(arg0);
        0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::assert_vault_is_not_admin_paused<T0, T1>(arg0);
        0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::assert_account_has_vault_authority<T0, T1>(arg0, arg1);
        0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::twap_orders::set_details<T1, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(arg1, 0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::account_cap<T0, T1>(arg0), arg2, arg3, arg4);
    }

    public(friend) fun edit_twap_order_ticket_executors<T0, T1>(arg0: &0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::Vault<T0, T1>, arg1: &mut 0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::account::Account<T1>, arg2: &0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::registry::Registry, arg3: 0x2::object::ID, arg4: vector<address>) {
        0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::assert_package_version<T0, T1>(arg0);
        0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::assert_vault_is_not_admin_paused<T0, T1>(arg0);
        0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::assert_account_has_vault_authority<T0, T1>(arg0, arg1);
        0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::twap_orders::set_executors<T1, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(arg1, 0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::account_cap<T0, T1>(arg0), arg2, arg3, arg4);
    }

    public(friend) fun end_perpetuals_session<T0, T1>(arg0: &mut 0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::Vault<T0, T1>, arg1: &mut 0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::account::Account<T1>, arg2: 0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::clearing_house::SessionHotPotato<T1>, arg3: bool, arg4: bool) : 0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::clearing_house::ClearingHouse<T1> {
        0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::assert_package_version<T0, T1>(arg0);
        0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::assert_vault_is_not_admin_paused<T0, T1>(arg0);
        0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::assert_account_has_vault_authority<T0, T1>(arg0, arg1);
        let (v0, _) = 0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::clearing_house::end_session<T1, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(arg2, 0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::account_cap<T0, T1>(arg0), arg1, arg3, arg4);
        let v2 = v0;
        let v3 = 0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::account::account_id<T1>(arg1);
        if (0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::clearing_house::exists_position<T1>(&v2, v3)) {
            assert_pending_orders_within_limit<T0, T1>(arg0, &v2, v3);
        };
        let v4 = &v2;
        let v5 = 0x2::object::id<0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::clearing_house::ClearingHouse<T1>>(v4);
        let v6 = 0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::ch_ids_mut<T0, T1>(arg0);
        if (0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::position_has_no_value<T1>(v4, v3)) {
            let v7 = 0;
            let v8;
            while (v7 < 0x1::vector::length<0x2::object::ID>(v6)) {
                if (*0x1::vector::borrow<0x2::object::ID>(v6, v7) == v5) {
                    v8 = 0x1::option::some<u64>(v7);
                    /* label 19 */
                    if (0x1::option::is_some<u64>(&v8)) {
                        0x1::vector::remove<0x2::object::ID>(v6, 0x1::option::destroy_some<u64>(v8));
                        /* goto 12 */
                    } else {
                        0x1::option::destroy_none<u64>(v8);
                        /* goto 12 */
                    };
                } else {
                    v7 = v7 + 1;
                };
            };
            v8 = 0x1::option::none<u64>();
            /* goto 19 */
        } else {
            let v9 = 0;
            let v10;
            while (v9 < 0x1::vector::length<0x2::object::ID>(v6)) {
                if (*0x1::vector::borrow<0x2::object::ID>(v6, v9) == v5) {
                    v10 = 0x1::option::some<u64>(v9);
                    /* label 8 */
                    if (0x1::option::is_none<u64>(&v10)) {
                        0x1::vector::push_back<0x2::object::ID>(v6, v5);
                        assert!(0x1::vector::length<0x2::object::ID>(v6) <= 0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::max_markets_in_vault<T0, T1>(arg0), 0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::errors::max_markets_exceeded());
                    };
                    /* label 12 */
                    return v2
                };
                v9 = v9 + 1;
            };
            v10 = 0x1::option::none<u64>();
            /* goto 8 */
        };
    }

    public(friend) fun execute_twap_order<T0, T1>(arg0: &mut 0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::Vault<T0, T1>, arg1: 0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::clearing_house::ClearingHouse<T1>, arg2: &0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::price_feed_storage::PriceFeedStorage, arg3: &0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::price_feed_storage::PriceFeedStorage, arg4: &0x2::clock::Clock, arg5: 0x2::object::ID, arg6: &mut 0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::account::Account<T1>, arg7: &0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::twap_orders::TWAPOrderDetails, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : (0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::clearing_house::SessionSummary, 0x2::coin::Coin<0x2::sui::SUI>, 0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::clearing_house::ClearingHouse<T1>) {
        0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::assert_package_version<T0, T1>(arg0);
        0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::assert_vault_is_not_paused<T0, T1>(arg0, arg4);
        0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::assert_account_has_vault_authority<T0, T1>(arg0, arg6);
        let v0 = 0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::executor<T0, T1>(arg0, arg9);
        let v1 = 0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::account_cap<T0, T1>(arg0);
        if (!0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::clearing_house::exists_position<T1>(&arg1, 0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::account::account_id<T1>(arg6))) {
            0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::clearing_house::create_market_position<T1, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(&mut arg1, v1, arg6);
        };
        let (v2, v3, v4) = 0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::twap_orders::execute<T1>(arg6, arg1, arg2, arg3, arg5, arg7, arg8, arg4, &v0, arg9);
        let v5 = v4;
        let v6 = &v5;
        let v7 = 0x2::object::id<0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::clearing_house::ClearingHouse<T1>>(v6);
        let v8 = 0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::ch_ids_mut<T0, T1>(arg0);
        if (0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::position_has_no_value<T1>(v6, 0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::account::account_id<T1>(arg6))) {
            let v9 = 0;
            let v10;
            while (v9 < 0x1::vector::length<0x2::object::ID>(v8)) {
                if (*0x1::vector::borrow<0x2::object::ID>(v8, v9) == v7) {
                    v10 = 0x1::option::some<u64>(v9);
                    /* label 9 */
                    if (0x1::option::is_some<u64>(&v10)) {
                        0x1::vector::remove<0x2::object::ID>(v8, 0x1::option::destroy_some<u64>(v10));
                    } else {
                        0x1::option::destroy_none<u64>(v10);
                    };
                    /* label 13 */
                    return (v2, v3, v5)
                };
                v9 = v9 + 1;
            };
            v10 = 0x1::option::none<u64>();
            /* goto 9 */
        } else {
            let v11 = 0;
            let v12;
            while (v11 < 0x1::vector::length<0x2::object::ID>(v8)) {
                if (*0x1::vector::borrow<0x2::object::ID>(v8, v11) == v7) {
                    v12 = 0x1::option::some<u64>(v11);
                    /* label 20 */
                    if (0x1::option::is_none<u64>(&v12)) {
                        0x1::vector::push_back<0x2::object::ID>(v8, v7);
                        assert!(0x1::vector::length<0x2::object::ID>(v8) <= 0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::max_markets_in_vault<T0, T1>(arg0), 0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::errors::max_markets_exceeded());
                        /* goto 13 */
                    } else {
                        /* goto 13 */
                    };
                } else {
                    v11 = v11 + 1;
                };
            };
            v12 = 0x1::option::none<u64>();
            /* goto 20 */
        };
    }

    public(friend) fun finalize_twap_order<T0, T1>(arg0: &mut 0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::Vault<T0, T1>, arg1: &mut 0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::account::Account<T1>, arg2: &mut 0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::clearing_house::ClearingHouse<T1>, arg3: &0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::price_feed_storage::PriceFeedStorage, arg4: &0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::price_feed_storage::PriceFeedStorage, arg5: &0x2::clock::Clock, arg6: 0x2::object::ID, arg7: &0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::twap_orders::TWAPOrderDetails, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::assert_package_version<T0, T1>(arg0);
        0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::assert_vault_is_not_paused<T0, T1>(arg0, arg5);
        0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::assert_account_has_vault_authority<T0, T1>(arg0, arg1);
        let v0 = 0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::executor<T0, T1>(arg0, arg8);
        let v1 = 0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::account::account_id<T1>(arg1);
        if (0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::clearing_house::exists_position<T1>(arg2, v1)) {
            let v2 = arg2;
            let v3 = 0x2::object::id<0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::clearing_house::ClearingHouse<T1>>(v2);
            let v4 = 0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::ch_ids_mut<T0, T1>(arg0);
            if (0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::position_has_no_value<T1>(v2, v1)) {
                /* goto 15 */
            } else {
                let v5 = 0;
                /* label 5 */
                while (v5 < 0x1::vector::length<0x2::object::ID>(v4)) {
                    if (*0x1::vector::borrow<0x2::object::ID>(v4, v5) == v3) {
                        /* label 8 */
                        let v6 = 0x1::option::some<u64>(v5);
                        if (0x1::option::is_none<u64>(&v6)) {
                            0x1::vector::push_back<0x2::object::ID>(v4, v3);
                            assert!(0x1::vector::length<0x2::object::ID>(v4) <= 0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::max_markets_in_vault<T0, T1>(arg0), 0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::errors::max_markets_exceeded());
                            /* goto 12 */
                        } else {
                            return 0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::twap_orders::finalize<T1>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, &v0, arg8)
                        };
                    } else {
                        /* goto 13 */
                    };
                };
            };
        };
        /* label 12 */
        return 0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::twap_orders::finalize<T1>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, &v0, arg8)
        /* label 13 */
        /* goto 5 */
        continue;
        /* goto 8 */
        /* label 15 */
        let v7 = 0;
        let v8;
        while (v7 < 0x1::vector::length<0x2::object::ID>(((/*raw:*//*undefined:47*/undefined)))) {
            if (*0x1::vector::borrow<0x2::object::ID>(((/*raw:*//*undefined:47*/undefined)), v7) == ((/*raw:*//*undefined:46*/undefined))) {
                v8 = 0x1::option::some<u64>(v7);
                /* label 19 */
                if (0x1::option::is_some<u64>(&v8)) {
                    0x1::vector::remove<0x2::object::ID>(((/*raw:*//*undefined:47*/undefined)), 0x1::option::destroy_some<u64>(v8));
                    return 0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::twap_orders::finalize<T1>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, &v0, arg8)
                } else {
                    0x1::option::destroy_none<u64>(v8);
                    return 0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::twap_orders::finalize<T1>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, &v0, arg8)
                };
            } else {
                v7 = v7 + 1;
            };
        };
        v8 = 0x1::option::none<u64>();
        /* goto 19 */
    }

    public(friend) fun liquidate<T0, T1>(arg0: &mut 0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::Vault<T0, T1>, arg1: &mut 0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::account::Account<T1>, arg2: 0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::clearing_house::ClearingHouse<T1>, arg3: &0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::price_feed_storage::PriceFeedStorage, arg4: &0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::price_feed_storage::PriceFeedStorage, arg5: u64, arg6: &vector<u128>, arg7: 0x1::option::Option<0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::account::IntegratorInfo>, arg8: &0x2::clock::Clock, arg9: &0x2::tx_context::TxContext) {
        0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::assert_package_version<T0, T1>(arg0);
        0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::assert_vault_is_not_paused<T0, T1>(arg0, arg8);
        let v0 = 0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::clearing_house::start_session<T1, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(arg2, 0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::account_cap<T0, T1>(arg0), arg1, arg3, arg4, arg7, arg8, arg9);
        0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::clearing_house::liquidate<T1>(&mut v0, arg5, arg6);
        let (v1, _) = 0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::clearing_house::end_session<T1, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(v0, 0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::account_cap<T0, T1>(arg0), arg1, false, false);
        let v3 = v1;
        let v4 = &v3;
        let v5 = 0x2::object::id<0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::clearing_house::ClearingHouse<T1>>(v4);
        let v6 = 0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::ch_ids_mut<T0, T1>(arg0);
        if (0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::position_has_no_value<T1>(v4, 0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::account::account_id<T1>(arg1))) {
            let v7 = 0;
            let v8;
            while (v7 < 0x1::vector::length<0x2::object::ID>(v6)) {
                if (*0x1::vector::borrow<0x2::object::ID>(v6, v7) == v5) {
                    v8 = 0x1::option::some<u64>(v7);
                    /* label 17 */
                    if (0x1::option::is_some<u64>(&v8)) {
                        0x1::vector::remove<0x2::object::ID>(v6, 0x1::option::destroy_some<u64>(v8));
                        /* goto 10 */
                    } else {
                        0x1::option::destroy_none<u64>(v8);
                        /* goto 10 */
                    };
                } else {
                    v7 = v7 + 1;
                };
            };
            v8 = 0x1::option::none<u64>();
            /* goto 17 */
        } else {
            let v9 = 0;
            let v10;
            while (v9 < 0x1::vector::length<0x2::object::ID>(v6)) {
                if (*0x1::vector::borrow<0x2::object::ID>(v6, v9) == v5) {
                    v10 = 0x1::option::some<u64>(v9);
                    /* label 6 */
                    if (0x1::option::is_none<u64>(&v10)) {
                        0x1::vector::push_back<0x2::object::ID>(v6, v5);
                        assert!(0x1::vector::length<0x2::object::ID>(v6) <= 0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::max_markets_in_vault<T0, T1>(arg0), 0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::errors::max_markets_exceeded());
                    };
                    /* label 10 */
                    share_clearing_house<T1>(v3);
                    return
                };
                v9 = v9 + 1;
            };
            v10 = 0x1::option::none<u64>();
            /* goto 6 */
        };
    }

    public(friend) fun place_limit_order<T0, T1>(arg0: &mut 0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::Vault<T0, T1>, arg1: &mut 0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::account::Account<T1>, arg2: 0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::clearing_house::ClearingHouse<T1>, arg3: &0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::price_feed_storage::PriceFeedStorage, arg4: &0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::price_feed_storage::PriceFeedStorage, arg5: bool, arg6: u64, arg7: u64, arg8: u64, arg9: 0x1::option::Option<u64>, arg10: bool, arg11: 0x1::option::Option<u64>, arg12: 0x1::option::Option<0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::account::IntegratorInfo>, arg13: &0x2::clock::Clock, arg14: &0x2::tx_context::TxContext) : (0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::clearing_house::ClearingHouse<T1>, 0x1::option::Option<u128>) {
        0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::assert_package_version<T0, T1>(arg0);
        0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::assert_vault_is_not_paused<T0, T1>(arg0, arg13);
        let v0 = 0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::clearing_house::start_session<T1, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(arg2, 0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::account_cap<T0, T1>(arg0), arg1, arg3, arg4, arg12, arg13, arg14);
        let v1 = 0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::clearing_house::place_limit_order<T1>(&mut v0, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
        let (v2, _) = 0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::clearing_house::end_session<T1, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(v0, 0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::account_cap<T0, T1>(arg0), arg1, false, false);
        let v4 = v2;
        if (0x1::option::is_some<u128>(&v1)) {
            assert_pending_orders_within_limit<T0, T1>(arg0, &v4, 0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::account::account_id<T1>(arg1));
        };
        let v5 = &v4;
        let v6 = 0x2::object::id<0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::clearing_house::ClearingHouse<T1>>(v5);
        let v7 = 0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::ch_ids_mut<T0, T1>(arg0);
        if (0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::position_has_no_value<T1>(v5, 0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::account::account_id<T1>(arg1))) {
            let v8 = 0;
            let v9;
            while (v8 < 0x1::vector::length<0x2::object::ID>(v7)) {
                if (*0x1::vector::borrow<0x2::object::ID>(v7, v8) == v6) {
                    v9 = 0x1::option::some<u64>(v8);
                    /* label 19 */
                    if (0x1::option::is_some<u64>(&v9)) {
                        0x1::vector::remove<0x2::object::ID>(v7, 0x1::option::destroy_some<u64>(v9));
                        /* goto 12 */
                    } else {
                        0x1::option::destroy_none<u64>(v9);
                        /* goto 12 */
                    };
                } else {
                    v8 = v8 + 1;
                };
            };
            v9 = 0x1::option::none<u64>();
            /* goto 19 */
        } else {
            let v10 = 0;
            let v11;
            while (v10 < 0x1::vector::length<0x2::object::ID>(v7)) {
                if (*0x1::vector::borrow<0x2::object::ID>(v7, v10) == v6) {
                    v11 = 0x1::option::some<u64>(v10);
                    /* label 8 */
                    if (0x1::option::is_none<u64>(&v11)) {
                        0x1::vector::push_back<0x2::object::ID>(v7, v6);
                        assert!(0x1::vector::length<0x2::object::ID>(v7) <= 0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::max_markets_in_vault<T0, T1>(arg0), 0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::errors::max_markets_exceeded());
                    };
                    /* label 12 */
                    return (v4, v1)
                };
                v10 = v10 + 1;
            };
            v11 = 0x1::option::none<u64>();
            /* goto 8 */
        };
    }

    public(friend) fun place_market_order<T0, T1>(arg0: &mut 0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::Vault<T0, T1>, arg1: &mut 0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::account::Account<T1>, arg2: 0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::clearing_house::ClearingHouse<T1>, arg3: &0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::price_feed_storage::PriceFeedStorage, arg4: &0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::price_feed_storage::PriceFeedStorage, arg5: bool, arg6: u64, arg7: bool, arg8: 0x1::option::Option<0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::account::IntegratorInfo>, arg9: &0x2::clock::Clock, arg10: &0x2::tx_context::TxContext) : 0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::clearing_house::ClearingHouse<T1> {
        0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::assert_package_version<T0, T1>(arg0);
        0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::assert_vault_is_not_paused<T0, T1>(arg0, arg9);
        let v0 = 0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::clearing_house::start_session<T1, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(arg2, 0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::account_cap<T0, T1>(arg0), arg1, arg3, arg4, arg8, arg9, arg10);
        0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::clearing_house::place_market_order<T1>(&mut v0, arg5, arg6, arg7);
        let (v1, _) = 0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::clearing_house::end_session<T1, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(v0, 0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::account_cap<T0, T1>(arg0), arg1, false, false);
        let v3 = v1;
        let v4 = &v3;
        let v5 = 0x2::object::id<0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::clearing_house::ClearingHouse<T1>>(v4);
        let v6 = 0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::ch_ids_mut<T0, T1>(arg0);
        if (0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::position_has_no_value<T1>(v4, 0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::account::account_id<T1>(arg1))) {
            let v7 = 0;
            let v8;
            while (v7 < 0x1::vector::length<0x2::object::ID>(v6)) {
                if (*0x1::vector::borrow<0x2::object::ID>(v6, v7) == v5) {
                    v8 = 0x1::option::some<u64>(v7);
                    /* label 17 */
                    if (0x1::option::is_some<u64>(&v8)) {
                        0x1::vector::remove<0x2::object::ID>(v6, 0x1::option::destroy_some<u64>(v8));
                        /* goto 10 */
                    } else {
                        0x1::option::destroy_none<u64>(v8);
                        /* goto 10 */
                    };
                } else {
                    v7 = v7 + 1;
                };
            };
            v8 = 0x1::option::none<u64>();
            /* goto 17 */
        } else {
            let v9 = 0;
            let v10;
            while (v9 < 0x1::vector::length<0x2::object::ID>(v6)) {
                if (*0x1::vector::borrow<0x2::object::ID>(v6, v9) == v5) {
                    v10 = 0x1::option::some<u64>(v9);
                    /* label 6 */
                    if (0x1::option::is_none<u64>(&v10)) {
                        0x1::vector::push_back<0x2::object::ID>(v6, v5);
                        assert!(0x1::vector::length<0x2::object::ID>(v6) <= 0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::max_markets_in_vault<T0, T1>(arg0), 0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::errors::max_markets_exceeded());
                    };
                    /* label 10 */
                    return v3
                };
                v9 = v9 + 1;
            };
            v10 = 0x1::option::none<u64>();
            /* goto 6 */
        };
    }

    public(friend) fun place_stop_order_sltp<T0, T1>(arg0: &mut 0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::Vault<T0, T1>, arg1: 0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::clearing_house::ClearingHouse<T1>, arg2: &0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::price_feed_storage::PriceFeedStorage, arg3: &0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::price_feed_storage::PriceFeedStorage, arg4: &0x2::clock::Clock, arg5: 0x2::object::ID, arg6: &mut 0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::account::Account<T1>, arg7: 0x1::option::Option<u64>, arg8: bool, arg9: u8, arg10: 0x1::option::Option<u256>, arg11: 0x1::option::Option<u256>, arg12: bool, arg13: u64, arg14: u64, arg15: u64, arg16: vector<u8>, arg17: 0x1::option::Option<0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::account::IntegratorInfo>, arg18: &mut 0x2::tx_context::TxContext) : (0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::clearing_house::SessionSummary, 0x2::coin::Coin<0x2::sui::SUI>, 0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::clearing_house::ClearingHouse<T1>) {
        0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::assert_package_version<T0, T1>(arg0);
        0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::assert_vault_is_not_paused<T0, T1>(arg0, arg4);
        0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::assert_account_has_vault_authority<T0, T1>(arg0, arg6);
        let v0 = 0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::executor<T0, T1>(arg0, arg18);
        let v1 = 0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::account_cap<T0, T1>(arg0);
        let v2 = 0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::account::account_id<T1>(arg6);
        if (!0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::clearing_house::exists_position<T1>(&arg1, v2)) {
            0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::clearing_house::create_market_position<T1, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(&mut arg1, v1, arg6);
        };
        let (v3, v4, v5) = 0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::stop_orders::place_stop_order_sltp<T1>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, &v0, arg18);
        let v6 = v5;
        if (arg8) {
            assert_pending_orders_within_limit<T0, T1>(arg0, &v6, v2);
        };
        let v7 = &v6;
        let v8 = 0x2::object::id<0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::clearing_house::ClearingHouse<T1>>(v7);
        let v9 = 0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::ch_ids_mut<T0, T1>(arg0);
        if (0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::position_has_no_value<T1>(v7, v2)) {
            let v10 = 0;
            let v11;
            while (v10 < 0x1::vector::length<0x2::object::ID>(v9)) {
                if (*0x1::vector::borrow<0x2::object::ID>(v9, v10) == v8) {
                    v11 = 0x1::option::some<u64>(v10);
                    /* label 22 */
                    if (0x1::option::is_some<u64>(&v11)) {
                        0x1::vector::remove<0x2::object::ID>(v9, 0x1::option::destroy_some<u64>(v11));
                        /* goto 15 */
                    } else {
                        0x1::option::destroy_none<u64>(v11);
                        /* goto 15 */
                    };
                } else {
                    v10 = v10 + 1;
                };
            };
            v11 = 0x1::option::none<u64>();
            /* goto 22 */
        } else {
            let v12 = 0;
            let v13;
            while (v12 < 0x1::vector::length<0x2::object::ID>(v9)) {
                if (*0x1::vector::borrow<0x2::object::ID>(v9, v12) == v8) {
                    v13 = 0x1::option::some<u64>(v12);
                    /* label 11 */
                    if (0x1::option::is_none<u64>(&v13)) {
                        0x1::vector::push_back<0x2::object::ID>(v9, v8);
                        assert!(0x1::vector::length<0x2::object::ID>(v9) <= 0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::max_markets_in_vault<T0, T1>(arg0), 0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::errors::max_markets_exceeded());
                    };
                    /* label 15 */
                    return (v3, v4, v6)
                };
                v12 = v12 + 1;
            };
            v13 = 0x1::option::none<u64>();
            /* goto 11 */
        };
    }

    public(friend) fun place_stop_order_standalone<T0, T1>(arg0: &mut 0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::Vault<T0, T1>, arg1: 0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::clearing_house::ClearingHouse<T1>, arg2: &0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::price_feed_storage::PriceFeedStorage, arg3: &0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::price_feed_storage::PriceFeedStorage, arg4: &0x2::clock::Clock, arg5: 0x2::object::ID, arg6: &mut 0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::account::Account<T1>, arg7: 0x1::option::Option<u64>, arg8: bool, arg9: u8, arg10: u256, arg11: bool, arg12: bool, arg13: u64, arg14: u64, arg15: u64, arg16: bool, arg17: vector<u8>, arg18: 0x1::option::Option<0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::account::IntegratorInfo>, arg19: &mut 0x2::tx_context::TxContext) : (0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::clearing_house::SessionSummary, 0x2::coin::Coin<0x2::sui::SUI>, 0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::clearing_house::ClearingHouse<T1>) {
        0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::assert_package_version<T0, T1>(arg0);
        0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::assert_vault_is_not_paused<T0, T1>(arg0, arg4);
        0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::assert_account_has_vault_authority<T0, T1>(arg0, arg6);
        let v0 = 0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::executor<T0, T1>(arg0, arg19);
        let v1 = 0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::account_cap<T0, T1>(arg0);
        let v2 = 0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::account::account_id<T1>(arg6);
        if (!0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::clearing_house::exists_position<T1>(&arg1, v2)) {
            0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::clearing_house::create_market_position<T1, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(&mut arg1, v1, arg6);
        };
        let (v3, v4, v5) = 0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::stop_orders::place_stop_order_standalone<T1>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, &v0, arg19);
        let v6 = v5;
        if (arg8) {
            assert_pending_orders_within_limit<T0, T1>(arg0, &v6, v2);
        };
        let v7 = &v6;
        let v8 = 0x2::object::id<0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::clearing_house::ClearingHouse<T1>>(v7);
        let v9 = 0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::ch_ids_mut<T0, T1>(arg0);
        if (0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::position_has_no_value<T1>(v7, v2)) {
            let v10 = 0;
            let v11;
            while (v10 < 0x1::vector::length<0x2::object::ID>(v9)) {
                if (*0x1::vector::borrow<0x2::object::ID>(v9, v10) == v8) {
                    v11 = 0x1::option::some<u64>(v10);
                    /* label 22 */
                    if (0x1::option::is_some<u64>(&v11)) {
                        0x1::vector::remove<0x2::object::ID>(v9, 0x1::option::destroy_some<u64>(v11));
                        /* goto 15 */
                    } else {
                        0x1::option::destroy_none<u64>(v11);
                        /* goto 15 */
                    };
                } else {
                    v10 = v10 + 1;
                };
            };
            v11 = 0x1::option::none<u64>();
            /* goto 22 */
        } else {
            let v12 = 0;
            let v13;
            while (v12 < 0x1::vector::length<0x2::object::ID>(v9)) {
                if (*0x1::vector::borrow<0x2::object::ID>(v9, v12) == v8) {
                    v13 = 0x1::option::some<u64>(v12);
                    /* label 11 */
                    if (0x1::option::is_none<u64>(&v13)) {
                        0x1::vector::push_back<0x2::object::ID>(v9, v8);
                        assert!(0x1::vector::length<0x2::object::ID>(v9) <= 0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::max_markets_in_vault<T0, T1>(arg0), 0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::errors::max_markets_exceeded());
                    };
                    /* label 15 */
                    return (v3, v4, v6)
                };
                v12 = v12 + 1;
            };
            v13 = 0x1::option::none<u64>();
            /* goto 11 */
        };
    }

    public(friend) fun reconcile_clearing_house<T0, T1>(arg0: &mut 0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::Vault<T0, T1>, arg1: &0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::account::Account<T1>, arg2: &0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::clearing_house::ClearingHouse<T1>) {
        0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::assert_package_version<T0, T1>(arg0);
        0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::assert_vault_is_not_admin_paused<T0, T1>(arg0);
        0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::assert_account_has_vault_authority<T0, T1>(arg0, arg1);
        let v0 = 0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::account::account_id<T1>(arg1);
        if (0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::clearing_house::exists_position<T1>(arg2, v0)) {
            let v1 = 0x2::object::id<0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::clearing_house::ClearingHouse<T1>>(arg2);
            let v2 = 0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::ch_ids_mut<T0, T1>(arg0);
            if (0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::position_has_no_value<T1>(arg2, v0)) {
                let v3 = 0;
                let v4;
                while (v3 < 0x1::vector::length<0x2::object::ID>(v2)) {
                    if (*0x1::vector::borrow<0x2::object::ID>(v2, v3) == v1) {
                        v4 = 0x1::option::some<u64>(v3);
                        /* label 18 */
                        if (0x1::option::is_some<u64>(&v4)) {
                            0x1::vector::remove<0x2::object::ID>(v2, 0x1::option::destroy_some<u64>(v4));
                            return
                        } else {
                            0x1::option::destroy_none<u64>(v4);
                            return
                        };
                    } else {
                        v3 = v3 + 1;
                    };
                };
                v4 = 0x1::option::none<u64>();
                /* goto 18 */
            } else {
                let v5 = 0;
                let v6;
                while (v5 < 0x1::vector::length<0x2::object::ID>(v2)) {
                    if (*0x1::vector::borrow<0x2::object::ID>(v2, v5) == v1) {
                        v6 = 0x1::option::some<u64>(v5);
                        /* label 7 */
                        if (0x1::option::is_none<u64>(&v6)) {
                            0x1::vector::push_back<0x2::object::ID>(v2, v1);
                            assert!(0x1::vector::length<0x2::object::ID>(v2) <= 0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::max_markets_in_vault<T0, T1>(arg0), 0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::errors::max_markets_exceeded());
                        };
                        return
                    };
                    v5 = v5 + 1;
                };
                v6 = 0x1::option::none<u64>();
                /* goto 7 */
            };
        } else {
            let v7 = 0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::ch_ids_mut<T0, T1>(arg0);
            let v8 = 0;
            let v9;
            while (v8 < 0x1::vector::length<0x2::object::ID>(v7)) {
                if (*0x1::vector::borrow<0x2::object::ID>(v7, v8) == 0x2::object::id<0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::clearing_house::ClearingHouse<T1>>(arg2)) {
                    v9 = 0x1::option::some<u64>(v8);
                    /* label 28 */
                    if (0x1::option::is_some<u64>(&v9)) {
                        0x1::vector::remove<0x2::object::ID>(v7, 0x1::option::destroy_some<u64>(v9));
                        return
                    } else {
                        0x1::option::destroy_none<u64>(v9);
                        return
                    };
                } else {
                    v8 = v8 + 1;
                };
            };
            v9 = 0x1::option::none<u64>();
            /* goto 28 */
        };
    }

    public(friend) fun remove_empty_clearing_house<T0, T1>(arg0: &mut 0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::Vault<T0, T1>, arg1: &0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::account::Account<T1>, arg2: &0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::clearing_house::ClearingHouse<T1>) {
        0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::assert_package_version<T0, T1>(arg0);
        0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::assert_vault_is_not_admin_paused<T0, T1>(arg0);
        0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::assert_account_has_vault_authority<T0, T1>(arg0, arg1);
        let v0 = 0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::account::account_id<T1>(arg1);
        assert!(!0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::clearing_house::exists_position<T1>(arg2, v0) || 0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::position_has_no_value<T1>(arg2, v0), 0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::errors::clearing_house_not_empty());
        0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::remove_ch_id<T0, T1>(arg0, 0x2::object::id<0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::clearing_house::ClearingHouse<T1>>(arg2));
    }

    public(friend) fun set_position_initial_margin_ratio<T0, T1>(arg0: &0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::Vault<T0, T1>, arg1: &0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::account::Account<T1>, arg2: &mut 0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::clearing_house::ClearingHouse<T1>, arg3: u256) {
        0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::assert_package_version<T0, T1>(arg0);
        0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::assert_vault_is_not_admin_paused<T0, T1>(arg0);
        0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::clearing_house::set_position_initial_margin_ratio<T1, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(arg2, 0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::account_cap<T0, T1>(arg0), arg1, arg3);
    }

    fun share_clearing_house<T0>(arg0: 0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::clearing_house::ClearingHouse<T0>) {
        0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::clearing_house::share<T0>(arg0);
    }

    public(friend) fun start_perpetuals_session<T0, T1>(arg0: &0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::Vault<T0, T1>, arg1: &mut 0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::account::Account<T1>, arg2: 0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::clearing_house::ClearingHouse<T1>, arg3: &0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::price_feed_storage::PriceFeedStorage, arg4: &0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::price_feed_storage::PriceFeedStorage, arg5: 0x1::option::Option<0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::account::IntegratorInfo>, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) : 0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::clearing_house::SessionHotPotato<T1> {
        0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::assert_package_version<T0, T1>(arg0);
        0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::assert_vault_is_not_paused<T0, T1>(arg0, arg6);
        0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::clearing_house::start_session<T1, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(arg2, 0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::account_cap<T0, T1>(arg0), arg1, arg3, arg4, arg5, arg6, arg7)
    }

    public(friend) fun try_cancel_orders<T0, T1>(arg0: &mut 0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::Vault<T0, T1>, arg1: &0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::account::Account<T1>, arg2: &mut 0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::clearing_house::ClearingHouse<T1>, arg3: &vector<u128>, arg4: &0x2::clock::Clock) : vector<bool> {
        0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::assert_package_version<T0, T1>(arg0);
        0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::assert_vault_is_not_paused<T0, T1>(arg0, arg4);
        let v0 = 0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::clearing_house::try_cancel_orders<T1, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(arg2, 0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::account_cap<T0, T1>(arg0), arg1, arg3);
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
            let v5 = 0x2::object::id<0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::clearing_house::ClearingHouse<T1>>(v4);
            let v6 = 0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::ch_ids_mut<T0, T1>(arg0);
            if (0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::position_has_no_value<T1>(v4, 0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::account::account_id<T1>(arg1))) {
                /* goto 21 */
            } else {
                let v7 = 0;
                /* label 11 */
                while (v7 < 0x1::vector::length<0x2::object::ID>(v6)) {
                    if (*0x1::vector::borrow<0x2::object::ID>(v6, v7) == v5) {
                        /* label 14 */
                        let v8 = 0x1::option::some<u64>(v7);
                        if (0x1::option::is_none<u64>(&v8)) {
                            0x1::vector::push_back<0x2::object::ID>(v6, v5);
                            assert!(0x1::vector::length<0x2::object::ID>(v6) <= 0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::max_markets_in_vault<T0, T1>(arg0), 0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::errors::max_markets_exceeded());
                            /* goto 18 */
                        } else {
                            /* goto 18 */
                        };
                    } else {
                        /* goto 19 */
                    };
                };
            };
        };
        /* label 18 */
        return v0
        /* label 19 */
        /* goto 11 */
        continue;
        /* goto 14 */
        /* label 21 */
        let v9 = 0;
        let v10;
        while (v9 < 0x1::vector::length<0x2::object::ID>(((/*raw:*//*undefined:49*/undefined)))) {
            if (*0x1::vector::borrow<0x2::object::ID>(((/*raw:*//*undefined:49*/undefined)), v9) == ((/*raw:*//*undefined:48*/undefined))) {
                v10 = 0x1::option::some<u64>(v9);
                /* label 25 */
                if (0x1::option::is_some<u64>(&v10)) {
                    0x1::vector::remove<0x2::object::ID>(((/*raw:*//*undefined:49*/undefined)), 0x1::option::destroy_some<u64>(v10));
                    /* goto 18 */
                } else {
                    0x1::option::destroy_none<u64>(v10);
                    /* goto 18 */
                };
            } else {
                v9 = v9 + 1;
            };
        };
        v10 = 0x1::option::none<u64>();
        /* goto 25 */
    }

    public(friend) fun user_cancel_twap_order<T0, T1>(arg0: &mut 0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::Vault<T0, T1>, arg1: &mut 0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::account::Account<T1>, arg2: &mut 0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::clearing_house::ClearingHouse<T1>, arg3: &0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::price_feed_storage::PriceFeedStorage, arg4: &0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::price_feed_storage::PriceFeedStorage, arg5: &0x2::clock::Clock, arg6: 0x2::object::ID, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::assert_package_version<T0, T1>(arg0);
        0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::assert_vault_is_not_paused<T0, T1>(arg0, arg5);
        0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::assert_account_has_vault_authority<T0, T1>(arg0, arg1);
        let v0 = 0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::account::account_id<T1>(arg1);
        if (0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::clearing_house::exists_position<T1>(arg2, v0)) {
            let v1 = arg2;
            let v2 = 0x2::object::id<0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::clearing_house::ClearingHouse<T1>>(v1);
            let v3 = 0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::ch_ids_mut<T0, T1>(arg0);
            if (0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::position_has_no_value<T1>(v1, v0)) {
                /* goto 15 */
            } else {
                let v4 = 0;
                /* label 5 */
                while (v4 < 0x1::vector::length<0x2::object::ID>(v3)) {
                    if (*0x1::vector::borrow<0x2::object::ID>(v3, v4) == v2) {
                        /* label 8 */
                        let v5 = 0x1::option::some<u64>(v4);
                        if (0x1::option::is_none<u64>(&v5)) {
                            0x1::vector::push_back<0x2::object::ID>(v3, v2);
                            assert!(0x1::vector::length<0x2::object::ID>(v3) <= 0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::max_markets_in_vault<T0, T1>(arg0), 0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::errors::max_markets_exceeded());
                            /* goto 12 */
                        } else {
                            return 0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::twap_orders::user_cancel_twap_order<T1, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(arg1, 0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::account_cap<T0, T1>(arg0), arg2, arg3, arg4, arg6, arg5, arg7)
                        };
                    } else {
                        /* goto 13 */
                    };
                };
            };
        };
        /* label 12 */
        return 0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::twap_orders::user_cancel_twap_order<T1, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(arg1, 0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::account_cap<T0, T1>(arg0), arg2, arg3, arg4, arg6, arg5, arg7)
        /* label 13 */
        /* goto 5 */
        continue;
        /* goto 8 */
        /* label 15 */
        let v6 = 0;
        let v7;
        while (v6 < 0x1::vector::length<0x2::object::ID>(((/*raw:*//*undefined:44*/undefined)))) {
            if (*0x1::vector::borrow<0x2::object::ID>(((/*raw:*//*undefined:44*/undefined)), v6) == ((/*raw:*//*undefined:43*/undefined))) {
                v7 = 0x1::option::some<u64>(v6);
                /* label 19 */
                if (0x1::option::is_some<u64>(&v7)) {
                    0x1::vector::remove<0x2::object::ID>(((/*raw:*//*undefined:44*/undefined)), 0x1::option::destroy_some<u64>(v7));
                    return 0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::twap_orders::user_cancel_twap_order<T1, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(arg1, 0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::account_cap<T0, T1>(arg0), arg2, arg3, arg4, arg6, arg5, arg7)
                } else {
                    0x1::option::destroy_none<u64>(v7);
                    return 0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::twap_orders::user_cancel_twap_order<T1, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(arg1, 0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::account_cap<T0, T1>(arg0), arg2, arg3, arg4, arg6, arg5, arg7)
                };
            } else {
                v6 = v6 + 1;
            };
        };
        v7 = 0x1::option::none<u64>();
        /* goto 19 */
    }

    public(friend) fun user_delete_stop_order_ticket<T0, T1>(arg0: &0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::Vault<T0, T1>, arg1: &mut 0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::account::Account<T1>, arg2: &0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::registry::Registry, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::assert_package_version<T0, T1>(arg0);
        0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::assert_vault_is_not_admin_paused<T0, T1>(arg0);
        0xec99b3d848d0eb8376f1283b89bac5d1c7d14daea93c25f1a11cd40f007f9277::stop_orders::cancel<T1, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(arg1, 0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::vault::account_cap<T0, T1>(arg0), arg2, arg3, arg4)
    }

    // decompiled from Move bytecode v7
}

