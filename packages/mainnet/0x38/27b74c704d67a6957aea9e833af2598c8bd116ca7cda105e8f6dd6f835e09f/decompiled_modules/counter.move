module 0x3827b74c704d67a6957aea9e833af2598c8bd116ca7cda105e8f6dd6f835e09f::counter {
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

