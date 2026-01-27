module 0x295f8f3e1399fd0ce0092d04503c2ce96a8ff1ac07c9d3f43e89e35ebdf0448b::phaser {
    struct LandingPhaseEvent has copy, drop {
        server_timestamp: u64,
        consensus_timestamp: u64,
        delta_ms: u64,
        last_consensus_timestamp: u64,
        delta_from_last_consensus: u64,
    }

    public entry fun measure_landing(arg0: &0x2::clock::Clock, arg1: u64, arg2: u64) {
        let v0 = 0x2::clock::timestamp_ms(arg0);
        let v1 = if (v0 >= arg1) {
            v0 - arg1
        } else {
            0
        };
        let v2 = if (v0 >= arg2) {
            v0 - arg2
        } else {
            0
        };
        let v3 = LandingPhaseEvent{
            server_timestamp          : arg1,
            consensus_timestamp       : v0,
            delta_ms                  : v1,
            last_consensus_timestamp  : arg2,
            delta_from_last_consensus : v2,
        };
        0x2::event::emit<LandingPhaseEvent>(v3);
    }

    // decompiled from Move bytecode v6
}

