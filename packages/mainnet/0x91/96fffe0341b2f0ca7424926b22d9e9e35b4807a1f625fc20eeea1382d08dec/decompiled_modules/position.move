module 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position {
    struct Position has store {
        collateral: u256,
        base_asset_amount: u256,
        quote_asset_notional_amount: u256,
        cum_funding_rate_long: u256,
        cum_funding_rate_short: u256,
        asks_quantity: u256,
        bids_quantity: u256,
        pending_orders: u64,
        initial_margin_ratio: u256,
    }

    public fun abs_net_base(arg0: &Position) : u256 {
        let v0 = arg0.base_asset_amount;
        0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::max(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::abs(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::add(v0, arg0.bids_quantity)), 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::abs(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::sub(v0, arg0.asks_quantity)))
    }

    public fun add_base_to_position(arg0: &mut Position, arg1: bool, arg2: u256, arg3: u256) : (u256, u256) {
        let v0 = arg0.base_asset_amount;
        if (arg1) {
            if (v0 < 57896044618658097711785492504343953926634992332820282019728792003956564819968) {
                let v1 = arg0.quote_asset_notional_amount;
                if (arg2 <= v0) {
                    let v2 = (v1 * arg2 + v0 - 1) / v0;
                    arg0.base_asset_amount = v0 - arg2;
                    arg0.quote_asset_notional_amount = v1 - v2;
                    if (arg3 >= v2) {
                        return (arg3 - v2, arg0.base_asset_amount)
                    };
                    return ((v2 - arg3 ^ 57896044618658097711785492504343953926634992332820282019728792003956564819967) + 1 ^ 57896044618658097711785492504343953926634992332820282019728792003956564819968, arg0.base_asset_amount)
                };
                let v3 = arg3 * v0 / arg2;
                let v4 = if (v3 >= v1) {
                    v3 - v1
                } else {
                    (v1 - v3 ^ 57896044618658097711785492504343953926634992332820282019728792003956564819967) + 1 ^ 57896044618658097711785492504343953926634992332820282019728792003956564819968
                };
                arg0.base_asset_amount = (arg2 - v0 ^ 115792089237316195423570985008687907853269984665640564039457584007913129639935) + 1;
                arg0.quote_asset_notional_amount = (arg3 - v3 ^ 57896044618658097711785492504343953926634992332820282019728792003956564819967) + 1 ^ 57896044618658097711785492504343953926634992332820282019728792003956564819968;
                return (v4, arg0.base_asset_amount)
            };
            let v5 = (v0 ^ 115792089237316195423570985008687907853269984665640564039457584007913129639935) + 1 + arg2;
            assert!(v5 < 57896044618658097711785492504343953926634992332820282019728792003956564819968, 2000);
            arg0.base_asset_amount = (v5 ^ 115792089237316195423570985008687907853269984665640564039457584007913129639935) + 1;
            let v6 = ((arg0.quote_asset_notional_amount ^ 57896044618658097711785492504343953926634992332820282019728792003956564819967) + 1 ^ 57896044618658097711785492504343953926634992332820282019728792003956564819968) + arg3;
            assert!(v6 < 57896044618658097711785492504343953926634992332820282019728792003956564819968, 2000);
            arg0.quote_asset_notional_amount = (v6 ^ 57896044618658097711785492504343953926634992332820282019728792003956564819967) + 1 ^ 57896044618658097711785492504343953926634992332820282019728792003956564819968;
            return (0, arg0.base_asset_amount)
        };
        if (v0 < 57896044618658097711785492504343953926634992332820282019728792003956564819968) {
            let v7 = v0 + arg2;
            assert!(v7 < 57896044618658097711785492504343953926634992332820282019728792003956564819968, 2000);
            let v8 = arg0.quote_asset_notional_amount + arg3;
            assert!(v8 < 57896044618658097711785492504343953926634992332820282019728792003956564819968, 2000);
            arg0.base_asset_amount = v7;
            arg0.quote_asset_notional_amount = v8;
            return (0, arg0.base_asset_amount)
        };
        let v9 = (v0 ^ 115792089237316195423570985008687907853269984665640564039457584007913129639935) + 1;
        let v10 = (arg0.quote_asset_notional_amount ^ 57896044618658097711785492504343953926634992332820282019728792003956564819967) + 1 ^ 57896044618658097711785492504343953926634992332820282019728792003956564819968;
        if (arg2 <= v9) {
            let v11 = v10 * arg2 / v9;
            arg0.base_asset_amount = (v9 - arg2 ^ 57896044618658097711785492504343953926634992332820282019728792003956564819967) + 1 ^ 57896044618658097711785492504343953926634992332820282019728792003956564819968;
            arg0.quote_asset_notional_amount = (v10 - v11 ^ 57896044618658097711785492504343953926634992332820282019728792003956564819967) + 1 ^ 57896044618658097711785492504343953926634992332820282019728792003956564819968;
            if (v11 >= arg3) {
                return (v11 - arg3, arg0.base_asset_amount)
            };
            return ((arg3 - v11 ^ 57896044618658097711785492504343953926634992332820282019728792003956564819967) + 1 ^ 57896044618658097711785492504343953926634992332820282019728792003956564819968, arg0.base_asset_amount)
        };
        arg0.base_asset_amount = arg2 - v9;
        let v12 = (arg3 * v9 - 1) / arg2 + 1;
        let v4 = if (v10 >= v12) {
            v10 - v12
        } else {
            (v12 - v10 ^ 57896044618658097711785492504343953926634992332820282019728792003956564819967) + 1 ^ 57896044618658097711785492504343953926634992332820282019728792003956564819968
        };
        arg0.quote_asset_notional_amount = arg3 - v12;
        (v4, arg0.base_asset_amount)
    }

    public fun add_to_collateral(arg0: &mut Position, arg1: u256) {
        arg0.collateral = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::add(arg0.collateral, arg1);
    }

    public fun add_to_collateral_usd(arg0: &mut Position, arg1: u256, arg2: u256) : u256 {
        let v0 = if (arg1 >= 57896044618658097711785492504343953926634992332820282019728792003956564819968) {
            let v1 = (((arg1 ^ 115792089237316195423570985008687907853269984665640564039457584007913129639935) + 1) * 1000000000000000000 - 1) / arg2 + 1;
            if (arg0.collateral >= 57896044618658097711785492504343953926634992332820282019728792003956564819968) {
                let v2 = arg0.collateral - v1;
                if (v2 < 57896044618658097711785492504343953926634992332820282019728792003956564819968) {
                    abort 2000
                };
                v2
            } else if (arg0.collateral >= v1) {
                arg0.collateral - v1
            } else {
                (v1 - arg0.collateral ^ 115792089237316195423570985008687907853269984665640564039457584007913129639935) + 1
            }
        } else {
            let v3 = arg1 * 1000000000000000000 / arg2;
            if (arg0.collateral >= 57896044618658097711785492504343953926634992332820282019728792003956564819968) {
                let v4 = (arg0.collateral ^ 115792089237316195423570985008687907853269984665640564039457584007913129639935) + 1;
                if (v3 >= v4) {
                    v3 - v4
                } else {
                    (v4 - v3 ^ 115792089237316195423570985008687907853269984665640564039457584007913129639935) + 1
                }
            } else {
                let v5 = arg0.collateral + v3;
                if (v5 >= 57896044618658097711785492504343953926634992332820282019728792003956564819968) {
                    abort 2000
                };
                v5
            }
        };
        arg0.collateral = v0;
        v0
    }

    public fun add_to_pending_amount(arg0: &mut Position, arg1: bool, arg2: u256) {
        if (arg1) {
            arg0.asks_quantity = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::add(arg0.asks_quantity, arg2);
        } else {
            arg0.bids_quantity = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::add(arg0.bids_quantity, arg2);
        };
    }

    public fun apply_maker_fill_or_restore_if_bad_debt(arg0: &mut Position, arg1: bool, arg2: u256, arg3: u256, arg4: u256, arg5: u256, arg6: u256, arg7: u256, arg8: u256, arg9: 0x1::option::Option<u256>) : (bool, u256, u256) {
        let v0 = arg0.collateral;
        let v1 = arg0.base_asset_amount;
        let v2 = arg0.quote_asset_notional_amount;
        let (v3, v4) = add_base_to_position(arg0, arg1, arg2, arg3);
        add_to_collateral_usd(arg0, 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::sub(v3, arg4), arg6);
        let v5 = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::add(effective_collateral_usd_value(arg0, arg6, arg8), unrealized_pnl(arg0, arg7));
        if (v5 >= 57896044618658097711785492504343953926634992332820282019728792003956564819968) {
        } else {
            let v6 = arg0.base_asset_amount;
            let v7 = if (v6 >= 57896044618658097711785492504343953926634992332820282019728792003956564819968) {
                (v6 ^ 115792089237316195423570985008687907853269984665640564039457584007913129639935) + 1
            } else {
                v6
            };
            if (v7 * arg7 / 1000000000000000000 * arg5 / 1000000000000000000 > v5) {
            } else {
                let v8 = if (0x1::option::is_some<u256>(&arg9)) {
                    if (0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::greater_than(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::abs(v4), 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::abs(v1))) {
                        0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::greater_than(v7, *0x1::option::borrow<u256>(&arg9))
                    } else {
                        false
                    }
                } else {
                    false
                };
                if (v8) {
                } else {
                    return (true, v3, v4)
                };
            };
        };
        arg0.collateral = v0;
        arg0.base_asset_amount = v1;
        arg0.quote_asset_notional_amount = v2;
        (false, 0, v1)
    }

    public fun apply_taker_fills_and_settle(arg0: &mut Position, arg1: u256, arg2: u256, arg3: u256, arg4: u256, arg5: u256, arg6: u256, arg7: u256) : (u256, u256, u256, u256) {
        let v0 = arg0.base_asset_amount;
        let (v1, v2) = if (arg2 != 0) {
            let (v3, v4) = add_base_to_position(arg0, true, arg2, arg3);
            (v4, v3)
        } else {
            (v0, 0)
        };
        let v5 = if (arg4 != 0) {
            let (v6, v7) = add_base_to_position(arg0, false, arg4, arg5);
            v1 = v7;
            v6
        } else {
            0
        };
        let v8 = if (v1 < 57896044618658097711785492504343953926634992332820282019728792003956564819968) {
            if (v0 < 57896044618658097711785492504343953926634992332820282019728792003956564819968) {
                if (v1 >= v0) {
                    v1 - v0
                } else {
                    (v0 - v1 ^ 115792089237316195423570985008687907853269984665640564039457584007913129639935) + 1
                }
            } else {
                v1
            }
        } else if (v0 < 57896044618658097711785492504343953926634992332820282019728792003956564819968) {
            (v0 ^ 57896044618658097711785492504343953926634992332820282019728792003956564819967) + 1 ^ 57896044618658097711785492504343953926634992332820282019728792003956564819968
        } else {
            0
        };
        let v9 = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::add(v2, v5);
        let v10 = arg3 + arg5;
        let v11 = arg6 >= 57896044618658097711785492504343953926634992332820282019728792003956564819968;
        let v12 = if (v11) {
            (arg6 ^ 115792089237316195423570985008687907853269984665640564039457584007913129639935) + 1
        } else {
            arg6
        };
        let v13 = if (v11) {
            (v12 * v10 / 1000000000000000000 ^ 57896044618658097711785492504343953926634992332820282019728792003956564819967) + 1 ^ 57896044618658097711785492504343953926634992332820282019728792003956564819968
        } else {
            v12 * v10 / 1000000000000000000
        };
        let v14 = arg7 * v10 / 1000000000000000000;
        add_to_collateral_usd(arg0, 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::sub(v9, 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::add(v13, v14)), arg1);
        (v9, v13, v14, v8)
    }

    public fun base_and_quote_amounts(arg0: &Position) : (u256, u256) {
        (arg0.base_asset_amount, arg0.quote_asset_notional_amount)
    }

    public fun calculate_bankruptcy_price(arg0: &Position, arg1: u256, arg2: u64) : u64 {
        let v0 = arg0.base_asset_amount;
        if (v0 == 0) {
            return 0
        };
        let v1 = !0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::is_neg(v0);
        let v2 = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::sub(arg0.quote_asset_notional_amount, 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::mul(arg1, arg0.collateral));
        let v3 = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::div(v2, v0);
        let v4 = v3;
        if (v1 && v2 != 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::mul(v3, v0)) {
            v4 = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::add(v3, 1);
        };
        let v5 = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::max(v4, 0);
        let v6 = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::to_balance(v5, 1000000000);
        let v7 = v6;
        if (v1 && 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::from_balance(v6, 1000000000) != v5) {
            v7 = v6 + 1;
        };
        let v8 = v7 % arg2;
        if (v8 != 0) {
            if (v1) {
                let v9 = v7 + arg2;
                v7 = v9 - v8;
            } else {
                v7 = v7 - v8;
            };
        };
        v7
    }

    public fun calculate_position_funding_internal(arg0: &Position, arg1: u256, arg2: u256) : u256 {
        if (0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::is_neg(arg0.base_asset_amount)) {
            unrealized_funding(arg2, arg0.cum_funding_rate_short, arg0.base_asset_amount)
        } else {
            unrealized_funding(arg1, arg0.cum_funding_rate_long, arg0.base_asset_amount)
        }
    }

    public fun collateral(arg0: &Position) : u256 {
        arg0.collateral
    }

    public fun compute_free_collateral(arg0: &Position, arg1: u256, arg2: u256, arg3: u256, arg4: u256) : u256 {
        if (arg0.pending_orders == 0 && arg0.base_asset_amount == 0) {
            return 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::max(0, arg0.collateral)
        };
        let v0 = unrealized_pnl(arg0, arg2);
        let v1 = margin_requirement(arg0, arg2, arg3);
        let v2 = if (0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::less_than(v0, 0)) {
            0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::add(effective_collateral_usd_value(arg0, arg1, arg4), v0)
        } else {
            effective_collateral_usd_value(arg0, arg1, arg4)
        };
        if (0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::greater_than_eq(v2, v1)) {
            if (arg4 != 0) {
                0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::div(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::div(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::sub(v2, v1), arg1), 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::sub(1000000000000000000, arg4))
            } else {
                0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::div(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::sub(v2, v1), arg1)
            }
        } else {
            0
        }
    }

    public fun compute_free_collateral_with_fundings(arg0: &Position, arg1: u256, arg2: u256, arg3: u256, arg4: u256, arg5: u256, arg6: u256) : u256 {
        if (arg0.pending_orders == 0 && arg0.base_asset_amount == 0) {
            return 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::max(0, arg0.collateral)
        };
        let v0 = unrealized_pnl(arg0, arg2);
        let v1 = margin_requirement(arg0, arg2, arg3);
        let v2 = if (0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::less_than(v0, 0)) {
            0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::add(effective_collateral_usd_value_with_funding(arg0, arg1, arg6, calculate_position_funding_internal(arg0, arg4, arg5)), v0)
        } else {
            effective_collateral_usd_value_with_funding(arg0, arg1, arg6, calculate_position_funding_internal(arg0, arg4, arg5))
        };
        if (0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::greater_than_eq(v2, v1)) {
            if (arg6 != 0) {
                0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::div(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::div(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::sub(v2, v1), arg1), 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::sub(1000000000000000000, arg6))
            } else {
                0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::div(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::sub(v2, v1), arg1)
            }
        } else {
            0
        }
    }

    public fun compute_margin_and_free_collateral(arg0: &Position, arg1: u256, arg2: u256, arg3: u256, arg4: u256) : (u256, u256, u256) {
        if (arg0.pending_orders == 0 && arg0.base_asset_amount == 0) {
            return (effective_collateral_usd_value(arg0, arg1, arg4), 0, 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::max(0, arg0.collateral))
        };
        let v0 = unrealized_pnl(arg0, arg2);
        let v1 = margin_requirement(arg0, arg2, arg3);
        let v2 = effective_collateral_usd_value(arg0, arg1, arg4);
        let v3 = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::add(v2, v0);
        if (0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::greater_than(v1, v3)) {
            return (v3, v1, 0)
        };
        let v4 = if (0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::less_than(v0, 0)) {
            v3
        } else {
            v2
        };
        let v5 = if (0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::greater_than_eq(v4, v1)) {
            if (arg4 != 0) {
                0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::div(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::div(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::sub(v4, v1), arg1), 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::sub(1000000000000000000, arg4))
            } else {
                0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::div(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::sub(v4, v1), arg1)
            }
        } else {
            0
        };
        (v3, v1, v5)
    }

    public fun compute_margin_and_requirement(arg0: &Position, arg1: u256, arg2: u256, arg3: u256, arg4: u256) : (u256, u256) {
        (0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::add(effective_collateral_usd_value(arg0, arg1, arg4), unrealized_pnl(arg0, arg2)), margin_requirement(arg0, arg2, arg3))
    }

    public fun compute_margin_with_fundings(arg0: &Position, arg1: u256, arg2: u256, arg3: u256, arg4: u256, arg5: u256, arg6: u256) : (u256, u256) {
        (0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::add(effective_collateral_usd_value_with_funding(arg0, arg1, arg6, calculate_position_funding_internal(arg0, arg4, arg5)), unrealized_pnl(arg0, arg2)), margin_requirement(arg0, arg2, arg3))
    }

    public fun create_position(arg0: u256, arg1: u256) : Position {
        Position{
            collateral                  : 0,
            base_asset_amount           : 0,
            quote_asset_notional_amount : 0,
            cum_funding_rate_long       : arg0,
            cum_funding_rate_short      : arg1,
            asks_quantity               : 0,
            bids_quantity               : 0,
            pending_orders              : 0,
            initial_margin_ratio        : 1000000000000000000,
        }
    }

    fun effective_collateral_usd_value(arg0: &Position, arg1: u256, arg2: u256) : u256 {
        if (arg2 != 0 && !0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::is_neg(arg0.collateral)) {
            0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::mul(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::mul(arg0.collateral, arg1), 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::sub(1000000000000000000, arg2))
        } else {
            0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::mul(arg0.collateral, arg1)
        }
    }

    fun effective_collateral_usd_value_with_funding(arg0: &Position, arg1: u256, arg2: u256, arg3: u256) : u256 {
        let v0 = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::add(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::mul(arg0.collateral, arg1), arg3);
        if (arg2 != 0 && !0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::is_neg(v0)) {
            0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::mul(v0, 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::sub(1000000000000000000, arg2))
        } else {
            v0
        }
    }

    public fun effective_initial_margin_ratio(arg0: &Position, arg1: u256) : u256 {
        0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::max(arg0.initial_margin_ratio, arg1)
    }

    public fun ensure_margin_requirements(arg0: u256, arg1: u256, arg2: u256, arg3: u256, arg4: u256, arg5: u256) {
        if (0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::greater_than_eq(arg2, arg3)) {
            return
        };
        assert!(arg1 != 0, 2001);
        assert!(!0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::is_neg(arg2) && !0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::is_neg(arg0), 2002);
        let v0 = if (arg4 == 0) {
            true
        } else if (arg5 == 0) {
            true
        } else {
            0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::is_neg(arg4) == 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::is_neg(arg5)
        };
        assert!(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::less_than_eq(arg3, arg1) && v0, 2001);
        if (0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::greater_than_eq(arg2, arg0)) {
            return
        };
        assert!(arg3 != arg1, 2001);
        assert!(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::greater_than_eq(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::mul(arg2, arg1), 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::mul(arg0, arg3)), 2001);
    }

    public fun funding_rate_snapshots(arg0: &Position) : (u256, u256) {
        (arg0.cum_funding_rate_long, arg0.cum_funding_rate_short)
    }

    public fun initial_margin_ratio(arg0: &Position) : u256 {
        arg0.initial_margin_ratio
    }

    public fun is_long_or_flat(arg0: &Position) : bool {
        !0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::is_neg(arg0.base_asset_amount)
    }

    public fun margin_requirement(arg0: &Position, arg1: u256, arg2: u256) : u256 {
        0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::mul(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::mul(abs_net_base(arg0), arg1), arg2)
    }

    public fun pending_base_amounts_by_side(arg0: &Position) : (u256, u256) {
        (arg0.asks_quantity, arg0.bids_quantity)
    }

    public fun pending_order_count(arg0: &Position) : u64 {
        arg0.pending_orders
    }

    public fun reset_collateral(arg0: &mut Position) : u256 {
        arg0.collateral = 0;
        0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::abs(arg0.collateral)
    }

    public fun set_initial_margin_ratio(arg0: &mut Position, arg1: u256, arg2: u256) {
        assert!(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::greater_than_eq(arg1, arg2) && 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::less_than_eq(arg1, 1000000000000000000), 2003);
        arg0.initial_margin_ratio = arg1;
    }

    public fun settle_position_funding(arg0: &mut Position, arg1: u256, arg2: u256, arg3: u256) : (bool, u256, u256) {
        let v0 = arg0.base_asset_amount >= 57896044618658097711785492504343953926634992332820282019728792003956564819968;
        let (v1, v2, v3) = if (v0) {
            ((arg0.base_asset_amount ^ 115792089237316195423570985008687907853269984665640564039457584007913129639935) + 1, arg0.cum_funding_rate_short, arg3)
        } else {
            (arg0.base_asset_amount, arg0.cum_funding_rate_long, arg2)
        };
        let v4;
        let v5;
        if (v3 != v2) {
            if (v1 != 0) {
                let v6 = v3 >= 57896044618658097711785492504343953926634992332820282019728792003956564819968;
                let (v7, v8) = if (v2 >= 57896044618658097711785492504343953926634992332820282019728792003956564819968 == v6) {
                    if (v3 >= v2) {
                        (v3 - v2, false)
                    } else {
                        (v2 - v3, true)
                    }
                } else {
                    let v7 = if (v6) {
                        (v3 ^ 115792089237316195423570985008687907853269984665640564039457584007913129639935) + 1 + v2
                    } else {
                        (v2 ^ 115792089237316195423570985008687907853269984665640564039457584007913129639935) + 1 + v3
                    };
                    (v7, v6)
                };
                let v9 = v7 * v1;
                if (v0 != v8) {
                    let v10 = v9 / arg1;
                    v5 = v9 / 1000000000000000000;
                    if (v10 != 0) {
                        if (arg0.collateral >= 57896044618658097711785492504343953926634992332820282019728792003956564819968) {
                            let v11 = (arg0.collateral ^ 115792089237316195423570985008687907853269984665640564039457584007913129639935) + 1;
                            if (v10 >= v11) {
                                v4 = v10 - v11;
                            } else {
                                v4 = arg0.collateral + v10;
                            };
                        } else {
                            let v12 = arg0.collateral + v10;
                            v4 = v12;
                            assert!(!(v12 >= 57896044618658097711785492504343953926634992332820282019728792003956564819968), 2000);
                        };
                        arg0.collateral = v4;
                    } else {
                        v4 = arg0.collateral;
                    };
                } else {
                    let v13 = (v9 + arg1 - 1) / arg1;
                    if (arg0.collateral >= 57896044618658097711785492504343953926634992332820282019728792003956564819968) {
                        let v14 = arg0.collateral - v13;
                        v4 = v14;
                        assert!(v14 >= 57896044618658097711785492504343953926634992332820282019728792003956564819968, 2000);
                    } else if (arg0.collateral >= v13) {
                        v4 = arg0.collateral - v13;
                    } else {
                        v4 = (v13 - arg0.collateral ^ 115792089237316195423570985008687907853269984665640564039457584007913129639935) + 1;
                    };
                    v5 = ((v9 + 999999999999999999) / 1000000000000000000 ^ 57896044618658097711785492504343953926634992332820282019728792003956564819967) + 1 ^ 57896044618658097711785492504343953926634992332820282019728792003956564819968;
                    arg0.collateral = v4;
                };
            };
        };
        v4 = arg0.collateral;
        v5 = 0;
        let v15 = if (v5 != 0) {
            true
        } else if (arg0.cum_funding_rate_long != arg2) {
            true
        } else {
            arg0.cum_funding_rate_short != arg3
        };
        arg0.cum_funding_rate_long = arg2;
        arg0.cum_funding_rate_short = arg3;
        (v15, v5, v4)
    }

    public fun sub_from_collateral(arg0: &mut Position, arg1: u256) {
        arg0.collateral = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::sub(arg0.collateral, arg1);
    }

    public fun sub_from_pending_amount(arg0: &mut Position, arg1: bool, arg2: u256) {
        if (arg1) {
            arg0.asks_quantity = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::sub(arg0.asks_quantity, arg2);
        } else {
            arg0.bids_quantity = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::sub(arg0.bids_quantity, arg2);
        };
    }

    public fun unrealized_funding(arg0: u256, arg1: u256, arg2: u256) : u256 {
        if (arg0 == arg1) {
            return 0
        };
        0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::mul(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::sub(arg0, arg1), 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::neg(arg2))
    }

    public fun unrealized_pnl(arg0: &Position, arg1: u256) : u256 {
        0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::sub(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::mul(arg0.base_asset_amount, arg1), arg0.quote_asset_notional_amount)
    }

    public fun update_pending_orders(arg0: &mut Position, arg1: bool, arg2: u64) {
        if (arg1) {
            arg0.pending_orders = arg0.pending_orders + arg2;
        } else {
            arg0.pending_orders = arg0.pending_orders - arg2;
        };
    }

    // decompiled from Move bytecode v7
}

