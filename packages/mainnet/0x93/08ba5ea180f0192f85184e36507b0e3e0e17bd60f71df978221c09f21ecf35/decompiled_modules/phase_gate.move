module 0x9308ba5ea180f0192f85184e36507b0e3e0e17bd60f71df978221c09f21ecf35::phase_gate {
    struct PhaseGate has key {
        id: 0x2::object::UID,
        current_phase: u8,
        deployed_at_ms: u64,
        last_advanced_at_ms: u64,
        advance_attempts: u64,
    }

    public fun advance_phase_skeleton(arg0: &0x9308ba5ea180f0192f85184e36507b0e3e0e17bd60f71df978221c09f21ecf35::admin::AdminCap, arg1: &mut PhaseGate, arg2: u64) {
        assert!(arg1.current_phase < 4, 1);
        arg1.current_phase = arg1.current_phase + 1;
        arg1.last_advanced_at_ms = arg2;
        arg1.advance_attempts = arg1.advance_attempts + 1;
    }

    public fun assert_min_phase(arg0: &PhaseGate, arg1: u8) {
        assert!(arg0.current_phase >= arg1, 2);
    }

    public fun current_phase(arg0: &PhaseGate) : u8 {
        arg0.current_phase
    }

    public fun deployed_at_ms(arg0: &PhaseGate) : u64 {
        arg0.deployed_at_ms
    }

    public fun init_phase_gate(arg0: &0x9308ba5ea180f0192f85184e36507b0e3e0e17bd60f71df978221c09f21ecf35::admin::AdminCap, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = PhaseGate{
            id                  : 0x2::object::new(arg2),
            current_phase       : 1,
            deployed_at_ms      : arg1,
            last_advanced_at_ms : arg1,
            advance_attempts    : 0,
        };
        0x2::transfer::share_object<PhaseGate>(v0);
    }

    public fun last_advanced_at_ms(arg0: &PhaseGate) : u64 {
        arg0.last_advanced_at_ms
    }

    public fun min_inter_phase_gap_days() : u64 {
        30
    }

    public fun min_risk_score() : u8 {
        80
    }

    public fun min_uptime_days() : u64 {
        90
    }

    public fun phase_2_tvl_threshold() : u64 {
        2000000000000
    }

    public fun phase_3_tvl_threshold() : u64 {
        10000000000000
    }

    public fun phase_4_tvl_threshold() : u64 {
        50000000000000
    }

    // decompiled from Move bytecode v7
}

