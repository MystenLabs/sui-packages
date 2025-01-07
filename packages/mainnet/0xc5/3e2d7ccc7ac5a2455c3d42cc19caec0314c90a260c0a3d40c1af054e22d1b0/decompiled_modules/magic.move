module 0xc53e2d7ccc7ac5a2455c3d42cc19caec0314c90a260c0a3d40c1af054e22d1b0::magic {
    struct Magic has store, key {
        id: 0x2::object::UID,
        magic: u64,
    }

    public entry fun create(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Magic{
            id    : 0x2::object::new(arg0),
            magic : 3,
        };
        0x2::transfer::transfer<Magic>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

