module 0x68d6cb699c4badf64b10891133bab0c4b21afcb821a0741ab89e0bf500606eb3::counter {
    struct Counter has key {
        id: 0x2::object::UID,
        value: u64,
    }

    public fun create(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Counter{
            id    : 0x2::object::new(arg0),
            value : 1,
        };
        0x2::transfer::share_object<Counter>(v0);
    }

    public fun increment(arg0: &mut Counter, arg1: u64) {
        arg0.value = arg0.value + arg1;
    }

    public fun value(arg0: &Counter) : u64 {
        arg0.value
    }

    // decompiled from Move bytecode v6
}

