module 0xf240dc4f8be3c09d9aad8d6f5c09c57f67fe5a67915a92c0a898103260986be4::my_nft {
    struct MyNFT has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MyNFT{
            id        : 0x2::object::new(arg0),
            name      : 0x1::string::utf8(b"YANGTO NFT"),
            image_url : 0x1::string::utf8(b"https://avatars.githubusercontent.com/u/7939959?v=4"),
        };
        0x2::transfer::transfer<MyNFT>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun mint(arg0: 0x1::string::String, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = MyNFT{
            id        : 0x2::object::new(arg2),
            name      : 0x1::string::utf8(b"NFT FOR YOU"),
            image_url : arg0,
        };
        0x2::transfer::transfer<MyNFT>(v0, arg1);
    }

    // decompiled from Move bytecode v6
}

