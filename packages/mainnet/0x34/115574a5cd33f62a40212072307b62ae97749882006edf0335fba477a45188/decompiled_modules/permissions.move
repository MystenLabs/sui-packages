module 0xf1f6aad6635b667b3d659bce864dabf9cc7099f870ea078dc68fdcff7d81ef61::permissions {
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

    public fun governance_permission() : u8 {
        10
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

    public fun staking_permission() : u8 {
        9
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

