module 0x21e88b1ecb6dc36f39842d6955f3c53448a1b0e4d82aad030c1291188749e427::record {
    struct Proof has store, key {
        id: 0x2::object::UID,
        payload: vector<u8>,
    }

    struct ProofCreated has copy, drop {
        payload: vector<u8>,
    }

    public entry fun create_proof(arg0: vector<u8>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Proof{
            id      : 0x2::object::new(arg1),
            payload : arg0,
        };
        let v1 = ProofCreated{payload: v0.payload};
        0x2::event::emit<ProofCreated>(v1);
        0x2::transfer::public_transfer<Proof>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

