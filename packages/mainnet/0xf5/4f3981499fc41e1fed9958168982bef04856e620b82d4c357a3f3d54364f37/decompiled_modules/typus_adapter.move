module 0xf54f3981499fc41e1fed9958168982bef04856e620b82d4c357a3f3d54364f37::typus_adapter {
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

