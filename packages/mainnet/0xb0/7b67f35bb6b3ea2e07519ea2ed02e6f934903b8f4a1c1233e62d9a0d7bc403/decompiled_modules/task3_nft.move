module 0xb07b67f35bb6b3ea2e07519ea2ed02e6f934903b8f4a1c1233e62d9a0d7bc403::task3_nft {
    struct NFT has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = NFT{
            id          : 0x2::object::new(arg0),
            name        : 0x1::string::utf8(b"SherVite NFT"),
            description : 0x1::string::utf8(b"Task3 NFT"),
            image_url   : 0x1::string::utf8(b"https://avatars.githubusercontent.com/u/201323230?v=4"),
        };
        0x2::transfer::transfer<NFT>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun mint(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = NFT{
            id          : 0x2::object::new(arg0),
            name        : 0x1::string::utf8(b"SherVite NFT"),
            description : 0x1::string::utf8(b"Task3 NFT"),
            image_url   : 0x1::string::utf8(b"https://avatars.githubusercontent.com/u/201323230?v=4"),
        };
        0x2::transfer::transfer<NFT>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun transfer_nft(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = NFT{
            id          : 0x2::object::new(arg1),
            name        : 0x1::string::utf8(b"SherVite NFT"),
            description : 0x1::string::utf8(b"Task3 NFT"),
            image_url   : 0x1::string::utf8(b"https://avatars.githubusercontent.com/u/201323230?v=4"),
        };
        0x2::transfer::transfer<NFT>(v0, arg0);
    }

    // decompiled from Move bytecode v6
}

