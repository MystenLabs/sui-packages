module 0x3106674389a685d1326ab410c218c0f1de9aabd8ddb5200138bbb5df78d6a0fc::errors {
    public fun deposit_paused() : u64 {
        3
    }

    public fun inactive_queue_processor() : u64 {
        1
    }

    public fun insufficient_funds() : u64 {
        5
    }

    public fun queue_alread_created() : u64 {
        6
    }

    public fun version_mismatch() : u64 {
        2
    }

    public fun withdraw_paused() : u64 {
        4
    }

    // decompiled from Move bytecode v6
}

