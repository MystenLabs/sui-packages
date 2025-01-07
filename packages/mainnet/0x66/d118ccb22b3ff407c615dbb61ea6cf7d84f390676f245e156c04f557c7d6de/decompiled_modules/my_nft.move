module 0x66d118ccb22b3ff407c615dbb61ea6cf7d84f390676f245e156c04f557c7d6de::my_nft {
    struct MyNFT has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MyNFT{
            id        : 0x2::object::new(arg0),
            name      : 0x1::string::utf8(b"suiceber NFT"),
            image_url : 0x1::string::utf8(b"https://avatars.githubusercontent.com/u/182899206?v=4&size=64"),
        };
        0x2::transfer::transfer<MyNFT>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun mint(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = MyNFT{
            id        : 0x2::object::new(arg1),
            name      : 0x1::string::utf8(b"suiceber NFT"),
            image_url : arg0,
        };
        0x2::transfer::transfer<MyNFT>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

