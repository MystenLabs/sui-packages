module 0x464995c7f33bc1afa46b4161f053a54c299db0be9fa0f31549ddb4810966dbf0::rate_limiter {
    struct RateLimiter has copy, drop, store {
        config: RateLimiterConfig,
        prev_qty: 0x464995c7f33bc1afa46b4161f053a54c299db0be9fa0f31549ddb4810966dbf0::decimal::Decimal,
        window_start: u64,
        cur_qty: 0x464995c7f33bc1afa46b4161f053a54c299db0be9fa0f31549ddb4810966dbf0::decimal::Decimal,
    }

    struct RateLimiterConfig has copy, drop, store {
        window_duration: u64,
        max_outflow: u64,
    }

    fun current_outflow(arg0: &RateLimiter, arg1: u64) : 0x464995c7f33bc1afa46b4161f053a54c299db0be9fa0f31549ddb4810966dbf0::decimal::Decimal {
        0x464995c7f33bc1afa46b4161f053a54c299db0be9fa0f31549ddb4810966dbf0::decimal::add(0x464995c7f33bc1afa46b4161f053a54c299db0be9fa0f31549ddb4810966dbf0::decimal::mul(arg0.prev_qty, 0x464995c7f33bc1afa46b4161f053a54c299db0be9fa0f31549ddb4810966dbf0::decimal::div(0x464995c7f33bc1afa46b4161f053a54c299db0be9fa0f31549ddb4810966dbf0::decimal::sub(0x464995c7f33bc1afa46b4161f053a54c299db0be9fa0f31549ddb4810966dbf0::decimal::from(arg0.config.window_duration), 0x464995c7f33bc1afa46b4161f053a54c299db0be9fa0f31549ddb4810966dbf0::decimal::from(arg1 - arg0.window_start + 1)), 0x464995c7f33bc1afa46b4161f053a54c299db0be9fa0f31549ddb4810966dbf0::decimal::from(arg0.config.window_duration))), arg0.cur_qty)
    }

    public fun new(arg0: RateLimiterConfig, arg1: u64) : RateLimiter {
        RateLimiter{
            config       : arg0,
            prev_qty     : 0x464995c7f33bc1afa46b4161f053a54c299db0be9fa0f31549ddb4810966dbf0::decimal::from(0),
            window_start : arg1,
            cur_qty      : 0x464995c7f33bc1afa46b4161f053a54c299db0be9fa0f31549ddb4810966dbf0::decimal::from(0),
        }
    }

    public fun new_config(arg0: u64, arg1: u64) : RateLimiterConfig {
        assert!(arg0 > 0, 0);
        RateLimiterConfig{
            window_duration : arg0,
            max_outflow     : arg1,
        }
    }

    public fun process_qty(arg0: &mut RateLimiter, arg1: u64, arg2: 0x464995c7f33bc1afa46b4161f053a54c299db0be9fa0f31549ddb4810966dbf0::decimal::Decimal) {
        update_internal(arg0, arg1);
        arg0.cur_qty = 0x464995c7f33bc1afa46b4161f053a54c299db0be9fa0f31549ddb4810966dbf0::decimal::add(arg0.cur_qty, arg2);
        assert!(0x464995c7f33bc1afa46b4161f053a54c299db0be9fa0f31549ddb4810966dbf0::decimal::le(current_outflow(arg0, arg1), 0x464995c7f33bc1afa46b4161f053a54c299db0be9fa0f31549ddb4810966dbf0::decimal::from(arg0.config.max_outflow)), 2);
    }

    public fun remaining_outflow(arg0: &mut RateLimiter, arg1: u64) : 0x464995c7f33bc1afa46b4161f053a54c299db0be9fa0f31549ddb4810966dbf0::decimal::Decimal {
        update_internal(arg0, arg1);
        0x464995c7f33bc1afa46b4161f053a54c299db0be9fa0f31549ddb4810966dbf0::decimal::saturating_sub(0x464995c7f33bc1afa46b4161f053a54c299db0be9fa0f31549ddb4810966dbf0::decimal::from(arg0.config.max_outflow), current_outflow(arg0, arg1))
    }

    fun update_internal(arg0: &mut RateLimiter, arg1: u64) {
        assert!(arg1 >= arg0.window_start, 1);
        if (arg1 < arg0.window_start + arg0.config.window_duration) {
            return
        };
        if (arg1 < arg0.window_start + 2 * arg0.config.window_duration) {
            arg0.prev_qty = arg0.cur_qty;
            arg0.window_start = arg0.window_start + arg0.config.window_duration;
            arg0.cur_qty = 0x464995c7f33bc1afa46b4161f053a54c299db0be9fa0f31549ddb4810966dbf0::decimal::from(0);
        } else {
            arg0.prev_qty = 0x464995c7f33bc1afa46b4161f053a54c299db0be9fa0f31549ddb4810966dbf0::decimal::from(0);
            arg0.window_start = arg1;
            arg0.cur_qty = 0x464995c7f33bc1afa46b4161f053a54c299db0be9fa0f31549ddb4810966dbf0::decimal::from(0);
        };
    }

    // decompiled from Move bytecode v6
}

