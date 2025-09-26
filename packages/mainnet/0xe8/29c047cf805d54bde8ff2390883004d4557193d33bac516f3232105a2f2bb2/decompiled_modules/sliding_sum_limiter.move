module 0xe829c047cf805d54bde8ff2390883004d4557193d33bac516f3232105a2f2bb2::sliding_sum_limiter {
    struct SlidingSumLimiter has copy, drop, store {
        ring_aggregator: 0xe829c047cf805d54bde8ff2390883004d4557193d33bac516f3232105a2f2bb2::ring_aggregator::RingAggregator,
        max_sum_limit: 0x1::option::Option<u256>,
    }

    public fun ring_aggregator(arg0: &SlidingSumLimiter) : &0xe829c047cf805d54bde8ff2390883004d4557193d33bac516f3232105a2f2bb2::ring_aggregator::RingAggregator {
        &arg0.ring_aggregator
    }

    public fun total_sum(arg0: &SlidingSumLimiter) : u256 {
        0xe829c047cf805d54bde8ff2390883004d4557193d33bac516f3232105a2f2bb2::ring_aggregator::total_sum(&arg0.ring_aggregator)
    }

    public fun consume(arg0: &mut SlidingSumLimiter, arg1: u64, arg2: &0x2::clock::Clock) {
        0xe829c047cf805d54bde8ff2390883004d4557193d33bac516f3232105a2f2bb2::ring_aggregator::advance_and_add(&mut arg0.ring_aggregator, (0x2::clock::timestamp_ms(arg2) as u256), arg1);
        let v0 = &arg0.max_sum_limit;
        if (0x1::option::is_some<u256>(v0)) {
            assert!(0xe829c047cf805d54bde8ff2390883004d4557193d33bac516f3232105a2f2bb2::ring_aggregator::total_sum(&arg0.ring_aggregator) <= *0x1::option::borrow<u256>(v0), 13835058398879547393);
        };
    }

    public fun max_sum_limit(arg0: &SlidingSumLimiter) : 0x1::option::Option<u256> {
        arg0.max_sum_limit
    }

    public fun new(arg0: u64, arg1: u64, arg2: 0x1::option::Option<u256>, arg3: &0x2::clock::Clock) : SlidingSumLimiter {
        SlidingSumLimiter{
            ring_aggregator : 0xe829c047cf805d54bde8ff2390883004d4557193d33bac516f3232105a2f2bb2::ring_aggregator::new_with_initial_position(arg0, arg1, (0x2::clock::timestamp_ms(arg3) as u256)),
            max_sum_limit   : arg2,
        }
    }

    public fun set_max_sum_limit(arg0: &mut SlidingSumLimiter, arg1: 0x1::option::Option<u256>) {
        arg0.max_sum_limit = arg1;
    }

    // decompiled from Move bytecode v6
}

