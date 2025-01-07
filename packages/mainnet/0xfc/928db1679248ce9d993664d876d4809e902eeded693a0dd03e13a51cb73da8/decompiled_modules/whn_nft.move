module 0xfc928db1679248ce9d993664d876d4809e902eeded693a0dd03e13a51cb73da8::whn_nft {
    struct WhnNft has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = WhnNft{
            id        : 0x2::object::new(arg0),
            name      : 0x1::string::utf8(b"Pebbler"),
            image_url : 0x1::string::utf8(b"https://avatars.githubusercontent.com/u/10150276?v=4&size=64"),
        };
        0x2::transfer::public_transfer<WhnNft>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun mint(arg0: address, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = WhnNft{
            id        : 0x2::object::new(arg3),
            name      : arg1,
            image_url : arg2,
        };
        0x2::transfer::public_transfer<WhnNft>(v0, arg0);
    }

    // decompiled from Move bytecode v6
}

