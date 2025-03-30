module 0xef78f9e2f983710e4635c4593ccc08d6478e3cce7db4b520e79b9df767cd9684::my_nft {
    struct MyNFT has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MyNFT{
            id        : 0x2::object::new(arg0),
            name      : 0x1::string::utf8(b"0x-zeros NFT"),
            image_url : 0x1::string::utf8(b"https://madlads.s3.us-west-2.amazonaws.com/images/7308.png"),
        };
        0x2::transfer::transfer<MyNFT>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun mint(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = MyNFT{
            id        : 0x2::object::new(arg1),
            name      : 0x1::string::utf8(b"0x-zeros NFT"),
            image_url : 0x1::string::utf8(b"https://madlads.s3.us-west-2.amazonaws.com/images/7308.png"),
        };
        0x2::transfer::transfer<MyNFT>(v0, arg0);
    }

    // decompiled from Move bytecode v6
}

