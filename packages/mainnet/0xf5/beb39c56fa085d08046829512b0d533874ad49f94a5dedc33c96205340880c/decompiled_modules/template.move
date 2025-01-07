module 0xf5beb39c56fa085d08046829512b0d533874ad49f94a5dedc33c96205340880c::template {
    struct NumberEvent has copy, drop {
        number: u64,
    }

    public entry fun get_number(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = NumberEvent{number: 1};
        0x2::event::emit<NumberEvent>(v0);
    }

    public fun get_number_test() : u64 {
        1
    }

    // decompiled from Move bytecode v6
}

