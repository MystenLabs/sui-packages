module 0xf54f3981499fc41e1fed9958168982bef04856e620b82d4c357a3f3d54364f37::steamm_adapter {
    struct SteammProtocolSwapRequest {
        dummy_field: bool,
    }

    struct SteammProtocolAddLiquidityRequest {
        dummy_field: bool,
    }

    struct SteammProtocolRemoveLiquidityRequest {
        dummy_field: bool,
    }

    struct SteammProtocolClaimRequest {
        dummy_field: bool,
    }

    struct SteammProtocolSwapReceipt {
        dummy_field: bool,
    }

    struct SteammProtocolAddLiquidityReceipt {
        dummy_field: bool,
    }

    struct SteammProtocolRemoveLiquidityReceipt {
        dummy_field: bool,
    }

    struct SteammProtocolClaimReceipt {
        dummy_field: bool,
    }

    public(friend) fun drop_add_liquidity_request(arg0: SteammProtocolAddLiquidityRequest) {
        let SteammProtocolAddLiquidityRequest {  } = arg0;
    }

    public(friend) fun drop_claim_request(arg0: SteammProtocolClaimRequest) {
        let SteammProtocolClaimRequest {  } = arg0;
    }

    public(friend) fun drop_remove_liquidity_request(arg0: SteammProtocolRemoveLiquidityRequest) {
        let SteammProtocolRemoveLiquidityRequest {  } = arg0;
    }

    public(friend) fun drop_swap_request(arg0: SteammProtocolSwapRequest) {
        let SteammProtocolSwapRequest {  } = arg0;
    }

    public(friend) fun new_add_liquidity_request() : SteammProtocolAddLiquidityRequest {
        SteammProtocolAddLiquidityRequest{dummy_field: false}
    }

    public(friend) fun new_claim_request() : SteammProtocolClaimRequest {
        SteammProtocolClaimRequest{dummy_field: false}
    }

    public(friend) fun new_remove_liquidity_request() : SteammProtocolRemoveLiquidityRequest {
        SteammProtocolRemoveLiquidityRequest{dummy_field: false}
    }

    public(friend) fun new_swap_request() : SteammProtocolSwapRequest {
        SteammProtocolSwapRequest{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

