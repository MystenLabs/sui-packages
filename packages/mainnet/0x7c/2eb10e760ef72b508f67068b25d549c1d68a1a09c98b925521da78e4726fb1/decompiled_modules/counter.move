module 0x7c2eb10e760ef72b508f67068b25d549c1d68a1a09c98b925521da78e4726fb1::counter {
    struct Counter has key {
        id: 0x2::object::UID,
        counter: u64,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Counter{
            id      : 0x2::object::new(arg0),
            counter : 0,
        };
        0x2::transfer::share_object<Counter>(v0);
    }

    public entry fun tick(arg0: &mut Counter) {
        arg0.counter = arg0.counter + 1;
    }

    // decompiled from Move bytecode v6
}

