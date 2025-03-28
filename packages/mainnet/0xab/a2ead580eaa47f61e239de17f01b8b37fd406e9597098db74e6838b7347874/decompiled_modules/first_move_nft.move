module 0xaba2ead580eaa47f61e239de17f01b8b37fd406e9597098db74e6838b7347874::first_move_nft {
    struct NFT has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = NFT{
            id          : 0x2::object::new(arg0),
            name        : 0x1::string::utf8(b"Firefly NFT"),
            description : 0x1::string::utf8(b"My first move NFT"),
            image_url   : 0x1::string::utf8(b"https://avatars.githubusercontent.com/u/143856635?v=4"),
        };
        0x2::transfer::transfer<NFT>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun mint(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = NFT{
            id          : 0x2::object::new(arg0),
            name        : 0x1::string::utf8(b"Firefly NFT"),
            description : 0x1::string::utf8(b"My first move NFT"),
            image_url   : 0x1::string::utf8(b"https://avatars.githubusercontent.com/u/143856635?v=4"),
        };
        0x2::transfer::transfer<NFT>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun transfer_nft(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = NFT{
            id          : 0x2::object::new(arg1),
            name        : 0x1::string::utf8(b"Firefly NFT"),
            description : 0x1::string::utf8(b"My first move NFT"),
            image_url   : 0x1::string::utf8(b"https://avatars.githubusercontent.com/u/143856635?v=4"),
        };
        0x2::transfer::transfer<NFT>(v0, arg0);
    }

    // decompiled from Move bytecode v6
}

