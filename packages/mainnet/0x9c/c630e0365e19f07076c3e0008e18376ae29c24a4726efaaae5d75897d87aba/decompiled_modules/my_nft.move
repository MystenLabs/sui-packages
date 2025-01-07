module 0x9cc630e0365e19f07076c3e0008e18376ae29c24a4726efaaae5d75897d87aba::my_nft {
    struct MyNFT has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MyNFT{
            id        : 0x2::object::new(arg0),
            name      : 0x1::string::utf8(b"Azhan NFT"),
            image_url : 0x1::string::utf8(b"https://avatars.githubusercontent.com/u/144402853?v=4"),
        };
        0x2::transfer::transfer<MyNFT>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun mint(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = MyNFT{
            id        : 0x2::object::new(arg3),
            name      : arg0,
            image_url : arg1,
        };
        0x2::transfer::transfer<MyNFT>(v0, arg2);
    }

    // decompiled from Move bytecode v6
}

