module 0xf3c04d94f3148bf8b61e0f4714fbba1b6694728ba9ab5c5ef6e4b7cd810bc47d::maybeok_nft {
    struct MaybeokNFT has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MaybeokNFT{
            id        : 0x2::object::new(arg0),
            name      : 0x1::string::utf8(b"MaybeOk NFT"),
            image_url : 0x1::string::utf8(b"https://avatars.githubusercontent.com/u/22394215?u=ac963b3b1ad2ea8e81ba9a2e8416095c80a78076&v=4"),
        };
        0x2::transfer::transfer<MaybeokNFT>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun mint(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = MaybeokNFT{
            id        : 0x2::object::new(arg1),
            name      : 0x1::string::utf8(b"MaybeOk NFT"),
            image_url : arg0,
        };
        0x2::transfer::transfer<MaybeokNFT>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

