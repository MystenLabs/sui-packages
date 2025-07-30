module 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::constants {
    public fun BASIS_POINTS() : u64 {
        10000
    }

    public fun INDEX_PRECISION() : u256 {
        1000000000000000000000000000000000000
    }

    public fun MAX_SCALE_FACTOR_EXPONENT() : u64 {
        8
    }

    public fun MIN_TO_LEAVE_IN_SP() : u256 {
        1000000000000000000
    }

    public fun MIN_YIELD_DEPOSIT() : u64 {
        1000000000
    }

    public fun ONE_DAY_MS() : u64 {
        86400000
    }

    public fun ONE_MIN_MS() : u64 {
        60000
    }

    public fun ONE_YEAR_MS() : u64 {
        31557600000
    }

    public fun ORACLE_TYPE_PYTH() : u8 {
        0
    }

    public fun ORACLE_TYPE_STORK() : u8 {
        1
    }

    public fun ORACLE_TYPE_SWITCHBOARD() : u8 {
        3
    }

    public fun REDEMPTION_BETA() : u64 {
        1
    }

    public fun REDEMPTION_FEE_FLOOR_BPS() : u64 {
        50
    }

    public fun SCALE_FACTOR() : u256 {
        1000000000
    }

    public fun SCALE_SPAN() : u64 {
        2
    }

    public fun STORK_STATE_ADDRESS() : address {
        @0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a
    }

    public fun SUI_TOKEN_ADDRESS() : address {
        @0x2
    }

    public fun VERSION() : u64 {
        10
    }

    public fun WAD() : u256 {
        1000000000000000000
    }

    // decompiled from Move bytecode v6
}

