module 0x10552ee4560c35386e19a4675216ebe8988fe9d339da91c6abf30714a3682e79::nft {
    struct MyNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x1::string::String,
    }

    public entry fun mint(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = MyNFT{
            id          : 0x2::object::new(arg3),
            name        : arg0,
            description : arg1,
            url         : arg2,
        };
        0x2::transfer::public_transfer<MyNFT>(v0, 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v7
}

