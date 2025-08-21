module 0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::position {
    struct Position has store {
        id: 0x2::object::UID,
        create_ts_ms: u64,
        position_id: u64,
        linked_order_ids: vector<u64>,
        linked_order_prices: vector<u64>,
        user: address,
        is_long: bool,
        size: u64,
        size_decimal: u64,
        collateral_token: 0x1::type_name::TypeName,
        collateral_token_decimal: u64,
        symbol: 0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::symbol::Symbol,
        collateral_amount: u64,
        reserve_amount: u64,
        average_price: u64,
        entry_borrow_index: u64,
        entry_funding_rate_index_sign: bool,
        entry_funding_rate_index: u64,
        unrealized_loss: u64,
        unrealized_funding_sign: bool,
        unrealized_funding_fee: u64,
        unrealized_trading_fee: u64,
        unrealized_borrow_fee: u64,
        unrealized_rebate: u64,
        option_collateral_info: 0x1::option::Option<OptionCollateralInfo>,
        u64_padding: vector<u64>,
    }

    struct OptionCollateralInfo has drop, store {
        index: u64,
        bid_token: 0x1::type_name::TypeName,
        bid_receipts_bcs: vector<vector<u8>>,
    }

    struct TradingOrder has store {
        id: 0x2::object::UID,
        create_ts_ms: u64,
        order_id: u64,
        linked_position_id: 0x1::option::Option<u64>,
        user: address,
        collateral_token: 0x1::type_name::TypeName,
        collateral_token_decimal: u64,
        symbol: 0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::symbol::Symbol,
        leverage_mbp: u64,
        reduce_only: bool,
        is_long: bool,
        is_stop_order: bool,
        size: u64,
        size_decimal: u64,
        trigger_price: u64,
        oracle_price_when_placing: u64,
        u64_padding: vector<u64>,
    }

    struct RemovePositionEvent has copy, drop {
        user: address,
        collateral_token: 0x1::type_name::TypeName,
        symbol: 0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::symbol::Symbol,
        linked_order_ids: vector<u64>,
        linked_order_prices: vector<u64>,
        remaining_collateral_amount: u64,
        realized_trading_fee_amount: u64,
        realized_borrow_fee_amount: u64,
        u64_padding: vector<u64>,
    }

    struct OrderFilledEvent has copy, drop {
        user: address,
        collateral_token: 0x1::type_name::TypeName,
        symbol: 0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::symbol::Symbol,
        order_id: u64,
        linked_position_id: 0x1::option::Option<u64>,
        new_position_id: 0x1::option::Option<u64>,
        filled_size: u64,
        filled_price: u64,
        position_side: bool,
        position_size: u64,
        position_average_price: u64,
        realized_trading_fee: u64,
        realized_borrow_fee: u64,
        realized_fee_in_usd: u64,
        realized_amount: u64,
        realized_amount_sign: bool,
        u64_padding: vector<u64>,
    }

    struct RealizeFundingEvent has copy, drop {
        user: address,
        collateral_token: 0x1::type_name::TypeName,
        symbol: 0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::symbol::Symbol,
        position_id: u64,
        realized_funding_sign: bool,
        realized_funding_fee: u64,
        realized_funding_fee_usd: u64,
        u64_padding: vector<u64>,
    }

    public(friend) fun order_filled<T0>(arg0: &0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::admin::Version, arg1: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::Version, arg2: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::leaderboard::TypusLeaderboardRegistry, arg3: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::tails_staking::TailsStakingRegistry, arg4: &0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::competition::CompetitionConfig, arg5: TradingOrder, arg6: 0x1::option::Option<Position>, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: bool, arg14: u64, arg15: u64, arg16: &0x2::clock::Clock, arg17: &mut 0x2::tx_context::TxContext) : (Position, u64, u64, u64) {
        0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::admin::version_check(arg0);
        let TradingOrder {
            id                        : v0,
            create_ts_ms              : _,
            order_id                  : v2,
            linked_position_id        : v3,
            user                      : v4,
            collateral_token          : v5,
            collateral_token_decimal  : v6,
            symbol                    : v7,
            leverage_mbp              : _,
            reduce_only               : v9,
            is_long                   : v10,
            is_stop_order             : _,
            size                      : v12,
            size_decimal              : v13,
            trigger_price             : _,
            oracle_price_when_placing : _,
            u64_padding               : _,
        } = arg5;
        let v17 = v0;
        assert!(v5 == 0x1::type_name::get<T0>(), 0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::error::wrong_collateral_type());
        let v18 = if (0x1::option::is_some<Position>(&arg6)) {
            let v19 = 0x1::option::borrow<Position>(&arg6).size;
            if (v10 != 0x1::option::borrow<Position>(&arg6).is_long) {
                if (v19 > v12) {
                    v12
                } else {
                    v19
                }
            } else {
                v12
            }
        } else {
            v12
        };
        let v20 = 0x2::dynamic_field::remove<0x1::string::String, 0x2::balance::Balance<T0>>(&mut v17, 0x1::string::utf8(b"collateral"));
        let (v21, v22) = calculate_trading_fee(v18, v13, arg8, arg9, arg10, arg11, arg15, v6);
        let v23 = 0x2::balance::value<T0>(&v20);
        let (v24, v25, v26, v27, v28) = if (0x1::option::is_some<Position>(&arg6)) {
            let v29 = 0x1::option::extract<Position>(&mut arg6);
            let v30 = get_position_size(&v29);
            let (v31, v32, v33, v34, v35, v36) = calculate_filled_(&v29, v9, v10, v18, arg10, arg11);
            let v37 = &mut v29;
            remove_position_linked_order_info(v37, v2);
            let v38 = if (v34 == get_position_side(&v29)) {
                if (v35 >= v30) {
                    v35 - v30
                } else {
                    v30 - v35
                }
            } else {
                v35 + v30
            };
            let v39 = &mut v29;
            let (_, _, _) = update_position_borrow_rate_and_funding_rate(v39, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
            let v43 = 0x2::balance::value<T0>(0x2::dynamic_field::borrow<0x1::string::String, 0x2::balance::Balance<T0>>(&v29.id, 0x1::string::utf8(b"collateral"))) + v23;
            let v44 = 0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::math::usd_to_amount(0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::math::amount_to_usd(v35, v29.size_decimal, arg10, arg11), v29.collateral_token_decimal, arg8, arg9);
            let v45 = if (v43 >= v44) {
                0
            } else {
                v44 - v43
            };
            v29.is_long = v34;
            v29.size = v35;
            v29.average_price = v36;
            v29.reserve_amount = v45;
            v29.unrealized_trading_fee = v29.unrealized_trading_fee + v21;
            (v29, v31, v32, v33, v38)
        } else {
            let v46 = 0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::math::usd_to_amount(0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::math::amount_to_usd(v12, v13, arg10, arg11), v6, arg8, arg9);
            let v47 = if (v23 >= v46) {
                0
            } else {
                v46 - v23
            };
            let v48 = Position{
                id                            : 0x2::object::new(arg17),
                create_ts_ms                  : 0x2::clock::timestamp_ms(arg16),
                position_id                   : arg7,
                linked_order_ids              : 0x1::vector::empty<u64>(),
                linked_order_prices           : 0x1::vector::empty<u64>(),
                user                          : v4,
                is_long                       : v10,
                size                          : v12,
                size_decimal                  : v13,
                collateral_token              : v5,
                collateral_token_decimal      : v6,
                symbol                        : v7,
                collateral_amount             : v23 - v21,
                reserve_amount                : v47,
                average_price                 : arg10,
                entry_borrow_index            : arg12,
                entry_funding_rate_index_sign : arg13,
                entry_funding_rate_index      : arg14,
                unrealized_loss               : 0,
                unrealized_funding_sign       : true,
                unrealized_funding_fee        : 0,
                unrealized_trading_fee        : v21,
                unrealized_borrow_fee         : 0,
                unrealized_rebate             : 0,
                option_collateral_info        : 0x1::option::none<OptionCollateralInfo>(),
                u64_padding                   : 0x1::vector::empty<u64>(),
            };
            0x2::dynamic_field::add<0x1::string::String, 0x2::balance::Balance<T0>>(&mut v48.id, 0x1::string::utf8(b"collateral"), 0x2::balance::zero<T0>());
            (v48, false, false, 0, v12)
        };
        let v49 = v24;
        0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::balance::Balance<T0>>(&mut v49.id, 0x1::string::utf8(b"collateral")), v20);
        let v50 = 0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::math::usd_to_amount(v27, v49.collateral_token_decimal, arg8, arg9);
        let v51 = if (!v26) {
            v50
        } else {
            0
        };
        let v52 = if (v25 && v26) {
            v50
        } else {
            0
        };
        0x2::object::delete(v17);
        0x1::option::destroy_none<Position>(arg6);
        v49.collateral_amount = 0x2::balance::value<T0>(0x2::dynamic_field::borrow<0x1::string::String, 0x2::balance::Balance<T0>>(&v49.id, 0x1::string::utf8(b"collateral")));
        0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::competition::add_score(arg0, arg1, arg2, arg3, arg4, 0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::math::amount_to_usd(v28, v13, arg10, arg11), v4, arg16, arg17);
        let v53 = if (0x1::option::is_none<Position>(&arg6)) {
            0x1::option::some<u64>(v49.position_id)
        } else {
            0x1::option::none<u64>()
        };
        let v54 = OrderFilledEvent{
            user                   : v4,
            collateral_token       : v5,
            symbol                 : v7,
            order_id               : v2,
            linked_position_id     : v3,
            new_position_id        : v53,
            filled_size            : v28,
            filled_price           : arg10,
            position_side          : v49.is_long,
            position_size          : v49.size,
            position_average_price : v49.average_price,
            realized_trading_fee   : v21,
            realized_borrow_fee    : v49.unrealized_borrow_fee,
            realized_fee_in_usd    : 0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::math::amount_to_usd(v21 + v49.unrealized_borrow_fee, v49.collateral_token_decimal, arg8, arg9),
            realized_amount        : v50,
            realized_amount_sign   : v26,
            u64_padding            : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<OrderFilledEvent>(v54);
        (v49, v51, v52, v22)
    }

    public(friend) fun add_position_linked_order_info(arg0: &mut Position, arg1: u64, arg2: u64) {
        0x1::vector::push_back<u64>(&mut arg0.linked_order_ids, arg1);
        0x1::vector::push_back<u64>(&mut arg0.linked_order_prices, arg2);
        assert!(0x1::vector::length<u64>(&arg0.linked_order_ids) <= 5, 0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::error::too_many_linked_orders());
    }

    fun calculate_filled_(arg0: &Position, arg1: bool, arg2: bool, arg3: u64, arg4: u64, arg5: u64) : (bool, bool, u64, bool, u64, u64) {
        let v0 = false;
        let v1 = 0;
        let v2 = false;
        let (v3, v4, v5) = if (arg2) {
            if (arg0.is_long) {
                assert!(!arg1, 0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::error::not_reduce_only_execution());
                let v6 = (arg0.average_price as u128) * (arg0.size as u128);
                let v7 = (arg4 as u128) * (arg3 as u128);
                let v8 = arg0.size + arg3;
                let v9 = (((v6 + v7) / (v8 as u128)) as u64);
                let v10 = v9;
                if (v6 + v7 > (v9 as u128) * (v8 as u128)) {
                    v10 = v9 + 1;
                };
                (true, v8, v10)
            } else if (arg1 || !arg1 && arg3 <= arg0.size) {
                v0 = true;
                let v11 = if (arg3 > arg0.size) {
                    arg0.size
                } else {
                    arg3
                };
                let (v12, v13) = calculate_realized_pnl_usd(arg0.is_long, v11, arg0.average_price, arg4, arg0.size_decimal, arg5);
                v1 = v13;
                v2 = v12;
                (false, arg0.size - v11, arg0.average_price)
            } else {
                v0 = true;
                let (v14, v15) = calculate_realized_pnl_usd(arg0.is_long, arg0.size, arg0.average_price, arg4, arg0.size_decimal, arg5);
                v1 = v15;
                v2 = v14;
                (true, arg3 - arg0.size, arg4)
            }
        } else if (!arg0.is_long) {
            assert!(!arg1, 0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::error::not_reduce_only_execution());
            (false, arg0.size + arg3, ((((arg0.average_price as u128) * (arg0.size as u128) + (arg4 as u128) * (arg3 as u128)) / ((arg0.size + arg3) as u128)) as u64))
        } else if (arg1 || !arg1 && arg3 <= arg0.size) {
            v0 = true;
            let v16 = if (arg3 > arg0.size) {
                arg0.size
            } else {
                arg3
            };
            let (v17, v18) = calculate_realized_pnl_usd(arg0.is_long, v16, arg0.average_price, arg4, arg0.size_decimal, arg5);
            v1 = v18;
            v2 = v17;
            (true, arg0.size - v16, arg0.average_price)
        } else {
            v0 = true;
            let (v19, v20) = calculate_realized_pnl_usd(arg0.is_long, arg0.size, arg0.average_price, arg4, arg0.size_decimal, arg5);
            v1 = v20;
            v2 = v19;
            (false, arg3 - arg0.size, arg4)
        };
        (v0, v2, v1, v3, v4, v5)
    }

    fun calculate_intrinsic_value<T0>(arg0: &0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg1: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg2: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg3: &vector<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusBidReceipt>, arg4: &0x2::clock::Clock) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v0 < 0x1::vector::length<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusBidReceipt>(arg3)) {
            v1 = v1 + 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::get_bid_receipt_intrinsic_value_v2<T0>(arg0, arg1, arg2, 0x1::vector::borrow<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusBidReceipt>(arg3, v0), arg4);
            v0 = v0 + 1;
        };
        v1
    }

    fun calculate_period_borrow_cost(arg0: &Position, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : (u64, u64) {
        let v0 = 0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::math::amount_to_usd(arg0.size, arg0.size_decimal, arg3, arg4);
        let v1 = 0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::math::usd_to_amount(v0, arg0.collateral_token_decimal, arg1, arg2);
        let v2 = if (arg0.collateral_amount >= v1) {
            0
        } else {
            v1 - arg0.collateral_amount
        };
        (v0, (((v2 as u128) * ((arg5 - arg0.entry_borrow_index) as u128) / (0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::math::multiplier(0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::lp_pool::get_borrow_rate_decimal()) as u128)) as u64))
    }

    fun calculate_position_funding_rate(arg0: &Position, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: bool, arg6: u64) : (bool, u64) {
        let (v0, v1) = if (arg5 && arg0.entry_funding_rate_index_sign) {
            if (arg6 > arg0.entry_funding_rate_index) {
                (true, arg6 - arg0.entry_funding_rate_index)
            } else {
                (false, arg0.entry_funding_rate_index - arg6)
            }
        } else if (arg5 && !arg0.entry_funding_rate_index_sign) {
            (true, arg6 + arg0.entry_funding_rate_index)
        } else if (!arg5 && arg0.entry_funding_rate_index_sign) {
            (false, arg6 + arg0.entry_funding_rate_index)
        } else if (arg6 > arg0.entry_funding_rate_index) {
            (false, arg6 - arg0.entry_funding_rate_index)
        } else {
            (true, arg0.entry_funding_rate_index - arg6)
        };
        let v2 = (((0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::math::usd_to_amount(0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::math::amount_to_usd(arg0.size, arg0.size_decimal, arg3, arg4), arg0.collateral_token_decimal, arg1, arg2) as u128) * (v1 as u128) / (0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::math::multiplier(0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::math::get_funding_rate_decimal()) as u128)) as u64);
        let v3 = arg0.unrealized_funding_sign;
        let v4 = v3;
        let v5 = arg0.unrealized_funding_fee;
        let v6 = if (arg0.is_long) {
            if (v0) {
                if (v3) {
                    v5 + v2
                } else if (v2 > v5) {
                    v4 = true;
                    v2 - v5
                } else {
                    v5 - v2
                }
            } else if (v3) {
                if (v2 > v5) {
                    v4 = false;
                    v2 - v5
                } else {
                    v5 - v2
                }
            } else {
                v5 + v2
            }
        } else if (v0) {
            if (v3) {
                if (v2 > v5) {
                    v4 = false;
                    v2 - v5
                } else {
                    v5 - v2
                }
            } else {
                v5 + v2
            }
        } else if (v3) {
            v5 + v2
        } else if (v2 > v5) {
            v4 = true;
            v2 - v5
        } else {
            v5 - v2
        };
        (v4, v6)
    }

    fun calculate_realized_pnl_usd(arg0: bool, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : (bool, u64) {
        let v0 = arg0 && arg3 > arg2 || arg3 < arg2;
        let v1 = if (arg3 > arg2) {
            arg3 - arg2
        } else {
            arg2 - arg3
        };
        (v0, ((((((arg1 as u128) * (v1 as u128) / (0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::math::multiplier(arg4) as u128)) as u64) as u128) * (0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::math::multiplier(0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::math::get_usd_decimal()) as u128) / (0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::math::multiplier(arg5) as u128)) as u64))
    }

    fun calculate_trading_fee(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64) : (u64, u64) {
        let v0 = (((0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::math::amount_to_usd(arg0, arg1, arg4, arg5) as u128) * (arg6 as u128) / 10000000) as u64);
        (0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::math::usd_to_amount(v0, arg7, arg2, arg3), v0)
    }

    public(friend) fun calculate_unrealized_cost(arg0: &Position) : (bool, u64) {
        let v0 = arg0.unrealized_loss + arg0.unrealized_trading_fee + arg0.unrealized_borrow_fee;
        if (arg0.unrealized_funding_sign) {
            (true, v0 + arg0.unrealized_funding_fee)
        } else if (v0 > arg0.unrealized_funding_fee) {
            (true, v0 - arg0.unrealized_funding_fee)
        } else {
            (false, arg0.unrealized_funding_fee - v0)
        }
    }

    public(friend) fun calculate_unrealized_pnl(arg0: &Position, arg1: u64, arg2: u64, arg3: u64) : (bool, u64, u64) {
        let v0 = (((0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::math::amount_to_usd(arg0.size, arg0.size_decimal, arg1, arg2) as u128) * (arg3 as u128) / 10000000) as u64);
        let (v1, v2) = if (arg0.is_long) {
            let v3 = arg1 > arg0.average_price;
            let v4 = v3;
            let v5 = if (v3) {
                arg1 - arg0.average_price
            } else {
                arg0.average_price - arg1
            };
            let v6 = ((((((arg0.size as u128) * (v5 as u128) / (0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::math::multiplier(arg0.size_decimal) as u128)) as u64) as u128) * (0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::math::multiplier(0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::math::get_usd_decimal()) as u128) / (0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::math::multiplier(arg2) as u128)) as u64);
            let v7 = if (v3) {
                if (v6 < v0) {
                    v4 = false;
                    v0 - v6
                } else {
                    v6 - v0
                }
            } else {
                v6 + v0
            };
            (v4, v7)
        } else {
            let v8 = arg1 < arg0.average_price;
            let v9 = v8;
            let v10 = if (v8) {
                arg0.average_price - arg1
            } else {
                arg1 - arg0.average_price
            };
            let v11 = ((((((arg0.size as u128) * (v10 as u128) / (0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::math::multiplier(arg0.size_decimal) as u128)) as u64) as u128) * (0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::math::multiplier(0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::math::get_usd_decimal()) as u128) / (0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::math::multiplier(arg2) as u128)) as u64);
            let v12 = if (v8) {
                if (v11 < v0) {
                    v9 = false;
                    v0 - v11
                } else {
                    v11 - v0
                }
            } else {
                v11 + v0
            };
            (v9, v12)
        };
        (v1, v2, v0)
    }

    public(friend) fun check_option_collateral_position_liquidated<T0>(arg0: &0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg1: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg2: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg3: &Position, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: &0x2::clock::Clock) : bool {
        let v0 = 0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::math::amount_to_usd(calculate_intrinsic_value<T0>(arg0, arg1, arg2, 0x2::dynamic_field::borrow<0x1::string::String, vector<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusBidReceipt>>(&arg3.id, 0x1::string::utf8(b"collateral")), arg11), arg3.collateral_token_decimal, arg4, arg5);
        let (v1, v2, _) = calculate_unrealized_pnl(arg3, arg6, arg7, arg8);
        let (v4, v5) = calculate_period_borrow_cost(arg3, arg4, arg5, arg6, arg7, arg10);
        let v6 = 0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::math::amount_to_usd(arg3.unrealized_loss + arg3.unrealized_trading_fee + arg3.unrealized_borrow_fee + v5, arg3.collateral_token_decimal, arg4, arg5);
        if (!v1) {
            let v8 = if (v0 > v2 + v6) {
                v0 - v2 - v6
            } else {
                0
            };
            v8 <= (((arg9 as u128) * (v4 as u128) / 10000) as u64)
        } else {
            false
        }
    }

    public(friend) fun check_order_filled(arg0: &TradingOrder, arg1: u64) : bool {
        arg0.is_long && (arg0.is_stop_order && arg1 >= arg0.trigger_price || arg1 <= arg0.trigger_price) || arg0.is_stop_order && arg1 <= arg0.trigger_price || arg1 >= arg0.trigger_price
    }

    public(friend) fun check_position_liquidated(arg0: &Position, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: bool, arg9: u64) : bool {
        let (v0, v1) = calculate_position_funding_rate(arg0, arg1, arg2, arg3, arg4, arg8, arg9);
        let v2 = 0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::math::amount_to_usd(v1, arg0.collateral_token_decimal, arg1, arg2);
        let v3 = collateral_with_pnl(arg0, arg1, arg2, arg3, arg4, arg5);
        let (v4, v5) = calculate_period_borrow_cost(arg0, arg1, arg2, arg3, arg4, arg7);
        let v6 = 0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::math::amount_to_usd(arg0.unrealized_borrow_fee + v5, arg0.collateral_token_decimal, arg1, arg2);
        let v7 = if (v3 > v6) {
            let v8 = v3 - v6;
            if (v0) {
                if (v8 > v2) {
                    v8 - v2
                } else {
                    0
                }
            } else {
                v8 + v2
            }
        } else if (v0) {
            0
        } else if (v3 + v2 > v6) {
            v3 + v2 - v6
        } else {
            0
        };
        v7 <= (((arg6 as u128) * (v4 as u128) / 10000) as u64)
    }

    fun collateral_with_pnl(arg0: &Position, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : u64 {
        let v0 = 0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::math::amount_to_usd(arg0.collateral_amount, arg0.collateral_token_decimal, arg1, arg2);
        let (v1, v2, _) = calculate_unrealized_pnl(arg0, arg3, arg4, arg5);
        if (v1) {
            v0 + v2
        } else if (v0 > v2) {
            v0 - v2
        } else {
            0
        }
    }

    public(friend) fun create_order<T0>(arg0: &0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::admin::Version, arg1: 0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::symbol::Symbol, arg2: u64, arg3: bool, arg4: bool, arg5: bool, arg6: u64, arg7: u64, arg8: u64, arg9: 0x2::balance::Balance<T0>, arg10: u64, arg11: 0x1::option::Option<u64>, arg12: u64, arg13: u64, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) : TradingOrder {
        0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::admin::version_check(arg0);
        let v0 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v0, 0x2::balance::value<T0>(&arg9));
        let v1 = TradingOrder{
            id                        : 0x2::object::new(arg15),
            create_ts_ms              : 0x2::clock::timestamp_ms(arg14),
            order_id                  : arg12,
            linked_position_id        : arg11,
            user                      : 0x2::tx_context::sender(arg15),
            collateral_token          : 0x1::type_name::get<T0>(),
            collateral_token_decimal  : arg10,
            symbol                    : arg1,
            leverage_mbp              : arg2,
            reduce_only               : arg3,
            is_long                   : arg4,
            is_stop_order             : arg5,
            size                      : arg6,
            size_decimal              : arg7,
            trigger_price             : arg8,
            oracle_price_when_placing : arg13,
            u64_padding               : v0,
        };
        0x2::dynamic_field::add<0x1::string::String, 0x2::balance::Balance<T0>>(&mut v1.id, 0x1::string::utf8(b"collateral"), arg9);
        v1
    }

    public(friend) fun create_order_with_bid_receipts(arg0: &0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::admin::Version, arg1: 0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::symbol::Symbol, arg2: u64, arg3: 0x1::type_name::TypeName, arg4: u64, arg5: bool, arg6: bool, arg7: bool, arg8: u64, arg9: u64, arg10: u64, arg11: vector<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusBidReceipt>, arg12: u64, arg13: 0x1::option::Option<u64>, arg14: u64, arg15: u64, arg16: address, arg17: &0x2::clock::Clock, arg18: &mut 0x2::tx_context::TxContext) : TradingOrder {
        0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::admin::version_check(arg0);
        assert!(arg5 && 0x1::vector::length<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusBidReceipt>(&arg11) == 0 || !arg5, 0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::error::invalid_bid_receipts_input());
        let v0 = TradingOrder{
            id                        : 0x2::object::new(arg18),
            create_ts_ms              : 0x2::clock::timestamp_ms(arg17),
            order_id                  : arg14,
            linked_position_id        : arg13,
            user                      : arg16,
            collateral_token          : 0x1::type_name::get<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusBidReceipt>(),
            collateral_token_decimal  : arg12,
            symbol                    : arg1,
            leverage_mbp              : arg4,
            reduce_only               : arg5,
            is_long                   : arg6,
            is_stop_order             : arg7,
            size                      : arg8,
            size_decimal              : arg9,
            trigger_price             : arg10,
            oracle_price_when_placing : arg15,
            u64_padding               : vector[0],
        };
        0x2::dynamic_field::add<0x1::string::String, vector<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusBidReceipt>>(&mut v0.id, 0x1::string::utf8(b"collateral"), arg11);
        0x2::dynamic_field::add<0x1::string::String, 0x1::type_name::TypeName>(&mut v0.id, 0x1::string::utf8(b"deposit_token"), arg3);
        0x2::dynamic_field::add<0x1::string::String, u64>(&mut v0.id, 0x1::string::utf8(b"portfolio_index"), arg2);
        v0
    }

    public(friend) fun emit_realized_funding_event(arg0: address, arg1: 0x1::type_name::TypeName, arg2: 0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::symbol::Symbol, arg3: u64, arg4: bool, arg5: u64, arg6: u64, arg7: vector<u64>) {
        let v0 = RealizeFundingEvent{
            user                     : arg0,
            collateral_token         : arg1,
            symbol                   : arg2,
            position_id              : arg3,
            realized_funding_sign    : arg4,
            realized_funding_fee     : arg5,
            realized_funding_fee_usd : arg6,
            u64_padding              : arg7,
        };
        0x2::event::emit<RealizeFundingEvent>(v0);
    }

    public(friend) fun get_estimated_liquidation_price(arg0: &Position, arg1: bool, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) : u64 {
        if (arg1) {
            if (get_position_side(arg0)) {
                let v1 = (arg0.collateral_amount as u128) + (arg0.size as u128) * (0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::math::multiplier(arg0.collateral_token_decimal) as u128) / (0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::math::multiplier(arg0.size_decimal) as u128);
                let v2 = v1;
                let v3 = (arg0.unrealized_borrow_fee as u128) + ((arg0.size as u128) * (arg5 as u128) / 10000000 + (arg0.size as u128) * (arg6 as u128) / 10000) * (0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::math::multiplier(arg0.collateral_token_decimal) as u128) / (0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::math::multiplier(arg0.size_decimal) as u128);
                let v4 = v3;
                if (arg0.unrealized_funding_sign) {
                    v4 = v3 + (arg0.unrealized_funding_fee as u128);
                } else {
                    v2 = v1 + (arg0.unrealized_funding_fee as u128);
                };
                if (v2 > v4) {
                    (((0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::math::multiplier(arg4) as u128) * (((arg0.size as u256) * (arg0.average_price as u256) * (0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::math::multiplier(arg0.collateral_token_decimal) as u256) / (0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::math::multiplier(arg0.size_decimal) as u256) / (0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::math::multiplier(arg4) as u256)) as u128) / (v2 - v4)) as u64)
                } else {
                    0
                }
            } else {
                let v5 = (arg0.unrealized_borrow_fee as u128) + ((arg0.size as u128) + (arg0.size as u128) * (arg5 as u128) / 10000000 + (arg0.size as u128) * (arg6 as u128) / 10000) * (0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::math::multiplier(arg0.collateral_token_decimal) as u128) / (0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::math::multiplier(arg0.size_decimal) as u128);
                let v6 = v5;
                let v7 = (arg0.collateral_amount as u128);
                let v8 = v7;
                if (arg0.unrealized_funding_sign) {
                    v6 = v5 + (arg0.unrealized_funding_fee as u128);
                } else {
                    v8 = v7 + (arg0.unrealized_funding_fee as u128);
                };
                if (v6 > v8) {
                    (((0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::math::multiplier(arg4) as u128) * (((arg0.size as u256) * (arg0.average_price as u256) * (0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::math::multiplier(arg0.collateral_token_decimal) as u256) / (0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::math::multiplier(arg0.size_decimal) as u256) / (0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::math::multiplier(arg4) as u256)) as u128) / (v6 - v8)) as u64)
                } else {
                    0
                }
            }
        } else if (get_position_side(arg0)) {
            let v9 = (0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::math::amount_to_usd(arg0.unrealized_borrow_fee, arg0.collateral_token_decimal, arg2, arg3) as u128) + (((arg0.size as u256) * (arg0.average_price as u256) * (0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::math::multiplier(0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::math::get_usd_decimal()) as u256) / (0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::math::multiplier(arg0.size_decimal) as u256) / (0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::math::multiplier(arg4) as u256)) as u128);
            let v10 = v9;
            let v11 = (0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::math::amount_to_usd(arg0.collateral_amount, arg0.collateral_token_decimal, arg2, arg3) as u128);
            let v12 = v11;
            if (arg0.unrealized_funding_sign) {
                v10 = v9 + (0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::math::amount_to_usd(arg0.unrealized_funding_fee, arg0.collateral_token_decimal, arg2, arg3) as u128);
            } else {
                v12 = v11 + (0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::math::amount_to_usd(arg0.unrealized_funding_fee, arg0.collateral_token_decimal, arg2, arg3) as u128);
            };
            let v13 = (arg0.size as u128);
            let v14 = (arg0.size as u128) * (arg5 as u128) / 10000000 + (arg0.size as u128) * (arg6 as u128) / 10000;
            if (v10 > v12 && v13 > v14) {
                (((0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::math::multiplier(arg4) as u128) * (v10 - v12) / ((((v13 - v14) as u256) * (0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::math::multiplier(0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::math::get_usd_decimal()) as u256) / (0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::math::multiplier(arg0.size_decimal) as u256)) as u128)) as u64)
            } else {
                0
            }
        } else {
            let v15 = (0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::math::amount_to_usd(arg0.collateral_amount, arg0.collateral_token_decimal, arg2, arg3) as u128) + (((arg0.size as u256) * (arg0.average_price as u256) * (0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::math::multiplier(0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::math::get_usd_decimal()) as u256) / (0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::math::multiplier(arg0.size_decimal) as u256) / (0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::math::multiplier(arg4) as u256)) as u128);
            let v16 = v15;
            let v17 = (0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::math::amount_to_usd(arg0.unrealized_borrow_fee, arg0.collateral_token_decimal, arg2, arg3) as u128);
            let v18 = v17;
            if (arg0.unrealized_funding_sign) {
                v18 = v17 + (0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::math::amount_to_usd(arg0.unrealized_funding_fee, arg0.collateral_token_decimal, arg2, arg3) as u128);
            } else {
                v16 = v15 + (0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::math::amount_to_usd(arg0.unrealized_funding_fee, arg0.collateral_token_decimal, arg2, arg3) as u128);
            };
            if (v16 > v18) {
                (((0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::math::multiplier(arg4) as u128) * (v16 - v18) / (((((arg0.size as u128) + (arg0.size as u128) * (arg5 as u128) / 10000000 + (arg0.size as u128) * (arg6 as u128) / 10000) as u256) * (0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::math::multiplier(0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::math::get_usd_decimal()) as u256) / (0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::math::multiplier(arg0.size_decimal) as u256)) as u128)) as u64)
            } else {
                0
            }
        }
    }

    public(friend) fun get_max_order_type_tag() : u8 {
        3
    }

    public(friend) fun get_option_collateral_order_collateral_amount<T0>(arg0: &0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg1: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg2: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg3: &TradingOrder, arg4: &0x2::clock::Clock) : u64 {
        if (0x2::dynamic_field::exists_with_type<0x1::string::String, vector<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusBidReceipt>>(&arg3.id, 0x1::string::utf8(b"collateral"))) {
            calculate_intrinsic_value<T0>(arg0, arg1, arg2, 0x2::dynamic_field::borrow<0x1::string::String, vector<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusBidReceipt>>(&arg3.id, 0x1::string::utf8(b"collateral")), arg4)
        } else {
            0
        }
    }

    public(friend) fun get_option_position_collateral_amount<T0>(arg0: &0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg1: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg2: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg3: &Position, arg4: &0x2::clock::Clock) : u64 {
        assert!(is_option_collateral_position(arg3), 0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::error::not_option_collateral_position());
        calculate_intrinsic_value<T0>(arg0, arg1, arg2, 0x2::dynamic_field::borrow<0x1::string::String, vector<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusBidReceipt>>(&arg3.id, 0x1::string::utf8(b"collateral")), arg4)
    }

    public(friend) fun get_option_position_exercise_value<T0>(arg0: &0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg1: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg2: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg3: &Position, arg4: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::dynamic_field::borrow<0x1::string::String, vector<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusBidReceipt>>(&arg3.id, 0x1::string::utf8(b"collateral"));
        let v1 = 0;
        let v2 = 0;
        while (v1 < 0x1::vector::length<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusBidReceipt>(v0)) {
            if (0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::check_bid_receipt_expired(arg0, 0x1::vector::borrow<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusBidReceipt>(v0, v1))) {
                v2 = v2 + 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::get_bid_receipt_intrinsic_value_v2<T0>(arg0, arg1, arg2, 0x1::vector::borrow<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusBidReceipt>(v0, v1), arg4);
            };
            v1 = v1 + 1;
        };
        v2
    }

    public(friend) fun get_order_collateral_amount<T0>(arg0: &TradingOrder) : u64 {
        if (0x2::dynamic_field::exists_with_type<0x1::string::String, 0x2::balance::Balance<T0>>(&arg0.id, 0x1::string::utf8(b"collateral"))) {
            0x2::balance::value<T0>(0x2::dynamic_field::borrow<0x1::string::String, 0x2::balance::Balance<T0>>(&arg0.id, 0x1::string::utf8(b"collateral")))
        } else {
            0
        }
    }

    public(friend) fun get_order_collateral_token(arg0: &TradingOrder) : 0x1::type_name::TypeName {
        if (is_option_collateral_order(arg0)) {
            *0x2::dynamic_field::borrow<0x1::string::String, 0x1::type_name::TypeName>(&arg0.id, 0x1::string::utf8(b"deposit_token"))
        } else {
            arg0.collateral_token
        }
    }

    public(friend) fun get_order_collateral_token_decimal(arg0: &TradingOrder) : u64 {
        arg0.collateral_token_decimal
    }

    public(friend) fun get_order_filled_fee(arg0: &TradingOrder, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : u64 {
        0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::math::usd_to_amount((((0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::math::amount_to_usd(arg0.size, arg0.size_decimal, arg3, arg4) as u128) * (arg5 as u128) / 10000000) as u64), arg0.collateral_token_decimal, arg1, arg2)
    }

    public(friend) fun get_order_id(arg0: &TradingOrder) : u64 {
        arg0.order_id
    }

    public(friend) fun get_order_linked_position_id(arg0: &TradingOrder) : 0x1::option::Option<u64> {
        arg0.linked_position_id
    }

    public(friend) fun get_order_price(arg0: &TradingOrder) : u64 {
        arg0.trigger_price
    }

    public(friend) fun get_order_reduce_only(arg0: &TradingOrder) : bool {
        arg0.reduce_only
    }

    public(friend) fun get_order_side(arg0: &TradingOrder) : bool {
        arg0.is_long
    }

    public(friend) fun get_order_size(arg0: &TradingOrder) : u64 {
        arg0.size
    }

    public(friend) fun get_order_trading_symbol(arg0: &TradingOrder) : (0x1::type_name::TypeName, 0x1::type_name::TypeName) {
        (0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::symbol::base_token(&arg0.symbol), 0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::symbol::quote_token(&arg0.symbol))
    }

    public(friend) fun get_order_type_tag(arg0: &TradingOrder) : u8 {
        if (arg0.is_long && !arg0.is_stop_order) {
            return 0
        };
        if (!arg0.is_long && !arg0.is_stop_order) {
            return 1
        };
        if (arg0.is_long && arg0.is_stop_order) {
            return 2
        };
        if (!arg0.is_long && arg0.is_stop_order) {
            return 3
        };
        255
    }

    public(friend) fun get_order_user(arg0: &TradingOrder) : address {
        arg0.user
    }

    public(friend) fun get_position_collateral_amount<T0>(arg0: &Position) : u64 {
        assert!(!is_option_collateral_position(arg0), 0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::error::not_token_collateral_position());
        0x2::balance::value<T0>(0x2::dynamic_field::borrow<0x1::string::String, 0x2::balance::Balance<T0>>(&arg0.id, 0x1::string::utf8(b"collateral")))
    }

    public(friend) fun get_position_collateral_token_decimal(arg0: &Position) : u64 {
        arg0.collateral_token_decimal
    }

    public(friend) fun get_position_collateral_token_type(arg0: &Position) : 0x1::type_name::TypeName {
        arg0.collateral_token
    }

    public(friend) fun get_position_id(arg0: &Position) : u64 {
        arg0.position_id
    }

    public(friend) fun get_position_linked_order_ids(arg0: &Position) : vector<u64> {
        arg0.linked_order_ids
    }

    public(friend) fun get_position_option_collateral_info(arg0: &Position) : (u64, 0x1::type_name::TypeName) {
        let v0 = 0x1::option::borrow<OptionCollateralInfo>(&arg0.option_collateral_info);
        (v0.index, v0.bid_token)
    }

    public(friend) fun get_position_side(arg0: &Position) : bool {
        arg0.is_long
    }

    public(friend) fun get_position_size(arg0: &Position) : u64 {
        arg0.size
    }

    public(friend) fun get_position_size_decimal(arg0: &Position) : u64 {
        arg0.size_decimal
    }

    public(friend) fun get_position_symbol(arg0: &Position) : 0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::symbol::Symbol {
        arg0.symbol
    }

    public(friend) fun get_position_user(arg0: &Position) : address {
        arg0.user
    }

    public(friend) fun get_reserve_amount(arg0: &Position) : u64 {
        arg0.reserve_amount
    }

    public(friend) fun increase_collateral<T0>(arg0: &mut Position, arg1: 0x2::balance::Balance<T0>, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = 0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::balance::Balance<T0>>(&mut arg0.id, 0x1::string::utf8(b"collateral"));
        0x2::balance::join<T0>(v0, arg1);
        arg0.collateral_amount = 0x2::balance::value<T0>(v0);
        let v1 = 0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::math::usd_to_amount(0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::math::amount_to_usd(arg0.size, arg0.size_decimal, arg4, arg5), arg0.collateral_token_decimal, arg2, arg3);
        let v2 = if (arg0.collateral_amount >= v1) {
            0
        } else {
            v1 - arg0.collateral_amount
        };
        arg0.reserve_amount = v2;
    }

    public(friend) fun is_option_collateral_order(arg0: &TradingOrder) : bool {
        0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, 0x1::string::utf8(b"deposit_token"))
    }

    public(friend) fun is_option_collateral_position(arg0: &Position) : bool {
        0x1::option::is_some<OptionCollateralInfo>(&arg0.option_collateral_info)
    }

    public(friend) fun manager_create_reduce_only_order<T0>(arg0: &0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::admin::Version, arg1: 0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::symbol::Symbol, arg2: bool, arg3: u64, arg4: u64, arg5: u64, arg6: 0x2::balance::Balance<T0>, arg7: u64, arg8: u64, arg9: address, arg10: u64, arg11: u64, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : TradingOrder {
        0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::admin::verify(arg0, arg13);
        let v0 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v0, 0x2::balance::value<T0>(&arg6));
        let v1 = TradingOrder{
            id                        : 0x2::object::new(arg13),
            create_ts_ms              : 0x2::clock::timestamp_ms(arg12),
            order_id                  : arg10,
            linked_position_id        : 0x1::option::some<u64>(arg8),
            user                      : arg9,
            collateral_token          : 0x1::type_name::get<T0>(),
            collateral_token_decimal  : arg7,
            symbol                    : arg1,
            leverage_mbp              : 10000000,
            reduce_only               : true,
            is_long                   : arg2,
            is_stop_order             : false,
            size                      : arg3,
            size_decimal              : arg4,
            trigger_price             : arg5,
            oracle_price_when_placing : arg11,
            u64_padding               : v0,
        };
        0x2::dynamic_field::add<0x1::string::String, 0x2::balance::Balance<T0>>(&mut v1.id, 0x1::string::utf8(b"collateral"), arg6);
        v1
    }

    public(friend) fun max_releasing_collateral_amount(arg0: &Position, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64) : u64 {
        let v0 = collateral_with_pnl(arg0, arg1, arg2, arg3, arg4, arg5);
        let (v1, v2) = calculate_period_borrow_cost(arg0, arg1, arg2, arg3, arg4, arg6);
        let v3 = 0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::math::amount_to_usd(arg0.unrealized_borrow_fee + v2, arg0.collateral_token_decimal, arg1, arg2);
        let v4 = ((100 * (v1 as u128) / (arg7 as u128)) as u64);
        if (v0 >= v3) {
            let v6 = v0 - v3;
            if (v6 > v4) {
                0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::math::usd_to_amount(v6 - v4, arg0.collateral_token_decimal, arg1, arg2)
            } else {
                0
            }
        } else {
            0
        }
    }

    public(friend) fun option_position_bid_receipts_expired(arg0: &0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg1: &Position) : bool {
        let v0 = true;
        let v1 = 0x2::dynamic_field::borrow<0x1::string::String, vector<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusBidReceipt>>(&arg1.id, 0x1::string::utf8(b"collateral"));
        let v2 = 0;
        while (v2 < 0x1::vector::length<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusBidReceipt>(v1)) {
            if (!0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::check_bid_receipt_expired(arg0, 0x1::vector::borrow<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusBidReceipt>(v1, v2))) {
                v0 = false;
            };
            v2 = v2 + 1;
        };
        v0
    }

    public(friend) fun order_filled_with_bid_receipts_collateral<T0, T1>(arg0: &0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::admin::Version, arg1: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::Version, arg2: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::leaderboard::TypusLeaderboardRegistry, arg3: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::tails_staking::TailsStakingRegistry, arg4: &0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::competition::CompetitionConfig, arg5: &mut 0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::lp_pool::LiquidityPool, arg6: &0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg7: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg8: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg9: TradingOrder, arg10: 0x1::option::Option<Position>, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: bool, arg18: u64, arg19: u64, arg20: u64, arg21: &0x2::clock::Clock, arg22: &mut 0x2::tx_context::TxContext) : (Position, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T0>, u64) {
        0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::admin::version_check(arg0);
        let TradingOrder {
            id                        : v0,
            create_ts_ms              : _,
            order_id                  : v2,
            linked_position_id        : v3,
            user                      : v4,
            collateral_token          : v5,
            collateral_token_decimal  : v6,
            symbol                    : v7,
            leverage_mbp              : _,
            reduce_only               : v9,
            is_long                   : v10,
            is_stop_order             : _,
            size                      : v12,
            size_decimal              : v13,
            trigger_price             : _,
            oracle_price_when_placing : _,
            u64_padding               : _,
        } = arg9;
        let v17 = v0;
        assert!(v5 == 0x1::type_name::get<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusBidReceipt>(), 0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::error::wrong_collateral_type());
        let (v18, v19) = calculate_trading_fee(v12, v13, arg12, arg13, arg14, arg15, arg19, v6);
        let v20 = (((v18 as u128) * (arg20 as u128) / 10000) as u64);
        let (v21, v22) = if (!v9) {
            let v23 = 0x2::dynamic_field::remove<0x1::string::String, vector<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusBidReceipt>>(&mut v17, 0x1::string::utf8(b"collateral"));
            (0x1::option::some<vector<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusBidReceipt>>(v23), calculate_intrinsic_value<T0>(arg6, arg7, arg8, &v23, arg21))
        } else {
            (0x1::option::none<vector<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusBidReceipt>>(), 0)
        };
        let v24 = v21;
        let (v25, v26, v27, v28, v29) = if (0x1::option::is_some<Position>(&arg10)) {
            let v30 = 0x1::option::extract<Position>(&mut arg10);
            let v31 = get_position_size(&v30);
            assert!(0x2::dynamic_field::remove<0x1::string::String, 0x1::type_name::TypeName>(&mut v17, 0x1::string::utf8(b"deposit_token")) == v30.collateral_token, 0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::error::deposit_token_mismatched());
            assert!(0x2::dynamic_field::remove<0x1::string::String, u64>(&mut v17, 0x1::string::utf8(b"portfolio_index")) == 0x1::option::borrow<OptionCollateralInfo>(&v30.option_collateral_info).index, 0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::error::portfolio_index_mismatched());
            let (v32, v33, v34, v35, v36, v37) = calculate_filled_(&v30, v9, v10, v12, arg14, arg15);
            let v38 = if (v35 == get_position_side(&v30)) {
                if (v36 >= v31) {
                    v36 - v31
                } else {
                    v31 - v36
                }
            } else {
                v36 + v31
            };
            let v39 = calculate_intrinsic_value<T0>(arg6, arg7, arg8, 0x2::dynamic_field::borrow<0x1::string::String, vector<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusBidReceipt>>(&v30.id, 0x1::string::utf8(b"collateral")), arg21) + v22;
            let v40 = &mut v30;
            let (_, _, _) = update_position_borrow_rate_and_funding_rate(v40, arg12, arg13, arg14, arg15, arg16, arg17, arg18);
            let v44 = 0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::math::usd_to_amount(0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::math::amount_to_usd(v36, v30.size_decimal, arg14, arg15), v30.collateral_token_decimal, arg12, arg13);
            let v45 = if (v39 >= v44) {
                0
            } else {
                v44 - v39
            };
            v30.is_long = v35;
            v30.size = v36;
            v30.average_price = v37;
            v30.reserve_amount = v45;
            v30.collateral_amount = v39;
            v30.unrealized_trading_fee = v30.unrealized_trading_fee + v18 - v20;
            v30.unrealized_rebate = v30.unrealized_rebate + v20;
            (v30, v32, v33, v34, v38)
        } else {
            let v46 = 0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::math::usd_to_amount(0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::math::amount_to_usd(v12, v13, arg14, arg15), v6, arg12, arg13);
            let v47 = if (v22 >= v46) {
                0
            } else {
                v46 - v22
            };
            let v48 = 0x1::vector::empty<vector<u8>>();
            let v49 = 0x1::option::borrow<vector<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusBidReceipt>>(&v24);
            let v50 = 0;
            while (v50 < 0x1::vector::length<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusBidReceipt>(v49)) {
                0x1::vector::push_back<vector<u8>>(&mut v48, 0x2::bcs::to_bytes<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusBidReceipt>(0x1::vector::borrow<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusBidReceipt>(v49, v50)));
                v50 = v50 + 1;
            };
            let v51 = OptionCollateralInfo{
                index            : 0x2::dynamic_field::remove<0x1::string::String, u64>(&mut v17, 0x1::string::utf8(b"portfolio_index")),
                bid_token        : 0x1::type_name::get<T1>(),
                bid_receipts_bcs : v48,
            };
            let v52 = Position{
                id                            : 0x2::object::new(arg22),
                create_ts_ms                  : 0x2::clock::timestamp_ms(arg21),
                position_id                   : arg11,
                linked_order_ids              : 0x1::vector::empty<u64>(),
                linked_order_prices           : 0x1::vector::empty<u64>(),
                user                          : v4,
                is_long                       : v10,
                size                          : v12,
                size_decimal                  : v13,
                collateral_token              : 0x2::dynamic_field::remove<0x1::string::String, 0x1::type_name::TypeName>(&mut v17, 0x1::string::utf8(b"deposit_token")),
                collateral_token_decimal      : v6,
                symbol                        : v7,
                collateral_amount             : v22,
                reserve_amount                : v47,
                average_price                 : arg14,
                entry_borrow_index            : arg16,
                entry_funding_rate_index_sign : arg17,
                entry_funding_rate_index      : arg18,
                unrealized_loss               : 0,
                unrealized_funding_sign       : true,
                unrealized_funding_fee        : 0,
                unrealized_trading_fee        : v18 - v20,
                unrealized_borrow_fee         : 0,
                unrealized_rebate             : v20,
                option_collateral_info        : 0x1::option::some<OptionCollateralInfo>(v51),
                u64_padding                   : 0x1::vector::empty<u64>(),
            };
            0x2::dynamic_field::add<0x1::string::String, vector<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusBidReceipt>>(&mut v52.id, 0x1::string::utf8(b"collateral"), 0x1::vector::empty<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusBidReceipt>());
            (v52, false, false, 0, v12)
        };
        let v53 = v25;
        let v54 = 0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::math::usd_to_amount(v28, v53.collateral_token_decimal, arg12, arg13);
        if (v26 && !v27) {
            v53.unrealized_loss = v53.unrealized_loss + v54;
        };
        let v55 = if (v26 && v27) {
            0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::lp_pool::request_collateral<T0>(arg5, v54, arg12, arg13)
        } else {
            0x2::balance::zero<T0>()
        };
        let v56 = v55;
        let v57 = 0x2::balance::value<T0>(&v56);
        let v58 = if (v53.unrealized_loss > v57) {
            v57
        } else {
            v53.unrealized_loss
        };
        let v59 = 0x2::balance::split<T0>(&mut v56, v58);
        v53.unrealized_loss = v53.unrealized_loss - 0x2::balance::value<T0>(&v59);
        let v60 = 0x2::balance::value<T0>(&v56);
        let v61 = if (v53.unrealized_trading_fee > v60) {
            v60
        } else {
            v53.unrealized_trading_fee
        };
        let v62 = 0x2::balance::split<T0>(&mut v56, v61);
        let v63 = 0x2::balance::value<T0>(&v62);
        v53.unrealized_trading_fee = v53.unrealized_trading_fee - 0x2::balance::value<T0>(&v62);
        let v64 = if (v53.unrealized_borrow_fee > v60) {
            v60
        } else {
            v53.unrealized_borrow_fee
        };
        let v65 = 0x2::balance::split<T0>(&mut v56, v64);
        v53.unrealized_borrow_fee = v53.unrealized_borrow_fee - 0x2::balance::value<T0>(&v65);
        let v66 = 0x2::balance::value<T0>(&v65);
        0x2::balance::join<T0>(&mut v62, v65);
        let v67 = 0x2::balance::value<T0>(&v56);
        let v68 = if (v53.unrealized_rebate > v67) {
            v67
        } else {
            v53.unrealized_rebate
        };
        let v69 = 0x2::balance::split<T0>(&mut v56, v68);
        v53.unrealized_rebate = v53.unrealized_rebate - 0x2::balance::value<T0>(&v69);
        if (0x1::option::is_some<vector<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusBidReceipt>>(&v24)) {
            0x1::vector::append<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusBidReceipt>(0x2::dynamic_field::borrow_mut<0x1::string::String, vector<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusBidReceipt>>(&mut v53.id, 0x1::string::utf8(b"collateral")), 0x1::option::extract<vector<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusBidReceipt>>(&mut v24));
            0x1::option::destroy_none<vector<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusBidReceipt>>(v24);
        } else {
            0x1::option::destroy_none<vector<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusBidReceipt>>(v24);
        };
        0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::competition::add_score(arg0, arg1, arg2, arg3, arg4, 0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::math::amount_to_usd(v29, v13, arg14, arg15), v4, arg21, arg22);
        let v70 = if (v53.size != 0) {
            0x1::option::some<u64>(v53.position_id)
        } else {
            0x1::option::none<u64>()
        };
        let v71 = OrderFilledEvent{
            user                   : v4,
            collateral_token       : v53.collateral_token,
            symbol                 : v7,
            order_id               : v2,
            linked_position_id     : v3,
            new_position_id        : v70,
            filled_size            : v29,
            filled_price           : arg14,
            position_side          : v53.is_long,
            position_size          : v53.size,
            position_average_price : v53.average_price,
            realized_trading_fee   : v63,
            realized_borrow_fee    : v66,
            realized_fee_in_usd    : 0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::math::amount_to_usd(v63 + v66, v53.collateral_token_decimal, arg12, arg13),
            realized_amount        : v54,
            realized_amount_sign   : v27,
            u64_padding            : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<OrderFilledEvent>(v71);
        0x2::object::delete(v17);
        0x1::option::destroy_none<Position>(arg10);
        (v53, v59, v62, v69, v56, v19)
    }

    public(friend) fun realize_funding<T0>(arg0: &mut Position, arg1: 0x2::balance::Balance<T0>, arg2: u64, arg3: u64) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::balance::Balance<T0>>(&mut arg0.id, 0x1::string::utf8(b"collateral"));
        let (v1, v2) = if (arg0.unrealized_funding_sign) {
            0x2::balance::destroy_zero<T0>(arg1);
            let v3 = if (0x2::balance::value<T0>(v0) > arg0.unrealized_funding_fee) {
                arg0.unrealized_funding_fee
            } else {
                0x2::balance::value<T0>(v0)
            };
            arg0.collateral_amount = arg0.collateral_amount - v3;
            arg0.unrealized_funding_fee = arg0.unrealized_funding_fee - v3;
            (0x2::balance::split<T0>(v0, v3), v3)
        } else {
            let v4 = 0x2::balance::value<T0>(&arg1);
            0x2::balance::join<T0>(v0, arg1);
            arg0.collateral_amount = arg0.collateral_amount + v4;
            arg0.unrealized_funding_fee = arg0.unrealized_funding_fee - v4;
            (0x2::balance::zero<T0>(), v4)
        };
        emit_realized_funding_event(arg0.user, arg0.collateral_token, arg0.symbol, arg0.position_id, arg0.unrealized_funding_sign, v2, 0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::math::amount_to_usd(v2, arg0.collateral_token_decimal, arg2, arg3), 0x1::vector::empty<u64>());
        arg0.collateral_amount = 0x2::balance::value<T0>(v0);
        v1
    }

    public(friend) fun realize_funding_fee<T0>(arg0: &mut 0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::lp_pool::LiquidityPool, arg1: &mut Position, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        if (arg1.unrealized_funding_fee > 0) {
            if (arg1.unrealized_funding_sign) {
                let v0 = 0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::balance::Balance<T0>>(&mut arg1.id, 0x1::string::utf8(b"collateral"));
                let v1 = if (arg1.unrealized_funding_fee > 0x2::balance::value<T0>(v0)) {
                    0x2::balance::value<T0>(v0)
                } else {
                    arg1.unrealized_funding_fee
                };
                let v2 = 0x2::balance::split<T0>(v0, v1);
                arg1.unrealized_funding_fee = arg1.unrealized_funding_fee - 0x2::balance::value<T0>(&v2);
                emit_realized_funding_event(arg1.user, arg1.collateral_token, arg1.symbol, arg1.position_id, arg1.unrealized_funding_sign, 0x2::balance::value<T0>(&v2), 0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::math::amount_to_usd(0x2::balance::value<T0>(&v2), arg1.collateral_token_decimal, arg2, arg3), 0x1::vector::empty<u64>());
                0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::lp_pool::put_collateral<T0>(arg0, v2, arg2, arg3);
            } else {
                let v3 = 0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::lp_pool::request_collateral<T0>(arg0, arg1.unrealized_funding_fee, arg2, arg3);
                let v4 = 0x2::balance::value<T0>(&v3);
                arg1.unrealized_funding_fee = arg1.unrealized_funding_fee - v4;
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v3, arg4), arg1.user);
                emit_realized_funding_event(arg1.user, arg1.collateral_token, arg1.symbol, arg1.position_id, arg1.unrealized_funding_sign, v4, 0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::math::amount_to_usd(v4, arg1.collateral_token_decimal, arg2, arg3), 0x1::vector::empty<u64>());
            };
        };
    }

    public(friend) fun realize_position_pnl_and_fee<T0>(arg0: &mut 0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::admin::Version, arg1: &mut 0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::lp_pool::LiquidityPool, arg2: &mut Position, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64) : 0x2::balance::Balance<T0> {
        let v0 = arg2.unrealized_trading_fee + arg2.unrealized_borrow_fee;
        let v1 = 0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::lp_pool::request_collateral<T0>(arg1, arg3, arg7, arg8);
        let v2 = 0x2::dynamic_field::remove<0x1::string::String, 0x2::balance::Balance<T0>>(&mut arg2.id, 0x1::string::utf8(b"collateral"));
        let v3 = 0x2::balance::value<T0>(&v2);
        0x2::balance::join<T0>(&mut v1, v2);
        let v4 = 0x2::balance::split<T0>(&mut v1, arg4);
        let v5 = 0x2::balance::split<T0>(&mut v1, v0);
        0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::admin::charge_fee<T0>(arg0, 0x2::balance::split<T0>(&mut v5, (((v0 as u128) * (arg6 as u128) / 10000) as u64)));
        0x2::balance::join<T0>(&mut v4, v5);
        let v6 = arg2.reserve_amount;
        let v7 = if (v6 > arg5) {
            v6 - arg5
        } else {
            arg5 - v6
        };
        0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::lp_pool::order_filled<T0>(arg1, v6 > arg5, v7, v4);
        if (arg2.unrealized_funding_fee > 0) {
            if (arg2.unrealized_funding_sign) {
                let v8 = 0x2::balance::split<T0>(&mut v1, arg2.unrealized_funding_fee);
                arg2.unrealized_funding_fee = arg2.unrealized_funding_fee - 0x2::balance::value<T0>(&v8);
                emit_realized_funding_event(arg2.user, arg2.collateral_token, arg2.symbol, arg2.position_id, arg2.unrealized_funding_sign, 0x2::balance::value<T0>(&v8), 0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::math::amount_to_usd(0x2::balance::value<T0>(&v8), arg2.collateral_token_decimal, arg7, arg8), 0x1::vector::empty<u64>());
                0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::lp_pool::put_collateral<T0>(arg1, v8, arg7, arg8);
            } else {
                let v9 = 0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::lp_pool::request_collateral<T0>(arg1, arg2.unrealized_funding_fee, arg7, arg8);
                let v10 = 0x2::balance::value<T0>(&v9);
                0x2::balance::join<T0>(&mut v1, v9);
                arg2.unrealized_funding_fee = arg2.unrealized_funding_fee - v10;
                emit_realized_funding_event(arg2.user, arg2.collateral_token, arg2.symbol, arg2.position_id, arg2.unrealized_funding_sign, v10, 0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::math::amount_to_usd(v10, arg2.collateral_token_decimal, arg7, arg8), 0x1::vector::empty<u64>());
            };
        };
        let v11 = if (0x2::balance::value<T0>(&v1) > v3) {
            0x2::balance::value<T0>(&v1) - v3
        } else {
            0
        };
        0x2::dynamic_field::add<0x1::string::String, 0x2::balance::Balance<T0>>(&mut arg2.id, 0x1::string::utf8(b"collateral"), v1);
        arg2.unrealized_trading_fee = 0;
        arg2.unrealized_borrow_fee = 0;
        arg2.collateral_amount = 0x2::balance::value<T0>(&v1);
        0x2::balance::split<T0>(&mut v1, v11)
    }

    public(friend) fun release_collateral<T0>(arg0: &mut Position, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::balance::Balance<T0>>(&mut arg0.id, 0x1::string::utf8(b"collateral"));
        let v1 = 0x2::balance::split<T0>(v0, arg1);
        arg0.collateral_amount = 0x2::balance::value<T0>(v0);
        let v2 = 0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::math::usd_to_amount(0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::math::amount_to_usd(arg0.size, arg0.size_decimal, arg4, arg5), arg0.collateral_token_decimal, arg2, arg3);
        let v3 = if (arg0.collateral_amount >= v2) {
            0
        } else {
            v2 - arg0.collateral_amount
        };
        arg0.reserve_amount = v3;
        v1
    }

    public(friend) fun remove_order<T0>(arg0: &0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::admin::Version, arg1: TradingOrder) : 0x2::balance::Balance<T0> {
        0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::admin::version_check(arg0);
        let TradingOrder {
            id                        : v0,
            create_ts_ms              : _,
            order_id                  : _,
            linked_position_id        : _,
            user                      : _,
            collateral_token          : _,
            collateral_token_decimal  : _,
            symbol                    : _,
            leverage_mbp              : _,
            reduce_only               : _,
            is_long                   : _,
            is_stop_order             : _,
            size                      : _,
            size_decimal              : _,
            trigger_price             : _,
            oracle_price_when_placing : _,
            u64_padding               : _,
        } = arg1;
        let v17 = v0;
        0x2::object::delete(v17);
        0x2::dynamic_field::remove<0x1::string::String, 0x2::balance::Balance<T0>>(&mut v17, 0x1::string::utf8(b"collateral"))
    }

    public(friend) fun remove_order_with_bid_receipts(arg0: &0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::admin::Version, arg1: TradingOrder) : vector<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusBidReceipt> {
        0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::admin::version_check(arg0);
        let TradingOrder {
            id                        : v0,
            create_ts_ms              : _,
            order_id                  : _,
            linked_position_id        : _,
            user                      : _,
            collateral_token          : v5,
            collateral_token_decimal  : _,
            symbol                    : _,
            leverage_mbp              : _,
            reduce_only               : _,
            is_long                   : _,
            is_stop_order             : _,
            size                      : _,
            size_decimal              : _,
            trigger_price             : _,
            oracle_price_when_placing : _,
            u64_padding               : _,
        } = arg1;
        let v17 = v0;
        assert!(v5 == 0x1::type_name::get<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusBidReceipt>(), 0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::error::wrong_collateral_type());
        let v18 = if (0x2::dynamic_field::exists_<0x1::string::String>(&v17, 0x1::string::utf8(b"collateral"))) {
            0x2::dynamic_field::remove<0x1::string::String, vector<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusBidReceipt>>(&mut v17, 0x1::string::utf8(b"collateral"))
        } else {
            0x1::vector::empty<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusBidReceipt>()
        };
        0x2::dynamic_field::remove<0x1::string::String, 0x1::type_name::TypeName>(&mut v17, 0x1::string::utf8(b"deposit_token"));
        0x2::dynamic_field::remove<0x1::string::String, u64>(&mut v17, 0x1::string::utf8(b"portfolio_index"));
        0x2::object::delete(v17);
        v18
    }

    public(friend) fun remove_position<T0>(arg0: &0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::admin::Version, arg1: Position) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T0>, vector<u64>, vector<u64>) {
        0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::admin::version_check(arg0);
        let Position {
            id                            : v0,
            create_ts_ms                  : _,
            position_id                   : _,
            linked_order_ids              : v3,
            linked_order_prices           : v4,
            user                          : v5,
            is_long                       : _,
            size                          : _,
            size_decimal                  : _,
            collateral_token              : v9,
            collateral_token_decimal      : _,
            symbol                        : v11,
            collateral_amount             : _,
            reserve_amount                : _,
            average_price                 : _,
            entry_borrow_index            : _,
            entry_funding_rate_index_sign : _,
            entry_funding_rate_index      : _,
            unrealized_loss               : _,
            unrealized_funding_sign       : _,
            unrealized_funding_fee        : _,
            unrealized_trading_fee        : v21,
            unrealized_borrow_fee         : v22,
            unrealized_rebate             : _,
            option_collateral_info        : v24,
            u64_padding                   : _,
        } = arg1;
        let v26 = v0;
        0x1::option::destroy_none<OptionCollateralInfo>(v24);
        let v27 = 0x2::dynamic_field::remove<0x1::string::String, 0x2::balance::Balance<T0>>(&mut v26, 0x1::string::utf8(b"collateral"));
        0x2::object::delete(v26);
        let v28 = 0x2::balance::value<T0>(&v27);
        let v29 = if (v22 >= v28) {
            v28
        } else {
            v22
        };
        let v30 = 0x2::balance::split<T0>(&mut v27, v29);
        let v31 = v28 - 0x2::balance::value<T0>(&v30);
        let v32 = if (v21 >= v31) {
            v31
        } else {
            v22
        };
        let v33 = 0x2::balance::split<T0>(&mut v27, v32);
        let v34 = RemovePositionEvent{
            user                        : v5,
            collateral_token            : v9,
            symbol                      : v11,
            linked_order_ids            : v3,
            linked_order_prices         : v4,
            remaining_collateral_amount : 0x2::balance::value<T0>(&v27),
            realized_trading_fee_amount : 0x2::balance::value<T0>(&v33),
            realized_borrow_fee_amount  : 0x2::balance::value<T0>(&v30),
            u64_padding                 : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<RemovePositionEvent>(v34);
        0x2::balance::join<T0>(&mut v33, v30);
        (v27, v33, v3, v4)
    }

    public(friend) fun remove_position_linked_order_info(arg0: &mut Position, arg1: u64) {
        let (v0, v1) = 0x1::vector::index_of<u64>(&arg0.linked_order_ids, &arg1);
        assert!(v0, 0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::error::linked_order_id_not_existed());
        0x1::vector::remove<u64>(&mut arg0.linked_order_ids, v1);
        0x1::vector::remove<u64>(&mut arg0.linked_order_prices, v1);
    }

    public(friend) fun remove_position_with_bid_receipts(arg0: &0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::admin::Version, arg1: Position) : (vector<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusBidReceipt>, vector<u64>, vector<u64>, u64, bool, u64, u64, u64, u64) {
        0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::admin::version_check(arg0);
        let Position {
            id                            : v0,
            create_ts_ms                  : _,
            position_id                   : _,
            linked_order_ids              : v3,
            linked_order_prices           : v4,
            user                          : _,
            is_long                       : _,
            size                          : _,
            size_decimal                  : _,
            collateral_token              : _,
            collateral_token_decimal      : _,
            symbol                        : _,
            collateral_amount             : _,
            reserve_amount                : _,
            average_price                 : _,
            entry_borrow_index            : _,
            entry_funding_rate_index_sign : _,
            entry_funding_rate_index      : _,
            unrealized_loss               : v18,
            unrealized_funding_sign       : v19,
            unrealized_funding_fee        : v20,
            unrealized_trading_fee        : v21,
            unrealized_borrow_fee         : v22,
            unrealized_rebate             : v23,
            option_collateral_info        : _,
            u64_padding                   : _,
        } = arg1;
        let v26 = v0;
        0x2::object::delete(v26);
        (0x2::dynamic_field::remove<0x1::string::String, vector<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusBidReceipt>>(&mut v26, 0x1::string::utf8(b"collateral")), v3, v4, v18, v19, v20, v21, v22, v23)
    }

    public(friend) fun split_bid_receipt(arg0: &mut 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg1: &mut Position, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusBidReceipt {
        let (v0, v1, _) = 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::tds_user_entry::simple_split_bid_receipt(arg0, 0x1::option::borrow<OptionCollateralInfo>(&arg1.option_collateral_info).index, 0x2::dynamic_field::remove<0x1::string::String, vector<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusBidReceipt>>(&mut arg1.id, 0x1::string::utf8(b"collateral")), 0x1::option::some<u64>(arg2), arg3);
        let v3 = 0x1::vector::empty<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusBidReceipt>();
        0x1::vector::push_back<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusBidReceipt>(&mut v3, 0x1::option::destroy_some<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusBidReceipt>(v1));
        0x2::dynamic_field::add<0x1::string::String, vector<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusBidReceipt>>(&mut arg1.id, 0x1::string::utf8(b"collateral"), v3);
        0x1::option::destroy_some<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusBidReceipt>(v0)
    }

    public(friend) fun update_option_position_collateral_amount<T0>(arg0: &0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg1: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg2: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg3: &mut Position, arg4: &0x2::clock::Clock) {
        arg3.collateral_amount = calculate_intrinsic_value<T0>(arg0, arg1, arg2, 0x2::dynamic_field::borrow<0x1::string::String, vector<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusBidReceipt>>(&arg3.id, 0x1::string::utf8(b"collateral")), arg4);
    }

    public(friend) fun update_position_borrow_rate_and_funding_rate(arg0: &mut Position, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: bool, arg7: u64) : (u64, bool, u64) {
        let (_, v1) = calculate_period_borrow_cost(arg0, arg1, arg2, arg3, arg4, arg5);
        arg0.unrealized_borrow_fee = arg0.unrealized_borrow_fee + v1;
        arg0.entry_borrow_index = arg5;
        let (v2, v3) = calculate_position_funding_rate(arg0, arg1, arg2, arg3, arg4, arg6, arg7);
        arg0.unrealized_funding_sign = v2;
        arg0.unrealized_funding_fee = v3;
        arg0.entry_funding_rate_index_sign = arg6;
        arg0.entry_funding_rate_index = arg7;
        (arg0.unrealized_borrow_fee, v2, v3)
    }

    // decompiled from Move bytecode v6
}

