module 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::scallop_adapter {
    struct ScallopProtocolBorrowRequest {
        dummy_field: bool,
    }

    struct ScallopProtocolSupplyRequest {
        dummy_field: bool,
    }

    struct ScallopProtocolRepayRequest {
        dummy_field: bool,
    }

    struct ScallopProtocolWithdrawRequest {
        dummy_field: bool,
    }

    struct ScallopProtocolClaimRequest {
        dummy_field: bool,
    }

    struct ScallopProtocolBorrowReceipt {
        dummy_field: bool,
    }

    struct ScallopProtocolSupplyReceipt {
        dummy_field: bool,
    }

    struct ScallopProtocolRepayReceipt {
        dummy_field: bool,
    }

    struct ScallopProtocolWithdrawReceipt {
        dummy_field: bool,
    }

    struct ScallopProtocolClaimReceipt {
        dummy_field: bool,
    }

    public(friend) fun drop_borrow_request(arg0: ScallopProtocolBorrowRequest) {
        let ScallopProtocolBorrowRequest {  } = arg0;
    }

    public(friend) fun drop_claim_request(arg0: ScallopProtocolClaimRequest) {
        let ScallopProtocolClaimRequest {  } = arg0;
    }

    public(friend) fun drop_repay_request(arg0: ScallopProtocolRepayRequest) {
        let ScallopProtocolRepayRequest {  } = arg0;
    }

    public(friend) fun drop_supply_request(arg0: ScallopProtocolSupplyRequest) {
        let ScallopProtocolSupplyRequest {  } = arg0;
    }

    public(friend) fun drop_withdraw_request(arg0: ScallopProtocolWithdrawRequest) {
        let ScallopProtocolWithdrawRequest {  } = arg0;
    }

    public(friend) fun new_borrow_request() : ScallopProtocolBorrowRequest {
        ScallopProtocolBorrowRequest{dummy_field: false}
    }

    public(friend) fun new_claim_request() : ScallopProtocolClaimRequest {
        ScallopProtocolClaimRequest{dummy_field: false}
    }

    public(friend) fun new_repay_request() : ScallopProtocolRepayRequest {
        ScallopProtocolRepayRequest{dummy_field: false}
    }

    public(friend) fun new_supply_request() : ScallopProtocolSupplyRequest {
        ScallopProtocolSupplyRequest{dummy_field: false}
    }

    public(friend) fun new_withdraw_request() : ScallopProtocolWithdrawRequest {
        ScallopProtocolWithdrawRequest{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

