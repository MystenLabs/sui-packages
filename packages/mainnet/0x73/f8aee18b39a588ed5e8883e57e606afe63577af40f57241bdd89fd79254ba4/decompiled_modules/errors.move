module 0x73f8aee18b39a588ed5e8883e57e606afe63577af40f57241bdd89fd79254ba4::errors {
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

