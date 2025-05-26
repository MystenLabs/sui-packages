module 0x29770c4fd2b879693aaa86803c81c5dcc6efc53e8a088a3f0a43f8885f48b192::my_nft {
    struct My_NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = My_NFT{
            id        : 0x2::object::new(arg0),
            name      : 0x1::string::utf8(b"Blaze Leon's NFT!"),
            image_url : 0x1::string::utf8(b"https://avatars.githubusercontent.com/u/48305889?v=4"),
        };
        0x2::transfer::public_transfer<My_NFT>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun mint(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = My_NFT{
            id        : 0x2::object::new(arg2),
            name      : arg0,
            image_url : arg1,
        };
        0x2::transfer::public_transfer<My_NFT>(v0, 0x2::tx_context::sender(arg2));
    }

    public entry fun mint_and_transfer(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = My_NFT{
            id        : 0x2::object::new(arg1),
            name      : 0x1::string::utf8(b"Blaze Leon"),
            image_url : 0x1::string::utf8(b"https://avatars.githubusercontent.com/u/48305889?v=4"),
        };
        0x2::transfer::public_transfer<My_NFT>(v0, arg0);
    }

    // decompiled from Move bytecode v6
}

