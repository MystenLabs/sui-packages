module 0xa3292ed7828c45353631d878b0a2b9c89f7a1264752d5c3f27fff602a9eac7a8::reserve {
    struct Reserve has drop {
        array_index: u64,
        config: 0xa3292ed7828c45353631d878b0a2b9c89f7a1264752d5c3f27fff602a9eac7a8::reserve_config::ReserveConfig,
        mint_decimals: u8,
        price: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal,
        price_lower_bound: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal,
        price_upper_bound: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal,
        available_amount: u64,
        ctoken_supply: u64,
        borrowed_amount: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal,
        cumulative_borrow_rate: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal,
        interest_last_update_timestamp_s: u64,
        unclaimed_spread_fees: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal,
    }

    struct LiquidityRequest has drop {
        amount: u64,
        fee: u64,
    }

    public(friend) fun array_index(arg0: &Reserve) : u64 {
        arg0.array_index
    }

    public(friend) fun calculate_utilization_rate(arg0: &Reserve) : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal {
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::add(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(arg0.available_amount), arg0.borrowed_amount);
        if (0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::eq(v0, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(0))) {
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(0)
        } else {
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::div(arg0.borrowed_amount, v0)
        }
    }

    public(friend) fun compound_interest(arg0: &mut Reserve, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg1) / 1000;
        let v1 = v0 - arg0.interest_last_update_timestamp_s;
        if (v1 == 0) {
            return
        };
        let v2 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::pow(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::add(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(1), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::div(0xa3292ed7828c45353631d878b0a2b9c89f7a1264752d5c3f27fff602a9eac7a8::reserve_config::calculate_apr(config(arg0), calculate_utilization_rate(arg0)), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(31536000))), v1);
        arg0.cumulative_borrow_rate = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::mul(arg0.cumulative_borrow_rate, v2);
        let v3 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::mul(arg0.borrowed_amount, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::sub(v2, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(1)));
        arg0.unclaimed_spread_fees = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::add(arg0.unclaimed_spread_fees, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::mul(v3, 0xa3292ed7828c45353631d878b0a2b9c89f7a1264752d5c3f27fff602a9eac7a8::reserve_config::spread_fee(config(arg0))));
        arg0.borrowed_amount = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::add(arg0.borrowed_amount, v3);
        arg0.interest_last_update_timestamp_s = v0;
    }

    public(friend) fun config(arg0: &Reserve) : &0xa3292ed7828c45353631d878b0a2b9c89f7a1264752d5c3f27fff602a9eac7a8::reserve_config::ReserveConfig {
        &arg0.config
    }

    public(friend) fun ctoken_market_value(arg0: &Reserve, arg1: u64) : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal {
        market_value(arg0, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::mul(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(arg1), ctoken_ratio(arg0)))
    }

    public(friend) fun ctoken_market_value_lower_bound(arg0: &Reserve, arg1: u64) : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal {
        market_value_lower_bound(arg0, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::mul(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(arg1), ctoken_ratio(arg0)))
    }

    public(friend) fun ctoken_market_value_upper_bound(arg0: &Reserve, arg1: u64) : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal {
        market_value_upper_bound(arg0, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::mul(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(arg1), ctoken_ratio(arg0)))
    }

    public(friend) fun ctoken_ratio(arg0: &Reserve) : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal {
        if (arg0.ctoken_supply == 0) {
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(1)
        } else {
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::div(total_supply(arg0), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(arg0.ctoken_supply))
        }
    }

    public(friend) fun cumulative_borrow_rate(arg0: &Reserve) : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal {
        arg0.cumulative_borrow_rate
    }

    public(friend) fun deduct_liquidation_fee(arg0: &Reserve, arg1: u64) : (u64, u64) {
        let v0 = 0xa3292ed7828c45353631d878b0a2b9c89f7a1264752d5c3f27fff602a9eac7a8::reserve_config::liquidation_bonus(config(arg0));
        let v1 = 0xa3292ed7828c45353631d878b0a2b9c89f7a1264752d5c3f27fff602a9eac7a8::reserve_config::protocol_liquidation_fee(config(arg0));
        let v2 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::ceil(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::mul(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::div(v1, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::add(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::add(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(1), v0), v1)), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(arg1)));
        (v2, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::ceil(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::mul(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::div(v0, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::add(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::add(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(1), v0), v1)), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(arg1 - v2))))
    }

    public(friend) fun from_origin<T0>(arg0: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::Reserve<T0>) : Reserve {
        let v0 = 0;
        while (0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::price<T0>(arg0) != 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::market_value<T0>(arg0, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(0x1::u64::pow(10, v0)))) {
            v0 = v0 + 1;
        };
        Reserve{
            array_index                      : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::array_index<T0>(arg0),
            config                           : 0xa3292ed7828c45353631d878b0a2b9c89f7a1264752d5c3f27fff602a9eac7a8::reserve_config::from_origin(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::config<T0>(arg0)),
            mint_decimals                    : v0,
            price                            : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::price<T0>(arg0),
            price_lower_bound                : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::price_lower_bound<T0>(arg0),
            price_upper_bound                : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::price_upper_bound<T0>(arg0),
            available_amount                 : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::available_amount<T0>(arg0),
            ctoken_supply                    : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::ctoken_supply<T0>(arg0),
            borrowed_amount                  : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::borrowed_amount<T0>(arg0),
            cumulative_borrow_rate           : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::cumulative_borrow_rate<T0>(arg0),
            interest_last_update_timestamp_s : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::interest_last_update_timestamp_s<T0>(arg0),
            unclaimed_spread_fees            : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::unclaimed_spread_fees<T0>(arg0),
        }
    }

    public(friend) fun liquidity_request_amount(arg0: &LiquidityRequest) : u64 {
        arg0.amount
    }

    public(friend) fun liquidity_request_fee(arg0: &LiquidityRequest) : u64 {
        arg0.fee
    }

    public(friend) fun market_value(arg0: &Reserve, arg1: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal) : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal {
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::div(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::mul(price(arg0), arg1), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(0x1::u64::pow(10, arg0.mint_decimals)))
    }

    public(friend) fun market_value_lower_bound(arg0: &Reserve, arg1: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal) : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal {
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::div(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::mul(price_lower_bound(arg0), arg1), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(0x1::u64::pow(10, arg0.mint_decimals)))
    }

    public(friend) fun market_value_upper_bound(arg0: &Reserve, arg1: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal) : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal {
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::div(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::mul(price_upper_bound(arg0), arg1), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(0x1::u64::pow(10, arg0.mint_decimals)))
    }

    public(friend) fun price(arg0: &Reserve) : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal {
        arg0.price
    }

    public(friend) fun price_lower_bound(arg0: &Reserve) : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal {
        arg0.price_lower_bound
    }

    public(friend) fun price_upper_bound(arg0: &Reserve) : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal {
        arg0.price_upper_bound
    }

    public(friend) fun redeem_ctokens(arg0: &mut Reserve, arg1: u64) : LiquidityRequest {
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::floor(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::mul(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(arg1), ctoken_ratio(arg0)));
        arg0.available_amount = arg0.available_amount - v0;
        arg0.ctoken_supply = arg0.ctoken_supply - arg1;
        assert!(arg0.available_amount >= 100 && arg0.ctoken_supply >= 100, 5);
        LiquidityRequest{
            amount : v0,
            fee    : 0,
        }
    }

    public(friend) fun repay_liquidity(arg0: &mut Reserve, arg1: u64, arg2: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal) {
        assert!(arg1 == 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::ceil(arg2), 6);
        arg0.available_amount = arg0.available_amount + arg1;
        arg0.borrowed_amount = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::saturating_sub(arg0.borrowed_amount, arg2);
    }

    public(friend) fun total_supply(arg0: &Reserve) : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal {
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::sub(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::add(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(arg0.available_amount), arg0.borrowed_amount), arg0.unclaimed_spread_fees)
    }

    // decompiled from Move bytecode v6
}

