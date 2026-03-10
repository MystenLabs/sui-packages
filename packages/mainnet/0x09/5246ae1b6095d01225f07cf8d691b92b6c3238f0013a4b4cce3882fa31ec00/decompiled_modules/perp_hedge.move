module 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::perp_hedge {
    public fun adjust_position(arg0: &0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::config::Config, arg1: address, arg2: u64) : (address, u64, bool) {
        if (!is_available(arg0) || arg2 == 0) {
            (@0x0, 0, arg1 != @0x0)
        } else {
            let v3 = if (arg1 == @0x0) {
                0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::config::perps_market_id(arg0)
            } else {
                arg1
            };
            (v3, required_margin(arg2), true)
        }
    }

    public fun close_short(arg0: &0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::config::Config, arg1: address, arg2: u64) : (address, u64) {
        let v0 = if (arg1 == @0x0) {
            @0x0
        } else {
            @0x0
        };
        (v0, arg2)
    }

    public fun get_hedge_value(arg0: &0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::config::Config, arg1: u64) : u64 {
        arg1
    }

    public fun initial_margin_bps() : u64 {
        500
    }

    public fun is_available(arg0: &0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::config::Config) : bool {
        0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::config::perps_market_id(arg0) != @0x0
    }

    public fun open_short(arg0: &0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::config::Config, arg1: u64) : (address, u64) {
        if (!is_available(arg0) || arg1 == 0) {
            (@0x0, 0)
        } else {
            (0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::config::perps_market_id(arg0), required_margin(arg1))
        }
    }

    public fun required_margin(arg0: u64) : u64 {
        0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::math::mul_div(arg0, 500, 10000)
    }

    // decompiled from Move bytecode v6
}

