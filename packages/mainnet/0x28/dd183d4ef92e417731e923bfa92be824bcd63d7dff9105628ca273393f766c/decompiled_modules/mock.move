module 0x28dd183d4ef92e417731e923bfa92be824bcd63d7dff9105628ca273393f766c::mock {
    struct GlobalCounter has key {
        id: 0x2::object::UID,
        count: u64,
    }

    struct ExecutedEvent has copy, drop {
        count: u64,
        checkpoint: u64,
        timestamp: u64,
    }

    public fun execute(arg0: &mut GlobalCounter, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg0.count = arg0.count + 1;
        let v0 = ExecutedEvent{
            count      : arg0.count,
            checkpoint : arg1,
            timestamp  : arg2,
        };
        0x2::event::emit<ExecutedEvent>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GlobalCounter{
            id    : 0x2::object::new(arg0),
            count : 0,
        };
        0x2::transfer::share_object<GlobalCounter>(v0);
    }

    // decompiled from Move bytecode v7
}

