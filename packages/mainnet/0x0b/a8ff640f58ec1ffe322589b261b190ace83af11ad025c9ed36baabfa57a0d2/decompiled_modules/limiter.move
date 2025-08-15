module 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::limiter {
    struct Limiter has drop, store {
        outflow_limit: u64,
        outflow_cycle_duration: u32,
        outflow_segment_duration: u32,
        outflow_segments: vector<Segment>,
    }

    struct NewLimiter has drop {
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

    public(friend) fun add_limiter<T0>(arg0: &mut 0xfa6003d96385f88f62cb5e6d8e7c0786464add393ec44a5023b14f7a6fd37e7a::wit_table::WitTable<Limiters, 0x1::type_name::TypeName, Limiter>, arg1: u64, arg2: u32, arg3: u32) {
        let v0 = Limiters{dummy_field: false};
        0xfa6003d96385f88f62cb5e6d8e7c0786464add393ec44a5023b14f7a6fd37e7a::wit_table::add<Limiters, 0x1::type_name::TypeName, Limiter>(v0, arg0, 0x1::type_name::get<T0>(), new(arg1, arg2, arg3));
    }

    public(friend) fun add_limiter_from_struct<T0>(arg0: &mut 0xfa6003d96385f88f62cb5e6d8e7c0786464add393ec44a5023b14f7a6fd37e7a::wit_table::WitTable<Limiters, 0x1::type_name::TypeName, Limiter>, arg1: NewLimiter) {
        let v0 = Limiters{dummy_field: false};
        0xfa6003d96385f88f62cb5e6d8e7c0786464add393ec44a5023b14f7a6fd37e7a::wit_table::add<Limiters, 0x1::type_name::TypeName, Limiter>(v0, arg0, 0x1::type_name::get<T0>(), new(arg1.outflow_limit, arg1.outflow_cycle_duration, arg1.outflow_segment_duration));
    }

    public(friend) fun add_outflow(arg0: &mut 0xfa6003d96385f88f62cb5e6d8e7c0786464add393ec44a5023b14f7a6fd37e7a::wit_table::WitTable<Limiters, 0x1::type_name::TypeName, Limiter>, arg1: 0x1::type_name::TypeName, arg2: u64, arg3: u64) {
        let v0 = Limiters{dummy_field: false};
        let v1 = 0xfa6003d96385f88f62cb5e6d8e7c0786464add393ec44a5023b14f7a6fd37e7a::wit_table::borrow_mut<Limiters, 0x1::type_name::TypeName, Limiter>(v0, arg0, arg1);
        assert!(count_current_outflow(arg0, arg1, arg2) + arg3 <= v1.outflow_limit, 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::error::outflow_reach_limit_error());
        let v2 = arg2 / (v1.outflow_segment_duration as u64);
        let v3 = 0x1::vector::borrow_mut<Segment>(&mut v1.outflow_segments, v2 % 0x1::vector::length<Segment>(&v1.outflow_segments));
        if (v3.index != v2) {
            v3.index = v2;
            v3.value = 0;
        };
        v3.value = v3.value + arg3;
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

    public fun count_current_outflow(arg0: &0xfa6003d96385f88f62cb5e6d8e7c0786464add393ec44a5023b14f7a6fd37e7a::wit_table::WitTable<Limiters, 0x1::type_name::TypeName, Limiter>, arg1: 0x1::type_name::TypeName, arg2: u64) : u64 {
        let v0 = 0xfa6003d96385f88f62cb5e6d8e7c0786464add393ec44a5023b14f7a6fd37e7a::wit_table::borrow<Limiters, 0x1::type_name::TypeName, Limiter>(arg0, arg1);
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

    public(friend) fun create_new_limiter_change(arg0: u64, arg1: u32, arg2: u32) : NewLimiter {
        NewLimiter{
            outflow_limit            : arg0,
            outflow_cycle_duration   : arg1,
            outflow_segment_duration : arg2,
        }
    }

    public(friend) fun init_table(arg0: &mut 0x2::tx_context::TxContext) : 0xfa6003d96385f88f62cb5e6d8e7c0786464add393ec44a5023b14f7a6fd37e7a::wit_table::WitTable<Limiters, 0x1::type_name::TypeName, Limiter> {
        let v0 = Limiters{dummy_field: false};
        0xfa6003d96385f88f62cb5e6d8e7c0786464add393ec44a5023b14f7a6fd37e7a::wit_table::new<Limiters, 0x1::type_name::TypeName, Limiter>(v0, false, arg0)
    }

    fun new(arg0: u64, arg1: u32, arg2: u32) : Limiter {
        Limiter{
            outflow_limit            : arg0,
            outflow_cycle_duration   : arg1,
            outflow_segment_duration : arg2,
            outflow_segments         : build_segments(arg1, arg2),
        }
    }

    public(friend) fun reduce_outflow(arg0: &mut 0xfa6003d96385f88f62cb5e6d8e7c0786464add393ec44a5023b14f7a6fd37e7a::wit_table::WitTable<Limiters, 0x1::type_name::TypeName, Limiter>, arg1: 0x1::type_name::TypeName, arg2: u64, arg3: u64) {
        let v0 = Limiters{dummy_field: false};
        let v1 = 0xfa6003d96385f88f62cb5e6d8e7c0786464add393ec44a5023b14f7a6fd37e7a::wit_table::borrow_mut<Limiters, 0x1::type_name::TypeName, Limiter>(v0, arg0, arg1);
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

    public(friend) fun update_outflow_limit_params(arg0: &mut 0xfa6003d96385f88f62cb5e6d8e7c0786464add393ec44a5023b14f7a6fd37e7a::wit_table::WitTable<Limiters, 0x1::type_name::TypeName, Limiter>, arg1: 0x1::type_name::TypeName, arg2: u64) {
        let v0 = Limiters{dummy_field: false};
        0xfa6003d96385f88f62cb5e6d8e7c0786464add393ec44a5023b14f7a6fd37e7a::wit_table::borrow_mut<Limiters, 0x1::type_name::TypeName, Limiter>(v0, arg0, arg1).outflow_limit = arg2;
    }

    public(friend) fun update_outflow_segment_params(arg0: &mut 0xfa6003d96385f88f62cb5e6d8e7c0786464add393ec44a5023b14f7a6fd37e7a::wit_table::WitTable<Limiters, 0x1::type_name::TypeName, Limiter>, arg1: 0x1::type_name::TypeName, arg2: u32, arg3: u32) {
        let v0 = Limiters{dummy_field: false};
        let v1 = 0xfa6003d96385f88f62cb5e6d8e7c0786464add393ec44a5023b14f7a6fd37e7a::wit_table::borrow_mut<Limiters, 0x1::type_name::TypeName, Limiter>(v0, arg0, arg1);
        v1.outflow_segment_duration = arg3;
        v1.outflow_cycle_duration = arg2;
        v1.outflow_segments = build_segments(arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

