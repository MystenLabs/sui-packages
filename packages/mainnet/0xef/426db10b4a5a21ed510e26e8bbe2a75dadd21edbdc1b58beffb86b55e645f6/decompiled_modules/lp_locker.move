module 0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::lp_locker {
    struct LockedLP has key {
        id: 0x2::object::UID,
        launch_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        locked_at_ms: u64,
    }

    public fun create_lock(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : LockedLP {
        LockedLP{
            id           : 0x2::object::new(arg4),
            launch_id    : arg0,
            pool_id      : arg1,
            position_id  : arg2,
            locked_at_ms : arg3,
        }
    }

    public fun launch_id(arg0: &LockedLP) : 0x2::object::ID {
        arg0.launch_id
    }

    public fun locked_at_ms(arg0: &LockedLP) : u64 {
        arg0.locked_at_ms
    }

    public fun pool_id(arg0: &LockedLP) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun position_id(arg0: &LockedLP) : 0x2::object::ID {
        arg0.position_id
    }

    public entry fun share_lock(arg0: LockedLP) {
        0x2::transfer::share_object<LockedLP>(arg0);
    }

    // decompiled from Move bytecode v7
}

