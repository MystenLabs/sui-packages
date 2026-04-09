module 0x5d5469041f22c1912cbeb6976dee0be1ea69ba12bc2c04a1961ffe77889350d6::clock_guard {
    struct TimeLock has store, key {
        id: 0x2::object::UID,
        unlock_ms: u64,
        unlocked: bool,
    }

    public fun create(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = TimeLock{
            id        : 0x2::object::new(arg1),
            unlock_ms : arg0,
            unlocked  : false,
        };
        0x2::transfer::transfer<TimeLock>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun is_unlocked(arg0: &TimeLock) : bool {
        arg0.unlocked
    }

    public fun try_unlock(arg0: &mut TimeLock, arg1: &0x2::clock::Clock) {
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.unlock_ms, 1);
        arg0.unlocked = true;
    }

    // decompiled from Move bytecode v6
}

