module 0x4b5f686e7ede5b052e07f4ef22091501ad327445db9108d1c078c3a76faa643c::counter {
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

