module 0x9d3e58a59ab9ab67931427be462be53303632016905480949cfd2093926df98b::demo {
    struct D has store, key {
        id: 0x2::object::UID,
        v: u64,
    }

    public entry fun create_D(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = D{
            id : 0x2::object::new(arg1),
            v  : arg0,
        };
        0x2::transfer::public_transfer<D>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun set_value(arg0: &mut D, arg1: u64) {
        arg0.v = arg1;
    }

    public fun value(arg0: &D) : u64 {
        arg0.v
    }

    // decompiled from Move bytecode v7
}

