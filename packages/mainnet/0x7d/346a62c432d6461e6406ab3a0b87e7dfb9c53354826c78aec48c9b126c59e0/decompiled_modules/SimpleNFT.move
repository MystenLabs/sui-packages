module 0x7d346a62c432d6461e6406ab3a0b87e7dfb9c53354826c78aec48c9b126c59e0::SimpleNFT {
    struct SimpleNFT has store, key {
        id: 0x2::object::UID,
    }

    public fun claim(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : vector<SimpleNFT> {
        let v0 = 0;
        let v1 = 0x1::vector::empty<SimpleNFT>();
        while (v0 < arg0) {
            let v2 = SimpleNFT{id: 0x2::object::new(arg1)};
            0x1::vector::push_back<SimpleNFT>(&mut v1, v2);
            v0 = v0 + 1;
        };
        v1
    }

    public fun claim_and_transfer(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < arg0) {
            let v1 = SimpleNFT{id: 0x2::object::new(arg1)};
            0x2::transfer::public_transfer<SimpleNFT>(v1, 0x2::tx_context::sender(arg1));
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

