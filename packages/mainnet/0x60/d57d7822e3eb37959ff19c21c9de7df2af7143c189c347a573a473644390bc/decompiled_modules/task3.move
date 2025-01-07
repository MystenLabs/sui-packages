module 0x60d57d7822e3eb37959ff19c21c9de7df2af7143c189c347a573a473644390bc::task3 {
    struct XddNFT has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = XddNFT{
            id        : 0x2::object::new(arg0),
            name      : 0x1::string::utf8(b"XDD NFT"),
            image_url : 0x1::string::utf8(b"https://avatars.githubusercontent.com/u/24604365"),
        };
        0x2::transfer::transfer<XddNFT>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun mint(arg0: 0x1::string::String, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = XddNFT{
            id        : 0x2::object::new(arg2),
            name      : 0x1::string::utf8(b"XDD NFT"),
            image_url : arg0,
        };
        0x2::transfer::transfer<XddNFT>(v0, arg1);
    }

    // decompiled from Move bytecode v6
}

