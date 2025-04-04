module 0x8e748e6679597f3aa53f34f526b2c5c26a55a4b0e79162a65c72c9020541d857::mynft {
    struct MyNft has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MyNft{
            id        : 0x2::object::new(arg0),
            name      : 0x1::string::utf8(b"dryan86 NFT"),
            image_url : 0x1::string::utf8(b"https://avatars.githubusercontent.com/u/25659468?v=4"),
        };
        0x2::transfer::public_transfer<MyNft>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun mint(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = MyNft{
            id        : 0x2::object::new(arg1),
            name      : 0x1::string::utf8(b"dryan86 NFT"),
            image_url : arg0,
        };
        0x2::transfer::public_transfer<MyNft>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mintTo(arg0: 0x1::string::String, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = MyNft{
            id        : 0x2::object::new(arg2),
            name      : 0x1::string::utf8(b"dryan86 NFT"),
            image_url : arg0,
        };
        0x2::transfer::public_transfer<MyNft>(v0, arg1);
    }

    // decompiled from Move bytecode v6
}

