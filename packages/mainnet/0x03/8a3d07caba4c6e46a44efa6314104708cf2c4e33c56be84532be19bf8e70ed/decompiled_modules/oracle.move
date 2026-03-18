module 0x1dd6cffcf41e79b261d82a598c45b2d59e0891ce27d3500733572c167a3633::oracle {
    struct RateSnapshot has copy, drop, store {
        protocol_id: u8,
        rate_num: u64,
        rate_den: u64,
        timestamp_ms: u64,
    }

    struct OracleState has key {
        id: 0x2::object::UID,
        current: vector<RateSnapshot>,
        previous: vector<RateSnapshot>,
        last_update_ms: u64,
    }

    struct OracleUpdateEvent has copy, drop {
        num_protocols: u64,
        timestamp_ms: u64,
    }

    public fun begin_update(arg0: &mut OracleState, arg1: &0x2::clock::Clock) {
        arg0.previous = arg0.current;
        arg0.current = 0x1::vector::empty<RateSnapshot>();
        arg0.last_update_ms = 0x2::clock::timestamp_ms(arg1);
    }

    public fun create_oracle(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OracleState{
            id             : 0x2::object::new(arg0),
            current        : 0x1::vector::empty<RateSnapshot>(),
            previous       : 0x1::vector::empty<RateSnapshot>(),
            last_update_ms : 0,
        };
        0x2::transfer::share_object<OracleState>(v0);
    }

    public fun finish_update(arg0: &OracleState, arg1: &0x2::clock::Clock) {
        let v0 = OracleUpdateEvent{
            num_protocols : 0x1::vector::length<RateSnapshot>(&arg0.current),
            timestamp_ms  : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<OracleUpdateEvent>(v0);
    }

    public fun get_last_update_ms(arg0: &OracleState) : u64 {
        arg0.last_update_ms
    }

    public fun get_prev_rate(arg0: &OracleState, arg1: u8) : (u64, u64, u64) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<RateSnapshot>(&arg0.previous)) {
            let v1 = 0x1::vector::borrow<RateSnapshot>(&arg0.previous, v0);
            if (v1.protocol_id == arg1) {
                return (v1.rate_num, v1.rate_den, v1.timestamp_ms)
            };
            v0 = v0 + 1;
        };
        (0, 1, 0)
    }

    public fun get_rate(arg0: &OracleState, arg1: u8) : (u64, u64, u64) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<RateSnapshot>(&arg0.current)) {
            let v1 = 0x1::vector::borrow<RateSnapshot>(&arg0.current, v0);
            if (v1.protocol_id == arg1) {
                return (v1.rate_num, v1.rate_den, v1.timestamp_ms)
            };
            v0 = v0 + 1;
        };
        (0, 1, 0)
    }

    public fun get_snapshot_count(arg0: &OracleState) : u64 {
        0x1::vector::length<RateSnapshot>(&arg0.current)
    }

    public fun push_snapshot(arg0: &mut OracleState, arg1: u8, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) {
        let v0 = RateSnapshot{
            protocol_id  : arg1,
            rate_num     : arg2,
            rate_den     : arg3,
            timestamp_ms : 0x2::clock::timestamp_ms(arg4),
        };
        0x1::vector::push_back<RateSnapshot>(&mut arg0.current, v0);
    }

    // decompiled from Move bytecode v6
}

