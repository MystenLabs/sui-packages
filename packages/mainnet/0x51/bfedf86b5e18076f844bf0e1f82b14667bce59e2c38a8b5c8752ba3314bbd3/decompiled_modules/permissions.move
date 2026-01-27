module 0x51bfedf86b5e18076f844bf0e1f82b14667bce59e2c38a8b5c8752ba3314bbd3::permissions {
    public fun borrow_permission() : u8 {
        3
    }

    public(friend) fun check_permission(arg0: u32, arg1: u8) : bool {
        arg0 & 1 << arg1 > 0
    }

    public fun claim_reward_permission() : u8 {
        7
    }

    public fun close_position_permission() : u8 {
        1
    }

    public fun deposit_permission() : u8 {
        2
    }

    public fun open_position_permission() : u8 {
        0
    }

    public fun repay_permission() : u8 {
        5
    }

    public(friend) fun set_permission(arg0: &mut u32, arg1: u8) {
        if (check_permission(*arg0, arg1)) {
            return
        };
        *arg0 = *arg0 | 1 << arg1;
    }

    public(friend) fun unset_permission(arg0: &mut u32, arg1: u8) {
        if (!check_permission(*arg0, arg1)) {
            return
        };
        *arg0 = *arg0 & 4294967295 - (1 << arg1);
    }

    public fun withdraw_permission() : u8 {
        4
    }

    // decompiled from Move bytecode v6
}

