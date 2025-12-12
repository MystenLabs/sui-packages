module 0xd79a17afa8df58530cb298dc8d4be6abc39cf5e26f9eb2b91b723e820388333f::erros {
    public fun identical_addresses() : u64 {
        2004
    }

    public fun insufficient_a_amount() : u64 {
        3002
    }

    public fun insufficient_b_amount() : u64 {
        3003
    }

    public fun insufficient_input_amount() : u64 {
        2000
    }

    public fun insufficient_liquidity() : u64 {
        1002
    }

    public fun insufficient_liquidity_minted() : u64 {
        3001
    }

    public fun insufficient_lp_tokens() : u64 {
        3000
    }

    public fun insufficient_output_amount() : u64 {
        2001
    }

    public fun invalid_pool_ratio() : u64 {
        1003
    }

    public fun not_authorized() : u64 {
        4000
    }

    public fun pool_already_exists() : u64 {
        1001
    }

    public fun pool_not_found() : u64 {
        1000
    }

    public fun pool_paused() : u64 {
        4001
    }

    public fun slippage_exceeded() : u64 {
        2002
    }

    public fun zero_amount() : u64 {
        2003
    }

    // decompiled from Move bytecode v6
}

