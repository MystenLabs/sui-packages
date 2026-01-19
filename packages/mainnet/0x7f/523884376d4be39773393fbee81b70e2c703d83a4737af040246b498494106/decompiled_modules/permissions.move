module 0x7f523884376d4be39773393fbee81b70e2c703d83a4737af040246b498494106::permissions {
    public fun all_permissions() : u32 {
        4294967295
    }

    public fun borrow_permission() : u8 {
        5
    }

    public fun check_permission(arg0: u32, arg1: u8) : bool {
        arg0 & 1 << arg1 > 0
    }

    public fun conditional_order_permission() : u8 {
        8
    }

    public fun deposit_permission() : u8 {
        0
    }

    public fun liquidate_permission() : u8 {
        7
    }

    public fun no_permissions() : u32 {
        0
    }

    public fun repay_permission() : u8 {
        2
    }

    public fun set_permission(arg0: &mut u32, arg1: u8) {
        *arg0 = *arg0 | 1 << arg1;
    }

    public fun supplier_withdraw_permission() : u8 {
        4
    }

    public fun supply_permission() : u8 {
        3
    }

    public fun trade_permission() : u8 {
        6
    }

    public fun unset_permission(arg0: &mut u32, arg1: u8) {
        *arg0 = *arg0 & 4294967295 - (1 << arg1);
    }

    public fun withdraw_permission() : u8 {
        1
    }

    // decompiled from Move bytecode v6
}

