module 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::lockable {
    struct Lockable has copy, drop, store {
        balance: u64,
        locked: u64,
    }

    public fun available_balance(arg0: &Lockable) : u64 {
        arg0.balance
    }

    public fun decrease_available(arg0: &mut Lockable, arg1: u64) {
        if (arg0.balance < arg1) {
            arg0.balance = 0;
        } else {
            arg0.balance = arg0.balance - arg1;
        };
    }

    public fun increase_available(arg0: &mut Lockable, arg1: u64) {
        arg0.balance = arg0.balance + arg1;
    }

    public fun increase_locked(arg0: &mut Lockable, arg1: u64) {
        arg0.locked = arg0.locked + arg1;
    }

    public fun locked(arg0: &Lockable) : u64 {
        arg0.locked
    }

    public fun new_lockable() : Lockable {
        Lockable{
            balance : 0,
            locked  : 0,
        }
    }

    public fun total_balance(arg0: &Lockable) : u64 {
        arg0.balance + arg0.locked
    }

    public fun unlock(arg0: &mut Lockable, arg1: u64) {
        if (arg0.locked < arg1) {
            arg0.balance = arg0.balance + arg0.locked;
            arg0.locked = 0;
        } else {
            arg0.balance = arg0.balance + arg1;
            arg0.locked = arg0.locked - arg1;
        };
    }

    // decompiled from Move bytecode v6
}

