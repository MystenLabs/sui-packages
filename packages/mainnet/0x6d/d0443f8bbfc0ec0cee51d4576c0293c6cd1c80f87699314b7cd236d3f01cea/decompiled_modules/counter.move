module 0x6dd0443f8bbfc0ec0cee51d4576c0293c6cd1c80f87699314b7cd236d3f01cea::counter {
    struct Counter has key {
        id: 0x2::object::UID,
        value: u64,
    }

    public entry fun bump(arg0: &mut Counter, arg1: u64) {
        arg0.value = arg0.value + 1;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Counter{
            id    : 0x2::object::new(arg0),
            value : 0,
        };
        0x2::transfer::share_object<Counter>(v0);
    }

    // decompiled from Move bytecode v7
}

