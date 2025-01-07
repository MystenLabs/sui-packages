module 0xd274bf8a1ad63e7969ac9f653c2017c684e3a3762dff2bd48d7c5b7796a4263a::mynft {
    struct MyNFT has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MyNFT{
            id        : 0x2::object::new(arg0),
            name      : 0x1::string::utf8(b"linqining"),
            image_url : 0x1::string::utf8(b"https://avatars.githubusercontent.com/u/18323181?s=400&u=1a7a274db375e0ffe9f303939d3283c5cedc1e25&v=4"),
        };
        0x2::transfer::transfer<MyNFT>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun mint(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = MyNFT{
            id        : 0x2::object::new(arg1),
            name      : 0x1::string::utf8(b"linqining"),
            image_url : arg0,
        };
        0x2::transfer::transfer<MyNFT>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

