module 0xa3292ed7828c45353631d878b0a2b9c89f7a1264752d5c3f27fff602a9eac7a8::reserve_config {
    struct ReserveConfig has drop {
        open_ltv_pct: u8,
        close_ltv_pct: u8,
        max_close_ltv_pct: u8,
        borrow_weight_bps: u64,
        deposit_limit: u64,
        borrow_limit: u64,
        liquidation_bonus_bps: u64,
        max_liquidation_bonus_bps: u64,
        deposit_limit_usd: u64,
        borrow_limit_usd: u64,
        interest_rate_utils: vector<u8>,
        interest_rate_aprs: vector<u64>,
        borrow_fee_bps: u64,
        spread_fee_bps: u64,
        protocol_liquidation_fee_bps: u64,
        isolated: bool,
        open_attributed_borrow_limit_usd: u64,
        close_attributed_borrow_limit_usd: u64,
    }

    public(friend) fun borrow_weight(arg0: &ReserveConfig) : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal {
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from_bps(arg0.borrow_weight_bps)
    }

    public(friend) fun calculate_apr(arg0: &ReserveConfig, arg1: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal) : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal {
        assert!(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::le(arg1, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(1)), 1);
        let v0 = 1;
        while (v0 < 0x1::vector::length<u8>(&arg0.interest_rate_utils)) {
            let v1 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from_percent(*0x1::vector::borrow<u8>(&arg0.interest_rate_utils, v0 - 1));
            let v2 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from_percent(*0x1::vector::borrow<u8>(&arg0.interest_rate_utils, v0));
            if (0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::ge(arg1, v1) && 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::le(arg1, v2)) {
                let v3 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from_bps(*0x1::vector::borrow<u64>(&arg0.interest_rate_aprs, v0 - 1));
                return 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::add(v3, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::mul(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::div(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::sub(arg1, v1), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::sub(v2, v1)), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::sub(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from_bps(*0x1::vector::borrow<u64>(&arg0.interest_rate_aprs, v0)), v3)))
            };
            v0 = v0 + 1;
        };
        abort 0
    }

    public(friend) fun close_ltv(arg0: &ReserveConfig) : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal {
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from_percent(arg0.close_ltv_pct)
    }

    public(friend) fun from_origin(arg0: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve_config::ReserveConfig) : ReserveConfig {
        let v0 = 0x2::bcs::new(0x2::bcs::to_bytes<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve_config::ReserveConfig>(arg0));
        ReserveConfig{
            open_ltv_pct                      : 0x2::bcs::peel_u8(&mut v0),
            close_ltv_pct                     : 0x2::bcs::peel_u8(&mut v0),
            max_close_ltv_pct                 : 0x2::bcs::peel_u8(&mut v0),
            borrow_weight_bps                 : 0x2::bcs::peel_u64(&mut v0),
            deposit_limit                     : 0x2::bcs::peel_u64(&mut v0),
            borrow_limit                      : 0x2::bcs::peel_u64(&mut v0),
            liquidation_bonus_bps             : 0x2::bcs::peel_u64(&mut v0),
            max_liquidation_bonus_bps         : 0x2::bcs::peel_u64(&mut v0),
            deposit_limit_usd                 : 0x2::bcs::peel_u64(&mut v0),
            borrow_limit_usd                  : 0x2::bcs::peel_u64(&mut v0),
            interest_rate_utils               : 0x2::bcs::peel_vec_u8(&mut v0),
            interest_rate_aprs                : 0x2::bcs::peel_vec_u64(&mut v0),
            borrow_fee_bps                    : 0x2::bcs::peel_u64(&mut v0),
            spread_fee_bps                    : 0x2::bcs::peel_u64(&mut v0),
            protocol_liquidation_fee_bps      : 0x2::bcs::peel_u64(&mut v0),
            isolated                          : 0x2::bcs::peel_bool(&mut v0),
            open_attributed_borrow_limit_usd  : 0x2::bcs::peel_u64(&mut v0),
            close_attributed_borrow_limit_usd : 0x2::bcs::peel_u64(&mut v0),
        }
    }

    public(friend) fun isolated(arg0: &ReserveConfig) : bool {
        arg0.isolated
    }

    public(friend) fun liquidation_bonus(arg0: &ReserveConfig) : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal {
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from_bps(arg0.liquidation_bonus_bps)
    }

    public(friend) fun open_ltv(arg0: &ReserveConfig) : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal {
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from_percent(arg0.open_ltv_pct)
    }

    public(friend) fun protocol_liquidation_fee(arg0: &ReserveConfig) : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal {
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from_bps(arg0.protocol_liquidation_fee_bps)
    }

    public(friend) fun spread_fee(arg0: &ReserveConfig) : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal {
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from_bps(arg0.spread_fee_bps)
    }

    // decompiled from Move bytecode v6
}

