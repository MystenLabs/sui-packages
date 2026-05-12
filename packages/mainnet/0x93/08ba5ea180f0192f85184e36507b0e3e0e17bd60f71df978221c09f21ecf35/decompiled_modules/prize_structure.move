module 0x9308ba5ea180f0192f85184e36507b0e3e0e17bd60f71df978221c09f21ecf35::prize_structure {
    public fun bps_denom() : u64 {
        10000
    }

    public fun fee_bps() : u64 {
        1000
    }

    public fun per_winner_amount(arg0: u64, arg1: u64) : u64 {
        if (arg1 == 0) {
            0
        } else {
            arg0 / arg1
        }
    }

    public fun small_pool_threshold() : u64 {
        397
    }

    public fun tier_10_bps() : u64 {
        2200
    }

    public fun tier_1_9_total() : u64 {
        396
    }

    public fun tier_1_bps() : u64 {
        4000
    }

    public fun tier_1_recipients() : u64 {
        1
    }

    public fun tier_2_bps() : u64 {
        2000
    }

    public fun tier_2_recipients() : u64 {
        2
    }

    public fun tier_3_bps() : u64 {
        600
    }

    public fun tier_3_recipients() : u64 {
        3
    }

    public fun tier_4_bps() : u64 {
        400
    }

    public fun tier_4_recipients() : u64 {
        5
    }

    public fun tier_5_bps() : u64 {
        300
    }

    public fun tier_5_recipients() : u64 {
        10
    }

    public fun tier_6_bps() : u64 {
        200
    }

    public fun tier_6_recipients() : u64 {
        25
    }

    public fun tier_7_bps() : u64 {
        150
    }

    public fun tier_7_recipients() : u64 {
        50
    }

    public fun tier_8_bps() : u64 {
        100
    }

    public fun tier_8_recipients() : u64 {
        100
    }

    public fun tier_9_bps() : u64 {
        50
    }

    public fun tier_9_recipients() : u64 {
        200
    }

    public fun tier_amount(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / 10000) as u64)
    }

    // decompiled from Move bytecode v7
}

