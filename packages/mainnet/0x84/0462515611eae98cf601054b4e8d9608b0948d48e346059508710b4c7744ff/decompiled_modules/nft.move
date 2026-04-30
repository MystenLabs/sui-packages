module 0x840462515611eae98cf601054b4e8d9608b0948d48e346059508710b4c7744ff::nft {
    struct TestNFT has store, key {
        id: 0x2::object::UID,
        name: vector<u8>,
    }

    public entry fun mint(arg0: vector<u8>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = TestNFT{
            id   : 0x2::object::new(arg1),
            name : arg0,
        };
        0x2::transfer::public_transfer<TestNFT>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

