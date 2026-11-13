module 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::margin {
    struct Liquidated has copy, drop {
        user: address,
        legs_taken: u64,
        legs_skipped: u64,
        coins_taken: u64,
        repaid: u64,
        penalty: u64,
        debt_before: u64,
        debt_after: u64,
        written_off: u64,
    }

    struct LegSkipped has copy, drop {
        user: address,
        instrument: u256,
    }

    fun leg_runs<T0>(arg0: &0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::Exchange<T0>, arg1: address, arg2: address, arg3: u256, arg4: u64, arg5: bool, arg6: u64) : bool {
        if (!0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::is_listed<T0>(arg0, arg3)) {
            return false
        };
        let v0 = 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::instrument<T0>(arg0, arg3);
        if (0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::instrument::is_closed(v0)) {
            return false
        };
        let v1 = if (arg5) {
            0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::instrument::short_of(v0, arg1)
        } else {
            0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::instrument::long_of(v0, arg1)
        };
        if (v1 < arg4) {
            return false
        };
        let v2 = 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::cash<T0>();
        let v3 = 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::instrument::spec_of(v0);
        let v4 = (arg6 as u128);
        if (arg5) {
            let v6 = (0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::instrument::lots_value(v3, arg4 - 0x1::u64::min(0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::instrument::long_of(v0, arg2), arg4)) as u128);
            let v7 = if (v6 > v4) {
                v6 - v4
            } else {
                0
            };
            (0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::account::balance(0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::account<T0>(arg0, arg2), &v2) as u128) + 0x1::u128::min((0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::account::debt(0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::account<T0>(arg0, arg1)) as u128), (0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::instrument::lots_value(v3, arg4) as u128) - v4) >= v7
        } else {
            let v8 = if (0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::instrument::collateral_coin(v3) == v2) {
                (0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::instrument::lots_value(v3, 0x1::u64::min(0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::instrument::short_of(v0, arg2), arg4)) as u128)
            } else {
                0
            };
            let v9 = if (v4 > v8) {
                v4 - v8
            } else {
                0
            };
            (0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::account::balance(0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::account<T0>(arg0, arg2), &v2) as u128) + 0x1::u128::min((0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::account::debt(0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::account<T0>(arg0, arg1)) as u128), v4) >= v9
        }
    }

    public fun liquidate<T0>(arg0: &0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::OperatorCap, arg1: &mut 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::Exchange<T0>, arg2: 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::Liquidation, arg3: vector<u8>, arg4: vector<0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::MarkProof>, arg5: vector<vector<u8>>, arg6: vector<0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::IndexProof>, arg7: vector<vector<u8>>, arg8: &0x2::clock::Clock) {
        0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::check_operator<T0>(arg1, arg0);
        0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::verify_risk<T0, 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::Liquidation>(arg1, &arg2, &arg3);
        assert!(0x1::vector::length<0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::MarkProof>(&arg4) == 0x1::vector::length<vector<u8>>(&arg5), 508);
        assert!(0x1::vector::length<0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::IndexProof>(&arg6) == 0x1::vector::length<vector<u8>>(&arg7), 510);
        let v0 = 0;
        while (v0 < 0x1::vector::length<0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::MarkProof>(&arg4)) {
            0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::verify_price<T0, 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::MarkProof>(arg1, 0x1::vector::borrow<0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::MarkProof>(&arg4, v0), 0x1::vector::borrow<vector<u8>>(&arg5, v0));
            v0 = v0 + 1;
        };
        v0 = 0;
        while (v0 < 0x1::vector::length<0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::IndexProof>(&arg6)) {
            0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::verify_price<T0, 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::IndexProof>(arg1, 0x1::vector::borrow<0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::IndexProof>(&arg6, v0), 0x1::vector::borrow<vector<u8>>(&arg7, v0));
            v0 = v0 + 1;
        };
        liquidate_verified<T0>(arg1, arg2, arg4, arg6, arg8);
    }

    fun liquidate_verified<T0>(arg0: &mut 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::Exchange<T0>, arg1: 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::Liquidation, arg2: vector<0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::MarkProof>, arg3: vector<0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::IndexProof>, arg4: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::liquidation_user(&arg1);
        let v2 = 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::house<T0>(arg0);
        let v3 = 0x2::object::id<0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::Exchange<T0>>(arg0);
        let v4 = 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::cash<T0>();
        0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::check_target(0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::liquidation_domain_of(&arg1), 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::liquidation_domain(), 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::liquidation_exchange(&arg1), v3);
        0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::check_market_fresh(0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::liquidation_at_ms(&arg1), v0);
        assert!(v1 != v2, 504);
        0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::check_idle<T0>(arg0, v1);
        0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::check_idle<T0>(arg0, v2);
        assert!(0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::liquidation_seq(&arg1) == 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::account::seq(0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::account<T0>(arg0, v1)), 500);
        let v5 = 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::account::debt(0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::account<T0>(arg0, v1));
        assert!(v5 > 0, 503);
        let v6 = *0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::liquidation_take(&arg1);
        let v7 = *0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::liquidation_coins(&arg1);
        assert!(0x1::vector::length<0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::MarkProof>(&arg2) == 0x1::vector::length<0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::LiquidationLeg>(&v6), 508);
        assert!(0x1::vector::length<0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::IndexProof>(&arg3) == 0x1::vector::length<0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::CoinLeg>(&v7), 510);
        let v8 = 0;
        while (v8 < 0x1::vector::length<0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::LiquidationLeg>(&v6)) {
            let v9 = 0x1::vector::borrow<0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::LiquidationLeg>(&v6, v8);
            let v10 = 0x1::vector::borrow<0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::MarkProof>(&arg2, v8);
            let v11 = 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::leg_amount(v9);
            let v12 = 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::leg_total_price(v9);
            assert!(v11 > 0, 505);
            0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::check_target(0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::mark_domain_of(v10), 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::mark_domain(), 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::mark_exchange(v10), v3);
            0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::check_market_fresh(0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::mark_at_ms(v10), v0);
            assert!(0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::mark_instrument(v10) == 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::leg_instrument(v9), 508);
            let v13 = 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::mark_value(v10, v11);
            let v14 = v13 * 1000 / 10000 + 1;
            let v15 = (v12 as u128);
            assert!(v15 + v14 >= v13 && v15 <= v13 + v14, 509);
            if (0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::is_listed<T0>(arg0, 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::leg_instrument(v9))) {
                let v16 = *0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::instrument::spec_of(0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::instrument<T0>(arg0, 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::leg_instrument(v9)));
                if (0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::instrument::collateral_coin(&v16) == v4) {
                    assert!(v12 <= 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::instrument::lots_value(&v16, v11), 507);
                };
                if (0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::leg_is_short(v9)) {
                    assert!(0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::instrument::collateral_coin(&v16) == v4, 506);
                };
            };
            v8 = v8 + 1;
        };
        v8 = 0;
        while (v8 < 0x1::vector::length<0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::CoinLeg>(&v7)) {
            let v17 = 0x1::vector::borrow<0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::CoinLeg>(&v7, v8);
            let v18 = 0x1::vector::borrow<0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::IndexProof>(&arg3, v8);
            assert!(0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::coin_leg_amount(v17) > 0 && 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::coin_leg_coin(v17) != v4, 505);
            let (v19, v20) = 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::coin_info<T0>(arg0, 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::coin_leg_coin(v17));
            0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::check_target(0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::index_domain_of(v18), 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::index_domain(), 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::index_exchange(v18), v3);
            0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::check_market_fresh(0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::index_at_ms(v18), v0);
            0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::check_index_price(0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::index_price(v18));
            assert!(0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::index_underlying(v18) == v20 && v20 != 0, 510);
            let v21 = (0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::index_price(v18) as u256) * (0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::coin_leg_amount(v17) as u256);
            let v22 = (0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::coin_leg_total_price(v17) as u256) * pow10(v19);
            assert!(v22 <= v21 && v22 * (10000 as u256) >= v21 * 9500, 511);
            v8 = v8 + 1;
        };
        let v23 = 0;
        let v24 = 0;
        v8 = 0;
        while (v8 < 0x1::vector::length<0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::LiquidationLeg>(&v6)) {
            let v25 = 0x1::vector::borrow<0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::LiquidationLeg>(&v6, v8);
            let v26 = 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::leg_instrument(v25);
            let v27 = 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::leg_amount(v25);
            let v28 = 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::leg_total_price(v25);
            if (leg_runs<T0>(arg0, v1, v2, v26, v27, 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::leg_is_short(v25), v28)) {
                if (0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::leg_is_short(v25)) {
                    0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::trade::fill<T0>(arg0, v26, v1, v2, v27, v28, 0, 0, 0x1::option::none<0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::RiskApproval>(), 0x1::option::none<0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::RiskApproval>());
                } else {
                    0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::trade::fill<T0>(arg0, v26, v2, v1, v27, v28, 0, 0, 0x1::option::none<0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::RiskApproval>(), 0x1::option::none<0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::RiskApproval>());
                };
                v23 = v23 + 1;
            } else {
                v24 = v24 + 1;
                let v29 = LegSkipped{
                    user       : v1,
                    instrument : v26,
                };
                0x2::event::emit<LegSkipped>(v29);
            };
            v8 = v8 + 1;
        };
        let v30 = 0;
        v8 = 0;
        while (v8 < 0x1::vector::length<0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::CoinLeg>(&v7)) {
            let v31 = 0x1::vector::borrow<0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::CoinLeg>(&v7, v8);
            let v32 = 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::coin_leg_coin(v31);
            let v33 = 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::coin_leg_amount(v31);
            let v34 = 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::coin_leg_total_price(v31);
            if (0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::account::balance(0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::account<T0>(arg0, v1), &v32) >= v33 && (0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::account::balance(0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::account<T0>(arg0, v2), &v4) as u128) + (0x1::u64::min(0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::account::debt(0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::account<T0>(arg0, v1)), v34) as u128) >= (v34 as u128)) {
                0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::debit_coin<T0>(arg0, v1, v32, v33);
                0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::credit_coin<T0>(arg0, v2, v32, v33);
                0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::credit_cash<T0>(arg0, v1, v34);
                0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::debit_coin<T0>(arg0, v2, v4, v34);
                v30 = v30 + 1;
            } else {
                v24 = v24 + 1;
            };
            v8 = v8 + 1;
        };
        let v35 = v5 - 0x1::u64::min(0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::account::debt(0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::account<T0>(arg0, v1)), v5);
        let v36 = 0x1::u64::min((((v35 as u128) * 500 / 10000) as u64), 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::account::balance(0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::account<T0>(arg0, v1), &v4));
        if (v36 > 0) {
            0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::debit_coin<T0>(arg0, v1, v4, v36);
            0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::credit_cash<T0>(arg0, v2, v36);
            0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::account::add_penalty(0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::account_mut<T0>(arg0, v1), v36);
        };
        let v37 = 0x1::u64::min(0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::account::debt(0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::account<T0>(arg0, v1)), 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::account::balance(0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::account<T0>(arg0, v1), &v4));
        if (v37 > 0) {
            0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::account::debit_quietly(0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::account_mut<T0>(arg0, v1), v4, v37);
            0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::credit_cash<T0>(arg0, v1, v37);
        };
        let v38 = 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::account<T0>(arg0, v1);
        let v39 = if (0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::liquidation_write_off(&arg1)) {
            if (v24 == 0) {
                if (0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::account::debt(v38) > 0) {
                    if (0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::account::open_positions(v38) == 0) {
                        if (!0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::account::is_busy(v38)) {
                            0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::holds_only_dust<T0>(arg0, v1)
                        } else {
                            false
                        }
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        let v40 = if (v39) {
            0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::take_dust_to_house<T0>(arg0, v1);
            0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::forgive<T0>(arg0, v1)
        } else {
            0
        };
        0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::bump<T0>(arg0, v1);
        let v41 = Liquidated{
            user         : v1,
            legs_taken   : v23,
            legs_skipped : v24,
            coins_taken  : v30,
            repaid       : v35,
            penalty      : v36,
            debt_before  : v5,
            debt_after   : 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::account::debt(0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::account<T0>(arg0, v1)),
            written_off  : v40,
        };
        0x2::event::emit<Liquidated>(v41);
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

    public fun withdraw_approved<T0, T1>(arg0: &mut 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::Exchange<T0>, arg1: 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::WithdrawApproval, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::check_version<T0>(arg0);
        let v0 = 0x2::tx_context::sender(arg4);
        0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::check_target(0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::withdraw_domain_of(&arg1), 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::withdraw_domain(), 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::withdraw_exchange(&arg1), 0x2::object::id<0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::Exchange<T0>>(arg0));
        0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::verify_risk<T0, 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::WithdrawApproval>(arg0, &arg1, &arg2);
        0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::check_fresh(0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::withdraw_at_ms(&arg1), 0x2::clock::timestamp_ms(arg3));
        let v1 = if (0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::withdraw_user(&arg1) == v0) {
            if (0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::withdraw_seq(&arg1) == 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::account::seq(0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::account<T0>(arg0, v0))) {
                0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::withdraw_coin(&arg1) == 0x1::type_name::with_original_ids<T1>()
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 500);
        0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::take_out<T0, T1>(arg0, v0, 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::withdraw_amount(&arg1), arg4)
    }

    // decompiled from Move bytecode v7
}

