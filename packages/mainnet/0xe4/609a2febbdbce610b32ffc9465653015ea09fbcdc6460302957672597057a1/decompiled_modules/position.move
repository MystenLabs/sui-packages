module 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::position {
    struct Position has store {
        id: 0x2::object::UID,
        create_ts_ms: u64,
        update_ts_ms: u64,
        position_id: u64,
        linked_order_ids: vector<u64>,
        linked_order_prices: vector<u64>,
        user: address,
        is_long: bool,
        size: u64,
        size_decimal: u64,
        collateral_token: 0x1::type_name::TypeName,
        collateral_token_decimal: u64,
        symbol: 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::symbol::Symbol,
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
        u64_padding: vector<u64>,
    }

    struct TradingOrder has store {
        id: 0x2::object::UID,
        create_ts_ms: u64,
        order_id: u64,
        linked_position_id: 0x1::option::Option<u64>,
        user: address,
        collateral_token: 0x1::type_name::TypeName,
        collateral_token_decimal: u64,
        symbol: 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::symbol::Symbol,
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
        symbol: 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::symbol::Symbol,
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
        symbol: 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::symbol::Symbol,
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
        symbol: 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::symbol::Symbol,
        position_id: u64,
        realized_funding_sign: bool,
        realized_funding_fee: u64,
        realized_funding_fee_usd: u64,
        u64_padding: vector<u64>,
    }

    struct SettleSocializationEvent has copy, drop {
        user: address,
        position_id: u64,
        collateral_token: 0x1::type_name::TypeName,
        charge: u64,
        socialization_index: u64,
    }

    public(friend) fun order_filled<T0>(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &0x99ded857ba63fc66c21b3d48c0c964c88f4803b4d7a96a41623a30fb9d2cd5c2::ecosystem::Version, arg2: &mut 0x99ded857ba63fc66c21b3d48c0c964c88f4803b4d7a96a41623a30fb9d2cd5c2::leaderboard::TypusLeaderboardRegistry, arg3: &0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::competition::CompetitionConfig, arg4: TradingOrder, arg5: 0x1::option::Option<Position>, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: bool, arg13: u64, arg14: u64, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) : (Position, u64, u64, u64) {
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::version_check(arg0);
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
        } = arg4;
        let v17 = v0;
        assert!(v5 == 0x1::type_name::with_defining_ids<T0>(), 1);
        let v18 = if (0x1::option::is_some<Position>(&arg5)) {
            let v19 = 0x1::option::borrow<Position>(&arg5).size;
            if (v10 != 0x1::option::borrow<Position>(&arg5).is_long) {
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
        let (v21, v22) = calculate_trading_fee(v18, v13, arg7, arg8, arg9, arg10, arg14, v6);
        let v23 = 0x2::balance::value<T0>(&v20);
        let (v24, v25, v26, v27, v28) = if (0x1::option::is_some<Position>(&arg5)) {
            let v29 = 0x1::option::extract<Position>(&mut arg5);
            let v30 = get_position_size(&v29);
            let (v31, v32, v33, v34, v35, v36) = calculate_filled_(&v29, v9, v10, v18, arg9, arg10);
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
            let (_, _, _) = update_position_borrow_rate_and_funding_rate(v39, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
            v29.update_ts_ms = 0x2::clock::timestamp_ms(arg15);
            v29.is_long = v34;
            v29.size = v35;
            v29.average_price = v36;
            v29.reserve_amount = calculate_reserve_amount(v35, v29.size_decimal, 0x2::balance::value<T0>(0x2::dynamic_field::borrow<0x1::string::String, 0x2::balance::Balance<T0>>(&v29.id, 0x1::string::utf8(b"collateral"))) + v23, v29.collateral_token_decimal, arg7, arg8, arg9, arg10);
            v29.unrealized_trading_fee = v29.unrealized_trading_fee + v21;
            (v29, v31, v32, v33, v38)
        } else {
            let v43 = Position{
                id                            : 0x2::object::new(arg16),
                create_ts_ms                  : 0x2::clock::timestamp_ms(arg15),
                update_ts_ms                  : 0x2::clock::timestamp_ms(arg15),
                position_id                   : arg6,
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
                reserve_amount                : calculate_reserve_amount(v12, v13, v23, v6, arg7, arg8, arg9, arg10),
                average_price                 : arg9,
                entry_borrow_index            : arg11,
                entry_funding_rate_index_sign : arg12,
                entry_funding_rate_index      : arg13,
                unrealized_loss               : 0,
                unrealized_funding_sign       : true,
                unrealized_funding_fee        : 0,
                unrealized_trading_fee        : v21,
                unrealized_borrow_fee         : 0,
                unrealized_rebate             : 0,
                u64_padding                   : 0x1::vector::empty<u64>(),
            };
            0x2::dynamic_field::add<0x1::string::String, 0x2::balance::Balance<T0>>(&mut v43.id, 0x1::string::utf8(b"collateral"), 0x2::balance::zero<T0>());
            (v43, false, false, 0, v12)
        };
        let v44 = v24;
        0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::balance::Balance<T0>>(&mut v44.id, 0x1::string::utf8(b"collateral")), v20);
        let v45 = 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::usd_to_amount(v27, v44.collateral_token_decimal, arg7, arg8);
        let v46 = if (!v26) {
            v45
        } else {
            0
        };
        let v47 = if (v25 && v26) {
            v45
        } else {
            0
        };
        0x2::object::delete(v17);
        0x1::option::destroy_none<Position>(arg5);
        v44.collateral_amount = 0x2::balance::value<T0>(0x2::dynamic_field::borrow<0x1::string::String, 0x2::balance::Balance<T0>>(&v44.id, 0x1::string::utf8(b"collateral")));
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::competition::add_score(arg0, arg1, arg2, arg3, 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::amount_to_usd(v28, v13, arg9, arg10), v4, arg15, arg16);
        let v48 = if (0x1::option::is_none<Position>(&arg5)) {
            0x1::option::some<u64>(v44.position_id)
        } else {
            0x1::option::none<u64>()
        };
        let v49 = if (v10) {
            1
        } else {
            0
        };
        let v50 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v50, v49);
        let v51 = OrderFilledEvent{
            user                   : v4,
            collateral_token       : v5,
            symbol                 : v7,
            order_id               : v2,
            linked_position_id     : v3,
            new_position_id        : v48,
            filled_size            : v28,
            filled_price           : arg9,
            position_side          : v44.is_long,
            position_size          : v44.size,
            position_average_price : v44.average_price,
            realized_trading_fee   : v21,
            realized_borrow_fee    : v44.unrealized_borrow_fee,
            realized_fee_in_usd    : 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::amount_to_usd(v21 + v44.unrealized_borrow_fee, v44.collateral_token_decimal, arg7, arg8),
            realized_amount        : v45,
            realized_amount_sign   : v26,
            u64_padding            : v50,
        };
        0x2::event::emit<OrderFilledEvent>(v51);
        (v44, v46, v47, v22)
    }

    public(friend) fun add_position_linked_order_info(arg0: &mut Position, arg1: u64, arg2: u64) {
        0x1::vector::push_back<u64>(&mut arg0.linked_order_ids, arg1);
        0x1::vector::push_back<u64>(&mut arg0.linked_order_prices, arg2);
        assert!(0x1::vector::length<u64>(&arg0.linked_order_ids) <= 5, 9);
    }

    fun calculate_filled_(arg0: &Position, arg1: bool, arg2: bool, arg3: u64, arg4: u64, arg5: u64) : (bool, bool, u64, bool, u64, u64) {
        let v0 = false;
        let v1 = 0;
        let v2 = false;
        let (v3, v4, v5) = if (arg2) {
            if (arg0.is_long) {
                assert!(!arg1, 0);
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
            assert!(!arg1, 0);
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

    fun calculate_period_borrow_cost(arg0: &Position, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : (u64, u64) {
        (0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::amount_to_usd(arg0.size, arg0.size_decimal, arg3, arg4), (((calculate_reserve_amount(arg0.size, arg0.size_decimal, arg0.collateral_amount, arg0.collateral_token_decimal, arg1, arg2, arg3, arg4) as u128) * ((arg5 - arg0.entry_borrow_index) as u128) / (0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::multiplier(0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::get_borrow_rate_decimal()) as u128)) as u64))
    }

    public(friend) fun calculate_position_equity_usd(arg0: &Position, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: bool, arg8: u64) : (u64, bool) {
        let (v0, v1) = calculate_position_funding_rate(arg0, arg1, arg2, arg3, arg4, arg7, arg8);
        let v2 = 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::amount_to_usd(v1, arg0.collateral_token_decimal, arg1, arg2);
        let (v3, v4, v5) = calculate_unrealized_pnl(arg0, arg3, arg4, arg5);
        let (_, v7) = calculate_period_borrow_cost(arg0, arg1, arg2, arg3, arg4, arg6);
        let v8 = if (v3) {
            v4
        } else {
            0
        };
        let v9 = if (v0) {
            0
        } else {
            v2
        };
        let v10 = 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::amount_to_usd(arg0.collateral_amount, arg0.collateral_token_decimal, arg1, arg2) + v5 + v8 + v9;
        let v11 = if (v3) {
            0
        } else {
            v4
        };
        let v12 = if (v0) {
            v2
        } else {
            0
        };
        let v13 = 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::amount_to_usd(arg0.unrealized_borrow_fee + v7, arg0.collateral_token_decimal, arg1, arg2) + v11 + v12;
        let (v14, v15) = if (v13 > v10) {
            (true, v13 - v10)
        } else {
            (false, v10 - v13)
        };
        (v15, v14)
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
        let v2 = (((0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::usd_to_amount(0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::amount_to_usd(arg0.size, arg0.size_decimal, arg3, arg4), arg0.collateral_token_decimal, arg1, arg2) as u128) * (v1 as u128) / (0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::multiplier(0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::get_funding_rate_decimal()) as u128)) as u64);
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
        (v0, ((((((arg1 as u128) * (v1 as u128) / (0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::multiplier(arg4) as u128)) as u64) as u128) * (0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::multiplier(0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::get_usd_decimal()) as u128) / (0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::multiplier(arg5) as u128)) as u64))
    }

    fun calculate_reserve_amount(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64) : u64 {
        let v0 = 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::usd_to_amount(0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::amount_to_usd(arg0, arg1, arg6, arg7), arg3, arg4, arg5);
        if (arg2 >= v0) {
            0
        } else {
            v0 - arg2
        }
    }

    public(friend) fun calculate_trading_fee(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64) : (u64, u64) {
        let v0 = (((0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::amount_to_usd(arg0, arg1, arg4, arg5) as u128) * (arg6 as u128) / (0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::get_mbp_scale() as u128)) as u64);
        (0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::usd_to_amount(v0, arg7, arg2, arg3), v0)
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
        let v0 = (((0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::amount_to_usd(arg0.size, arg0.size_decimal, arg1, arg2) as u128) * (arg3 as u128) / (0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::get_mbp_scale() as u128)) as u64);
        let v1 = (((arg0.size as u128) * (0x1::u64::diff(arg1, arg0.average_price) as u128) / (0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::multiplier(arg0.size_decimal + arg2 - 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::get_usd_decimal()) as u128)) as u64);
        let v2 = arg0.is_long && arg1 > arg0.average_price || arg1 < arg0.average_price;
        let v3 = v2;
        let v4 = if (v2) {
            if (v1 < v0) {
                v3 = false;
                v0 - v1
            } else {
                v1 - v0
            }
        } else {
            v1 + v0
        };
        (v3, v4, v0)
    }

    public(friend) fun check_order_filled(arg0: &TradingOrder, arg1: u64) : bool {
        arg0.is_long && (arg0.is_stop_order && arg1 >= arg0.trigger_price || arg1 <= arg0.trigger_price) || arg0.is_stop_order && arg1 <= arg0.trigger_price || arg1 >= arg0.trigger_price
    }

    public(friend) fun check_position_liquidated(arg0: &Position, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: bool, arg9: u64) : bool {
        check_position_liquidated_with_pending_debt(arg0, 0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
    }

    public(friend) fun check_position_liquidated_with_pending_debt(arg0: &Position, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: bool, arg10: u64) : bool {
        let (v0, v1) = calculate_position_funding_rate(arg0, arg2, arg3, arg4, arg5, arg9, arg10);
        let v2 = 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::amount_to_usd(v1, arg0.collateral_token_decimal, arg2, arg3);
        let v3 = collateral_with_pnl(arg0, arg2, arg3, arg4, arg5, arg6);
        let (v4, v5) = calculate_period_borrow_cost(arg0, arg2, arg3, arg4, arg5, arg8);
        let v6 = 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::amount_to_usd(arg0.collateral_amount, arg0.collateral_token_decimal, arg2, arg3);
        let (v7, v8, _) = calculate_unrealized_pnl(arg0, arg4, arg5, arg6);
        let v10 = if (!v7 && v8 > v6) {
            v8 - v6
        } else {
            0
        };
        let v11 = 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::amount_to_usd(arg0.unrealized_borrow_fee + v5 + arg1, arg0.collateral_token_decimal, arg2, arg3) + v10;
        let v12 = if (v3 > v11) {
            let v13 = v3 - v11;
            if (v0) {
                if (v13 > v2) {
                    v13 - v2
                } else {
                    0
                }
            } else {
                v13 + v2
            }
        } else if (v0) {
            0
        } else if (v3 + v2 > v11) {
            v3 + v2 - v11
        } else {
            0
        };
        v12 <= (((arg7 as u128) * (v4 as u128) / (0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::get_bp_scale() as u128)) as u64)
    }

    public(friend) fun check_position_update_timestamp(arg0: &Position, arg1: &0x2::clock::Clock, arg2: u64) {
        assert!(check_position_update_timestamp_(arg0, arg1, arg2), 10);
    }

    public(friend) fun check_position_update_timestamp_(arg0: &Position, arg1: &0x2::clock::Clock, arg2: u64) : bool {
        0x2::clock::timestamp_ms(arg1) >= arg0.update_ts_ms + arg2
    }

    fun collateral_with_pnl(arg0: &Position, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : u64 {
        let v0 = 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::amount_to_usd(arg0.collateral_amount, arg0.collateral_token_decimal, arg1, arg2);
        let (v1, v2, _) = calculate_unrealized_pnl(arg0, arg3, arg4, arg5);
        if (v1) {
            v0 + v2
        } else if (v0 > v2) {
            v0 - v2
        } else {
            0
        }
    }

    public(friend) fun create_order<T0>(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::symbol::Symbol, arg2: u64, arg3: bool, arg4: bool, arg5: bool, arg6: u64, arg7: u64, arg8: u64, arg9: 0x2::balance::Balance<T0>, arg10: u64, arg11: 0x1::option::Option<u64>, arg12: u64, arg13: u64, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) : TradingOrder {
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::version_check(arg0);
        let v0 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v0, 0x2::balance::value<T0>(&arg9));
        let v1 = TradingOrder{
            id                        : 0x2::object::new(arg15),
            create_ts_ms              : 0x2::clock::timestamp_ms(arg14),
            order_id                  : arg12,
            linked_position_id        : arg11,
            user                      : 0x2::tx_context::sender(arg15),
            collateral_token          : 0x1::type_name::with_defining_ids<T0>(),
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

    public(friend) fun emit_realized_funding_event(arg0: address, arg1: 0x1::type_name::TypeName, arg2: 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::symbol::Symbol, arg3: u64, arg4: bool, arg5: u64, arg6: u64, arg7: vector<u64>) {
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

    public(friend) fun funding_receivable_in_collateral(arg0: &Position, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: bool, arg6: u64) : u64 {
        let (v0, v1) = calculate_position_funding_rate(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        if (v0) {
            0
        } else {
            v1
        }
    }

    public(friend) fun get_max_order_type_tag() : u8 {
        3
    }

    public(friend) fun get_order_collateral_amount<T0>(arg0: &TradingOrder) : u64 {
        if (0x2::dynamic_field::exists_with_type<0x1::string::String, 0x2::balance::Balance<T0>>(&arg0.id, 0x1::string::utf8(b"collateral"))) {
            0x2::balance::value<T0>(0x2::dynamic_field::borrow<0x1::string::String, 0x2::balance::Balance<T0>>(&arg0.id, 0x1::string::utf8(b"collateral")))
        } else {
            0
        }
    }

    public(friend) fun get_order_collateral_token(arg0: &TradingOrder) : 0x1::type_name::TypeName {
        arg0.collateral_token
    }

    public(friend) fun get_order_collateral_token_decimal(arg0: &TradingOrder) : u64 {
        arg0.collateral_token_decimal
    }

    public(friend) fun get_order_expires_ts_ms(arg0: &TradingOrder) : u64 {
        0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::get_u64_vector_value(&arg0.u64_padding, 1)
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
        (0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::symbol::base_token(&arg0.symbol), 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::symbol::quote_token(&arg0.symbol))
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

    public(friend) fun get_position_side(arg0: &Position) : bool {
        arg0.is_long
    }

    public(friend) fun get_position_size(arg0: &Position) : u64 {
        arg0.size
    }

    public(friend) fun get_position_size_decimal(arg0: &Position) : u64 {
        arg0.size_decimal
    }

    public(friend) fun get_position_symbol(arg0: &Position) : 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::symbol::Symbol {
        arg0.symbol
    }

    public(friend) fun get_position_unrealized_borrow_fee(arg0: &Position) : u64 {
        arg0.unrealized_borrow_fee
    }

    public(friend) fun get_position_user(arg0: &Position) : address {
        arg0.user
    }

    public(friend) fun get_reserve_amount(arg0: &Position) : u64 {
        arg0.reserve_amount
    }

    public(friend) fun get_socialization_pending_charge(arg0: &Position) : u64 {
        0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::get_u64_vector_value(&arg0.u64_padding, 1)
    }

    public(friend) fun increase_collateral<T0>(arg0: &mut Position, arg1: 0x2::balance::Balance<T0>, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = 0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::balance::Balance<T0>>(&mut arg0.id, 0x1::string::utf8(b"collateral"));
        0x2::balance::join<T0>(v0, arg1);
        arg0.collateral_amount = 0x2::balance::value<T0>(v0);
        arg0.reserve_amount = calculate_reserve_amount(arg0.size, arg0.size_decimal, arg0.collateral_amount, arg0.collateral_token_decimal, arg2, arg3, arg4, arg5);
    }

    public(friend) fun manager_create_reduce_only_order<T0>(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::symbol::Symbol, arg2: bool, arg3: u64, arg4: u64, arg5: u64, arg6: 0x2::balance::Balance<T0>, arg7: u64, arg8: u64, arg9: address, arg10: u64, arg11: u64, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : TradingOrder {
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::verify(arg0, arg13);
        let v0 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v0, 0x2::balance::value<T0>(&arg6));
        let v1 = TradingOrder{
            id                        : 0x2::object::new(arg13),
            create_ts_ms              : 0x2::clock::timestamp_ms(arg12),
            order_id                  : arg10,
            linked_position_id        : 0x1::option::some<u64>(arg8),
            user                      : arg9,
            collateral_token          : 0x1::type_name::with_defining_ids<T0>(),
            collateral_token_decimal  : arg7,
            symbol                    : arg1,
            leverage_mbp              : 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::get_mbp_scale(),
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

    public(friend) fun max_releasing_collateral_amount(arg0: &Position, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: bool, arg8: u64, arg9: u64) : u64 {
        let v0 = collateral_with_pnl(arg0, arg1, arg2, arg3, arg4, arg5);
        let (v1, v2) = calculate_period_borrow_cost(arg0, arg1, arg2, arg3, arg4, arg6);
        let (v3, v4) = calculate_position_funding_rate(arg0, arg1, arg2, arg3, arg4, arg7, arg8);
        let v5 = if (v3) {
            v4
        } else {
            0
        };
        let v6 = 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::amount_to_usd(arg0.unrealized_borrow_fee + v2 + v5, arg0.collateral_token_decimal, arg1, arg2);
        let v7 = (((0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::get_mbp_scale() as u128) * (v1 as u128) / (arg9 as u128)) as u64);
        if (v0 >= v6) {
            let v9 = v0 - v6;
            if (v9 > v7) {
                0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::usd_to_amount(v9 - v7, arg0.collateral_token_decimal, arg1, arg2)
            } else {
                0
            }
        } else {
            0
        }
    }

    public(friend) fun pending_debts_in_collateral(arg0: &Position, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: bool, arg7: u64) : u64 {
        let (_, v1) = calculate_period_borrow_cost(arg0, arg1, arg2, arg3, arg4, arg5);
        let (v2, v3) = calculate_position_funding_rate(arg0, arg1, arg2, arg3, arg4, arg6, arg7);
        let v4 = if (v2) {
            v3
        } else {
            0
        };
        arg0.unrealized_borrow_fee + v1 + v4
    }

    public(friend) fun pending_socialization_charge(arg0: &Position, arg1: u64, arg2: u64) : u64 {
        let v0 = 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::get_u64_vector_value(&arg0.u64_padding, 0);
        if (arg1 <= v0) {
            return 0
        };
        let v1 = (arg0.reserve_amount as u128) * ((arg1 - v0) as u128) / (arg2 as u128);
        if (v1 > 18446744073709551615) {
            18446744073709551615
        } else {
            (v1 as u64)
        }
    }

    public(friend) fun realize_funding_fee<T0>(arg0: &mut 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::LiquidityPool, arg1: &mut Position, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        if (arg1.unrealized_funding_fee > 0) {
            if (arg1.unrealized_funding_sign) {
                let v0 = 0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::balance::Balance<T0>>(&mut arg1.id, 0x1::string::utf8(b"collateral"));
                let v1 = if (arg1.unrealized_funding_fee > 0x2::balance::value<T0>(v0)) {
                    0x2::balance::value<T0>(v0)
                } else {
                    arg1.unrealized_funding_fee
                };
                let v2 = 0x2::balance::split<T0>(v0, v1);
                arg1.collateral_amount = 0x2::balance::value<T0>(v0);
                arg1.unrealized_funding_fee = arg1.unrealized_funding_fee - 0x2::balance::value<T0>(&v2);
                emit_realized_funding_event(arg1.user, arg1.collateral_token, arg1.symbol, arg1.position_id, arg1.unrealized_funding_sign, 0x2::balance::value<T0>(&v2), 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::amount_to_usd(0x2::balance::value<T0>(&v2), arg1.collateral_token_decimal, arg2, arg3), 0x1::vector::empty<u64>());
                0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::put_collateral<T0>(arg0, v2, arg2, arg3);
            } else {
                let v3 = 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::request_collateral<T0>(arg0, arg1.unrealized_funding_fee, arg2, arg3);
                let v4 = 0x2::balance::value<T0>(&v3);
                arg1.unrealized_funding_fee = arg1.unrealized_funding_fee - v4;
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v3, arg4), arg1.user);
                emit_realized_funding_event(arg1.user, arg1.collateral_token, arg1.symbol, arg1.position_id, arg1.unrealized_funding_sign, v4, 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::amount_to_usd(v4, arg1.collateral_token_decimal, arg2, arg3), 0x1::vector::empty<u64>());
            };
        };
    }

    public(friend) fun realize_position_pnl_and_fee<T0>(arg0: &mut 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &mut 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::LiquidityPool, arg2: &mut Position, arg3: u64, arg4: u64, arg5: u64, arg6: bool, arg7: u64, arg8: u64, arg9: u64) : 0x2::balance::Balance<T0> {
        let v0 = arg2.unrealized_trading_fee + arg2.unrealized_borrow_fee;
        let v1 = 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::request_collateral<T0>(arg1, arg3, arg8, arg9);
        let v2 = 0x2::dynamic_field::remove<0x1::string::String, 0x2::balance::Balance<T0>>(&mut arg2.id, 0x1::string::utf8(b"collateral"));
        let v3 = 0x2::balance::value<T0>(&v2);
        0x2::balance::join<T0>(&mut v1, v2);
        let v4 = 0x2::balance::split<T0>(&mut v1, arg4);
        let v5 = 0x2::balance::split<T0>(&mut v1, v0);
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::charge_fee<T0>(arg0, 0x2::balance::split<T0>(&mut v5, ((((v0 - 0x1::u64::min(0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::get_u64_vector_value(&arg2.u64_padding, 1), v0)) as u128) * (arg7 as u128) / (0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::get_bp_scale() as u128)) as u64)));
        0x2::balance::join<T0>(&mut v4, v5);
        let v6 = arg2.reserve_amount;
        let v7 = if (v6 > arg5) {
            v6 - arg5
        } else {
            arg5 - v6
        };
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::order_filled<T0>(arg1, arg6, v6 > arg5, v7, v4);
        if (arg2.unrealized_funding_fee > 0) {
            if (arg2.unrealized_funding_sign) {
                let v8 = 0x2::balance::split<T0>(&mut v1, arg2.unrealized_funding_fee);
                arg2.unrealized_funding_fee = arg2.unrealized_funding_fee - 0x2::balance::value<T0>(&v8);
                emit_realized_funding_event(arg2.user, arg2.collateral_token, arg2.symbol, arg2.position_id, arg2.unrealized_funding_sign, 0x2::balance::value<T0>(&v8), 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::amount_to_usd(0x2::balance::value<T0>(&v8), arg2.collateral_token_decimal, arg8, arg9), 0x1::vector::empty<u64>());
                0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::put_collateral<T0>(arg1, v8, arg8, arg9);
            } else {
                let v9 = 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool::request_collateral<T0>(arg1, arg2.unrealized_funding_fee, arg8, arg9);
                let v10 = 0x2::balance::value<T0>(&v9);
                0x2::balance::join<T0>(&mut v1, v9);
                arg2.unrealized_funding_fee = arg2.unrealized_funding_fee - v10;
                emit_realized_funding_event(arg2.user, arg2.collateral_token, arg2.symbol, arg2.position_id, arg2.unrealized_funding_sign, v10, 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::amount_to_usd(v10, arg2.collateral_token_decimal, arg8, arg9), 0x1::vector::empty<u64>());
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
        0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::set_u64_vector_value(&mut arg2.u64_padding, 1, 0);
        arg2.collateral_amount = 0x2::balance::value<T0>(&v1);
        0x2::balance::split<T0>(&mut v1, v11)
    }

    public(friend) fun release_collateral<T0>(arg0: &mut Position, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::balance::Balance<T0>>(&mut arg0.id, 0x1::string::utf8(b"collateral"));
        arg0.collateral_amount = 0x2::balance::value<T0>(v0);
        arg0.reserve_amount = calculate_reserve_amount(arg0.size, arg0.size_decimal, arg0.collateral_amount, arg0.collateral_token_decimal, arg2, arg3, arg4, arg5);
        0x2::balance::split<T0>(v0, arg1)
    }

    public(friend) fun remove_order<T0>(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: TradingOrder) : 0x2::balance::Balance<T0> {
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::version_check(arg0);
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

    public(friend) fun remove_position<T0>(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: Position) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T0>, vector<u64>, vector<u64>) {
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::version_check(arg0);
        let Position {
            id                            : v0,
            create_ts_ms                  : _,
            update_ts_ms                  : _,
            position_id                   : _,
            linked_order_ids              : v4,
            linked_order_prices           : v5,
            user                          : v6,
            is_long                       : _,
            size                          : _,
            size_decimal                  : _,
            collateral_token              : v10,
            collateral_token_decimal      : _,
            symbol                        : v12,
            collateral_amount             : _,
            reserve_amount                : _,
            average_price                 : _,
            entry_borrow_index            : _,
            entry_funding_rate_index_sign : _,
            entry_funding_rate_index      : _,
            unrealized_loss               : _,
            unrealized_funding_sign       : _,
            unrealized_funding_fee        : _,
            unrealized_trading_fee        : v22,
            unrealized_borrow_fee         : v23,
            unrealized_rebate             : _,
            u64_padding                   : _,
        } = arg1;
        let v26 = v0;
        let v27 = 0x2::dynamic_field::remove<0x1::string::String, 0x2::balance::Balance<T0>>(&mut v26, 0x1::string::utf8(b"collateral"));
        0x2::object::delete(v26);
        let v28 = 0x2::balance::value<T0>(&v27);
        let v29 = if (v23 >= v28) {
            v28
        } else {
            v23
        };
        let v30 = 0x2::balance::split<T0>(&mut v27, v29);
        let v31 = v28 - 0x2::balance::value<T0>(&v30);
        let v32 = if (v22 >= v31) {
            v31
        } else {
            v22
        };
        let v33 = 0x2::balance::split<T0>(&mut v27, v32);
        let v34 = RemovePositionEvent{
            user                        : v6,
            collateral_token            : v10,
            symbol                      : v12,
            linked_order_ids            : v4,
            linked_order_prices         : v5,
            remaining_collateral_amount : 0x2::balance::value<T0>(&v27),
            realized_trading_fee_amount : 0x2::balance::value<T0>(&v33),
            realized_borrow_fee_amount  : 0x2::balance::value<T0>(&v30),
            u64_padding                 : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<RemovePositionEvent>(v34);
        0x2::balance::join<T0>(&mut v33, v30);
        (v27, v33, v4, v5)
    }

    public(friend) fun remove_position_linked_order_info(arg0: &mut Position, arg1: u64) {
        let (v0, v1) = 0x1::vector::index_of<u64>(&arg0.linked_order_ids, &arg1);
        assert!(v0, 4);
        0x1::vector::remove<u64>(&mut arg0.linked_order_ids, v1);
        0x1::vector::remove<u64>(&mut arg0.linked_order_prices, v1);
    }

    public(friend) fun reserve_after_reduce(arg0: &Position, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) : u64 {
        if (arg1 >= arg0.size) {
            return 0
        };
        let v0 = if (arg0.collateral_amount > arg2) {
            arg0.collateral_amount - arg2
        } else {
            0
        };
        calculate_reserve_amount(arg0.size - arg1, arg0.size_decimal, v0, arg0.collateral_token_decimal, arg3, arg4, arg5, arg6)
    }

    public(friend) fun set_order_expires_ts_ms(arg0: &mut TradingOrder, arg1: u64) {
        0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::set_u64_vector_value(&mut arg0.u64_padding, 1, arg1);
    }

    public(friend) fun set_socialization_entry_index(arg0: &mut Position, arg1: u64) {
        0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::set_u64_vector_value(&mut arg0.u64_padding, 0, arg1);
    }

    public(friend) fun settle_socialization(arg0: &mut Position, arg1: u64, arg2: u64) : u64 {
        if (arg1 <= 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::get_u64_vector_value(&arg0.u64_padding, 0)) {
            return 0
        };
        let v0 = pending_socialization_charge(arg0, arg1, arg2);
        let v1 = if (arg0.unrealized_borrow_fee > 18446744073709551615 - v0) {
            18446744073709551615
        } else {
            arg0.unrealized_borrow_fee + v0
        };
        arg0.unrealized_borrow_fee = v1;
        let v2 = 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::get_u64_vector_value(&arg0.u64_padding, 1);
        let v3 = if (v2 > 18446744073709551615 - v0) {
            18446744073709551615
        } else {
            v2 + v0
        };
        0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::set_u64_vector_value(&mut arg0.u64_padding, 1, v3);
        0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::set_u64_vector_value(&mut arg0.u64_padding, 0, arg1);
        let v4 = SettleSocializationEvent{
            user                : arg0.user,
            position_id         : arg0.position_id,
            collateral_token    : arg0.collateral_token,
            charge              : v0,
            socialization_index : arg1,
        };
        0x2::event::emit<SettleSocializationEvent>(v4);
        v0
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

    // decompiled from Move bytecode v7
}

