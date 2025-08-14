module 0xe0430643481e0c5cdcc1f0c8b7d298232f4d50d070642fc3cb02faf57d4aca79::zipdata1_nft {
    struct MyNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MyNFT{
            id        : 0x2::object::new(arg0),
            name      : 0x1::string::utf8(b"My NFT"),
            image_url : 0x1::string::utf8(b"https://avatars.githubusercontent.com/u/107616568?v=4"),
        };
        0x2::transfer::public_transfer<MyNFT>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun mint(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = MyNFT{
            id        : 0x2::object::new(arg1),
            name      : 0x1::string::utf8(b"My NFT"),
            image_url : arg0,
        };
        0x2::transfer::public_transfer<MyNFT>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

