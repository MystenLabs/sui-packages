module 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::perpetuals_api {
    struct VaultsSessionHotPotato {
        vault_id: 0x2::object::ID,
    }

    public(friend) fun allocate_collateral_to_position<T0, T1>(arg0: &mut 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::vault::Vault<T0, T1>, arg1: &mut 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::Account<T1>, arg2: &mut 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::clearing_house::ClearingHouse<T1>, arg3: &0x2::clock::Clock, arg4: u64) {
        assert!(0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::vault::version<T0, T1>(arg0) == 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::constants::version(), 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::errors::invalid_version());
        0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::vault::assert_vault_is_not_paused<T0, T1>(arg0, arg3);
        assert!(arg4 <= 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::get_collateral_value<T1>(arg1), 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::errors::not_enough_collateral_balance());
        0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::interface::allocate_collateral<T1, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::ADMIN>(arg2, 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::vault::account_cap<T0, T1>(arg0), arg1, arg4);
        let v0 = arg2;
        let v1 = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::clearing_house::get_position<T1>(v0, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::get_cap_account_id<0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::ADMIN>(0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::vault::account_cap<T0, T1>(arg0)));
        let (v2, _) = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::get_amounts(v1);
        let v4 = if (0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::to_balance(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::abs(0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::get_collateral(v1)), 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::market::get_scaling_factor(0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::clearing_house::get_market_params<T1>(v0))) == 0) {
            if (v2 == 0) {
                0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::get_pending_orders_counter(v1) == 0
            } else {
                false
            }
        } else {
            false
        };
        let v5 = 0x2::object::id<0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::clearing_house::ClearingHouse<T1>>(v0);
        let v6 = 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::vault::ch_ids_mut<T0, T1>(arg0);
        if (v4) {
            let v7 = 0;
            let v8;
            while (v7 < 0x1::vector::length<0x2::object::ID>(v6)) {
                if (*0x1::vector::borrow<0x2::object::ID>(v6, v7) == v5) {
                    v8 = 0x1::option::some<u64>(v7);
                    /* label 18 */
                    if (0x1::option::is_some<u64>(&v8)) {
                        0x1::vector::remove<0x2::object::ID>(v6, 0x1::option::destroy_some<u64>(v8));
                    } else {
                        0x1::option::destroy_none<u64>(v8);
                    };
                    /* label 22 */
                    return
                };
                v7 = v7 + 1;
            };
            v8 = 0x1::option::none<u64>();
            /* goto 18 */
        } else {
            let v9 = 0;
            let v10;
            while (v9 < 0x1::vector::length<0x2::object::ID>(v6)) {
                if (*0x1::vector::borrow<0x2::object::ID>(v6, v9) == v5) {
                    v10 = 0x1::option::some<u64>(v9);
                    /* label 29 */
                    if (0x1::option::is_none<u64>(&v10)) {
                        0x1::vector::push_back<0x2::object::ID>(v6, v5);
                        assert!(0x1::vector::length<0x2::object::ID>(v6) != 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::vault::max_markets_in_vault<T0, T1>(arg0), 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::errors::max_markets_exceeded());
                        /* goto 22 */
                    } else {
                        return
                    };
                } else {
                    v9 = v9 + 1;
                };
            };
            v10 = 0x1::option::none<u64>();
            /* goto 29 */
        };
    }

    public(friend) fun cancel_orders<T0, T1>(arg0: &0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::vault::Vault<T0, T1>, arg1: &0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::Account<T1>, arg2: &mut 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::clearing_house::ClearingHouse<T1>, arg3: &0x2::clock::Clock, arg4: &vector<u128>) {
        assert!(0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::vault::version<T0, T1>(arg0) == 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::constants::version(), 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::errors::invalid_version());
        0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::vault::assert_vault_is_not_paused<T0, T1>(arg0, arg3);
        0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::interface::cancel_orders<T1, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::ADMIN>(arg2, 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::vault::account_cap<T0, T1>(arg0), arg1, arg4);
    }

    public(friend) fun create_market_position<T0, T1>(arg0: &0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::vault::Vault<T0, T1>, arg1: &0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::Account<T1>, arg2: &mut 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::clearing_house::ClearingHouse<T1>) {
        assert!(0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::vault::version<T0, T1>(arg0) == 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::constants::version(), 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::errors::invalid_version());
        let v0 = 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::vault::account_cap<T0, T1>(arg0);
        if (!0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::clearing_house::exists_position<T1>(arg2, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::get_cap_account_id<0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::ADMIN>(v0))) {
            0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::interface::create_market_position<T1, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::ADMIN>(arg2, v0, arg1);
        };
    }

    public(friend) fun create_stop_order_ticket<T0, T1>(arg0: &mut 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::vault::Vault<T0, T1>, arg1: &0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::Account<T1>, arg2: &0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::registry::Registry, arg3: vector<address>, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: u64, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::vault::version<T0, T1>(arg0) == 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::constants::version(), 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::errors::invalid_version());
        let v0 = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::interface::create_stop_order_ticket<T1, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::ADMIN>(0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::vault::account_cap<T0, T1>(arg0), arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::vault::add_stop_order_ticket_dof<T0, T1>(arg0, v0);
        0x2::object::id<0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::stop_orders::StopOrderTicket<T1>>(&v0)
    }

    public(friend) fun deallocate_collateral_from_position<T0, T1>(arg0: &mut 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::vault::Vault<T0, T1>, arg1: &mut 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::Account<T1>, arg2: &mut 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::clearing_house::ClearingHouse<T1>, arg3: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage, arg4: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage, arg5: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::config::Config, arg6: &0x2::clock::Clock, arg7: 0x1::option::Option<u64>) {
        assert!(0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::vault::version<T0, T1>(arg0) == 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::constants::version(), 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::errors::invalid_version());
        0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::vault::assert_vault_is_not_paused<T0, T1>(arg0, arg6);
        if (0x1::option::is_some<u64>(&arg7)) {
            0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::interface::deallocate_collateral<T1, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::ADMIN>(arg2, 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::vault::account_cap<T0, T1>(arg0), arg1, arg3, arg4, arg5, arg6, 0x1::option::destroy_some<u64>(arg7));
        } else {
            0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::interface::deallocate_free_collateral<T1, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::ADMIN>(arg2, 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::vault::account_cap<T0, T1>(arg0), arg1, arg3, arg4, arg5, arg6);
        };
        let v0 = arg2;
        let v1 = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::clearing_house::get_position<T1>(v0, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::get_cap_account_id<0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::ADMIN>(0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::vault::account_cap<T0, T1>(arg0)));
        let (v2, _) = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::get_amounts(v1);
        let v4 = if (0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::to_balance(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::abs(0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::get_collateral(v1)), 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::market::get_scaling_factor(0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::clearing_house::get_market_params<T1>(v0))) == 0) {
            if (v2 == 0) {
                0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::get_pending_orders_counter(v1) == 0
            } else {
                false
            }
        } else {
            false
        };
        let v5 = 0x2::object::id<0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::clearing_house::ClearingHouse<T1>>(v0);
        let v6 = 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::vault::ch_ids_mut<T0, T1>(arg0);
        if (v4) {
            let v7 = 0;
            let v8;
            while (v7 < 0x1::vector::length<0x2::object::ID>(v6)) {
                if (*0x1::vector::borrow<0x2::object::ID>(v6, v7) == v5) {
                    v8 = 0x1::option::some<u64>(v7);
                    /* label 19 */
                    if (0x1::option::is_some<u64>(&v8)) {
                        0x1::vector::remove<0x2::object::ID>(v6, 0x1::option::destroy_some<u64>(v8));
                    } else {
                        0x1::option::destroy_none<u64>(v8);
                    };
                    /* label 23 */
                    return
                };
                v7 = v7 + 1;
            };
            v8 = 0x1::option::none<u64>();
            /* goto 19 */
        } else {
            let v9 = 0;
            let v10;
            while (v9 < 0x1::vector::length<0x2::object::ID>(v6)) {
                if (*0x1::vector::borrow<0x2::object::ID>(v6, v9) == v5) {
                    v10 = 0x1::option::some<u64>(v9);
                    /* label 30 */
                    if (0x1::option::is_none<u64>(&v10)) {
                        0x1::vector::push_back<0x2::object::ID>(v6, v5);
                        assert!(0x1::vector::length<0x2::object::ID>(v6) != 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::vault::max_markets_in_vault<T0, T1>(arg0), 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::errors::max_markets_exceeded());
                        /* goto 23 */
                    } else {
                        return
                    };
                } else {
                    v9 = v9 + 1;
                };
            };
            v10 = 0x1::option::none<u64>();
            /* goto 30 */
        };
    }

    public(friend) fun delete_stop_order_ticket<T0, T1>(arg0: &mut 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::vault::Vault<T0, T1>, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::vault::version<T0, T1>(arg0) == 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::constants::version(), 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::errors::invalid_version());
        0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::interface::delete_stop_order_ticket<T1>(0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::vault::remove_stop_order_ticket_dof<T0, T1>(arg0, arg1), arg2)
    }

    public(friend) fun edit_stop_order_ticket_details<T0, T1>(arg0: &mut 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::vault::Vault<T0, T1>, arg1: &0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::Account<T1>, arg2: 0x2::object::ID, arg3: vector<u8>) {
        assert!(0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::vault::version<T0, T1>(arg0) == 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::constants::version(), 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::errors::invalid_version());
        let v0 = 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::vault::remove_stop_order_ticket_dof<T0, T1>(arg0, arg2);
        0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::interface::edit_stop_order_ticket_details<T1, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::ADMIN>(0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::vault::account_cap<T0, T1>(arg0), arg1, &mut v0, arg3);
        0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::vault::add_stop_order_ticket_dof<T0, T1>(arg0, v0);
    }

    public(friend) fun edit_stop_order_ticket_executors<T0, T1>(arg0: &mut 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::vault::Vault<T0, T1>, arg1: &0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::Account<T1>, arg2: 0x2::object::ID, arg3: vector<address>) {
        assert!(0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::vault::version<T0, T1>(arg0) == 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::constants::version(), 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::errors::invalid_version());
        let v0 = 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::vault::remove_stop_order_ticket_dof<T0, T1>(arg0, arg2);
        0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::interface::edit_stop_order_ticket_executors<T1, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::ADMIN>(0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::vault::account_cap<T0, T1>(arg0), arg1, &mut v0, arg3);
        0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::vault::add_stop_order_ticket_dof<T0, T1>(arg0, v0);
    }

    public(friend) fun end_perpetuals_session<T0, T1>(arg0: &mut 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::vault::Vault<T0, T1>, arg1: &mut 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::Account<T1>, arg2: 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::clearing_house::SessionHotPotato<T1>, arg3: VaultsSessionHotPotato, arg4: bool) : 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::clearing_house::ClearingHouse<T1> {
        assert!(0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::vault::version<T0, T1>(arg0) == 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::constants::version(), 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::errors::invalid_version());
        assert!(0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::get_cap_account_id<0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::ADMIN>(0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::vault::account_cap<T0, T1>(arg0)) == 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::clearing_house::get_account_id_in_session<T1>(&arg2), 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::errors::wrong_vault_for_session());
        let VaultsSessionHotPotato { vault_id: v0 } = arg3;
        assert!(0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::vault::id<T0, T1>(arg0) == v0, 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::errors::wrong_vault_for_session());
        let (v1, _) = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::interface::end_session<T1>(arg2, arg1, arg4, 0x1::option::none<0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::clearing_house::IntegratorInfo>());
        let v3 = v1;
        let v4 = &v3;
        let v5 = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::clearing_house::get_position<T1>(v4, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::get_cap_account_id<0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::ADMIN>(0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::vault::account_cap<T0, T1>(arg0)));
        let (v6, _) = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::get_amounts(v5);
        let v8 = if (0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::to_balance(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::abs(0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::get_collateral(v5)), 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::market::get_scaling_factor(0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::clearing_house::get_market_params<T1>(v4))) == 0) {
            if (v6 == 0) {
                0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::get_pending_orders_counter(v5) == 0
            } else {
                false
            }
        } else {
            false
        };
        let v9 = 0x2::object::id<0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::clearing_house::ClearingHouse<T1>>(v4);
        let v10 = 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::vault::ch_ids_mut<T0, T1>(arg0);
        if (v8) {
            let v11 = 0;
            let v12;
            while (v11 < 0x1::vector::length<0x2::object::ID>(v10)) {
                if (*0x1::vector::borrow<0x2::object::ID>(v10, v11) == v9) {
                    v12 = 0x1::option::some<u64>(v11);
                    /* label 31 */
                    if (0x1::option::is_some<u64>(&v12)) {
                        0x1::vector::remove<0x2::object::ID>(v10, 0x1::option::destroy_some<u64>(v12));
                        /* goto 24 */
                    } else {
                        0x1::option::destroy_none<u64>(v12);
                        /* goto 24 */
                    };
                } else {
                    v11 = v11 + 1;
                };
            };
            v12 = 0x1::option::none<u64>();
            /* goto 31 */
        } else {
            let v13 = 0;
            let v14;
            while (v13 < 0x1::vector::length<0x2::object::ID>(v10)) {
                if (*0x1::vector::borrow<0x2::object::ID>(v10, v13) == v9) {
                    v14 = 0x1::option::some<u64>(v13);
                    /* label 20 */
                    if (0x1::option::is_none<u64>(&v14)) {
                        0x1::vector::push_back<0x2::object::ID>(v10, v9);
                        assert!(0x1::vector::length<0x2::object::ID>(v10) != 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::vault::max_markets_in_vault<T0, T1>(arg0), 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::errors::max_markets_exceeded());
                    };
                    /* label 24 */
                    return v3
                };
                v13 = v13 + 1;
            };
            v14 = 0x1::option::none<u64>();
            /* goto 20 */
        };
    }

    public(friend) fun liquidate<T0, T1>(arg0: &0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::vault::Vault<T0, T1>, arg1: &mut 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::Account<T1>, arg2: 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::clearing_house::ClearingHouse<T1>, arg3: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage, arg4: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage, arg5: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::config::Config, arg6: &0x2::clock::Clock, arg7: u64, arg8: &vector<u128>, arg9: &0x2::tx_context::TxContext) {
        assert!(0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::vault::version<T0, T1>(arg0) == 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::constants::version(), 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::errors::invalid_version());
        0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::vault::assert_vault_is_not_paused<T0, T1>(arg0, arg6);
        let v0 = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::interface::start_session<T1, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::ADMIN>(arg2, 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::vault::account_cap<T0, T1>(arg0), arg1, arg3, arg4, arg5, arg6, arg9);
        0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::interface::liquidate<T1>(&mut v0, arg7, arg8);
        let (v1, _) = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::interface::end_session<T1>(v0, arg1, false, 0x1::option::none<0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::clearing_house::IntegratorInfo>());
        0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::interface::share_clearing_house<T1>(v1);
    }

    public(friend) fun liquidate_session<T0, T1>(arg0: &0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::vault::Vault<T0, T1>, arg1: &mut 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::clearing_house::SessionHotPotato<T1>, arg2: u64, arg3: &vector<u128>) {
        assert!(0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::vault::version<T0, T1>(arg0) == 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::constants::version(), 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::errors::invalid_version());
        assert!(0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::get_cap_account_id<0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::ADMIN>(0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::vault::account_cap<T0, T1>(arg0)) == 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::clearing_house::get_account_id_in_session<T1>(arg1), 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::errors::wrong_vault_for_session());
        0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::interface::liquidate<T1>(arg1, arg2, arg3);
    }

    public(friend) fun place_limit_order<T0, T1>(arg0: &0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::vault::Vault<T0, T1>, arg1: &mut 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::Account<T1>, arg2: 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::clearing_house::ClearingHouse<T1>, arg3: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage, arg4: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage, arg5: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::config::Config, arg6: &0x2::clock::Clock, arg7: bool, arg8: u64, arg9: u64, arg10: u64, arg11: bool, arg12: 0x1::option::Option<u64>, arg13: &0x2::tx_context::TxContext) : 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::clearing_house::ClearingHouse<T1> {
        assert!(0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::vault::version<T0, T1>(arg0) == 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::constants::version(), 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::errors::invalid_version());
        0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::vault::assert_vault_is_not_paused<T0, T1>(arg0, arg6);
        assert!(0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::get_pending_orders_counter(0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::clearing_house::get_position<T1>(&arg2, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::get_cap_account_id<0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::ADMIN>(0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::vault::account_cap<T0, T1>(arg0)))) < 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::vault::max_pending_orders_per_position<T0, T1>(arg0), 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::errors::max_pending_orders_exceeded());
        let v0 = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::interface::start_session<T1, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::ADMIN>(arg2, 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::vault::account_cap<T0, T1>(arg0), arg1, arg3, arg4, arg5, arg6, arg13);
        0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::interface::place_limit_order<T1>(&mut v0, arg7, arg8, arg9, arg10, arg11, arg12);
        let (v1, _) = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::interface::end_session<T1>(v0, arg1, false, 0x1::option::none<0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::clearing_house::IntegratorInfo>());
        v1
    }

    public(friend) fun place_limit_order_session<T0, T1>(arg0: &0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::vault::Vault<T0, T1>, arg1: &mut 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::clearing_house::SessionHotPotato<T1>, arg2: bool, arg3: u64, arg4: u64, arg5: u64, arg6: bool, arg7: 0x1::option::Option<u64>) {
        assert!(0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::vault::version<T0, T1>(arg0) == 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::constants::version(), 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::errors::invalid_version());
        assert!(0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::get_cap_account_id<0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::ADMIN>(0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::vault::account_cap<T0, T1>(arg0)) == 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::clearing_house::get_account_id_in_session<T1>(arg1), 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::errors::wrong_vault_for_session());
        0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::interface::place_limit_order<T1>(arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public(friend) fun place_market_order<T0, T1>(arg0: &0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::vault::Vault<T0, T1>, arg1: &mut 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::Account<T1>, arg2: 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::clearing_house::ClearingHouse<T1>, arg3: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage, arg4: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage, arg5: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::config::Config, arg6: &0x2::clock::Clock, arg7: bool, arg8: u64, arg9: bool, arg10: &0x2::tx_context::TxContext) : 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::clearing_house::ClearingHouse<T1> {
        assert!(0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::vault::version<T0, T1>(arg0) == 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::constants::version(), 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::errors::invalid_version());
        0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::vault::assert_vault_is_not_paused<T0, T1>(arg0, arg6);
        let v0 = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::interface::start_session<T1, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::ADMIN>(arg2, 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::vault::account_cap<T0, T1>(arg0), arg1, arg3, arg4, arg5, arg6, arg10);
        0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::interface::place_market_order<T1>(&mut v0, arg7, arg8, arg9);
        let (v1, _) = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::interface::end_session<T1>(v0, arg1, false, 0x1::option::none<0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::clearing_house::IntegratorInfo>());
        v1
    }

    public(friend) fun place_market_order_session<T0, T1>(arg0: &0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::vault::Vault<T0, T1>, arg1: &mut 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::clearing_house::SessionHotPotato<T1>, arg2: bool, arg3: u64, arg4: bool) {
        assert!(0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::vault::version<T0, T1>(arg0) == 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::constants::version(), 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::errors::invalid_version());
        assert!(0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::get_cap_account_id<0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::ADMIN>(0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::vault::account_cap<T0, T1>(arg0)) == 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::clearing_house::get_account_id_in_session<T1>(arg1), 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::errors::wrong_vault_for_session());
        0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::interface::place_market_order<T1>(arg1, arg2, arg3, arg4);
    }

    public(friend) fun place_stop_order_sltp<T0, T1>(arg0: &mut 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::vault::Vault<T0, T1>, arg1: 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::clearing_house::ClearingHouse<T1>, arg2: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage, arg3: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage, arg4: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::config::Config, arg5: &0x2::clock::Clock, arg6: 0x2::object::ID, arg7: &mut 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::Account<T1>, arg8: 0x1::option::Option<u64>, arg9: bool, arg10: 0x1::option::Option<u256>, arg11: 0x1::option::Option<u256>, arg12: bool, arg13: u64, arg14: u64, arg15: u64, arg16: vector<u8>, arg17: 0x1::option::Option<0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::clearing_house::IntegratorInfo>, arg18: &mut 0x2::tx_context::TxContext) : (0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::clearing_house::SessionSummary, 0x2::coin::Coin<0x2::sui::SUI>, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::clearing_house::ClearingHouse<T1>) {
        assert!(0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::vault::version<T0, T1>(arg0) == 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::constants::version(), 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::errors::invalid_version());
        0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::vault::assert_vault_is_not_paused<T0, T1>(arg0, arg5);
        let v0 = 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::vault::account_cap<T0, T1>(arg0);
        if (!0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::clearing_house::exists_position<T1>(&arg1, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::get_cap_account_id<0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::ADMIN>(v0))) {
            0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::interface::create_market_position<T1, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::ADMIN>(&mut arg1, v0, arg7);
        };
        let (v1, v2, v3) = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::interface::place_stop_order_sltp<T1>(arg1, arg2, arg3, arg4, arg5, 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::vault::remove_stop_order_ticket_dof<T0, T1>(arg0, arg6), arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18);
        let v4 = v3;
        let v5 = &v4;
        let v6 = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::clearing_house::get_position<T1>(v5, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::get_cap_account_id<0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::ADMIN>(0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::vault::account_cap<T0, T1>(arg0)));
        let (v7, _) = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::get_amounts(v6);
        let v9 = if (0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::to_balance(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::abs(0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::get_collateral(v6)), 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::market::get_scaling_factor(0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::clearing_house::get_market_params<T1>(v5))) == 0) {
            if (v7 == 0) {
                0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::get_pending_orders_counter(v6) == 0
            } else {
                false
            }
        } else {
            false
        };
        let v10 = 0x2::object::id<0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::clearing_house::ClearingHouse<T1>>(v5);
        let v11 = 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::vault::ch_ids_mut<T0, T1>(arg0);
        if (v9) {
            let v12 = 0;
            let v13;
            while (v12 < 0x1::vector::length<0x2::object::ID>(v11)) {
                if (*0x1::vector::borrow<0x2::object::ID>(v11, v12) == v10) {
                    v13 = 0x1::option::some<u64>(v12);
                    /* label 29 */
                    if (0x1::option::is_some<u64>(&v13)) {
                        0x1::vector::remove<0x2::object::ID>(v11, 0x1::option::destroy_some<u64>(v13));
                        /* goto 22 */
                    } else {
                        0x1::option::destroy_none<u64>(v13);
                        /* goto 22 */
                    };
                } else {
                    v12 = v12 + 1;
                };
            };
            v13 = 0x1::option::none<u64>();
            /* goto 29 */
        } else {
            let v14 = 0;
            let v15;
            while (v14 < 0x1::vector::length<0x2::object::ID>(v11)) {
                if (*0x1::vector::borrow<0x2::object::ID>(v11, v14) == v10) {
                    v15 = 0x1::option::some<u64>(v14);
                    /* label 18 */
                    if (0x1::option::is_none<u64>(&v15)) {
                        0x1::vector::push_back<0x2::object::ID>(v11, v10);
                        assert!(0x1::vector::length<0x2::object::ID>(v11) != 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::vault::max_markets_in_vault<T0, T1>(arg0), 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::errors::max_markets_exceeded());
                    };
                    /* label 22 */
                    return (v1, v2, v4)
                };
                v14 = v14 + 1;
            };
            v15 = 0x1::option::none<u64>();
            /* goto 18 */
        };
    }

    public(friend) fun place_stop_order_standalone<T0, T1>(arg0: &mut 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::vault::Vault<T0, T1>, arg1: 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::clearing_house::ClearingHouse<T1>, arg2: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage, arg3: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage, arg4: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::config::Config, arg5: &0x2::clock::Clock, arg6: 0x2::object::ID, arg7: &mut 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::Account<T1>, arg8: 0x1::option::Option<u64>, arg9: bool, arg10: u256, arg11: bool, arg12: bool, arg13: u64, arg14: u64, arg15: u64, arg16: bool, arg17: vector<u8>, arg18: 0x1::option::Option<0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::clearing_house::IntegratorInfo>, arg19: &mut 0x2::tx_context::TxContext) : (0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::clearing_house::SessionSummary, 0x2::coin::Coin<0x2::sui::SUI>, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::clearing_house::ClearingHouse<T1>) {
        assert!(0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::vault::version<T0, T1>(arg0) == 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::constants::version(), 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::errors::invalid_version());
        0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::vault::assert_vault_is_not_paused<T0, T1>(arg0, arg5);
        let v0 = 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::vault::account_cap<T0, T1>(arg0);
        if (!0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::clearing_house::exists_position<T1>(&arg1, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::get_cap_account_id<0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::ADMIN>(v0))) {
            0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::interface::create_market_position<T1, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::ADMIN>(&mut arg1, v0, arg7);
        };
        let (v1, v2, v3) = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::interface::place_stop_order_standalone<T1>(arg1, arg2, arg3, arg4, arg5, 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::vault::remove_stop_order_ticket_dof<T0, T1>(arg0, arg6), arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19);
        let v4 = v3;
        let v5 = &v4;
        let v6 = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::clearing_house::get_position<T1>(v5, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::get_cap_account_id<0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::ADMIN>(0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::vault::account_cap<T0, T1>(arg0)));
        let (v7, _) = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::get_amounts(v6);
        let v9 = if (0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::to_balance(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::abs(0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::get_collateral(v6)), 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::market::get_scaling_factor(0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::clearing_house::get_market_params<T1>(v5))) == 0) {
            if (v7 == 0) {
                0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::get_pending_orders_counter(v6) == 0
            } else {
                false
            }
        } else {
            false
        };
        let v10 = 0x2::object::id<0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::clearing_house::ClearingHouse<T1>>(v5);
        let v11 = 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::vault::ch_ids_mut<T0, T1>(arg0);
        if (v9) {
            let v12 = 0;
            let v13;
            while (v12 < 0x1::vector::length<0x2::object::ID>(v11)) {
                if (*0x1::vector::borrow<0x2::object::ID>(v11, v12) == v10) {
                    v13 = 0x1::option::some<u64>(v12);
                    /* label 29 */
                    if (0x1::option::is_some<u64>(&v13)) {
                        0x1::vector::remove<0x2::object::ID>(v11, 0x1::option::destroy_some<u64>(v13));
                        /* goto 22 */
                    } else {
                        0x1::option::destroy_none<u64>(v13);
                        /* goto 22 */
                    };
                } else {
                    v12 = v12 + 1;
                };
            };
            v13 = 0x1::option::none<u64>();
            /* goto 29 */
        } else {
            let v14 = 0;
            let v15;
            while (v14 < 0x1::vector::length<0x2::object::ID>(v11)) {
                if (*0x1::vector::borrow<0x2::object::ID>(v11, v14) == v10) {
                    v15 = 0x1::option::some<u64>(v14);
                    /* label 18 */
                    if (0x1::option::is_none<u64>(&v15)) {
                        0x1::vector::push_back<0x2::object::ID>(v11, v10);
                        assert!(0x1::vector::length<0x2::object::ID>(v11) != 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::vault::max_markets_in_vault<T0, T1>(arg0), 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::errors::max_markets_exceeded());
                    };
                    /* label 22 */
                    return (v1, v2, v4)
                };
                v14 = v14 + 1;
            };
            v15 = 0x1::option::none<u64>();
            /* goto 18 */
        };
    }

    public(friend) fun set_position_initial_margin_ratio<T0, T1>(arg0: &0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::vault::Vault<T0, T1>, arg1: &0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::Account<T1>, arg2: &mut 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::clearing_house::ClearingHouse<T1>, arg3: u256) {
        assert!(0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::vault::version<T0, T1>(arg0) == 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::constants::version(), 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::errors::invalid_version());
        0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::interface::set_position_initial_margin_ratio<T1, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::ADMIN>(arg2, 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::vault::account_cap<T0, T1>(arg0), arg1, arg3);
    }

    public(friend) fun start_perpetuals_session<T0, T1>(arg0: &0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::vault::Vault<T0, T1>, arg1: &0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::Account<T1>, arg2: 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::clearing_house::ClearingHouse<T1>, arg3: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage, arg4: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage, arg5: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::config::Config, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) : (0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::clearing_house::SessionHotPotato<T1>, VaultsSessionHotPotato) {
        assert!(0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::vault::version<T0, T1>(arg0) == 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::constants::version(), 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::errors::invalid_version());
        0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::vault::assert_vault_is_not_paused<T0, T1>(arg0, arg6);
        let v0 = VaultsSessionHotPotato{vault_id: 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::vault::id<T0, T1>(arg0)};
        (0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::interface::start_session<T1, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::ADMIN>(arg2, 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::vault::account_cap<T0, T1>(arg0), arg1, arg3, arg4, arg5, arg6, arg7), v0)
    }

    // decompiled from Move bytecode v6
}

