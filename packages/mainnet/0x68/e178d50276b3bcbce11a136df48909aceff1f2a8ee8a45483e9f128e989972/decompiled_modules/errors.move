module 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors {
    public fun already_locked() : u64 {
        21
    }

    public fun already_settled() : u64 {
        8
    }

    public fun graduated() : u64 {
        5
    }

    public fun insufficient_liquidity() : u64 {
        17
    }

    public fun invalid_fee() : u64 {
        2
    }

    public fun invalid_pit_mode() : u64 {
        10
    }

    public fun not_admin() : u64 {
        18
    }

    public fun not_beneficiary() : u64 {
        22
    }

    public fun not_creator() : u64 {
        19
    }

    public fun not_graduated() : u64 {
        6
    }

    public fun not_winner() : u64 {
        9
    }

    public fun nothing_to_claim() : u64 {
        14
    }

    public fun overflow() : u64 {
        13
    }

    public fun paused() : u64 {
        1
    }

    public fun round_not_started() : u64 {
        15
    }

    public fun slippage() : u64 {
        4
    }

    public fun still_locked() : u64 {
        20
    }

    public fun too_early() : u64 {
        7
    }

    public fun unsettled_winner() : u64 {
        16
    }

    public fun use_split_collect() : u64 {
        23
    }

    public fun zero_amount() : u64 {
        3
    }

    public fun zero_denominator() : u64 {
        11
    }

    public fun zero_in() : u64 {
        12
    }

    // decompiled from Move bytecode v7
}

