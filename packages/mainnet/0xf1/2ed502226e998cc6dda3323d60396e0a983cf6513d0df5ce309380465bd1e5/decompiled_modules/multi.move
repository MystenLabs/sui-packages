module 0xf12ed502226e998cc6dda3323d60396e0a983cf6513d0df5ce309380465bd1e5::multi {
    struct MultiCap has key {
        id: 0x2::object::UID,
        v: u64,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MultiCap{
            id : 0x2::object::new(arg0),
            v  : 0,
        };
        0x2::transfer::transfer<MultiCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun set_value(arg0: &mut MultiCap, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.v = arg1;
    }

    public entry fun transfer_multi_cap(arg0: MultiCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<MultiCap>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

