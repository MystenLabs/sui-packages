module 0x685fa3d296a62e13690bb08811c3de36b1ca537a11e4d32b631e83db78b88c7f::my_nft {
    struct MyNFT has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MyNFT{
            id        : 0x2::object::new(arg0),
            name      : 0x1::string::utf8(b"Test NFT"),
            image_url : 0x1::string::utf8(b"https://avatars.githubusercontent.com/u/48359478?s=400&u=a7010a302f736f46d1a815074735d789f812ca68&v=4"),
        };
        0x2::transfer::transfer<MyNFT>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun mint(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = MyNFT{
            id        : 0x2::object::new(arg1),
            name      : 0x1::string::utf8(b"ProcariHana NFT"),
            image_url : 0x1::string::utf8(b"https://avatars.githubusercontent.com/u/48359478?s=400&u=a7010a302f736f46d1a815074735d789f812ca68&v=4"),
        };
        0x2::transfer::transfer<MyNFT>(v0, arg0);
    }

    // decompiled from Move bytecode v6
}

