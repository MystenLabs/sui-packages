module 0xf4e58d0a1b169b8f5fa723250fd3790fc59fa506e919f442112f9168dbf1c3d0::validation {
    public fun CreatePoolDisabled() : u64 {
        209
    }

    public fun DepositDisabled() : u64 {
        202
    }

    public fun IncorrectTokenOrder() : u64 {
        208
    }

    public fun IncorrectVersion() : u64 {
        101
    }

    public fun InvalidType() : u64 {
        105
    }

    public fun LiquidityLogicError() : u64 {
        210
    }

    public fun LiquidityNotEnough() : u64 {
        201
    }

    public fun MaxValueExceeded() : u64 {
        211
    }

    public fun NotZeroBalance() : u64 {
        104
    }

    public fun PoolExists() : u64 {
        207
    }

    public fun SameTokenPair() : u64 {
        206
    }

    public fun Slippage() : u64 {
        205
    }

    public fun SwapDisabled() : u64 {
        204
    }

    public fun WithdrawDisabled() : u64 {
        203
    }

    public fun ZeroBalance() : u64 {
        102
    }

    public fun ZeroInput() : u64 {
        103
    }

    public fun next_version() : u64 {
        version() + 1
    }

    public fun pre_check_version(arg0: u64) {
        assert!(arg0 == version(), IncorrectVersion());
    }

    public fun version() : u64 {
        0
    }

    // decompiled from Move bytecode v6
}

