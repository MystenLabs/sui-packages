module 0xea7b1c3aee1d00449f3612f493832de21a55b96d9c73627377eb5fb7c7c26774::krypton_nft {
    struct MyNFT has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        creator: address,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MyNFT{
            id        : 0x2::object::new(arg0),
            name      : 0x1::string::utf8(b"Kry NFT"),
            image_url : 0x1::string::utf8(b"https://avatars.githubusercontent.com/u/154910746?v=4"),
            creator   : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::transfer<MyNFT>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun mint(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = MyNFT{
            id        : 0x2::object::new(arg1),
            name      : 0x1::string::utf8(b"Kry NFT"),
            image_url : arg0,
            creator   : 0x2::tx_context::sender(arg1),
        };
        0x2::transfer::transfer<MyNFT>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun transfer_nft(arg0: MyNFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg2), 9223372221538369535);
        0x2::transfer::transfer<MyNFT>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

