module 0xde3c36d56dab5b3f030dd39e4210d5db14a4858858825a5cded1707cf8aaea3::size_cost {
    struct ParamsKey has copy, drop, store {
        pos0: 0x2::object::ID,
    }

    struct ParamsV1 has copy, drop, store {
        free_skew: u64,
        skew_scale: u64,
        max_ppm: u64,
    }

    struct PositionKey has copy, drop, store {
        pos0: u64,
    }

    struct PositionCostV1 has copy, drop, store {
        cost_ppm: u64,
    }

    public fun cost_ppm(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : u64 {
        let v0 = if (arg5 == 0) {
            true
        } else if (arg2 == 0) {
            true
        } else {
            arg4 == 0
        };
        if (v0) {
            return 0
        };
        let v1 = (arg1 as u256) + (arg3 as u256);
        let v2 = (arg0 as u256);
        let v3 = v2 + (arg2 as u256);
        if (v3 <= v1) {
            return 0
        };
        let v4 = v3 - v1;
        let v5 = if (v2 > v1) {
            v2 - v1
        } else {
            0
        };
        let v6 = (v4 * v4 - v5 * v5) * 1000000 / 2 * (arg2 as u256) * (arg4 as u256);
        if (v6 >= (arg5 as u256)) {
            arg5
        } else {
            (v6 as u64)
        }
    }

    public fun on_open<T0>(arg0: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::access::Auth, arg1: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>, arg2: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::Config, arg3: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::Market<T0>, arg4: u64, arg5: bool, arg6: u64) {
        let v0 = 0x2::object::id<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::Market<T0>>(arg3);
        let (v1, v2, v3) = params(arg2, v0);
        let (v4, v5) = if (arg5) {
            (0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::long_oi<T0>(arg3), 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::short_oi<T0>(arg3))
        } else {
            (0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::short_oi<T0>(arg3), 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::long_oi<T0>(arg3))
        };
        let v6 = cost_ppm(v4, v5, arg6, v1, v2, v3);
        if (v6 == 0) {
            return
        };
        let v7 = PositionKey{pos0: arg4};
        let v8 = PositionCostV1{cost_ppm: v6};
        0x2::dynamic_field::add<PositionKey, PositionCostV1>(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::uid_mut<T0>(arg0, arg1), v7, v8);
        0xde3c36d56dab5b3f030dd39e4210d5db14a4858858825a5cded1707cf8aaea3::game_events::emit_set_size_cost_event(0x2::object::id<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>>(arg1), arg4, v0, arg5, arg6, v4, v5, v6);
    }

    public fun params(arg0: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::Config, arg1: 0x2::object::ID) : (u64, u64, u64) {
        let v0 = ParamsKey{pos0: arg1};
        if (!0x2::dynamic_field::exists<ParamsKey>(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::uid(arg0), v0)) {
            return (0, 0, 0)
        };
        let ParamsV1 {
            free_skew  : v1,
            skew_scale : v2,
            max_ppm    : v3,
        } = *0x2::dynamic_field::borrow<ParamsKey, ParamsV1>(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::uid(arg0), v0);
        (v1, v2, v3)
    }

    public(friend) fun release<T0>(arg0: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::access::Auth, arg1: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>, arg2: u64) {
        let v0 = PositionKey{pos0: arg2};
        if (!0x2::dynamic_field::exists<PositionKey>(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::uid<T0>(arg1), v0)) {
            return
        };
        0x2::dynamic_field::remove<PositionKey, PositionCostV1>(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::uid_mut<T0>(arg0, arg1), v0);
    }

    public fun set_params<T0>(arg0: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::access::Auth, arg1: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::Config, arg2: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::authority::AuthorityCap<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::authority::PACKAGE, 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::authority::ADMIN>, arg3: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::Market<T0>, arg4: u64, arg5: u64, arg6: u64) {
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::assert_version(arg1);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::authority::assert_admin(0x2::object::id<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::Config>(arg1), arg2);
        assert!(arg6 == 0 || arg6 <= 1000 && arg5 >= 1000000000000, 13835058463304056833);
        let v0 = 0x2::object::id<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::Config>(arg1);
        let v1 = 0x2::object::id<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::Market<T0>>(arg3);
        let v2 = ParamsV1{
            free_skew  : arg4,
            skew_scale : arg5,
            max_ppm    : arg6,
        };
        let v3 = 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::uid_mut(arg0, arg1);
        let v4 = ParamsKey{pos0: v1};
        if (0x2::dynamic_field::exists<ParamsKey>(v3, v4)) {
            *0x2::dynamic_field::borrow_mut<ParamsKey, ParamsV1>(v3, v4) = v2;
        } else {
            0x2::dynamic_field::add<ParamsKey, ParamsV1>(v3, v4, v2);
        };
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::events::emit_admin_action(arg0, v0, 114);
        0xde3c36d56dab5b3f030dd39e4210d5db14a4858858825a5cded1707cf8aaea3::game_events::emit_set_size_cost_params_event(v0, v1, arg4, arg5, arg6);
    }

    public(friend) fun take<T0>(arg0: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::access::Auth, arg1: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>, arg2: u64, arg3: u64) : u64 {
        let v0 = PositionKey{pos0: arg2};
        if (!0x2::dynamic_field::exists<PositionKey>(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::uid<T0>(arg1), v0)) {
            return 0
        };
        let v1 = 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::uid_mut<T0>(arg0, arg1);
        let PositionCostV1 { cost_ppm: v2 } = *0x2::dynamic_field::borrow<PositionKey, PositionCostV1>(v1, v0);
        if (arg3 == 0) {
            0x2::dynamic_field::remove<PositionKey, PositionCostV1>(v1, v0);
        };
        v2
    }

    // decompiled from Move bytecode v7
}

