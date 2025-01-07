module 0x24fff2b9b9e690601a57203c8bee416dda6144d27417fa8c0534d37d7e531878::errors {
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

