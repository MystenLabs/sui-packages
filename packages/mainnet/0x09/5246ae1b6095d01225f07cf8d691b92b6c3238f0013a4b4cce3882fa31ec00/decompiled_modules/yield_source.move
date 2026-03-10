module 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::yield_source {
    public fun accrue_yield(arg0: &0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::config::Config, arg1: u64) : u64 {
        if (!is_available(arg0) || arg1 == 0) {
            arg1
        } else {
            0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::math::safe_add(arg1, 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::math::mul_div(arg1, 2, 10000))
        }
    }

    public fun accrued_yield_amount(arg0: u64, arg1: u64) : u64 {
        if (arg1 > arg0) {
            arg1 - arg0
        } else {
            0
        }
    }

    public fun deposit_to_lending(arg0: &0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::config::Config, arg1: u64) : address {
        if (!is_available(arg0) || arg1 == 0) {
            @0x0
        } else {
            0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::config::lending_market_id(arg0)
        }
    }

    public fun get_yield_value(arg0: &0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::config::Config, arg1: u64) : u64 {
        arg1
    }

    public fun is_available(arg0: &0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::config::Config) : bool {
        0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::config::lending_market_id(arg0) != @0x0
    }

    public fun live_yield_action_deposit() : u64 {
        1
    }

    public fun live_yield_action_hold() : u64 {
        2
    }

    public fun live_yield_action_none() : u64 {
        0
    }

    public fun live_yield_action_withdraw_full() : u64 {
        4
    }

    public fun live_yield_action_withdraw_partial() : u64 {
        3
    }

    public fun normalize_live_receipt_id(arg0: &0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::config::Config, arg1: address, arg2: u64) : address {
        let v0 = if (!is_available(arg0)) {
            true
        } else if (arg1 == @0x0) {
            true
        } else {
            arg2 == 0
        };
        if (v0) {
            @0x0
        } else {
            arg1
        }
    }

    public fun principal_after_live_deposit(arg0: u64, arg1: u64) : u64 {
        0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::math::safe_add(arg0, arg1)
    }

    public fun principal_after_live_withdraw(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = if (arg0 == 0) {
            true
        } else if (arg1 == 0) {
            true
        } else {
            arg2 >= arg1
        };
        if (v0) {
            0
        } else {
            0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::math::safe_sub(arg0, 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::math::mul_div(arg0, arg2, arg1))
        }
    }

    public fun stake_sui_for_lst(arg0: &0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::config::Config, arg1: u64) : u64 {
        arg1
    }

    public fun unstake_lst(arg0: &0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::config::Config, arg1: u64) : u64 {
        arg1
    }

    public fun value_after_live_withdraw(arg0: u64, arg1: u64) : u64 {
        if (arg1 >= arg0) {
            0
        } else {
            arg0 - arg1
        }
    }

    public fun withdraw_from_lending(arg0: &0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::config::Config, arg1: address, arg2: u64, arg3: u64) : (address, u64, u64) {
        let v0 = if (arg2 < arg3) {
            arg2
        } else {
            arg3
        };
        let v1 = arg2 - v0;
        let v2 = if (v1 > 0) {
            arg1
        } else {
            @0x0
        };
        (v2, v0, v1)
    }

    // decompiled from Move bytecode v6
}

