module 0x3799d826b982e62e033ebfe4bca1aba4b5ab8d3cc31d5ea908fb5072b2ffddc4::tenor_borrow {
    struct LtvConfig has copy, drop, store {
        collateral_type: 0x1::type_name::TypeName,
        max_ltv_bps: u64,
        liq_threshold_bps: u64,
        liq_bonus_bps: u64,
        liq_fee_bps: u64,
        max_borrow_amount_per_unit: u64,
        min_collateral_amount: u64,
        max_collateral_amount: u64,
        alphalend_market_id: u64,
        collateral_decimal_digit: u8,
    }

    struct LtvConfigInput has drop {
        collateral_type: 0x1::type_name::TypeName,
        alphalend_market_id: u64,
        collateral_decimal_digit: u8,
        config: LtvConfig,
    }

    struct CachedPriceInfo has copy, drop, store {
        price: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number,
        ema_price: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number,
        last_updated: u64,
    }

    public(friend) fun bps_of(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / 10000) as u64)
    }

    public(friend) fun cached_price_ema_price(arg0: &CachedPriceInfo) : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number {
        arg0.ema_price
    }

    public(friend) fun cached_price_last_updated(arg0: &CachedPriceInfo) : u64 {
        arg0.last_updated
    }

    public(friend) fun cached_price_price(arg0: &CachedPriceInfo) : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number {
        arg0.price
    }

    public(friend) fun coin_max_price_per_raw_unit(arg0: &CachedPriceInfo, arg1: &0x2::clock::Clock, arg2: u64, arg3: u8) : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number {
        let v0 = 0x2::clock::timestamp_ms(arg1) / 1000;
        let v1 = cached_price_last_updated(arg0);
        let v2 = if (v0 > v1) {
            v0 - v1
        } else {
            0
        };
        assert!(v2 <= arg2, 37);
        price_per_raw_unit_from_whole(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::max(cached_price_price(arg0), cached_price_ema_price(arg0)), arg3)
    }

    public(friend) fun collateral_decimal_scale(arg0: u8) : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number {
        0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::pow(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(10), (arg0 as u64))
    }

    public(friend) fun collateral_ltv_price_per_raw_unit(arg0: &CachedPriceInfo, arg1: &0x2::clock::Clock, arg2: u64, arg3: u8) : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number {
        let v0 = 0x2::clock::timestamp_ms(arg1) / 1000;
        let v1 = cached_price_last_updated(arg0);
        let v2 = if (v0 > v1) {
            v0 - v1
        } else {
            0
        };
        assert!(v2 <= arg2, 37);
        price_per_raw_unit_from_whole(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::min(cached_price_price(arg0), cached_price_ema_price(arg0)), arg3)
    }

    public(friend) fun collateral_price_per_raw_unit(arg0: &CachedPriceInfo, arg1: &0x2::clock::Clock, arg2: u64, arg3: u8) : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number {
        let v0 = 0x2::clock::timestamp_ms(arg1) / 1000;
        let v1 = cached_price_last_updated(arg0);
        let v2 = if (v0 > v1) {
            v0 - v1
        } else {
            0
        };
        assert!(v2 <= arg2, 37);
        price_per_raw_unit_from_whole(cached_price_price(arg0), arg3)
    }

    public(friend) fun compute_force_resolve_seize_amounts(arg0: u64, arg1: u64, arg2: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number, arg3: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number) : (u64, u64, bool) {
        if (0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::eq(arg2, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0))) {
            return (arg1, 0, true)
        };
        let v0 = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::div_round_up(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(arg0), arg3), arg2);
        if (!0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::gt(v0, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(18446744073709551615))) {
            let v4 = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::round_up_u64(v0);
            let v5 = arg1 <= v4;
            let v6 = if (v5) {
                arg1
            } else {
                v4
            };
            let v7 = if (arg0 == 0) {
                0
            } else if (v6 >= v4) {
                arg0
            } else {
                let v8 = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u64(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::div(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(v6), arg2), arg3));
                if (v8 < arg0) {
                    v8
                } else {
                    arg0
                }
            };
            (v6, v7, v5)
        } else {
            let v9 = if (arg0 == 0) {
                0
            } else {
                let v10 = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u64(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::div(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(arg1), arg2), arg3));
                if (v10 < arg0) {
                    v10
                } else {
                    arg0
                }
            };
            (arg1, v9, true)
        }
    }

    public(friend) fun compute_liquidation_seize_amounts(arg0: u64, arg1: &LtvConfig, arg2: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number, arg3: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number, arg4: u64) : (u64, u64, u64, u64, bool) {
        let v0 = bps_of(arg0, arg1.liq_fee_bps);
        let v1 = arg0 + bps_of(arg0, arg1.liq_bonus_bps);
        let v2 = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::div(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(v1), arg2), arg3);
        let v3 = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::div(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(v0), arg2), arg3);
        let v4 = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(18446744073709551615);
        let v5 = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::gt(v2, v4) || 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::gt(v3, v4);
        let (v6, v7, v8, v9, v10) = if (!v5) {
            let (v11, v12) = convert_usd_legs_to_collateral_amounts(v1, v0, arg2, arg3);
            let v13 = v11 + v12;
            let v14 = v13 > 0 && arg4 <= v13;
            let (v15, v16, v17, v18) = if (v13 > 0 && arg4 < v13) {
                let v19 = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::div(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(arg4), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(v13));
                let v20 = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u64(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(arg0), v19));
                (v20, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u64(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(v11), v19)), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u64(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(v12), v19)), arg0 - v20)
            } else {
                (arg0, v11, v12, 0)
            };
            (v16, v17, v18, v14, v15)
        } else {
            let v21 = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::div(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(arg4), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::add(v2, v3));
            let v22 = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u64(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(arg0), v21));
            (0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u64(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(v2, v21)), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u64(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(v3, v21)), arg0 - v22, true, v22)
        };
        (v10, v6, v7, v8, v9)
    }

    public(friend) fun compute_max_mintable(arg0: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg1: &0x2::vec_map::VecMap<0x1::type_name::TypeName, CachedPriceInfo>, arg2: 0x2::object::ID, arg3: &vector<LtvConfig>, arg4: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number, arg5: u64, arg6: &0x2::clock::Clock) : u64 {
        let (v0, v1) = fetch_collateral_amounts_and_prices(arg0, arg1, arg2, arg3, arg5, arg6, true);
        let v2 = v1;
        let v3 = v0;
        let v4 = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0);
        let v5 = 0;
        while (v5 < 0x1::vector::length<LtvConfig>(arg3)) {
            let v6 = 0x1::vector::borrow<LtvConfig>(arg3, v5);
            let v7 = *0x1::vector::borrow<u64>(&v3, v5);
            v4 = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::add(v4, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::min(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(v7), *0x1::vector::borrow<0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number>(&v2, v5)), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from_bps(v6.max_ltv_bps)), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::div(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(v7), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::pow(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(10), (v6.collateral_decimal_digit as u64))), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(v6.max_borrow_amount_per_unit))));
            v5 = v5 + 1;
        };
        0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u64(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::div(v4, arg4))
    }

    public(friend) fun compute_max_seizable_usd(arg0: u64, arg1: u64, arg2: u64, arg3: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number, arg4: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number) : u64 {
        let v0 = (((arg0 as u128) * (arg1 as u128) / 10000) as u64);
        if (v0 < arg2 || 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::lt(arg3, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(arg0), arg4))) {
            arg0
        } else {
            v0
        }
    }

    public(friend) fun compute_mint_fee(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) * (arg2 as u128) / 10000 * (365 as u128)) as u64)
    }

    public(friend) fun compute_net_required(arg0: u64, arg1: u64, arg2: u64) : (u64, u64) {
        let v0 = compute_mint_fee(arg0, arg1, arg2);
        (arg0 - v0, v0)
    }

    public(friend) fun compute_total_collateral_usd(arg0: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg1: &0x2::vec_map::VecMap<0x1::type_name::TypeName, CachedPriceInfo>, arg2: 0x2::object::ID, arg3: &vector<LtvConfig>, arg4: u64, arg5: &0x2::clock::Clock) : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number {
        let (v0, v1) = fetch_collateral_amounts_and_prices(arg0, arg1, arg2, arg3, arg4, arg5, false);
        let v2 = v1;
        let v3 = v0;
        let v4 = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0);
        let v5 = 0;
        while (v5 < 0x1::vector::length<LtvConfig>(arg3)) {
            v4 = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::add(v4, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(*0x1::vector::borrow<u64>(&v3, v5)), *0x1::vector::borrow<0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number>(&v2, v5)));
            v5 = v5 + 1;
        };
        v4
    }

    public(friend) fun compute_weighted_liq_threshold_usd(arg0: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg1: &0x2::vec_map::VecMap<0x1::type_name::TypeName, CachedPriceInfo>, arg2: 0x2::object::ID, arg3: &vector<LtvConfig>, arg4: u64, arg5: &0x2::clock::Clock) : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number {
        let (v0, v1) = fetch_collateral_amounts_and_prices(arg0, arg1, arg2, arg3, arg4, arg5, false);
        let v2 = v1;
        let v3 = v0;
        let v4 = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0);
        let v5 = 0;
        while (v5 < 0x1::vector::length<LtvConfig>(arg3)) {
            v4 = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::add(v4, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(*0x1::vector::borrow<u64>(&v3, v5)), *0x1::vector::borrow<0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number>(&v2, v5)), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from_bps(ltv_liq_threshold_bps(0x1::vector::borrow<LtvConfig>(arg3, v5)))));
            v5 = v5 + 1;
        };
        v4
    }

    public(friend) fun convert_usd_legs_to_collateral_amounts(arg0: u64, arg1: u64, arg2: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number, arg3: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number) : (u64, u64) {
        (0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u64(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::div(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(arg0), arg2), arg3)), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u64(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::div(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(arg1), arg2), arg3)))
    }

    public(friend) fun drain_all_amount() : u64 {
        18446744073709551615
    }

    fun fetch_collateral_amounts_and_prices(arg0: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg1: &0x2::vec_map::VecMap<0x1::type_name::TypeName, CachedPriceInfo>, arg2: 0x2::object::ID, arg3: &vector<LtvConfig>, arg4: u64, arg5: &0x2::clock::Clock, arg6: bool) : (vector<u64>, vector<0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number>) {
        let v0 = vector[];
        let v1 = 0x1::vector::empty<0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<LtvConfig>(arg3)) {
            let v3 = 0x1::vector::borrow<LtvConfig>(arg3, v2);
            let v4 = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::get_collateral_amount(arg0, v3.alphalend_market_id, arg2, arg5);
            let v5 = if (v4 == 0) {
                0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0)
            } else {
                let v6 = 0x2::vec_map::try_get<0x1::type_name::TypeName, CachedPriceInfo>(arg1, &v3.collateral_type);
                assert!(0x1::option::is_some<CachedPriceInfo>(&v6), 46);
                let v7 = 0x1::option::destroy_some<CachedPriceInfo>(v6);
                if (arg6) {
                    collateral_ltv_price_per_raw_unit(&v7, arg5, arg4, v3.collateral_decimal_digit)
                } else {
                    collateral_price_per_raw_unit(&v7, arg5, arg4, v3.collateral_decimal_digit)
                }
            };
            0x1::vector::push_back<u64>(&mut v0, v4);
            0x1::vector::push_back<0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number>(&mut v1, v5);
            v2 = v2 + 1;
        };
        (v0, v1)
    }

    public(friend) fun finalize_ltv_config(arg0: &LtvConfigInput) : LtvConfig {
        let v0 = arg0.config;
        v0.alphalend_market_id = arg0.alphalend_market_id;
        v0.collateral_decimal_digit = arg0.collateral_decimal_digit;
        v0
    }

    public(friend) fun force_resolve_price_per_raw_unit(arg0: &CachedPriceInfo, arg1: &0x2::clock::Clock, arg2: u64, arg3: &LtvConfig) : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number {
        let v0 = 0x2::clock::timestamp_ms(arg1) / 1000;
        let v1 = cached_price_last_updated(arg0);
        let v2 = if (v0 > v1) {
            v0 - v1
        } else {
            0
        };
        assert!(v2 <= arg2, 37);
        price_per_raw_unit_from_whole(cached_price_price(arg0), arg3.collateral_decimal_digit)
    }

    public(friend) fun is_position_liquidatable(arg0: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg1: &0x2::vec_map::VecMap<0x1::type_name::TypeName, CachedPriceInfo>, arg2: 0x2::object::ID, arg3: u64, arg4: &vector<LtvConfig>, arg5: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number, arg6: u64, arg7: &0x2::clock::Clock) : bool {
        0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::lt(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::div(compute_weighted_liq_threshold_usd(arg0, arg1, arg2, arg4, arg6, arg7), arg5), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(arg3))
    }

    public(friend) fun ltv_alphalend_market_id(arg0: &LtvConfig) : u64 {
        arg0.alphalend_market_id
    }

    public(friend) fun ltv_collateral_decimal_digit(arg0: &LtvConfig) : u8 {
        arg0.collateral_decimal_digit
    }

    public(friend) fun ltv_collateral_type(arg0: &LtvConfig) : 0x1::type_name::TypeName {
        arg0.collateral_type
    }

    public(friend) fun ltv_input_alphalend_market_id(arg0: &LtvConfigInput) : u64 {
        arg0.alphalend_market_id
    }

    public(friend) fun ltv_input_collateral_decimal_digit(arg0: &LtvConfigInput) : u8 {
        arg0.collateral_decimal_digit
    }

    public(friend) fun ltv_input_collateral_type(arg0: &LtvConfigInput) : 0x1::type_name::TypeName {
        arg0.collateral_type
    }

    public(friend) fun ltv_liq_bonus_bps(arg0: &LtvConfig) : u64 {
        arg0.liq_bonus_bps
    }

    public(friend) fun ltv_liq_fee_bps(arg0: &LtvConfig) : u64 {
        arg0.liq_fee_bps
    }

    public(friend) fun ltv_liq_threshold_bps(arg0: &LtvConfig) : u64 {
        arg0.liq_threshold_bps
    }

    public(friend) fun ltv_max_borrow_amount_per_unit(arg0: &LtvConfig) : u64 {
        arg0.max_borrow_amount_per_unit
    }

    public(friend) fun ltv_max_collateral_amount(arg0: &LtvConfig) : u64 {
        arg0.max_collateral_amount
    }

    public(friend) fun ltv_max_ltv_bps(arg0: &LtvConfig) : u64 {
        arg0.max_ltv_bps
    }

    public(friend) fun ltv_min_collateral_amount(arg0: &LtvConfig) : u64 {
        arg0.min_collateral_amount
    }

    public(friend) fun new_cached_price_info(arg0: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number, arg1: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number, arg2: u64) : CachedPriceInfo {
        CachedPriceInfo{
            price        : arg0,
            ema_price    : arg1,
            last_updated : arg2,
        }
    }

    public fun new_ltv_config(arg0: 0x1::type_name::TypeName, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u8) : LtvConfig {
        LtvConfig{
            collateral_type            : arg0,
            max_ltv_bps                : arg1,
            liq_threshold_bps          : arg2,
            liq_bonus_bps              : arg3,
            liq_fee_bps                : arg4,
            max_borrow_amount_per_unit : arg5,
            min_collateral_amount      : arg6,
            max_collateral_amount      : arg7,
            alphalend_market_id        : 0,
            collateral_decimal_digit   : arg8,
        }
    }

    public fun new_ltv_input(arg0: 0x1::type_name::TypeName, arg1: u64, arg2: LtvConfig) : LtvConfigInput {
        assert!(arg2.collateral_type == arg0, 64);
        LtvConfigInput{
            collateral_type          : arg0,
            alphalend_market_id      : arg1,
            collateral_decimal_digit : arg2.collateral_decimal_digit,
            config                   : arg2,
        }
    }

    public(friend) fun open_position_and_deposit_collateral<T0>(arg0: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg1: u64, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::object::ID, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap) {
        let v0 = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::create_position(arg0, arg4);
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::add_collateral<T0>(arg0, &v0, arg1, arg2, arg3, arg4);
        (0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::get_position_id(&v0), v0)
    }

    public(friend) fun price_per_raw_unit_from_whole(arg0: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number, arg1: u8) : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number {
        0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::div(arg0, collateral_decimal_scale(arg1))
    }

    public(friend) fun price_runtime_floor() : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number {
        0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::div(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(1), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(1000000000000))
    }

    public(friend) fun set_ltv_max_borrow_amount_per_unit(arg0: &mut LtvConfig, arg1: u64) {
        arg0.max_borrow_amount_per_unit = arg1;
    }

    public(friend) fun set_ltv_max_collateral_amount(arg0: &mut LtvConfig, arg1: u64) {
        arg0.max_collateral_amount = arg1;
    }

    public(friend) fun withdraw_collateral<T0>(arg0: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg1: &0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        if (arg3 == 0) {
            return 0x2::coin::zero<T0>(arg5)
        };
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise<T0>(arg0, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::remove_collateral<T0>(arg0, arg1, arg2, arg3, arg4), arg4, arg5)
    }

    // decompiled from Move bytecode v7
}

