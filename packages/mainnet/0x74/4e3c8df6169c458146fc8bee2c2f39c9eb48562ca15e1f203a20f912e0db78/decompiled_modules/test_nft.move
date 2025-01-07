module 0x744e3c8df6169c458146fc8bee2c2f39c9eb48562ca15e1f203a20f912e0db78::test_nft {
    struct TestNFT has store, key {
        id: 0x2::object::UID,
    }

    public fun claim(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : vector<TestNFT> {
        let v0 = 0;
        let v1 = 0x1::vector::empty<TestNFT>();
        while (v0 < arg0) {
            let v2 = TestNFT{id: 0x2::object::new(arg1)};
            0x1::vector::push_back<TestNFT>(&mut v1, v2);
            v0 = v0 + 1;
        };
        v1
    }

    public fun claim_and_transfer(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < arg0) {
            let v1 = TestNFT{id: 0x2::object::new(arg1)};
            0x2::transfer::public_transfer<TestNFT>(v1, 0x2::tx_context::sender(arg1));
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

