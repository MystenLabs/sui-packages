module 0x1d18986b0ecc895e9f4be9f37fc28084e75e3ae9cb845f87ec4b5b16a6b20b0::errors {
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

