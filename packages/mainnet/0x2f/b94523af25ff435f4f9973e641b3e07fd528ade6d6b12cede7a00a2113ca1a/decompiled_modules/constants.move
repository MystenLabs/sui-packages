module 0x2fb94523af25ff435f4f9973e641b3e07fd528ade6d6b12cede7a00a2113ca1a::constants {
    public fun get_cetus_sui_usdc_pool() : address {
        @0xcf994611fd4c48e277ce3ffd4d4364c914af2c3cbb05f7bf6facd371de688630
    }

    public fun get_insufficient_profit_error() : u64 {
        1
    }

    public fun get_invalid_amount_error() : u64 {
        3
    }

    public fun get_min_sui_amount() : u64 {
        1000000
    }

    public fun get_turbos_sui_usdc_pool() : address {
        @0x95e7f015846af6905dc16bd37eb29ae4889af275e7a38df9d30c19845e838c41
    }

    public fun get_unsupported_dex_error() : u64 {
        9
    }

    public fun get_zero_amount_error() : u64 {
        7
    }

    // decompiled from Move bytecode v6
}

