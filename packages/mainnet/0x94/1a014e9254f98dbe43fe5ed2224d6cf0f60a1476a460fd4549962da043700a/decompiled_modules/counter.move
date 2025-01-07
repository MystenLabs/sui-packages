module 0x941a014e9254f98dbe43fe5ed2224d6cf0f60a1476a460fd4549962da043700a::counter {
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

