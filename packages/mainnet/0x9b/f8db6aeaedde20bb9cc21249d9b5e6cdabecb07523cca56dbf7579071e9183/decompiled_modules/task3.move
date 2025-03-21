module 0x9bf8db6aeaedde20bb9cc21249d9b5e6cdabecb07523cca56dbf7579071e9183::task3 {
    struct Yj9557NFT has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Yj9557NFT{
            id        : 0x2::object::new(arg0),
            name      : 0x1::string::utf8(b"Yj9557 NFT"),
            image_url : 0x1::string::utf8(b"https://avatars.githubusercontent.com/u/203784388?v=4"),
        };
        0x2::transfer::transfer<Yj9557NFT>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun mint(arg0: 0x1::string::String, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Yj9557NFT{
            id        : 0x2::object::new(arg2),
            name      : 0x1::string::utf8(b"Yj9557 NFT"),
            image_url : arg0,
        };
        0x2::transfer::transfer<Yj9557NFT>(v0, arg1);
    }

    // decompiled from Move bytecode v6
}

