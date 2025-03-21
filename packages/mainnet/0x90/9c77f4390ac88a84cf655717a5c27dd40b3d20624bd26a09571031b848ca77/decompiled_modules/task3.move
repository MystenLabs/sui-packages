module 0x909c77f4390ac88a84cf655717a5c27dd40b3d20624bd26a09571031b848ca77::task3 {
    struct LxjianbaiNFT has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = LxjianbaiNFT{
            id        : 0x2::object::new(arg0),
            name      : 0x1::string::utf8(b"lxjianbai NFT"),
            image_url : 0x1::string::utf8(b"https://avatars.githubusercontent.com/u/29810624?v=4"),
        };
        0x2::transfer::transfer<LxjianbaiNFT>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun mint(arg0: 0x1::string::String, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = LxjianbaiNFT{
            id        : 0x2::object::new(arg2),
            name      : 0x1::string::utf8(b"lxjianbai NFT"),
            image_url : arg0,
        };
        0x2::transfer::transfer<LxjianbaiNFT>(v0, arg1);
    }

    // decompiled from Move bytecode v6
}

