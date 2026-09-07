module 0xc7328ca5d57dd68431e49b3bb4779035c3bf75ca489ca10ef2e7fde90c08bef4::counter {
    struct Counter has key {
        id: 0x2::object::UID,
        value: u64,
    }

    struct CounterAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct IncrementedEvent has copy, drop {
        counter_id: 0x2::object::ID,
        value: u64,
    }

    public fun increment(arg0: &mut Counter) {
        arg0.value = arg0.value + 1;
        let v0 = IncrementedEvent{
            counter_id : 0x2::object::uid_to_inner(&arg0.id),
            value      : arg0.value,
        };
        0x2::event::emit<IncrementedEvent>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Counter{
            id    : 0x2::object::new(arg0),
            value : 0,
        };
        0x2::transfer::share_object<Counter>(v0);
        let v1 = CounterAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<CounterAdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun reset(arg0: &mut Counter, arg1: &CounterAdminCap) {
        arg0.value = 0;
    }

    public fun value(arg0: &Counter) : u64 {
        arg0.value
    }

    // decompiled from Move bytecode v7
}

