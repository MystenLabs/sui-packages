module 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::stem_adapter {
    struct StemProtocolSwapRequest {
        dummy_field: bool,
    }

    struct StemProtocolAddLiquidityRequest {
        dummy_field: bool,
    }

    struct StemProtocolRemoveLiquidityRequest {
        dummy_field: bool,
    }

    struct StemProtocolClaimRequest {
        dummy_field: bool,
    }

    struct StemProtocolSwapReceipt {
        dummy_field: bool,
    }

    struct StemProtocolAddLiquidityReceipt {
        dummy_field: bool,
    }

    struct StemProtocolRemoveLiquidityReceipt {
        dummy_field: bool,
    }

    struct StemProtocolClaimReceipt {
        dummy_field: bool,
    }

    public(friend) fun drop_add_liquidity_request(arg0: StemProtocolAddLiquidityRequest) {
        let StemProtocolAddLiquidityRequest {  } = arg0;
    }

    public(friend) fun drop_claim_request(arg0: StemProtocolClaimRequest) {
        let StemProtocolClaimRequest {  } = arg0;
    }

    public(friend) fun drop_remove_liquidity_request(arg0: StemProtocolRemoveLiquidityRequest) {
        let StemProtocolRemoveLiquidityRequest {  } = arg0;
    }

    public(friend) fun drop_swap_request(arg0: StemProtocolSwapRequest) {
        let StemProtocolSwapRequest {  } = arg0;
    }

    public(friend) fun new_add_liquidity_request() : StemProtocolAddLiquidityRequest {
        StemProtocolAddLiquidityRequest{dummy_field: false}
    }

    public(friend) fun new_claim_request() : StemProtocolClaimRequest {
        StemProtocolClaimRequest{dummy_field: false}
    }

    public(friend) fun new_remove_liquidity_request() : StemProtocolRemoveLiquidityRequest {
        StemProtocolRemoveLiquidityRequest{dummy_field: false}
    }

    public(friend) fun new_swap_request() : StemProtocolSwapRequest {
        StemProtocolSwapRequest{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

