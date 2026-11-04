module 0x22e92b6a6dd0a80e73b90fdf018d3682828667840a187e95e7e4750e12324818::acceptance_nft {
    struct TestNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = TestNFT{
            id          : 0x2::object::new(arg0),
            name        : 0x1::string::utf8(b"FX Wallet Acceptance NFT"),
            description : 0x1::string::utf8(b"Disposable service integration test object; no promised value."),
            image_url   : 0x1::string::utf8(b""),
        };
        0x2::transfer::transfer<TestNFT>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v7
}

