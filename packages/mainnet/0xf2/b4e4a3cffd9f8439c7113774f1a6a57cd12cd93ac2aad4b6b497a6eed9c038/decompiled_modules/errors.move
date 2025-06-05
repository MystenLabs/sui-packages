module 0xf2b4e4a3cffd9f8439c7113774f1a6a57cd12cd93ac2aad4b6b497a6eed9c038::errors {
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

