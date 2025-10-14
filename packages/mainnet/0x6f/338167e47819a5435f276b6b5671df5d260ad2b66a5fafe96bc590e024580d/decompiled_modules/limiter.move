module 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::limiter {
    struct Limiter has drop, store {
        outflow_limit: u64,
        outflow_cycle_duration: u32,
        outflow_segment_duration: u32,
        outflow_segments: vector<Segment>,
    }

    struct NewLimiter has copy, drop, store {
        outflow_limit: u64,
        outflow_cycle_duration: u32,
        outflow_segment_duration: u32,
    }

    struct Limiters has drop {
        dummy_field: bool,
    }

    struct Segment has drop, store {
        index: u64,
        value: u64,
    }

    struct RateLimitUsage has copy, drop {
        limit: u64,
        usage: u64,
    }

    public(friend) fun add_outflow(arg0: &mut Limiter, arg1: u64, arg2: u64) {
        assert!(count_current_outflow(arg0, arg1) + arg2 <= arg0.outflow_limit, 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::error::outflow_reach_limit_error());
        let v0 = arg1 / (arg0.outflow_segment_duration as u64);
        let v1 = 0x1::vector::borrow_mut<Segment>(&mut arg0.outflow_segments, v0 % 0x1::vector::length<Segment>(&arg0.outflow_segments));
        if (v1.index != v0) {
            v1.index = v0;
            v1.value = 0;
        };
        v1.value = v1.value + arg2;
    }

    fun build_segments(arg0: u32, arg1: u32) : vector<Segment> {
        let v0 = 0x1::vector::empty<Segment>();
        let v1 = 0;
        while (v1 < arg0 / arg1) {
            let v2 = Segment{
                index : (v1 as u64),
                value : 0,
            };
            0x1::vector::push_back<Segment>(&mut v0, v2);
            v1 = v1 + 1;
        };
        v0
    }

    public fun count_current_outflow(arg0: &Limiter, arg1: u64) : u64 {
        let v0 = 0;
        let v1 = arg1 / (arg0.outflow_segment_duration as u64);
        let v2 = 0x1::vector::length<Segment>(&arg0.outflow_segments);
        let v3 = 0;
        while (v3 < v2) {
            let v4 = 0x1::vector::borrow<Segment>(&arg0.outflow_segments, v3);
            if (v2 > v1 || v4.index >= v1 - v2 + 1) {
                v0 = v0 + v4.value;
            };
            v3 = v3 + 1;
        };
        v0
    }

    public(friend) fun create_new_limiter_change(arg0: u64, arg1: u32, arg2: u32) : NewLimiter {
        NewLimiter{
            outflow_limit            : arg0,
            outflow_cycle_duration   : arg1,
            outflow_segment_duration : arg2,
        }
    }

    public fun current_usage(arg0: &Limiter, arg1: u64) : RateLimitUsage {
        RateLimitUsage{
            limit : arg0.outflow_limit,
            usage : count_current_outflow(arg0, arg1),
        }
    }

    public(friend) fun new_from_struct(arg0: NewLimiter) : Limiter {
        Limiter{
            outflow_limit            : arg0.outflow_limit,
            outflow_cycle_duration   : arg0.outflow_cycle_duration,
            outflow_segment_duration : arg0.outflow_segment_duration,
            outflow_segments         : build_segments(arg0.outflow_cycle_duration, arg0.outflow_segment_duration),
        }
    }

    public(friend) fun reduce_outflow(arg0: &mut Limiter, arg1: u64, arg2: u64) {
        let v0 = arg1 / (arg0.outflow_segment_duration as u64);
        let v1 = 0x1::vector::borrow_mut<Segment>(&mut arg0.outflow_segments, v0 % 0x1::vector::length<Segment>(&arg0.outflow_segments));
        if (v1.index != v0) {
            v1.index = v0;
            v1.value = 0;
        };
        if (v1.value <= arg2) {
            v1.value = 0;
        } else {
            v1.value = v1.value - arg2;
        };
    }

    public(friend) fun update_outflow_limit_params(arg0: &mut Limiter, arg1: u64) {
        arg0.outflow_limit = arg1;
    }

    public(friend) fun update_outflow_segment_params(arg0: &mut Limiter, arg1: u32, arg2: u32) {
        arg0.outflow_segment_duration = arg2;
        arg0.outflow_cycle_duration = arg1;
        arg0.outflow_segments = build_segments(arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

