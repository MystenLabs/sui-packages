module 0x1f1f5a9b95278d1d5d121226db95c416a23c557a2ee5cd33256c80fb02ef1ae7::duration {
    struct DurationManager has store {
        start_time: u64,
        purchase_duration: u64,
        lock_up_duration: u64,
    }

    public fun assert_init_period(arg0: &DurationManager, arg1: &0x2::clock::Clock) {
        assert!(is_init_period(arg0, arg1), 1);
    }

    fun current_time(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) / 1000
    }

    public fun get_locked_duration(arg0: &DurationManager) : u64 {
        arg0.lock_up_duration
    }

    public fun is_claim_period(arg0: &DurationManager, arg1: &0x2::clock::Clock) : bool {
        current_time(arg1) > arg0.start_time + arg0.purchase_duration
    }

    public fun is_init_period(arg0: &DurationManager, arg1: &0x2::clock::Clock) : bool {
        current_time(arg1) < arg0.start_time
    }

    public fun is_purchase_period(arg0: &DurationManager, arg1: &0x2::clock::Clock) : bool {
        let v0 = current_time(arg1);
        v0 >= arg0.start_time && v0 <= arg0.start_time + arg0.purchase_duration
    }

    public fun new(arg0: u64, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock) : DurationManager {
        assert!(current_time(arg3) <= arg0, 2);
        assert!(arg1 > 0, 3);
        DurationManager{
            start_time        : arg0,
            purchase_duration : arg1,
            lock_up_duration  : arg2,
        }
    }

    public fun update(arg0: &0x1f1f5a9b95278d1d5d121226db95c416a23c557a2ee5cd33256c80fb02ef1ae7::config::AdminCap, arg1: &mut DurationManager, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock) {
        assert!(is_init_period(arg1, arg5), 1);
        if (arg2 > 0) {
            assert!(current_time(arg5) < arg2, 2);
            arg1.start_time = arg2;
        };
        if (arg3 > 0) {
            arg1.purchase_duration = arg3;
        };
        if (arg4 > 0) {
            arg1.lock_up_duration = arg4;
        };
    }

    // decompiled from Move bytecode v6
}

