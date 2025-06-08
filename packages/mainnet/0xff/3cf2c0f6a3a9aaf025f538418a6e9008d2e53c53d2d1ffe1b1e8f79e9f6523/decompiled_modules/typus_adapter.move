module 0xff3cf2c0f6a3a9aaf025f538418a6e9008d2e53c53d2d1ffe1b1e8f79e9f6523::typus_adapter {
    struct TypusFinanceBuyLongRequest {
        dummy_field: bool,
    }

    struct TypusFinanceBuyShortRequest {
        dummy_field: bool,
    }

    struct TypusFinanceSellShortRequest {
        dummy_field: bool,
    }

    struct TypusFinanceSellLongRequest {
        dummy_field: bool,
    }

    struct TypusFinanceBuyLongReceipt {
        dummy_field: bool,
    }

    struct TypusFinanceBuyShortReceipt {
        dummy_field: bool,
    }

    struct TypusFinanceSellShortReceipt {
        dummy_field: bool,
    }

    struct TypusFinanceSellLongReceipt {
        dummy_field: bool,
    }

    public(friend) fun drop_buy_long_request(arg0: TypusFinanceBuyLongRequest) {
        let TypusFinanceBuyLongRequest {  } = arg0;
    }

    public(friend) fun drop_buy_short_request(arg0: TypusFinanceBuyShortRequest) {
        let TypusFinanceBuyShortRequest {  } = arg0;
    }

    public(friend) fun drop_sell_long_request(arg0: TypusFinanceSellLongRequest) {
        let TypusFinanceSellLongRequest {  } = arg0;
    }

    public(friend) fun drop_sell_short_request(arg0: TypusFinanceSellShortRequest) {
        let TypusFinanceSellShortRequest {  } = arg0;
    }

    public(friend) fun new_buy_long_request() : TypusFinanceBuyLongRequest {
        TypusFinanceBuyLongRequest{dummy_field: false}
    }

    public(friend) fun new_buy_short_request() : TypusFinanceBuyShortRequest {
        TypusFinanceBuyShortRequest{dummy_field: false}
    }

    public(friend) fun new_sell_long_request() : TypusFinanceSellLongRequest {
        TypusFinanceSellLongRequest{dummy_field: false}
    }

    public(friend) fun new_sell_short_request() : TypusFinanceSellShortRequest {
        TypusFinanceSellShortRequest{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

