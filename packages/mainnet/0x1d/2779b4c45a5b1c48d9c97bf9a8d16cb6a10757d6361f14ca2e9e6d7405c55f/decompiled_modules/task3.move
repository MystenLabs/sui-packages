module 0x1d2779b4c45a5b1c48d9c97bf9a8d16cb6a10757d6361f14ca2e9e6d7405c55f::task3 {
    struct QweNFT has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = QweNFT{
            id        : 0x2::object::new(arg0),
            name      : 0x1::string::utf8(b"qwe563470907 NFT"),
            image_url : 0x1::string::utf8(b"https://avatars.githubusercontent.com/u/26663441?v=4"),
        };
        0x2::transfer::transfer<QweNFT>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun mint(arg0: 0x1::string::String, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = QweNFT{
            id        : 0x2::object::new(arg2),
            name      : 0x1::string::utf8(b"qwe563470907 NFT"),
            image_url : arg0,
        };
        0x2::transfer::transfer<QweNFT>(v0, arg1);
    }

    // decompiled from Move bytecode v6
}

