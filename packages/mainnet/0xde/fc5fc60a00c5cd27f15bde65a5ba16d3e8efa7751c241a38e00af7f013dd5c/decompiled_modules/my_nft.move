module 0xdefc5fc60a00c5cd27f15bde65a5ba16d3e8efa7751c241a38e00af7f013dd5c::my_nft {
    struct MyNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(b"AKAking23");
        let v1 = 0x1::string::utf8(b"https://avatars.githubusercontent.com/u/82486465?v=4");
        let v2 = MyNFT{
            id        : 0x2::object::new(arg0),
            name      : v0,
            image_url : v1,
        };
        0x2::transfer::public_transfer<MyNFT>(v2, 0x2::tx_context::sender(arg0));
        mint(v0, v1, @0x7b8e0864967427679b4e129f79dc332a885c6087ec9e187b53451a9006ee15f2, arg0);
    }

    public entry fun mint(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = MyNFT{
            id        : 0x2::object::new(arg3),
            name      : arg0,
            image_url : arg1,
        };
        0x2::transfer::public_transfer<MyNFT>(v0, arg2);
    }

    // decompiled from Move bytecode v6
}

