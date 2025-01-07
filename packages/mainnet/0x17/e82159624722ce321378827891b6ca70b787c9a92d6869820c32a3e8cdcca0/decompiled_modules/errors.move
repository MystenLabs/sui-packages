module 0x40529984528fb46b602d824b9240038c5e341476b3c3cd564223149019c188cf::errors {
    public(friend) fun ECannotEnterAfterCloseTime() : u64 {
        2
    }

    public(friend) fun ECannotParticipateInLockedGame() : u64 {
        5
    }

    public(friend) fun ECannotParticipateLimit() : u64 {
        4
    }

    public(friend) fun ECloseTimeNotReached() : u64 {
        1
    }

    public(friend) fun EGameNeedsToBeClosed() : u64 {
        6
    }

    public(friend) fun EGameNotInProgress() : u64 {
        0
    }

    public(friend) fun EInvalidPayment() : u64 {
        3
    }

    // decompiled from Move bytecode v6
}

