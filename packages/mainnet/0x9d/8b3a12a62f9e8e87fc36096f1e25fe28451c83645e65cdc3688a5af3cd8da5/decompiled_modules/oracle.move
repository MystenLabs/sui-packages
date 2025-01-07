module 0x9d8b3a12a62f9e8e87fc36096f1e25fe28451c83645e65cdc3688a5af3cd8da5::oracle {
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
        let v0 = (arg0.observation_index + 1) % arg0.observation_cardinality;
        let v1 = v0 + arg0.observation_cardinality - 1;
        let v2;
        let v3;
        loop {
            let v4 = (v0 + v1) / 2;
            v2 = get_observation(arg0, v4 % arg0.observation_cardinality);
            if (!v2.initialized) {
                v0 = v4 + 1;
                continue
            };
            v3 = get_observation(arg0, (v4 + 1) % arg0.observation_cardinality);
            if (v2.timestamp <= arg1 && arg1 <= v3.timestamp) {
                break
            };
            if (v2.timestamp < arg1) {
                v0 = v4 + 1;
                continue
            };
            v1 = v4 - 1;
        };
        (v2, v3)
    }

    public fun default_observation() : Observation {
        Observation{
            timestamp                        : 0,
            tick_cumulative                  : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i64::zero(),
            seconds_per_liquidity_cumulative : 0,
            initialized                      : false,
        }
    }

    fun get_observation(arg0: &ObservationManager, arg1: u64) : Observation {
        if (arg1 > 0x1::vector::length<Observation>(&arg0.observations) - 1) {
            default_observation()
        } else {
            *0x1::vector::borrow<Observation>(&arg0.observations, arg1)
        }
    }

    public fun get_surrounding_observations(arg0: &ObservationManager, arg1: u64, arg2: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg3: u128) : (Observation, Observation) {
        let v0 = get_observation(arg0, arg0.observation_index);
        if (v0.timestamp <= arg1) {
            if (v0.timestamp == arg1) {
                return (v0, default_observation())
            };
            return (v0, transform(&v0, arg1, arg2, arg3))
        };
        v0 = get_observation(arg0, (arg0.observation_index + 1) % arg0.observation_cardinality);
        if (!v0.initialized) {
            v0 = *0x1::vector::borrow<Observation>(&arg0.observations, 0);
        };
        assert!(v0.timestamp <= arg1, 0x9d8b3a12a62f9e8e87fc36096f1e25fe28451c83645e65cdc3688a5af3cd8da5::errors::invalid_observation_timestamp());
        binary_search(arg0, arg1)
    }

    public(friend) fun grow(arg0: &mut ObservationManager, arg1: u64) : (u64, u64) {
        let v0 = arg0.observation_cardinality_next;
        while (v0 < arg1) {
            0x1::vector::push_back<Observation>(&mut arg0.observations, default_observation());
            v0 = v0 + 1;
        };
        arg0.observation_cardinality_next = 0x1::u64::min(v0, arg1);
        (v0, arg0.observation_cardinality_next)
    }

    public fun initialize_manager(arg0: u64) : ObservationManager {
        let v0 = ObservationManager{
            observations                 : 0x1::vector::empty<Observation>(),
            observation_index            : 0,
            observation_cardinality      : 1,
            observation_cardinality_next : 1,
        };
        let v1 = default_observation();
        v1.timestamp = arg0;
        v1.initialized = true;
        0x1::vector::push_back<Observation>(&mut v0.observations, v1);
        v0
    }

    public fun observe_single(arg0: &ObservationManager, arg1: u64, arg2: u64, arg3: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg4: u128) : (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i64::I64, u256) {
        if (arg2 == 0) {
            let v0 = get_observation(arg0, arg0.observation_index);
            if (v0.timestamp != arg1) {
                let v1 = &v0;
                v0 = transform(v1, arg1, arg3, arg4);
            };
            return (v0.tick_cumulative, v0.seconds_per_liquidity_cumulative)
        };
        let v2 = arg1 - arg2;
        let (v3, v4) = get_surrounding_observations(arg0, v2, arg3, arg4);
        let v5 = v4;
        let v6 = v3;
        if (v2 == v6.timestamp) {
            (v6.tick_cumulative, v6.seconds_per_liquidity_cumulative)
        } else if (v2 == v5.timestamp) {
            (v5.tick_cumulative, v5.seconds_per_liquidity_cumulative)
        } else {
            let v9 = v5.timestamp - v6.timestamp;
            let v10 = v2 - v6.timestamp;
            (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i64::add(v6.tick_cumulative, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i64::mul(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i64::div(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i64::sub(v5.tick_cumulative, v6.tick_cumulative), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i64::from(v9)), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i64::from(v10))), v6.seconds_per_liquidity_cumulative + (v5.seconds_per_liquidity_cumulative - v6.seconds_per_liquidity_cumulative) * (v10 as u256) / (v9 as u256))
        }
    }

    public fun transform(arg0: &Observation, arg1: u64, arg2: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg3: u128) : Observation {
        let v0 = if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::is_neg(arg2)) {
            0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i64::neg_from((0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::abs_u32(arg2) as u64))
        } else {
            0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i64::from((0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::abs_u32(arg2) as u64))
        };
        let v1 = arg1 - arg0.timestamp;
        let v2 = if (arg3 == 0) {
            1
        } else {
            arg3
        };
        Observation{
            timestamp                        : arg1,
            tick_cumulative                  : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i64::add(arg0.tick_cumulative, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i64::mul(v0, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i64::from(v1))),
            seconds_per_liquidity_cumulative : 0x9d8b3a12a62f9e8e87fc36096f1e25fe28451c83645e65cdc3688a5af3cd8da5::utils::overflow_add(arg0.seconds_per_liquidity_cumulative, ((v1 as u256) << 128) / (v2 as u256)),
            initialized                      : true,
        }
    }

    public(friend) fun update(arg0: &mut ObservationManager, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg2: u128, arg3: u64) {
        let v0 = 0x1::vector::borrow<Observation>(&arg0.observations, arg0.observation_index);
        if (v0.timestamp == arg3) {
            return
        };
        let v1 = if (arg0.observation_cardinality_next > arg0.observation_cardinality && arg0.observation_index == arg0.observation_cardinality - 1) {
            arg0.observation_cardinality_next
        } else {
            arg0.observation_cardinality
        };
        let v2 = (arg0.observation_index + 1) % v1;
        *0x1::vector::borrow_mut<Observation>(&mut arg0.observations, v2) = transform(v0, arg3, arg1, arg2);
        arg0.observation_index = v2;
        arg0.observation_cardinality = v1;
    }

    // decompiled from Move bytecode v6
}

