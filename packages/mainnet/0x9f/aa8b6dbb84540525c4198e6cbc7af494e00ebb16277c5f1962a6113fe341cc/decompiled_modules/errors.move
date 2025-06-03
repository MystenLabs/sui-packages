module 0x9faa8b6dbb84540525c4198e6cbc7af494e00ebb16277c5f1962a6113fe341cc::errors {
    public fun EExponentMismatch() : u64 {
        404
    }

    public fun EForbidden() : u64 {
        400
    }

    public fun EIndexOutOfBounds() : u64 {
        401
    }

    public fun ENotEnoughPriceFeedCandidates() : u64 {
        403
    }

    public fun EPoolMismatch() : u64 {
        402
    }

    // decompiled from Move bytecode v6
}

