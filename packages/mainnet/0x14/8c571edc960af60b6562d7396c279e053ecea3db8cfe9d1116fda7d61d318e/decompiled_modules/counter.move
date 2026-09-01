module 0x148c571edc960af60b6562d7396c279e053ecea3db8cfe9d1116fda7d61d318e::counter {
    struct Counter has key {
        id: 0x2::object::UID,
        value: u64,
    }

    public fun bump(arg0: &mut Counter) {
        arg0.value = arg0.value + 1;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Counter{
            id    : 0x2::object::new(arg0),
            value : 0,
        };
        0x2::transfer::share_object<Counter>(v0);
    }

    public fun value(arg0: &Counter) : u64 {
        arg0.value
    }

    // decompiled from Move bytecode v7
}

