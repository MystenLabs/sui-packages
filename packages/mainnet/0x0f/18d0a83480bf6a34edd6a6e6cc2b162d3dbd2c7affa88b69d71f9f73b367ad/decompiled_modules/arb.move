module 0xf18d0a83480bf6a34edd6a6e6cc2b162d3dbd2c7affa88b69d71f9f73b367ad::arb {
    struct SwapStep has copy, drop {
        pool_id: address,
        a_to_b: bool,
        amount_in: u64,
    }

    public fun check_and_report(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : bool {
        0xf18d0a83480bf6a34edd6a6e6cc2b162d3dbd2c7affa88b69d71f9f73b367ad::profitability::check_profitability(arg0, arg1, arg2, arg3)
    }

    public fun validate_route(arg0: &vector<SwapStep>) : bool {
        if (0x1::vector::length<SwapStep>(arg0) < 2) {
            return false
        };
        0x1::vector::borrow<SwapStep>(arg0, 0).amount_in > 0
    }

    // decompiled from Move bytecode v6
}

