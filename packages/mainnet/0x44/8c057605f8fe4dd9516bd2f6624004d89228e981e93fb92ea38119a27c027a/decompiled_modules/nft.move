module 0x448c057605f8fe4dd9516bd2f6624004d89228e981e93fb92ea38119a27c027a::nft {
    struct NFT has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = NFT{
            id        : 0x2::object::new(arg0),
            name      : 0x1::string::utf8(b"zhbbll NFT"),
            image_url : 0x1::string::utf8(b"https://avatars.githubusercontent.com/u/117818070?v=4"),
        };
        0x2::transfer::transfer<NFT>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun mint_nft(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = NFT{
            id        : 0x2::object::new(arg1),
            name      : 0x1::string::utf8(b"zhbbll NFT"),
            image_url : arg0,
        };
        0x2::transfer::transfer<NFT>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun transfer_nft(arg0: NFT, arg1: address) {
        0x2::transfer::transfer<NFT>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

