module 0x1c3ccdea40e1bd2a5bcaa8d6ecab51d8afc830514beb77752aac8a837d8f8839::phaser {
    struct PhaserCheckEvent has copy, drop {
        estimated_next_consensus_timestamp: u64,
        server_timestamp: u64,
        actual_consensus_timestamp: u64,
        late_threshold_ms: u64,
        early_threshold_ms: u64,
        timestamp_diff: u64,
        is_late: bool,
        accepted: bool,
        rejection_reason: u8,
    }

    public entry fun check_and_abort(arg0: &0x2::clock::Clock, arg1: u64, arg2: u64) {
        check_and_abort_with_buffers(arg0, arg1, arg2, 500, 1000);
    }

    public entry fun check_and_abort_with_buffers(arg0: &0x2::clock::Clock, arg1: u64, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = 0x2::clock::timestamp_ms(arg0);
        let (v1, v2) = if (v0 > arg1) {
            (v0 - arg1, true)
        } else {
            (arg1 - v0, false)
        };
        if (v2) {
            assert!(v1 <= arg3, 1);
        } else {
            assert!(v1 <= arg4, 2);
        };
        let v3 = PhaserCheckEvent{
            estimated_next_consensus_timestamp : arg1,
            server_timestamp                   : arg2,
            actual_consensus_timestamp         : v0,
            late_threshold_ms                  : arg3,
            early_threshold_ms                 : arg4,
            timestamp_diff                     : v1,
            is_late                            : v2,
            accepted                           : true,
            rejection_reason                   : 0,
        };
        0x2::event::emit<PhaserCheckEvent>(v3);
    }

    public entry fun check_and_abort_with_threshold(arg0: &0x2::clock::Clock, arg1: u64, arg2: u64, arg3: u64) {
        check_and_abort_with_buffers(arg0, arg1, arg2, arg3, arg3);
    }

    public fun check_timing(arg0: &0x2::clock::Clock, arg1: u64, arg2: u64, arg3: u64) : bool {
        check_timing_with_buffers(arg0, arg1, arg2, arg3, arg3)
    }

    public fun check_timing_with_buffers(arg0: &0x2::clock::Clock, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : bool {
        let v0 = 0x2::clock::timestamp_ms(arg0);
        let (v1, v2) = if (v0 > arg1) {
            (v0 - arg1, true)
        } else {
            (arg1 - v0, false)
        };
        let (v3, v4) = if (v2) {
            if (v1 <= arg3) {
                (true, 0)
            } else {
                (false, 1)
            }
        } else if (v1 <= arg4) {
            (true, 0)
        } else {
            (false, 2)
        };
        let v5 = PhaserCheckEvent{
            estimated_next_consensus_timestamp : arg1,
            server_timestamp                   : arg2,
            actual_consensus_timestamp         : v0,
            late_threshold_ms                  : arg3,
            early_threshold_ms                 : arg4,
            timestamp_diff                     : v1,
            is_late                            : v2,
            accepted                           : v3,
            rejection_reason                   : v4,
        };
        0x2::event::emit<PhaserCheckEvent>(v5);
        v3
    }

    public entry fun emit_timing_info(arg0: &0x2::clock::Clock, arg1: u64, arg2: u64) {
        check_timing_with_buffers(arg0, arg1, arg2, 500, 1000);
    }

    public entry fun emit_timing_info_with_buffers(arg0: &0x2::clock::Clock, arg1: u64, arg2: u64, arg3: u64, arg4: u64) {
        check_timing_with_buffers(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun emit_timing_info_with_threshold(arg0: &0x2::clock::Clock, arg1: u64, arg2: u64, arg3: u64) {
        check_timing_with_buffers(arg0, arg1, arg2, arg3, arg3);
    }

    // decompiled from Move bytecode v6
}

