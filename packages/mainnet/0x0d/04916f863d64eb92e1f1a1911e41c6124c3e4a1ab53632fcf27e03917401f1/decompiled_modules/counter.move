module 0xd04916f863d64eb92e1f1a1911e41c6124c3e4a1ab53632fcf27e03917401f1::counter {
    struct Data has store, key {
        id: 0x2::object::UID,
        value: u64,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Data{
            id    : 0x2::object::new(arg0),
            value : 0,
        };
        0x2::transfer::transfer<Data>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Data{
            id    : 0x2::object::new(arg0),
            value : 0,
        };
        0x2::transfer::transfer<Data>(v1, 0x2::tx_context::sender(arg0));
    }

    entry fun set(arg0: &mut Data, arg1: u64) {
        arg0.value = arg1;
    }

    // decompiled from Move bytecode v6
}

