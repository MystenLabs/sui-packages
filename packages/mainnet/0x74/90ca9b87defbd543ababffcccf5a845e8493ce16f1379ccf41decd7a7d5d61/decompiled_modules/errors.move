module 0x7490ca9b87defbd543ababffcccf5a845e8493ce16f1379ccf41decd7a7d5d61::errors {
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

