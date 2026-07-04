module 0x1701f7e71bb1b853d5f9fb794172486ffa5b51c7059ba168a7fbaab69ad9c46::events {
    struct MigratedFeedInfoObjectV1 has copy, drop {
        feed_info_object_id: 0x2::object::ID,
        front_feed_id: u32,
        next_feed_id: u32,
        expiry_timestamp_ms: u64,
    }

    struct UpdatedRollingWindowV1 has copy, drop {
        feed_info_object_id: 0x2::object::ID,
        roll_start_timestamp_ms: u64,
        roll_end_timestamp_ms: u64,
    }

    public(friend) fun emit_migrated_feed_info_object(arg0: 0x2::object::ID, arg1: u32, arg2: u32, arg3: u64) {
        let v0 = MigratedFeedInfoObjectV1{
            feed_info_object_id : arg0,
            front_feed_id       : arg1,
            next_feed_id        : arg2,
            expiry_timestamp_ms : arg3,
        };
        0x2::event::emit<MigratedFeedInfoObjectV1>(v0);
    }

    public(friend) fun emit_updated_rolling_window(arg0: 0x2::object::ID, arg1: u64, arg2: u64) {
        let v0 = UpdatedRollingWindowV1{
            feed_info_object_id     : arg0,
            roll_start_timestamp_ms : arg1,
            roll_end_timestamp_ms   : arg2,
        };
        0x2::event::emit<UpdatedRollingWindowV1>(v0);
    }

    // decompiled from Move bytecode v7
}

