module 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::suilend_adapter {
    struct SuilendProtocolBorrowRequest {
        dummy_field: bool,
    }

    struct SuilendProtocolSupplyRequest {
        dummy_field: bool,
    }

    struct SuilendProtocolRepayRequest {
        dummy_field: bool,
    }

    struct SuilendProtocolWithdrawRequest {
        dummy_field: bool,
    }

    struct SuilendProtocolClaimRequest {
        dummy_field: bool,
    }

    struct SuilendProtocolBorrowReceipt {
        dummy_field: bool,
    }

    struct SuilendProtocolSupplyReceipt {
        dummy_field: bool,
    }

    struct SuilendProtocolRepayReceipt {
        dummy_field: bool,
    }

    struct SuilendProtocolWithdrawReceipt {
        dummy_field: bool,
    }

    struct SuilendProtocolClaimReceipt {
        dummy_field: bool,
    }

    public(friend) fun drop_borrow_request(arg0: SuilendProtocolBorrowRequest) {
        let SuilendProtocolBorrowRequest {  } = arg0;
    }

    public(friend) fun drop_claim_request(arg0: SuilendProtocolClaimRequest) {
        let SuilendProtocolClaimRequest {  } = arg0;
    }

    public(friend) fun drop_repay_request(arg0: SuilendProtocolRepayRequest) {
        let SuilendProtocolRepayRequest {  } = arg0;
    }

    public(friend) fun drop_supply_request(arg0: SuilendProtocolSupplyRequest) {
        let SuilendProtocolSupplyRequest {  } = arg0;
    }

    public(friend) fun drop_withdraw_request(arg0: SuilendProtocolWithdrawRequest) {
        let SuilendProtocolWithdrawRequest {  } = arg0;
    }

    public(friend) fun new_borrow_request() : SuilendProtocolBorrowRequest {
        SuilendProtocolBorrowRequest{dummy_field: false}
    }

    public(friend) fun new_claim_request() : SuilendProtocolClaimRequest {
        SuilendProtocolClaimRequest{dummy_field: false}
    }

    public(friend) fun new_repay_request() : SuilendProtocolRepayRequest {
        SuilendProtocolRepayRequest{dummy_field: false}
    }

    public(friend) fun new_supply_request() : SuilendProtocolSupplyRequest {
        SuilendProtocolSupplyRequest{dummy_field: false}
    }

    public(friend) fun new_withdraw_request() : SuilendProtocolWithdrawRequest {
        SuilendProtocolWithdrawRequest{dummy_field: false}
    }

    public fun supply<T0, T1>(arg0: 0x2::coin::Coin<T1>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>> {
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_liquidity_and_mint_ctokens<T0, T1>(arg1, arg2, arg3, arg0, arg4)
    }

    public fun withdraw<T0, T1>(arg0: 0x2::coin::Coin<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x2::coin::value<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>>(&arg0);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<T0, T1>(arg1, arg2, arg3, arg0, 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T1>>(), arg4)
    }

    // decompiled from Move bytecode v6
}

