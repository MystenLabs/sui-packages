module 0x62911c4cbd0b229cbc6dc6c0c1408563b1fc8896b1e774c71611aaa1e97dc28a::time_lock {
    struct TimeLock<T0> has store {
        inner: T0,
        expiration_time: u64,
        active_after: u64,
    }

    public(friend) fun active_after<T0>(arg0: &TimeLock<T0>) : u64 {
        arg0.active_after
    }

    fun clock_now(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) / 1000
    }

    public(friend) fun expiration_time<T0>(arg0: &TimeLock<T0>) : u64 {
        arg0.expiration_time
    }

    public(friend) fun inner<T0>(arg0: &TimeLock<T0>) : &T0 {
        &arg0.inner
    }

    public(friend) fun into_inner<T0>(arg0: TimeLock<T0>) : T0 {
        let TimeLock {
            inner           : v0,
            expiration_time : _,
            active_after    : _,
        } = arg0;
        v0
    }

    public(friend) fun is_active<T0>(arg0: &TimeLock<T0>, arg1: &0x2::clock::Clock) : bool {
        let v0 = clock_now(arg1);
        arg0.active_after < v0 && v0 < arg0.expiration_time
    }

    public(friend) fun new_time_locked<T0>(arg0: T0, arg1: &0x2::clock::Clock, arg2: u64, arg3: u64) : TimeLock<T0> {
        let v0 = clock_now(arg1) + arg2;
        TimeLock<T0>{
            inner           : arg0,
            expiration_time : v0 + arg3,
            active_after    : v0,
        }
    }

    // decompiled from Move bytecode v6
}

