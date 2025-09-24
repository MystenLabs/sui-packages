module 0xe0905cfef8329eddf62ba7d7ffe4ac1efd008307137b9d07e5f378c00aae729e::permissions {
    public fun borrow_permission() : u8 {
        3
    }

    public(friend) fun check_permission(arg0: u32, arg1: u8) : bool {
        arg0 & 1 << arg1 > 0
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
        *arg0 = *arg0 | 1 << arg1;
    }

    public(friend) fun unset_permission(arg0: &mut u32, arg1: u8) {
        *arg0 = *arg0 & 4294967295 - (1 << arg1);
    }

    public fun withdraw_permission() : u8 {
        4
    }

    // decompiled from Move bytecode v6
}

