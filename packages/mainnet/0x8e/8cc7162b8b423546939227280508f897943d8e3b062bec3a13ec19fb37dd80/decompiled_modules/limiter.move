module 0x8e8cc7162b8b423546939227280508f897943d8e3b062bec3a13ec19fb37dd80::limiter {
    struct NewLimiter has copy, drop, store {
        outflow_limit: u64,
        outflow_cycle_duration: u32,
        outflow_segment_duration: u32,
    }

    // decompiled from Move bytecode v6
}

