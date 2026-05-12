module 0x9308ba5ea180f0192f85184e36507b0e3e0e17bd60f71df978221c09f21ecf35::yield_router {
    struct Allocation has key {
        id: 0x2::object::UID,
        suilend_bps: u64,
        navi_bps: u64,
        alphalend_bps: u64,
        scallop_bps: u64,
        buffer_bps: u64,
        emergency_mode: bool,
        last_updated_ms: u64,
    }

    struct ProtocolHealth has copy, drop, store {
        last_apy_bps: u64,
        tvl_drop_magnitude_bps: u64,
        tvl_is_dropping: bool,
        consecutive_errors: u64,
        auto_paused: bool,
        last_check_ms: u64,
        auto_paused_at_ms: u64,
    }

    struct HealthRegistry has key {
        id: 0x2::object::UID,
        suilend: ProtocolHealth,
        navi: ProtocolHealth,
        alphalend: ProtocolHealth,
        scallop: ProtocolHealth,
    }

    struct AllocationUpdatedEvent has copy, drop {
        suilend_bps: u64,
        navi_bps: u64,
        alphalend_bps: u64,
        scallop_bps: u64,
        buffer_bps: u64,
        timestamp_ms: u64,
    }

    struct ProtocolIsolatedEvent has copy, drop {
        protocol: u8,
        reason: u8,
        timestamp_ms: u64,
    }

    struct EmergencyModeEvent has copy, drop {
        enabled: bool,
        timestamp_ms: u64,
    }

    public fun alphalend_bps(arg0: &Allocation) : u64 {
        arg0.alphalend_bps
    }

    public fun buffer_bps(arg0: &Allocation) : u64 {
        arg0.buffer_bps
    }

    public fun create_allocation(arg0: &0x9308ba5ea180f0192f85184e36507b0e3e0e17bd60f71df978221c09f21ecf35::admin::AdminCap, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Allocation{
            id              : 0x2::object::new(arg2),
            suilend_bps     : 3500,
            navi_bps        : 3500,
            alphalend_bps   : 0,
            scallop_bps     : 0,
            buffer_bps      : 3000,
            emergency_mode  : false,
            last_updated_ms : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::transfer::share_object<Allocation>(v0);
        let v1 = ProtocolHealth{
            last_apy_bps           : 0,
            tvl_drop_magnitude_bps : 0,
            tvl_is_dropping        : false,
            consecutive_errors     : 0,
            auto_paused            : false,
            last_check_ms          : 0,
            auto_paused_at_ms      : 0,
        };
        let v2 = HealthRegistry{
            id        : 0x2::object::new(arg2),
            suilend   : v1,
            navi      : v1,
            alphalend : v1,
            scallop   : v1,
        };
        0x2::transfer::share_object<HealthRegistry>(v2);
    }

    fun get_health_mut(arg0: &mut HealthRegistry, arg1: u8) : &mut ProtocolHealth {
        assert!(arg1 <= 3, 4);
        if (arg1 == 0) {
            &mut arg0.suilend
        } else if (arg1 == 1) {
            &mut arg0.navi
        } else if (arg1 == 2) {
            &mut arg0.alphalend
        } else {
            &mut arg0.scallop
        }
    }

    fun get_health_ref(arg0: &HealthRegistry, arg1: u8) : &ProtocolHealth {
        assert!(arg1 <= 3, 4);
        if (arg1 == 0) {
            &arg0.suilend
        } else if (arg1 == 1) {
            &arg0.navi
        } else if (arg1 == 2) {
            &arg0.alphalend
        } else {
            &arg0.scallop
        }
    }

    public fun is_emergency(arg0: &Allocation) : bool {
        arg0.emergency_mode
    }

    public fun is_protocol_paused(arg0: &HealthRegistry, arg1: u8) : bool {
        get_health_ref(arg0, arg1).auto_paused
    }

    public fun navi_bps(arg0: &Allocation) : u64 {
        arg0.navi_bps
    }

    public fun record_health(arg0: &0x9308ba5ea180f0192f85184e36507b0e3e0e17bd60f71df978221c09f21ecf35::admin::KeeperCap, arg1: &0x9308ba5ea180f0192f85184e36507b0e3e0e17bd60f71df978221c09f21ecf35::admin::KeeperRegistry, arg2: &mut Allocation, arg3: &mut HealthRegistry, arg4: u8, arg5: u64, arg6: u64, arg7: bool, arg8: u64, arg9: &0x2::clock::Clock) {
        0x9308ba5ea180f0192f85184e36507b0e3e0e17bd60f71df978221c09f21ecf35::admin::assert_active(arg1, arg0);
        let v0 = 0x2::clock::timestamp_ms(arg9);
        assert!(arg5 <= 5000, 6);
        let v1 = get_health_mut(arg3, arg4);
        assert!(v1.last_check_ms == 0 || v0 >= v1.last_check_ms + 3600000, 5);
        v1.last_apy_bps = arg5;
        v1.tvl_drop_magnitude_bps = arg6;
        v1.tvl_is_dropping = arg7;
        v1.consecutive_errors = arg8;
        v1.last_check_ms = v0;
        let v2 = if (arg5 < 100) {
            true
        } else if (arg7 && arg6 > 5000) {
            true
        } else {
            arg8 >= 3
        };
        if (v2 && !v1.auto_paused) {
            v1.auto_paused = true;
            v1.auto_paused_at_ms = v0;
            let v3 = release_allocation(arg2, arg4);
            arg2.buffer_bps = arg2.buffer_bps + v3;
            arg2.last_updated_ms = v0;
            let v4 = if (arg5 < 100) {
                0
            } else if (arg7 && arg6 > 5000) {
                1
            } else {
                2
            };
            let v5 = ProtocolIsolatedEvent{
                protocol     : arg4,
                reason       : v4,
                timestamp_ms : v0,
            };
            0x2::event::emit<ProtocolIsolatedEvent>(v5);
        };
    }

    fun release_allocation(arg0: &mut Allocation, arg1: u8) : u64 {
        if (arg1 == 0) {
            arg0.suilend_bps = 0;
            arg0.suilend_bps
        } else if (arg1 == 1) {
            arg0.navi_bps = 0;
            arg0.navi_bps
        } else if (arg1 == 2) {
            arg0.alphalend_bps = 0;
            arg0.alphalend_bps
        } else {
            arg0.scallop_bps = 0;
            arg0.scallop_bps
        }
    }

    public fun restore_protocol(arg0: &0x9308ba5ea180f0192f85184e36507b0e3e0e17bd60f71df978221c09f21ecf35::admin::AdminCap, arg1: &mut HealthRegistry, arg2: u8, arg3: &0x2::clock::Clock) {
        let v0 = get_health_mut(arg1, arg2);
        assert!(v0.auto_paused, 7);
        assert!(0x2::clock::timestamp_ms(arg3) >= v0.auto_paused_at_ms + 86400000, 8);
        v0.auto_paused = false;
        v0.consecutive_errors = 0;
        v0.tvl_drop_magnitude_bps = 0;
        v0.tvl_is_dropping = false;
    }

    public fun scallop_bps(arg0: &Allocation) : u64 {
        arg0.scallop_bps
    }

    public fun set_emergency_mode(arg0: &0x9308ba5ea180f0192f85184e36507b0e3e0e17bd60f71df978221c09f21ecf35::admin::AdminCap, arg1: &mut Allocation, arg2: bool, arg3: &0x2::clock::Clock) {
        arg1.emergency_mode = arg2;
        let v0 = 0x2::clock::timestamp_ms(arg3);
        arg1.last_updated_ms = v0;
        if (arg2) {
            arg1.suilend_bps = 0;
            arg1.navi_bps = 0;
            arg1.alphalend_bps = 0;
            arg1.scallop_bps = 0;
            arg1.buffer_bps = arg1.buffer_bps + arg1.suilend_bps + arg1.navi_bps + arg1.alphalend_bps + arg1.scallop_bps;
            let v1 = AllocationUpdatedEvent{
                suilend_bps   : 0,
                navi_bps      : 0,
                alphalend_bps : 0,
                scallop_bps   : 0,
                buffer_bps    : arg1.buffer_bps,
                timestamp_ms  : v0,
            };
            0x2::event::emit<AllocationUpdatedEvent>(v1);
        };
        let v2 = EmergencyModeEvent{
            enabled      : arg2,
            timestamp_ms : v0,
        };
        0x2::event::emit<EmergencyModeEvent>(v2);
    }

    public fun suilend_bps(arg0: &Allocation) : u64 {
        arg0.suilend_bps
    }

    public fun update_allocation(arg0: &0x9308ba5ea180f0192f85184e36507b0e3e0e17bd60f71df978221c09f21ecf35::admin::AdminCap, arg1: &mut Allocation, arg2: &HealthRegistry, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock) {
        assert!(arg3 + arg4 + arg5 + arg6 + arg7 == 10000, 1);
        assert!(arg3 <= 3500, 2);
        assert!(arg4 <= 3500, 2);
        assert!(arg5 <= 3500, 2);
        assert!(arg6 <= 1000, 2);
        assert!(arg7 >= 1500 && arg7 <= 3000, 3);
        if (arg1.emergency_mode) {
            let v0 = if (arg3 == 0) {
                if (arg4 == 0) {
                    if (arg5 == 0) {
                        arg6 == 0
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            };
            assert!(v0, 10);
        };
        assert!(!arg2.suilend.auto_paused || arg3 == 0, 9);
        assert!(!arg2.navi.auto_paused || arg4 == 0, 9);
        assert!(!arg2.alphalend.auto_paused || arg5 == 0, 9);
        assert!(!arg2.scallop.auto_paused || arg6 == 0, 9);
        arg1.suilend_bps = arg3;
        arg1.navi_bps = arg4;
        arg1.alphalend_bps = arg5;
        arg1.scallop_bps = arg6;
        arg1.buffer_bps = arg7;
        arg1.last_updated_ms = 0x2::clock::timestamp_ms(arg8);
        let v1 = AllocationUpdatedEvent{
            suilend_bps   : arg3,
            navi_bps      : arg4,
            alphalend_bps : arg5,
            scallop_bps   : arg6,
            buffer_bps    : arg7,
            timestamp_ms  : arg1.last_updated_ms,
        };
        0x2::event::emit<AllocationUpdatedEvent>(v1);
    }

    // decompiled from Move bytecode v7
}

