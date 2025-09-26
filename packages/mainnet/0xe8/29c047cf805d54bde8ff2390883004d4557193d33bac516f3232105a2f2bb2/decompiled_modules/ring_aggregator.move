module 0xe829c047cf805d54bde8ff2390883004d4557193d33bac516f3232105a2f2bb2::ring_aggregator {
    struct RingAggregator has copy, drop, store {
        buckets: vector<u128>,
        bucket_width: u64,
        current_position: u256,
        total_sum: u256,
    }

    public fun advance_and_add(arg0: &mut RingAggregator, arg1: u256, arg2: u64) {
        assert!(arg1 >= arg0.current_position, 13835058514843664385);
        let v0 = 0x1::vector::length<u128>(&arg0.buckets);
        let v1 = (arg0.bucket_width as u256);
        let v2 = arg1 / v1 - arg0.current_position / v1;
        if (v2 >= (v0 as u256)) {
            arg0.buckets = create_empty_buckets(0x1::vector::length<u128>(&arg0.buckets));
            arg0.total_sum = 0;
        } else if (v2 > 0) {
            let v3 = 0;
            while (v3 < (v2 as u64)) {
                let v4 = 0x1::vector::borrow_mut<u128>(&mut arg0.buckets, (get_current_bucket_index(arg0) + 1 + (v3 as u64)) % v0);
                arg0.total_sum = arg0.total_sum - (*v4 as u256);
                *v4 = 0;
                v3 = v3 + 1;
            };
        };
        let v5 = 0x1::vector::borrow_mut<u128>(&mut arg0.buckets, get_bucket_index(arg0, arg1));
        *v5 = *v5 + (arg2 as u128);
        arg0.total_sum = arg0.total_sum + (arg2 as u256);
        arg0.current_position = arg1;
    }

    public fun borrow_buckets(arg0: &RingAggregator) : &vector<u128> {
        &arg0.buckets
    }

    public fun bucket_count(arg0: &RingAggregator) : u64 {
        0x1::vector::length<u128>(&arg0.buckets)
    }

    public fun bucket_width(arg0: &RingAggregator) : u64 {
        arg0.bucket_width
    }

    fun create_empty_buckets(arg0: u64) : vector<u128> {
        let v0 = 0x1::vector::empty<u128>();
        let v1 = 0;
        while (v1 < arg0) {
            0x1::vector::push_back<u128>(&mut v0, 0);
            v1 = v1 + 1;
        };
        v0
    }

    public fun current_position(arg0: &RingAggregator) : u256 {
        arg0.current_position
    }

    fun get_bucket_index(arg0: &RingAggregator, arg1: u256) : u64 {
        let v0 = (arg0.bucket_width as u256);
        ((arg1 % (0x1::vector::length<u128>(&arg0.buckets) as u256) * v0 / v0) as u64)
    }

    fun get_current_bucket_index(arg0: &RingAggregator) : u64 {
        get_bucket_index(arg0, arg0.current_position)
    }

    public fun new(arg0: u64, arg1: u64) : RingAggregator {
        RingAggregator{
            buckets          : create_empty_buckets(arg1),
            bucket_width     : arg0,
            current_position : 0,
            total_sum        : 0,
        }
    }

    public fun new_with_initial_position(arg0: u64, arg1: u64, arg2: u256) : RingAggregator {
        RingAggregator{
            buckets          : create_empty_buckets(arg1),
            bucket_width     : arg0,
            current_position : arg2,
            total_sum        : 0,
        }
    }

    public fun total_sum(arg0: &RingAggregator) : u256 {
        arg0.total_sum
    }

    // decompiled from Move bytecode v6
}

