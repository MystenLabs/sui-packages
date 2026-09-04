module 0xc9ec02952f6b21a897906882a110cc475bf18769581a3315574f990500525cb2::counter {
    struct Counter has key {
        id: 0x2::object::UID,
        value: u64,
    }

    public fun increment(arg0: &mut Counter) {
        arg0.value = arg0.value + 1;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Counter{
            id    : 0x2::object::new(arg0),
            value : 0,
        };
        0x2::transfer::share_object<Counter>(v0);
    }

    // decompiled from Move bytecode v6
}

