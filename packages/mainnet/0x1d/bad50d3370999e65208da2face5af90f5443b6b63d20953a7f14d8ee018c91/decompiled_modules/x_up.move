module 0x1dbad50d3370999e65208da2face5af90f5443b6b63d20953a7f14d8ee018c91::x_up {
    struct XUP has drop {
        dummy_field: bool,
    }

    struct XUPState has store, key {
        id: 0x2::object::UID,
        amount: u64,
    }

    struct UPTreasury has store, key {
        id: 0x2::object::UID,
        up_balance: 0x2::balance::Balance<0x1dbad50d3370999e65208da2face5af90f5443b6b63d20953a7f14d8ee018c91::up::UP>,
        xup_circulating: u64,
        claiming_allowed: bool,
    }

    public fun amount_unclaimed(arg0: &XUPState) : u64 {
        arg0.amount
    }

    public fun borrow_balance_mut(arg0: &mut UPTreasury) : &mut 0x2::balance::Balance<0x1dbad50d3370999e65208da2face5af90f5443b6b63d20953a7f14d8ee018c91::up::UP> {
        &mut arg0.up_balance
    }

    public fun get_amount(arg0: &XUPState) : u64 {
        arg0.amount
    }

    public fun set_amount(arg0: &mut XUPState, arg1: u64) {
        arg0.amount = arg1;
    }

    // decompiled from Move bytecode v7
}

