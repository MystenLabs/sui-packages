module 0x2::clock {
    struct Clock has key {
        id: 0x2::object::UID,
        timestamp_ms: u64,
    }

    fun consensus_commit_prologue(arg0: &mut Clock, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0x0, 0);
        arg0.timestamp_ms = arg1;
    }

    fun create(arg0: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg0) == @0x0, 0);
        let v0 = Clock{
            id           : 0x2::object::clock(),
            timestamp_ms : 0,
        };
        0x2::transfer::share_object<Clock>(v0);
    }

    public fun timestamp_ms(arg0: &Clock) : u64 {
        arg0.timestamp_ms
    }

    // decompiled from Move bytecode v6
}

