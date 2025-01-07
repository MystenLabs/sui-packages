module 0xef27d52dbaf002d61b037193532fdc590773c069b1c05074fa2544be3d9ed10a::my_nft {
    struct Jdf12Nft has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        img_url: 0x1::string::String,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Jdf12Nft{
            id      : 0x2::object::new(arg0),
            name    : 0x1::string::utf8(b"JDF12 NFT"),
            img_url : 0x1::string::utf8(b"https://avatars.githubusercontent.com/u/74341734?v=4"),
        };
        0x2::transfer::transfer<Jdf12Nft>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun mint(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Jdf12Nft{
            id      : 0x2::object::new(arg1),
            name    : 0x1::string::utf8(b"JDF12 NFT"),
            img_url : arg0,
        };
        0x2::transfer::transfer<Jdf12Nft>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

