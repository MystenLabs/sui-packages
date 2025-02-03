module 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::time_lock {
    struct TimeLockData<T0: store> has store {
        until_ms: u64,
        expiration_ms: u64,
        data: T0,
    }

    public fun destroy_expired<T0: store>(arg0: TimeLockData<T0>, arg1: &0x2::clock::Clock) : T0 {
        let TimeLockData {
            until_ms      : _,
            expiration_ms : v1,
            data          : v2,
        } = arg0;
        assert!(v1 < 0x2::clock::timestamp_ms(arg1), 1002);
        v2
    }

    public fun destroy_unlocked<T0: store>(arg0: TimeLockData<T0>, arg1: &0x2::clock::Clock) : T0 {
        let TimeLockData {
            until_ms      : v0,
            expiration_ms : v1,
            data          : v2,
        } = arg0;
        assert!(v0 <= 0x2::clock::timestamp_ms(arg1), 1000);
        assert!(v1 >= 0x2::clock::timestamp_ms(arg1), 1001);
        v2
    }

    public fun new<T0: store>(arg0: T0, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock) : TimeLockData<T0> {
        let v0 = 0x2::clock::timestamp_ms(arg3) + arg1;
        TimeLockData<T0>{
            until_ms      : v0,
            expiration_ms : v0 + arg2,
            data          : arg0,
        }
    }

    // decompiled from Move bytecode v6
}

