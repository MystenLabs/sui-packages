module 0x25dfb8b6cdb5746983eaa816c7fd14e0f0b0d7f423b633564447b980b59c910d::oracle {
    struct ObservationManager has copy, drop, store {
        observations: vector<Observation>,
        observation_index: u64,
        observation_cardinality: u64,
        observation_cardinality_next: u64,
    }

    struct Observation has copy, drop, store {
        timestamp: u64,
        tick_cumulative: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i64::I64,
        seconds_per_liquidity_cumulative: u256,
        initialized: bool,
    }

    public fun binary_search(arg0: &ObservationManager, arg1: u64) : (Observation, Observation) {
        abort 0
    }

    public fun default_observation() : Observation {
        abort 0
    }

    fun get_observation(arg0: &ObservationManager, arg1: u64) : Observation {
        abort 0
    }

    public fun get_surrounding_observations(arg0: &ObservationManager, arg1: u64, arg2: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg3: u128) : (Observation, Observation) {
        abort 0
    }

    public(friend) fun grow(arg0: &mut ObservationManager, arg1: u64) : (u64, u64) {
        abort 0
    }

    public fun initialize_manager(arg0: u64) : ObservationManager {
        abort 0
    }

    public fun observe_single(arg0: &ObservationManager, arg1: u64, arg2: u64, arg3: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg4: u128) : (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i64::I64, u256) {
        abort 0
    }

    public fun transform(arg0: &Observation, arg1: u64, arg2: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg3: u128) : Observation {
        abort 0
    }

    public(friend) fun update(arg0: &mut ObservationManager, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg2: u128, arg3: u64) {
        abort 0
    }

    // decompiled from Move bytecode v6
}

