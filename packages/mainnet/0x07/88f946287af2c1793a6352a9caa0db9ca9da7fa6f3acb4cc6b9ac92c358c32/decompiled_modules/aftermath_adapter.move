module 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::aftermath_adapter {
    struct AftermathProtocolSwapRequest {
        dummy_field: bool,
    }

    struct AftermathProtocolAddLiquidityRequest {
        dummy_field: bool,
    }

    struct AftermathProtocolRemoveLiquidityRequest {
        dummy_field: bool,
    }

    struct AftermathProtocolClaimRequest {
        dummy_field: bool,
    }

    struct AftermathProtocolSwapReceipt {
        dummy_field: bool,
    }

    struct AftermathProtocolAddLiquidityReceipt {
        dummy_field: bool,
    }

    struct AftermathProtocolRemoveLiquidityReceipt {
        dummy_field: bool,
    }

    struct AftermathProtocolClaimReceipt {
        dummy_field: bool,
    }

    public(friend) fun drop_add_liquidity_request(arg0: AftermathProtocolAddLiquidityRequest) {
        let AftermathProtocolAddLiquidityRequest {  } = arg0;
    }

    public(friend) fun drop_claim_request(arg0: AftermathProtocolClaimRequest) {
        let AftermathProtocolClaimRequest {  } = arg0;
    }

    public(friend) fun drop_remove_liquidity_request(arg0: AftermathProtocolRemoveLiquidityRequest) {
        let AftermathProtocolRemoveLiquidityRequest {  } = arg0;
    }

    public(friend) fun drop_swap_request(arg0: AftermathProtocolSwapRequest) {
        let AftermathProtocolSwapRequest {  } = arg0;
    }

    public(friend) fun new_add_liquidity_request() : AftermathProtocolAddLiquidityRequest {
        AftermathProtocolAddLiquidityRequest{dummy_field: false}
    }

    public(friend) fun new_claim_request() : AftermathProtocolClaimRequest {
        AftermathProtocolClaimRequest{dummy_field: false}
    }

    public(friend) fun new_remove_liquidity_request() : AftermathProtocolRemoveLiquidityRequest {
        AftermathProtocolRemoveLiquidityRequest{dummy_field: false}
    }

    public(friend) fun new_swap_request() : AftermathProtocolSwapRequest {
        AftermathProtocolSwapRequest{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

