module 0x8095a90b14f23a43618ed863af87ac683ce8b604cc2db118312a0ec34478022b::my_nft {
    struct MyNft has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MyNft{
            id        : 0x2::object::new(arg0),
            name      : 0x1::string::utf8(b"cyhzuishuai"),
            image_url : 0x1::string::utf8(b"https://github.com/cyhzuishuai/images/blob/main/%E5%A4%B4%E5%83%8F.jpg?raw=true"),
        };
        0x2::transfer::transfer<MyNft>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun mint(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = MyNft{
            id        : 0x2::object::new(arg1),
            name      : 0x1::string::utf8(b"cyhzuishuai"),
            image_url : 0x1::string::utf8(b"https://github.com/cyhzuishuai/images/blob/main/%E5%A4%B4%E5%83%8F.jpg?raw=true"),
        };
        0x2::transfer::transfer<MyNft>(v0, arg0);
    }

    // decompiled from Move bytecode v6
}

