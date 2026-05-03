module 0x7b27cc5358dcaa4b6b6eee7ac38011114fb5d5ab46a6acba5411d65a6611090f::graduation_log {
    struct GraduationLoggedEvent has copy, drop, store {
        event_id: vector<u8>,
        event_type: u8,
        from_multiplier_x100: u32,
        to_multiplier_x100: u32,
        trigger_pot_micro_gbp: u64,
        mode: 0x1::string::String,
        claimed_timestamp_ms: u64,
        sui_consensus_timestamp_ms: u64,
    }

    public fun event_auto_applied() : u8 {
        0
    }

    public fun event_declined() : u8 {
        3
    }

    public fun event_downgraded() : u8 {
        4
    }

    public fun event_gate_failed() : u8 {
        2
    }

    public fun event_manual_applied() : u8 {
        1
    }

    public fun event_type_max() : u8 {
        4
    }

    public fun log_graduation(arg0: &0x2::clock::Clock, arg1: vector<u8>, arg2: u8, arg3: u32, arg4: u32, arg5: u64, arg6: 0x1::string::String, arg7: u64) {
        assert!(0x1::vector::length<u8>(&arg1) == 32, 2);
        assert!(arg2 <= 4, 1);
        assert!(arg3 > 0, 3);
        assert!(arg3 <= 6400, 3);
        assert!(arg4 > 0, 4);
        assert!(arg4 <= 6400, 4);
        assert!(arg5 > 0, 5);
        let v0 = 0x1::string::as_bytes(&arg6);
        assert!(0x1::vector::length<u8>(v0) > 0, 6);
        assert!(0x1::vector::length<u8>(v0) <= 32, 7);
        let v1 = GraduationLoggedEvent{
            event_id                   : arg1,
            event_type                 : arg2,
            from_multiplier_x100       : arg3,
            to_multiplier_x100         : arg4,
            trigger_pot_micro_gbp      : arg5,
            mode                       : arg6,
            claimed_timestamp_ms       : arg7,
            sui_consensus_timestamp_ms : 0x2::clock::timestamp_ms(arg0),
        };
        0x2::event::emit<GraduationLoggedEvent>(v1);
    }

    public fun multiplier_x100_max() : u32 {
        6400
    }

    // decompiled from Move bytecode v7
}

