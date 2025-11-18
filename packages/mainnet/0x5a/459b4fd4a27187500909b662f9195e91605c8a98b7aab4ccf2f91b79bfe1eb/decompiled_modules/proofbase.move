module 0x5a459b4fd4a27187500909b662f9195e91605c8a98b7aab4ccf2f91b79bfe1eb::proofbase {
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

