module 0xd3acb4b40b10d9720c55c554df874c38c89f85d643dd0cd7eee09d0226611006::errors {
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

