module 0x87ddec2984645dbbe2403a509cc6edf393a43acdba9b77d45da2bcbefcf733c1::limiter {
    struct Limiter has drop, store {
        outflow_limit: u64,
        outflow_cycle_duration: u32,
        outflow_segment_duration: u32,
        outflow_segments: vector<Segment>,
    }

    struct Limiters has drop {
        dummy_field: bool,
    }

    struct Segment has drop, store {
        index: u64,
        value: u64,
    }

    struct LimiterUpdateLimitChangeCreatedEvent has copy, drop {
        changes: LimiterUpdateLimitChange,
        current_epoch: u64,
        delay_epoches: u64,
        effective_epoches: u64,
    }

    struct LimiterUpdateParamsChangeCreatedEvent has copy, drop {
        changes: LimiterUpdateParamsChange,
        current_epoch: u64,
        delay_epoches: u64,
        effective_epoches: u64,
    }

    struct LimiterLimitChangeAppliedEvent has copy, drop {
        changes: LimiterUpdateLimitChange,
        current_epoch: u64,
    }

    struct LimiterParamsChangeAppliedEvent has copy, drop {
        changes: LimiterUpdateParamsChange,
        current_epoch: u64,
    }

    struct LimiterUpdateLimitChange has copy, drop, store {
        coin_type: 0x1::type_name::TypeName,
        outflow_limit: u64,
    }

    struct LimiterUpdateParamsChange has copy, drop, store {
        coin_type: 0x1::type_name::TypeName,
        outflow_cycle_duration: u32,
        outflow_segment_duration: u32,
    }

    fun new(arg0: u64, arg1: u32, arg2: u32) : Limiter {
        Limiter{
            outflow_limit            : arg0,
            outflow_cycle_duration   : arg1,
            outflow_segment_duration : arg2,
            outflow_segments         : build_segments(arg1, arg2),
        }
    }

    public(friend) fun add_limiter<T0>(arg0: &mut 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::WitTable<Limiters, 0x1::type_name::TypeName, Limiter>, arg1: u64, arg2: u32, arg3: u32) {
        let v0 = Limiters{dummy_field: false};
        0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::add<Limiters, 0x1::type_name::TypeName, Limiter>(v0, arg0, 0x1::type_name::get<T0>(), new(arg1, arg2, arg3));
    }

    public(friend) fun add_outflow(arg0: &mut 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::WitTable<Limiters, 0x1::type_name::TypeName, Limiter>, arg1: 0x1::type_name::TypeName, arg2: u64, arg3: u64) {
        let v0 = Limiters{dummy_field: false};
        let v1 = 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::borrow_mut<Limiters, 0x1::type_name::TypeName, Limiter>(v0, arg0, arg1);
        assert!(count_current_outflow(arg0, arg1, arg2) + arg3 <= v1.outflow_limit, 0x87ddec2984645dbbe2403a509cc6edf393a43acdba9b77d45da2bcbefcf733c1::error::outflow_reach_limit_error());
        let v2 = arg2 / (v1.outflow_segment_duration as u64);
        let v3 = 0x1::vector::borrow_mut<Segment>(&mut v1.outflow_segments, v2 % 0x1::vector::length<Segment>(&v1.outflow_segments));
        if (v3.index != v2) {
            v3.index = v2;
            v3.value = 0;
        };
        v3.value = v3.value + arg3;
    }

    public(friend) fun apply_limiter_limit_change(arg0: &mut 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::WitTable<Limiters, 0x1::type_name::TypeName, Limiter>, arg1: 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::one_time_lock_value::OneTimeLockValue<LimiterUpdateLimitChange>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::one_time_lock_value::get_value<LimiterUpdateLimitChange>(arg1, arg2);
        update_outflow_limit_params(arg0, v0.coin_type, v0.outflow_limit);
        let v1 = LimiterLimitChangeAppliedEvent{
            changes       : v0,
            current_epoch : 0x2::tx_context::epoch(arg2),
        };
        0x2::event::emit<LimiterLimitChangeAppliedEvent>(v1);
    }

    public(friend) fun apply_limiter_params_change(arg0: &mut 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::WitTable<Limiters, 0x1::type_name::TypeName, Limiter>, arg1: 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::one_time_lock_value::OneTimeLockValue<LimiterUpdateParamsChange>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::one_time_lock_value::get_value<LimiterUpdateParamsChange>(arg1, arg2);
        update_outflow_segment_params(arg0, v0.coin_type, v0.outflow_cycle_duration, v0.outflow_segment_duration);
        let v1 = LimiterParamsChangeAppliedEvent{
            changes       : v0,
            current_epoch : 0x2::tx_context::epoch(arg2),
        };
        0x2::event::emit<LimiterParamsChangeAppliedEvent>(v1);
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

    public fun count_current_outflow(arg0: &0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::WitTable<Limiters, 0x1::type_name::TypeName, Limiter>, arg1: 0x1::type_name::TypeName, arg2: u64) : u64 {
        let v0 = 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::borrow<Limiters, 0x1::type_name::TypeName, Limiter>(arg0, arg1);
        let v1 = 0;
        let v2 = arg2 / (v0.outflow_segment_duration as u64);
        let v3 = 0x1::vector::length<Segment>(&v0.outflow_segments);
        let v4 = 0;
        while (v4 < v3) {
            let v5 = 0x1::vector::borrow<Segment>(&v0.outflow_segments, v4);
            if (v3 > v2 || v5.index >= v2 - v3 + 1) {
                v1 = v1 + v5.value;
            };
            v4 = v4 + 1;
        };
        v1
    }

    public(friend) fun create_limiter_limit_change<T0>(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::one_time_lock_value::OneTimeLockValue<LimiterUpdateLimitChange> {
        let v0 = LimiterUpdateLimitChange{
            coin_type     : 0x1::type_name::get<T0>(),
            outflow_limit : arg0,
        };
        let v1 = LimiterUpdateLimitChangeCreatedEvent{
            changes           : v0,
            current_epoch     : 0x2::tx_context::epoch(arg2),
            delay_epoches     : arg1,
            effective_epoches : 0x2::tx_context::epoch(arg2) + arg1,
        };
        0x2::event::emit<LimiterUpdateLimitChangeCreatedEvent>(v1);
        0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::one_time_lock_value::new<LimiterUpdateLimitChange>(v0, arg1, 7, arg2)
    }

    public(friend) fun create_limiter_params_change<T0>(arg0: u32, arg1: u32, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::one_time_lock_value::OneTimeLockValue<LimiterUpdateParamsChange> {
        let v0 = LimiterUpdateParamsChange{
            coin_type                : 0x1::type_name::get<T0>(),
            outflow_cycle_duration   : arg0,
            outflow_segment_duration : arg1,
        };
        let v1 = LimiterUpdateParamsChangeCreatedEvent{
            changes           : v0,
            current_epoch     : 0x2::tx_context::epoch(arg3),
            delay_epoches     : arg2,
            effective_epoches : 0x2::tx_context::epoch(arg3) + arg2,
        };
        0x2::event::emit<LimiterUpdateParamsChangeCreatedEvent>(v1);
        0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::one_time_lock_value::new<LimiterUpdateParamsChange>(v0, arg2, 7, arg3)
    }

    public(friend) fun init_table(arg0: &mut 0x2::tx_context::TxContext) : 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::WitTable<Limiters, 0x1::type_name::TypeName, Limiter> {
        let v0 = Limiters{dummy_field: false};
        0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::new<Limiters, 0x1::type_name::TypeName, Limiter>(v0, false, arg0)
    }

    public(friend) fun reduce_outflow(arg0: &mut 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::WitTable<Limiters, 0x1::type_name::TypeName, Limiter>, arg1: 0x1::type_name::TypeName, arg2: u64, arg3: u64) {
        let v0 = Limiters{dummy_field: false};
        let v1 = 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::borrow_mut<Limiters, 0x1::type_name::TypeName, Limiter>(v0, arg0, arg1);
        let v2 = arg2 / (v1.outflow_segment_duration as u64);
        let v3 = 0x1::vector::borrow_mut<Segment>(&mut v1.outflow_segments, v2 % 0x1::vector::length<Segment>(&v1.outflow_segments));
        if (v3.index != v2) {
            v3.index = v2;
            v3.value = 0;
        };
        if (v3.value <= arg3) {
            v3.value = 0;
        } else {
            v3.value = v3.value - arg3;
        };
    }

    fun update_outflow_limit_params(arg0: &mut 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::WitTable<Limiters, 0x1::type_name::TypeName, Limiter>, arg1: 0x1::type_name::TypeName, arg2: u64) {
        let v0 = Limiters{dummy_field: false};
        0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::borrow_mut<Limiters, 0x1::type_name::TypeName, Limiter>(v0, arg0, arg1).outflow_limit = arg2;
    }

    fun update_outflow_segment_params(arg0: &mut 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::WitTable<Limiters, 0x1::type_name::TypeName, Limiter>, arg1: 0x1::type_name::TypeName, arg2: u32, arg3: u32) {
        let v0 = Limiters{dummy_field: false};
        let v1 = 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::borrow_mut<Limiters, 0x1::type_name::TypeName, Limiter>(v0, arg0, arg1);
        v1.outflow_segment_duration = arg3;
        v1.outflow_cycle_duration = arg2;
        v1.outflow_segments = build_segments(arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

