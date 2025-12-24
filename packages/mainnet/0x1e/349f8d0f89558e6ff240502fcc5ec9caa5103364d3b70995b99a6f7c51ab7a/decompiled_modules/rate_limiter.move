module 0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::rate_limiter {
    struct RateLimiter has store {
        available: u64,
        last_updated_ms: u64,
        capacity: u64,
        refill_rate_per_ms: u64,
        enabled: bool,
    }

    public fun capacity(arg0: &RateLimiter) : u64 {
        arg0.capacity
    }

    public(friend) fun check_and_record_withdrawal(arg0: &mut RateLimiter, arg1: u64, arg2: &0x2::clock::Clock) : bool {
        if (!arg0.enabled) {
            return true
        };
        refill(arg0, arg2);
        if (arg1 > arg0.available) {
            return false
        };
        arg0.available = arg0.available - arg1;
        true
    }

    public(friend) fun get_available_withdrawal(arg0: &RateLimiter, arg1: &0x2::clock::Clock) : u64 {
        if (!arg0.enabled) {
            return 18446744073709551615
        };
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = if (v0 > arg0.last_updated_ms) {
            v0 - arg0.last_updated_ms
        } else {
            0
        };
        (0x1::u128::min((arg0.available as u128) + (v1 as u128) * (arg0.refill_rate_per_ms as u128), (arg0.capacity as u128)) as u64)
    }

    public fun is_enabled(arg0: &RateLimiter) : bool {
        arg0.enabled
    }

    public(friend) fun new(arg0: u64, arg1: u64, arg2: bool, arg3: &0x2::clock::Clock) : RateLimiter {
        RateLimiter{
            available          : arg0,
            last_updated_ms    : 0x2::clock::timestamp_ms(arg3),
            capacity           : arg0,
            refill_rate_per_ms : arg1,
            enabled            : arg2,
        }
    }

    fun refill(arg0: &mut RateLimiter, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = if (v0 > arg0.last_updated_ms) {
            v0 - arg0.last_updated_ms
        } else {
            0
        };
        if (v1 > 0) {
            arg0.available = (0x1::u128::min((arg0.available as u128) + (v1 as u128) * (arg0.refill_rate_per_ms as u128), (arg0.capacity as u128)) as u64);
            arg0.last_updated_ms = v0;
        };
    }

    public fun refill_rate_per_ms(arg0: &RateLimiter) : u64 {
        arg0.refill_rate_per_ms
    }

    public(friend) fun update_config(arg0: &mut RateLimiter, arg1: u64, arg2: u64, arg3: bool, arg4: &0x2::clock::Clock) {
        refill(arg0, arg4);
        arg0.capacity = arg1;
        arg0.refill_rate_per_ms = arg2;
        arg0.enabled = arg3;
        if (arg0.available > arg1) {
            arg0.available = arg1;
        };
    }

    // decompiled from Move bytecode v6
}

