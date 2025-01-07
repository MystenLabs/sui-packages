module 0x9e88a456f0ed70397670403566b9ec1fde7343294bf9c34af0f85cefd8359028::errors {
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

