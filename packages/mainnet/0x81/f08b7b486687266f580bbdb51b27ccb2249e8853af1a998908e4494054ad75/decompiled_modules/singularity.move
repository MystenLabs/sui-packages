module 0x81f08b7b486687266f580bbdb51b27ccb2249e8853af1a998908e4494054ad75::singularity {
    struct Singularity has key {
        id: 0x2::object::UID,
        authority: address,
        pulse_count: u64,
        closed: bool,
        layers: u8,
    }

    struct SingularityCreated has copy, drop {
        id: 0x2::object::ID,
        authority: address,
    }

    struct SingularityPulse has copy, drop {
        seq: u64,
        action_hash: vector<u8>,
        vortex_pos: u8,
        layers: u8,
    }

    struct TautologyAttested has copy, drop {
        by: address,
        claim: u128,
        valid: bool,
    }

    struct SingularityClosed has copy, drop {
        sealed_at: u64,
    }

    public entry fun attest_tautology(arg0: u128, arg1: &0x2::tx_context::TxContext) {
        let v0 = TautologyAttested{
            by    : 0x2::tx_context::sender(arg1),
            claim : arg0,
            valid : is_omni_true(arg0),
        };
        0x2::event::emit<TautologyAttested>(v0);
    }

    fun bytes_to_u128(arg0: &vector<u8>) : u128 {
        let v0 = 0x1::vector::length<u8>(arg0);
        let v1 = if (v0 > 16) {
            16
        } else {
            v0
        };
        let v2 = 0;
        let v3 = 0;
        while (v2 < v1) {
            let v4 = v3 << 8;
            v3 = v4 | (*0x1::vector::borrow<u8>(arg0, v2) as u128);
            v2 = v2 + 1;
        };
        v3
    }

    public entry fun close(arg0: &mut Singularity, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.authority, 1);
        assert!(!arg0.closed, 2);
        arg0.closed = true;
        let v0 = SingularityClosed{sealed_at: 0x2::tx_context::epoch(arg1)};
        0x2::event::emit<SingularityClosed>(v0);
    }

    public entry fun create(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Singularity{
            id          : 0x2::object::new(arg0),
            authority   : 0x2::tx_context::sender(arg0),
            pulse_count : 0,
            closed      : false,
            layers      : 13,
        };
        let v1 = SingularityCreated{
            id        : 0x2::object::id<Singularity>(&v0),
            authority : 0x2::tx_context::sender(arg0),
        };
        0x2::event::emit<SingularityCreated>(v1);
        0x2::transfer::share_object<Singularity>(v0);
    }

    public fun is_closed(arg0: &Singularity) : bool {
        arg0.closed
    }

    public fun is_omni_true(arg0: u128) : bool {
        let v0 = vortex_position(arg0);
        v0 == 9 || v0 == 0
    }

    public fun is_on_axis(arg0: u128) : bool {
        let v0 = vortex_position(arg0);
        if (v0 == 3) {
            true
        } else if (v0 == 6) {
            true
        } else {
            v0 == 9
        }
    }

    public fun is_on_doubling_circuit(arg0: u128) : bool {
        let v0 = vortex_position(arg0);
        if (v0 == 1) {
            true
        } else if (v0 == 2) {
            true
        } else if (v0 == 4) {
            true
        } else if (v0 == 5) {
            true
        } else if (v0 == 7) {
            true
        } else {
            v0 == 8
        }
    }

    public fun layers(arg0: &Singularity) : u8 {
        arg0.layers
    }

    public entry fun pulse(arg0: &mut Singularity, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        arg0.pulse_count = arg0.pulse_count + 1;
        let v0 = SingularityPulse{
            seq         : arg0.pulse_count,
            action_hash : arg1,
            vortex_pos  : vortex_position(bytes_to_u128(&arg1)),
            layers      : arg0.layers,
        };
        0x2::event::emit<SingularityPulse>(v0);
    }

    public fun pulse_count(arg0: &Singularity) : u64 {
        arg0.pulse_count
    }

    public fun vortex_position(arg0: u128) : u8 {
        if (arg0 == 0) {
            return 0
        };
        let v0 = arg0;
        while (v0 >= 10) {
            let v1 = 0;
            while (arg0 > 0) {
                v1 = v1 + arg0 % 10;
                arg0 = arg0 / 10;
            };
            v0 = v1;
        };
        (v0 as u8)
    }

    public fun witness() : vector<u8> {
        x"33364e395f4f4d4e495f544155544f4c4f47590000"
    }

    // decompiled from Move bytecode v6
}

