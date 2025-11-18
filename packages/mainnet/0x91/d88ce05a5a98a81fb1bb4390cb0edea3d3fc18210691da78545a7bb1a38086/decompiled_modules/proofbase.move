module 0x91d88ce05a5a98a81fb1bb4390cb0edea3d3fc18210691da78545a7bb1a38086::proofbase {
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

