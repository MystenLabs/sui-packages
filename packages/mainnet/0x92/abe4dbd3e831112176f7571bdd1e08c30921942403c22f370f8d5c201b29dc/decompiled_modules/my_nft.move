module 0x92abe4dbd3e831112176f7571bdd1e08c30921942403c22f370f8d5c201b29dc::my_nft {
    struct MyNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MyNFT{
            id        : 0x2::object::new(arg0),
            name      : 0x1::string::utf8(b"cmdscz NFT"),
            image_url : 0x1::string::utf8(b"https://avatars.githubusercontent.com/u/169383631"),
        };
        0x2::transfer::transfer<MyNFT>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun mint(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = MyNFT{
            id        : 0x2::object::new(arg1),
            name      : 0x1::string::utf8(b"cmdscz NFT"),
            image_url : arg0,
        };
        0x2::transfer::transfer<MyNFT>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun transfer_nft(arg0: MyNFT, arg1: address) {
        0x2::transfer::public_transfer<MyNFT>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

