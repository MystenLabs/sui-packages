module 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::errors {
    public fun EAmountInOutOfRange() : u64 {
        409
    }

    public fun EBaseMaxReserveExceeded() : u64 {
        413
    }

    public fun EForbidden() : u64 {
        400
    }

    public fun EInsufficientAmountOut() : u64 {
        411
    }

    public fun EInsufficientLiquidity() : u64 {
        406
    }

    public fun EMaxPriceDiffRatioExceeded() : u64 {
        410
    }

    public fun EPoolInfoMismatch() : u64 {
        404
    }

    public fun EPoolPaused() : u64 {
        415
    }

    public fun EPositionPoolMismatch() : u64 {
        403
    }

    public fun EPriceAssetsMismatch() : u64 {
        402
    }

    public fun EPriceInvalid() : u64 {
        405
    }

    public fun EPriceObjectInvalid() : u64 {
        401
    }

    public fun EQuoteMaxReserveExceeded() : u64 {
        414
    }

    public fun ETradeIntervalTooShort() : u64 {
        408
    }

    public fun ETxExpired() : u64 {
        407
    }

    public fun EWithdrawTooEarly() : u64 {
        412
    }

    // decompiled from Move bytecode v6
}

