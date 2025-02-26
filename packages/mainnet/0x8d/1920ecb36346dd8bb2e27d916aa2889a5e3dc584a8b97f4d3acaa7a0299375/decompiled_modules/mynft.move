module 0x8d1920ecb36346dd8bb2e27d916aa2889a5e3dc584a8b97f4d3acaa7a0299375::mynft {
    struct NFT has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        link: 0x1::string::String,
        image_url: 0x1::string::String,
        description: 0x1::string::String,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = NFT{
            id          : 0x2::object::new(arg0),
            name        : 0x1::string::utf8(b"MY NFT2"),
            link        : 0x1::string::utf8(b"https://images.pexels.com/photos/2174974/pexels-photo-2174974.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),
            image_url   : 0x1::string::utf8(b"https://images.pexels.com/photos/2174974/pexels-photo-2174974.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),
            description : 0x1::string::utf8(b"MY NFT"),
        };
        0x2::transfer::transfer<NFT>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

