module 0x622a3b0a66325882fb134dc649278958890f6ec857a37f9ad70cf328c82c88a2::my_nft {
    struct MyNFT has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MyNFT{
            id        : 0x2::object::new(arg0),
            name      : 0x1::string::utf8(b"lemin222 NFT"),
            image_url : 0x1::string::utf8(b"https://avatars.githubusercontent.com/u/74967833?v=4&size=64"),
        };
        0x2::transfer::transfer<MyNFT>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun mint(arg0: 0x1::string::String, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = MyNFT{
            id        : 0x2::object::new(arg2),
            name      : 0x1::string::utf8(b"lemin222 NFT"),
            image_url : arg0,
        };
        0x2::transfer::transfer<MyNFT>(v0, arg1);
    }

    // decompiled from Move bytecode v6
}

