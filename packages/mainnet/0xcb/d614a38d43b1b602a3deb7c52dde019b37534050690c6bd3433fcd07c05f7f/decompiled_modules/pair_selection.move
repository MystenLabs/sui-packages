module 0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::pair_selection {
    struct PairSelection {
        obligation_id: 0x2::object::ID,
        liquidatable: bool,
        selected: bool,
        claimed: bool,
        considered: u64,
        repay_reserve_array_index: u64,
        withdraw_reserve_array_index: u64,
        maximum_repay_raw: u64,
        minimum_repay_raw: u64,
        minimum_repay_usd: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal,
        useful_repay_usd: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal,
        maximum_collateral_borrow_weight: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal,
    }

    struct PairSelectionResult has copy, drop {
        obligation_id: 0x2::object::ID,
        liquidatable: bool,
        selected: bool,
        claimed: bool,
        considered: u64,
        repay_reserve_array_index: u64,
        withdraw_reserve_array_index: u64,
        maximum_repay_raw: u64,
        minimum_repay_raw: u64,
        useful_repay_usd_e18: u256,
        maximum_collateral_borrow_weight_e18: u256,
    }

    public fun begin<T0>(arg0: &0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::LiquidationVault, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: 0x2::object::ID, arg3: u256, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : PairSelection {
        0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::assert_authorized(arg0, arg5);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_obligation<T0>(arg1, arg2, arg4);
        PairSelection{
            obligation_id                    : arg2,
            liquidatable                     : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::is_liquidatable<T0>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<T0>(arg1, arg2)),
            selected                         : false,
            claimed                          : false,
            considered                       : 0,
            repay_reserve_array_index        : 0,
            withdraw_reserve_array_index     : 0,
            maximum_repay_raw                : 0,
            minimum_repay_raw                : 0,
            minimum_repay_usd                : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from_scaled_val(arg3),
            useful_repay_usd                 : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(0),
            maximum_collateral_borrow_weight : maximum_deposit_borrow_weight<T0>(arg1, arg2),
        }
    }

    fun borrow_values<T0>(arg0: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg1: 0x2::object::ID, arg2: u64) : (0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal, bool) {
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::borrows<T0>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<T0>(arg0, arg1));
        let v1 = 0;
        while (v1 < 0x1::vector::length<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::Borrow>(v0)) {
            let v2 = 0x1::vector::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::Borrow>(v0, v1);
            if (0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::borrow_reserve_array_index(v2) == arg2) {
                return (0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::borrow_borrowed_amount(v2), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::borrow_market_value(v2), true)
            };
            v1 = v1 + 1;
        };
        (0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(0), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(0), false)
    }

    fun candidate_is_better(arg0: bool, arg1: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal, arg2: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal) : bool {
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::gt(arg2, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(0)) && (!arg0 || 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::gt(arg2, arg1))
    }

    public(friend) fun claim(arg0: &mut PairSelection, arg1: 0x2::object::ID, arg2: u64, arg3: u64) : bool {
        let v0 = if (arg0.claimed) {
            true
        } else if (!arg0.selected) {
            true
        } else if (arg0.obligation_id != arg1) {
            true
        } else if (arg0.repay_reserve_array_index != arg2) {
            true
        } else {
            arg0.withdraw_reserve_array_index != arg3
        };
        if (v0) {
            return false
        };
        arg0.claimed = true;
        true
    }

    fun collateral_capped_settle_amount(arg0: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal, arg1: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal, arg2: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal, arg3: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal) : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal {
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::mul(arg1, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::add(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(1), arg3));
        if (!0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::gt(v0, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(0))) {
            return 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(0)
        };
        if (0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::lt(arg2, v0)) {
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::mul(arg0, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::div(arg2, v0))
        } else {
            arg0
        }
    }

    public fun consider_vault_pair<T0, T1, T2>(arg0: &mut PairSelection, arg1: &0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::LiquidationVault, arg2: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: u64, arg4: u64, arg5: u64) {
        arg0.considered = arg0.considered + 1;
        if (!arg0.liquidatable || arg0.claimed) {
            return
        };
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserves<T0>(arg2);
        if (arg3 >= 0x1::vector::length<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::Reserve<T0>>(v0) || arg4 >= 0x1::vector::length<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::Reserve<T0>>(v0)) {
            return
        };
        let v1 = 0x1::vector::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::Reserve<T0>>(v0, arg3);
        let v2 = 0x1::vector::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::Reserve<T0>>(v0, arg4);
        if (0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::coin_type<T0>(v1) != 0x1::type_name::with_defining_ids<T1>() || 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::coin_type<T0>(v2) != 0x1::type_name::with_defining_ids<T2>()) {
            return
        };
        let v3 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::config<T0>(v2);
        if (0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::lt(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve_config::borrow_weight(v3), arg0.maximum_collateral_borrow_weight)) {
            return
        };
        let v4 = 0x1::u64::min(0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::balance<T1>(arg1), arg5);
        let v5 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::ceil(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::usd_to_token_amount_upper_bound<T0>(v1, arg0.minimum_repay_usd));
        if (v4 < v5 || v4 == 0) {
            return
        };
        let (v6, v7, v8) = borrow_values<T0>(arg2, arg0.obligation_id, arg3);
        let (v9, v10) = deposit_market_value<T0>(arg2, arg0.obligation_id, arg4);
        if (!v8 || !v10) {
            return
        };
        let v11 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<T0>(arg2, arg0.obligation_id);
        let v12 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::add(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve_config::liquidation_bonus(v3), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve_config::protocol_liquidation_fee(v3));
        let v13 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::unweighted_borrowed_value_usd<T0>(v11);
        let v14 = if (0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::gt(v13, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(0))) {
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::min(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::div(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::saturating_sub(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::deposited_value_usd<T0>(v11), v13), v13), v12)
        } else {
            v12
        };
        let v15 = protocol_capped_repay_amount(v4, v6, v7, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::weighted_borrowed_value_usd<T0>(v11), v14, v12);
        if (!0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::gt(v15, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(0))) {
            return
        };
        let v16 = collateral_capped_settle_amount(v15, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::market_value<T0>(v1, v15), v9, v14);
        if (0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::ceil(v16) < v5) {
            return
        };
        let v17 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::market_value<T0>(v1, v16);
        if (!candidate_is_better(arg0.selected, arg0.useful_repay_usd, v17)) {
            return
        };
        arg0.selected = true;
        arg0.repay_reserve_array_index = arg3;
        arg0.withdraw_reserve_array_index = arg4;
        arg0.maximum_repay_raw = v4;
        arg0.minimum_repay_raw = v5;
        arg0.useful_repay_usd = v17;
    }

    fun deposit_market_value<T0>(arg0: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg1: 0x2::object::ID, arg2: u64) : (0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal, bool) {
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::deposits<T0>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<T0>(arg0, arg1));
        let v1 = 0;
        while (v1 < 0x1::vector::length<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::Deposit>(v0)) {
            let v2 = 0x1::vector::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::Deposit>(v0, v1);
            if (0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::deposit_reserve_array_index(v2) == arg2) {
                return (0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::deposit_market_value(v2), true)
            };
            v1 = v1 + 1;
        };
        (0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(0), false)
    }

    public fun finish(arg0: PairSelection) {
        let PairSelection {
            obligation_id                    : v0,
            liquidatable                     : v1,
            selected                         : v2,
            claimed                          : v3,
            considered                       : v4,
            repay_reserve_array_index        : v5,
            withdraw_reserve_array_index     : v6,
            maximum_repay_raw                : v7,
            minimum_repay_raw                : v8,
            minimum_repay_usd                : _,
            useful_repay_usd                 : v10,
            maximum_collateral_borrow_weight : v11,
        } = arg0;
        let v12 = PairSelectionResult{
            obligation_id                        : v0,
            liquidatable                         : v1,
            selected                             : v2,
            claimed                              : v3,
            considered                           : v4,
            repay_reserve_array_index            : v5,
            withdraw_reserve_array_index         : v6,
            maximum_repay_raw                    : v7,
            minimum_repay_raw                    : v8,
            useful_repay_usd_e18                 : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::to_scaled_val(v10),
            maximum_collateral_borrow_weight_e18 : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::to_scaled_val(v11),
        };
        0x2::event::emit<PairSelectionResult>(v12);
    }

    fun maximum_deposit_borrow_weight<T0>(arg0: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg1: 0x2::object::ID) : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal {
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::deposits<T0>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<T0>(arg0, arg1));
        let v1 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserves<T0>(arg0);
        let v2 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(0);
        let v3 = 0;
        while (v3 < 0x1::vector::length<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::Deposit>(v0)) {
            let v4 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve_config::borrow_weight(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::config<T0>(0x1::vector::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::Reserve<T0>>(v1, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::deposit_reserve_array_index(0x1::vector::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::Deposit>(v0, v3)))));
            if (0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::gt(v4, v2)) {
                v2 = v4;
            };
            v3 = v3 + 1;
        };
        v2
    }

    public(friend) fun maximum_repay_raw(arg0: &PairSelection) : u64 {
        arg0.maximum_repay_raw
    }

    public(friend) fun minimum_repay_raw(arg0: &PairSelection) : u64 {
        arg0.minimum_repay_raw
    }

    fun protocol_capped_repay_amount(arg0: u64, arg1: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal, arg2: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal, arg3: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal, arg4: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal, arg5: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal) : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal {
        if (!0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::gt(arg2, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(0))) {
            return 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(0)
        };
        if (0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::le(arg2, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(100)) || 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::lt(arg4, arg5)) {
            return 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::min(arg1, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(arg0))
        };
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::min(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::mul(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::div(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::min(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::mul(arg3, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from_percent(20)), arg2), arg2), arg1), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(arg0))
    }

    // decompiled from Move bytecode v7
}

