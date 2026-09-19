module 0xe40dc8b5d1de28844f8883bb7e025233cbdaa39a5303dc9f0e2576b12636a0de::bucket {
    public fun coefficients<T0>(arg0: &0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg1: u64) : (u256, u256, u256, u256) {
        let v0 = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::borrow_reservoir<T0>(arg0);
        state(0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::reservoir::conversion_rate<T0>(v0), 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::reservoir::discharge_fee_rate<T0>(v0), 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::reservoir::pool_balance<T0>(v0), arg1)
    }

    fun state(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : (u256, u256, u256, u256) {
        let v0 = (arg0 as u256);
        let v1 = (arg1 as u256);
        let v2 = if (v0 == 0) {
            true
        } else if (arg2 == 0) {
            true
        } else {
            v1 >= 1000000
        };
        if (v2) {
            return (0, 0, 1, 0)
        };
        let v3 = (arg2 as u256) * v0 / 1000000000;
        let v4 = (arg3 as u256);
        let v5 = if (v4 < v3) {
            v4
        } else {
            v3
        };
        (1000000000 * (1000000 - v1), 0, v0 * 1000000, v5)
    }

    // decompiled from Move bytecode v7
}

