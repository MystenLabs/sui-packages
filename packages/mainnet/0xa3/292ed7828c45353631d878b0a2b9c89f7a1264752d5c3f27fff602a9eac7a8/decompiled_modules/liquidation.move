module 0xa3292ed7828c45353631d878b0a2b9c89f7a1264752d5c3f27fff602a9eac7a8::liquidation {
    struct LiquidateAndRedeemEstimation has copy, drop {
        input_repay_amount: u64,
        required_repay_amount: u64,
        withdraw_ctoken_amount: u64,
        withdraw_liquidity_amount: u64,
        protocol_fee_amount: u64,
        liquidator_bonus_amount: u64,
        redeem_fee_amount: u64,
    }

    struct LiquidateAndRedeemEvent has copy, drop {
        input_repay_amount: u64,
        required_repay_amount: u64,
        withdraw_ctoken_amount: u64,
        withdraw_liquidity_amount: u64,
        protocol_fee_amount: u64,
        liquidator_bonus_amount: u64,
        redeem_fee_amount: u64,
    }

    public fun input_repay_amount(arg0: &LiquidateAndRedeemEstimation) : u64 {
        arg0.input_repay_amount
    }

    public fun liquidate_and_redeem<T0>(arg0: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: u64) : LiquidateAndRedeemEstimation {
        assert!(arg5 > 0, 2);
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserves<T0>(arg0);
        let v1 = 0x1::vector::empty<0xa3292ed7828c45353631d878b0a2b9c89f7a1264752d5c3f27fff602a9eac7a8::reserve::Reserve>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::Reserve<T0>>(v0)) {
            0x1::vector::push_back<0xa3292ed7828c45353631d878b0a2b9c89f7a1264752d5c3f27fff602a9eac7a8::reserve::Reserve>(&mut v1, 0xa3292ed7828c45353631d878b0a2b9c89f7a1264752d5c3f27fff602a9eac7a8::reserve::from_origin<T0>(0x1::vector::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::Reserve<T0>>(v0, v2)));
            v2 = v2 + 1;
        };
        let v3 = 0xa3292ed7828c45353631d878b0a2b9c89f7a1264752d5c3f27fff602a9eac7a8::obligation::from_origin<T0>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<T0>(arg0, arg1));
        0xa3292ed7828c45353631d878b0a2b9c89f7a1264752d5c3f27fff602a9eac7a8::obligation::refresh(&mut v3, &mut v1, arg4);
        let (v4, v5) = 0xa3292ed7828c45353631d878b0a2b9c89f7a1264752d5c3f27fff602a9eac7a8::obligation::liquidate(&v3, &v1, arg2, arg3, arg4, arg5);
        assert!(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::gt(v5, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(0)), 2);
        0xa3292ed7828c45353631d878b0a2b9c89f7a1264752d5c3f27fff602a9eac7a8::reserve::repay_liquidity(0x1::vector::borrow_mut<0xa3292ed7828c45353631d878b0a2b9c89f7a1264752d5c3f27fff602a9eac7a8::reserve::Reserve>(&mut v1, arg2), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::ceil(v5), v5);
        let v6 = 0x1::vector::borrow_mut<0xa3292ed7828c45353631d878b0a2b9c89f7a1264752d5c3f27fff602a9eac7a8::reserve::Reserve>(&mut v1, arg3);
        let (v7, v8) = 0xa3292ed7828c45353631d878b0a2b9c89f7a1264752d5c3f27fff602a9eac7a8::reserve::deduct_liquidation_fee(v6, v4);
        let v9 = v4 - v7;
        0xa3292ed7828c45353631d878b0a2b9c89f7a1264752d5c3f27fff602a9eac7a8::reserve::compound_interest(v6, arg4);
        let v10 = 0xa3292ed7828c45353631d878b0a2b9c89f7a1264752d5c3f27fff602a9eac7a8::reserve::redeem_ctokens(v6, v9);
        let v11 = 0xa3292ed7828c45353631d878b0a2b9c89f7a1264752d5c3f27fff602a9eac7a8::reserve::liquidity_request_amount(&v10);
        let v12 = 0xa3292ed7828c45353631d878b0a2b9c89f7a1264752d5c3f27fff602a9eac7a8::reserve::liquidity_request_fee(&v10);
        assert!(v11 > 0, 2);
        let v13 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::ceil(v5);
        let v14 = v11 - v12;
        let v15 = LiquidateAndRedeemEvent{
            input_repay_amount        : arg5,
            required_repay_amount     : v13,
            withdraw_ctoken_amount    : v9,
            withdraw_liquidity_amount : v14,
            protocol_fee_amount       : v7,
            liquidator_bonus_amount   : v8,
            redeem_fee_amount         : v12,
        };
        0x2::event::emit<LiquidateAndRedeemEvent>(v15);
        LiquidateAndRedeemEstimation{
            input_repay_amount        : arg5,
            required_repay_amount     : v13,
            withdraw_ctoken_amount    : v9,
            withdraw_liquidity_amount : v14,
            protocol_fee_amount       : v7,
            liquidator_bonus_amount   : v8,
            redeem_fee_amount         : v12,
        }
    }

    public fun liquidator_bonus_amount(arg0: &LiquidateAndRedeemEstimation) : u64 {
        arg0.liquidator_bonus_amount
    }

    public fun protocol_fee_amount(arg0: &LiquidateAndRedeemEstimation) : u64 {
        arg0.protocol_fee_amount
    }

    public fun redeem_fee_amount(arg0: &LiquidateAndRedeemEstimation) : u64 {
        arg0.redeem_fee_amount
    }

    public fun required_repay_amount(arg0: &LiquidateAndRedeemEstimation) : u64 {
        arg0.required_repay_amount
    }

    public fun withdraw_ctoken_amount(arg0: &LiquidateAndRedeemEstimation) : u64 {
        arg0.withdraw_ctoken_amount
    }

    public fun withdraw_liquidity_amount(arg0: &LiquidateAndRedeemEstimation) : u64 {
        arg0.withdraw_liquidity_amount
    }

    // decompiled from Move bytecode v6
}

