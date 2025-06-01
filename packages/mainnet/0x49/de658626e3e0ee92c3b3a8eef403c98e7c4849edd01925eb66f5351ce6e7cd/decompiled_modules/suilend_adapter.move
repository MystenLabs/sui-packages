module 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::suilend_adapter {
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

    // decompiled from Move bytecode v6
}

