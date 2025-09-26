module 0xe829c047cf805d54bde8ff2390883004d4557193d33bac516f3232105a2f2bb2::net_sliding_sum_limiter {
    struct NetSlidingSumLimiter has copy, drop, store {
        inflow_limiter: 0xe829c047cf805d54bde8ff2390883004d4557193d33bac516f3232105a2f2bb2::sliding_sum_limiter::SlidingSumLimiter,
        outflow_limiter: 0xe829c047cf805d54bde8ff2390883004d4557193d33bac516f3232105a2f2bb2::sliding_sum_limiter::SlidingSumLimiter,
        max_net_inflow_limit: 0x1::option::Option<u256>,
        max_net_outflow_limit: 0x1::option::Option<u256>,
    }

    fun check_net_limits(arg0: &NetSlidingSumLimiter) {
        if (0x1::option::is_none<u256>(&arg0.max_net_inflow_limit) && 0x1::option::is_none<u256>(&arg0.max_net_outflow_limit)) {
            return
        };
        let (v0, v1) = net_value(arg0);
        if (v1) {
            let v2 = &arg0.max_net_outflow_limit;
            if (0x1::option::is_some<u256>(v2)) {
                assert!(v0 <= *0x1::option::borrow<u256>(v2), 13835058716707127297);
            };
        } else {
            let v3 = &arg0.max_net_inflow_limit;
            if (0x1::option::is_some<u256>(v3)) {
                assert!(v0 <= *0x1::option::borrow<u256>(v3), 13835058738181963777);
            };
        };
    }

    public fun consume_inflow(arg0: &mut NetSlidingSumLimiter, arg1: u64, arg2: &0x2::clock::Clock) {
        0xe829c047cf805d54bde8ff2390883004d4557193d33bac516f3232105a2f2bb2::sliding_sum_limiter::consume(&mut arg0.inflow_limiter, arg1, arg2);
        check_net_limits(arg0);
    }

    public fun consume_outflow(arg0: &mut NetSlidingSumLimiter, arg1: u64, arg2: &0x2::clock::Clock) {
        0xe829c047cf805d54bde8ff2390883004d4557193d33bac516f3232105a2f2bb2::sliding_sum_limiter::consume(&mut arg0.outflow_limiter, arg1, arg2);
        check_net_limits(arg0);
    }

    public fun inflow_limiter(arg0: &NetSlidingSumLimiter) : &0xe829c047cf805d54bde8ff2390883004d4557193d33bac516f3232105a2f2bb2::sliding_sum_limiter::SlidingSumLimiter {
        &arg0.inflow_limiter
    }

    public fun inflow_total(arg0: &NetSlidingSumLimiter) : u256 {
        0xe829c047cf805d54bde8ff2390883004d4557193d33bac516f3232105a2f2bb2::sliding_sum_limiter::total_sum(&arg0.inflow_limiter)
    }

    public fun max_net_inflow_limit(arg0: &NetSlidingSumLimiter) : 0x1::option::Option<u256> {
        arg0.max_net_inflow_limit
    }

    public fun max_net_outflow_limit(arg0: &NetSlidingSumLimiter) : 0x1::option::Option<u256> {
        arg0.max_net_outflow_limit
    }

    public fun net_value(arg0: &NetSlidingSumLimiter) : (u256, bool) {
        let v0 = 0xe829c047cf805d54bde8ff2390883004d4557193d33bac516f3232105a2f2bb2::sliding_sum_limiter::total_sum(&arg0.inflow_limiter);
        let v1 = 0xe829c047cf805d54bde8ff2390883004d4557193d33bac516f3232105a2f2bb2::sliding_sum_limiter::total_sum(&arg0.outflow_limiter);
        if (v0 >= v1) {
            (v0 - v1, false)
        } else {
            (v1 - v0, true)
        }
    }

    public fun new(arg0: u64, arg1: u64, arg2: 0x1::option::Option<u256>, arg3: 0x1::option::Option<u256>, arg4: 0x1::option::Option<u256>, arg5: 0x1::option::Option<u256>, arg6: &0x2::clock::Clock) : NetSlidingSumLimiter {
        NetSlidingSumLimiter{
            inflow_limiter        : 0xe829c047cf805d54bde8ff2390883004d4557193d33bac516f3232105a2f2bb2::sliding_sum_limiter::new(arg0, arg1, arg2, arg6),
            outflow_limiter       : 0xe829c047cf805d54bde8ff2390883004d4557193d33bac516f3232105a2f2bb2::sliding_sum_limiter::new(arg0, arg1, arg3, arg6),
            max_net_inflow_limit  : arg4,
            max_net_outflow_limit : arg5,
        }
    }

    public fun outflow_limiter(arg0: &NetSlidingSumLimiter) : &0xe829c047cf805d54bde8ff2390883004d4557193d33bac516f3232105a2f2bb2::sliding_sum_limiter::SlidingSumLimiter {
        &arg0.outflow_limiter
    }

    public fun outflow_total(arg0: &NetSlidingSumLimiter) : u256 {
        0xe829c047cf805d54bde8ff2390883004d4557193d33bac516f3232105a2f2bb2::sliding_sum_limiter::total_sum(&arg0.outflow_limiter)
    }

    public fun set_max_inflow_limit(arg0: &mut NetSlidingSumLimiter, arg1: 0x1::option::Option<u256>) {
        0xe829c047cf805d54bde8ff2390883004d4557193d33bac516f3232105a2f2bb2::sliding_sum_limiter::set_max_sum_limit(&mut arg0.inflow_limiter, arg1);
    }

    public fun set_max_net_inflow_limit(arg0: &mut NetSlidingSumLimiter, arg1: 0x1::option::Option<u256>) {
        arg0.max_net_inflow_limit = arg1;
    }

    public fun set_max_net_outflow_limit(arg0: &mut NetSlidingSumLimiter, arg1: 0x1::option::Option<u256>) {
        arg0.max_net_outflow_limit = arg1;
    }

    public fun set_max_outflow_limit(arg0: &mut NetSlidingSumLimiter, arg1: 0x1::option::Option<u256>) {
        0xe829c047cf805d54bde8ff2390883004d4557193d33bac516f3232105a2f2bb2::sliding_sum_limiter::set_max_sum_limit(&mut arg0.outflow_limiter, arg1);
    }

    // decompiled from Move bytecode v6
}

