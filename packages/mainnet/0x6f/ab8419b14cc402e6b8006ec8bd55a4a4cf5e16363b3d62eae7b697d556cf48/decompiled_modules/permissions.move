module 0x6fab8419b14cc402e6b8006ec8bd55a4a4cf5e16363b3d62eae7b697d556cf48::permissions {
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

