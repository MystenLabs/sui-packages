module 0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::duration {
    struct DurationManager has store {
        start_time: u64,
        activity_duration: u64,
        settle_duration: u64,
        locked_duration: u64,
    }

    public(friend) fun get_locked_duration(arg0: &DurationManager) : u64 {
        arg0.locked_duration
    }

    public(friend) fun is_init_period(arg0: &DurationManager, arg1: u64) : bool {
        arg1 < arg0.start_time
    }

    public(friend) fun is_purchase_period(arg0: &DurationManager, arg1: u64) : bool {
        arg1 >= arg0.start_time && arg1 <= arg0.start_time + arg0.activity_duration
    }

    public(friend) fun is_settle_period(arg0: &DurationManager, arg1: u64) : bool {
        let v0 = arg0.start_time + arg0.activity_duration;
        arg1 > v0 && arg1 <= v0 + arg0.settle_duration
    }

    public(friend) fun new(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : DurationManager {
        assert!(arg1 > 0 && arg2 > 0, 3);
        DurationManager{
            start_time        : arg0,
            activity_duration : arg1,
            settle_duration   : arg2,
            locked_duration   : arg3,
        }
    }

    public(friend) fun update_pool_duration(arg0: &0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::config::AdminCap, arg1: &mut DurationManager, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock) {
        assert!(is_init_period(arg1, 0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::utils::current_time(arg6)), 1);
        if (arg2 > 0) {
            assert!(0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::utils::current_time(arg6) < arg2, 2);
            arg1.start_time = arg2;
        };
        if (arg3 > 0) {
            arg1.activity_duration = arg3;
        };
        if (arg4 > 0) {
            arg1.settle_duration = arg4;
        };
        if (arg5 > 0) {
            arg1.locked_duration = arg5;
        };
    }

    // decompiled from Move bytecode v6
}

