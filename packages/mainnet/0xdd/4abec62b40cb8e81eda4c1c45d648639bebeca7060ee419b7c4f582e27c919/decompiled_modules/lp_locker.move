module 0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::lp_locker {
    struct LockedLP has key {
        id: 0x2::object::UID,
        launch_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        locked_at_ms: u64,
    }

    public fun create_lock(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : LockedLP {
        LockedLP{
            id           : 0x2::object::new(arg4),
            launch_id    : arg0,
            pool_id      : arg1,
            position_id  : arg2,
            locked_at_ms : 0x2::clock::timestamp_ms(arg3),
        }
    }

    public fun launch_id(arg0: &LockedLP) : 0x2::object::ID {
        arg0.launch_id
    }

    public fun locked_at_ms(arg0: &LockedLP) : u64 {
        arg0.locked_at_ms
    }

    public fun no_withdraw(arg0: &LockedLP) : bool {
        abort 500
    }

    public fun pool_id(arg0: &LockedLP) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun position_id(arg0: &LockedLP) : 0x2::object::ID {
        arg0.position_id
    }

    public fun share_lock(arg0: LockedLP) {
        0x2::transfer::share_object<LockedLP>(arg0);
    }

    // decompiled from Move bytecode v7
}

