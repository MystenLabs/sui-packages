module 0x6de55ff647ad89f37061a214078c36e2d08771d869c0d13725540be4dc30b9aa::constants {
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
        @0x5eb2dfcdd1b15d2021328258f6d5ec081e9a0cdcfa9e13a0eaeb9b5f7505ca78
    }

    public fun get_zero_amount_error() : u64 {
        7
    }

    // decompiled from Move bytecode v6
}

