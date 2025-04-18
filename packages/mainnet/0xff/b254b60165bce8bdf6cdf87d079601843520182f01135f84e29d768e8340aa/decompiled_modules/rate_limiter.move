module 0xffb254b60165bce8bdf6cdf87d079601843520182f01135f84e29d768e8340aa::rate_limiter {
    struct RateLimiter has drop, store {
        config: RateLimiterConfig,
        prev_qty: 0xffb254b60165bce8bdf6cdf87d079601843520182f01135f84e29d768e8340aa::decimal::Decimal,
        window_start: u64,
        cur_qty: 0xffb254b60165bce8bdf6cdf87d079601843520182f01135f84e29d768e8340aa::decimal::Decimal,
    }

    struct RateLimiterConfig has drop, store {
        window_duration: u64,
        max_outflow: u64,
    }

    fun current_outflow(arg0: &RateLimiter, arg1: u64) : 0xffb254b60165bce8bdf6cdf87d079601843520182f01135f84e29d768e8340aa::decimal::Decimal {
        0xffb254b60165bce8bdf6cdf87d079601843520182f01135f84e29d768e8340aa::decimal::add(0xffb254b60165bce8bdf6cdf87d079601843520182f01135f84e29d768e8340aa::decimal::mul(arg0.prev_qty, 0xffb254b60165bce8bdf6cdf87d079601843520182f01135f84e29d768e8340aa::decimal::div(0xffb254b60165bce8bdf6cdf87d079601843520182f01135f84e29d768e8340aa::decimal::sub(0xffb254b60165bce8bdf6cdf87d079601843520182f01135f84e29d768e8340aa::decimal::from(arg0.config.window_duration), 0xffb254b60165bce8bdf6cdf87d079601843520182f01135f84e29d768e8340aa::decimal::from(arg1 - arg0.window_start + 1)), 0xffb254b60165bce8bdf6cdf87d079601843520182f01135f84e29d768e8340aa::decimal::from(arg0.config.window_duration))), arg0.cur_qty)
    }

    public fun new(arg0: RateLimiterConfig, arg1: u64) : RateLimiter {
        RateLimiter{
            config       : arg0,
            prev_qty     : 0xffb254b60165bce8bdf6cdf87d079601843520182f01135f84e29d768e8340aa::decimal::from(0),
            window_start : arg1,
            cur_qty      : 0xffb254b60165bce8bdf6cdf87d079601843520182f01135f84e29d768e8340aa::decimal::from(0),
        }
    }

    public fun new_config(arg0: u64, arg1: u64) : RateLimiterConfig {
        assert!(arg0 > 0, 0);
        RateLimiterConfig{
            window_duration : arg0,
            max_outflow     : arg1,
        }
    }

    public fun process_qty(arg0: &mut RateLimiter, arg1: u64, arg2: 0xffb254b60165bce8bdf6cdf87d079601843520182f01135f84e29d768e8340aa::decimal::Decimal) {
        update_internal(arg0, arg1);
        arg0.cur_qty = 0xffb254b60165bce8bdf6cdf87d079601843520182f01135f84e29d768e8340aa::decimal::add(arg0.cur_qty, arg2);
        assert!(0xffb254b60165bce8bdf6cdf87d079601843520182f01135f84e29d768e8340aa::decimal::le(current_outflow(arg0, arg1), 0xffb254b60165bce8bdf6cdf87d079601843520182f01135f84e29d768e8340aa::decimal::from(arg0.config.max_outflow)), 2);
    }

    fun update_internal(arg0: &mut RateLimiter, arg1: u64) {
        assert!(arg1 >= arg0.window_start, 1);
        if (arg1 < arg0.window_start + arg0.config.window_duration) {
            return
        };
        if (arg1 < arg0.window_start + 2 * arg0.config.window_duration) {
            arg0.prev_qty = arg0.cur_qty;
            arg0.window_start = arg0.window_start + arg0.config.window_duration;
            arg0.cur_qty = 0xffb254b60165bce8bdf6cdf87d079601843520182f01135f84e29d768e8340aa::decimal::from(0);
        } else {
            arg0.prev_qty = 0xffb254b60165bce8bdf6cdf87d079601843520182f01135f84e29d768e8340aa::decimal::from(0);
            arg0.window_start = arg1;
            arg0.cur_qty = 0xffb254b60165bce8bdf6cdf87d079601843520182f01135f84e29d768e8340aa::decimal::from(0);
        };
    }

    // decompiled from Move bytecode v6
}

