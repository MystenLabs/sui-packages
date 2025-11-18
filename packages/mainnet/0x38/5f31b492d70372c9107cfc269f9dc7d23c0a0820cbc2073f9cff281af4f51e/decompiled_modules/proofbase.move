module 0x385f31b492d70372c9107cfc269f9dc7d23c0a0820cbc2073f9cff281af4f51e::proofbase {
    struct Proof has store, key {
        id: 0x2::object::UID,
        creator: address,
        hash: vector<u8>,
    }

    public entry fun record(arg0: vector<u8>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = Proof{
            id      : 0x2::object::new(arg1),
            creator : v0,
            hash    : arg0,
        };
        0x2::transfer::public_transfer<Proof>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

