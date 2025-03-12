module 0x4468902def1dd55378ff8d81a4a0dea1375576aabc4dea6546429f281c5c6d8a::my_nft {
    struct MyNFT has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MyNFT{
            id        : 0x2::object::new(arg0),
            name      : 0x1::string::utf8(b"MyNFT"),
            image_url : 0x1::string::utf8(b"https://avatars.githubusercontent.com/u/29913456?v=4"),
        };
        0x2::transfer::transfer<MyNFT>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

