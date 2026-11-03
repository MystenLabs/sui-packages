module 0x47c835b521b48763d916be0a22d195734ca56b1f0c6fc16ae9545ce9db3f177e::mynft {
    struct MyNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
    }

    public fun transfer(arg0: MyNFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<MyNFT>(arg0, arg1);
    }

    public fun url(arg0: &MyNFT) : &0x2::url::Url {
        &arg0.url
    }

    public fun burn(arg0: MyNFT, arg1: &mut 0x2::tx_context::TxContext) {
        let MyNFT {
            id          : v0,
            name        : _,
            description : _,
            url         : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun description(arg0: &MyNFT) : &0x1::string::String {
        &arg0.description
    }

    public fun mint_to(arg0: address, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = MyNFT{
            id          : 0x2::object::new(arg4),
            name        : 0x1::string::utf8(arg1),
            description : 0x1::string::utf8(arg2),
            url         : 0x2::url::new_unsafe_from_bytes(arg3),
        };
        0x2::transfer::public_transfer<MyNFT>(v0, arg0);
    }

    public fun mint_to_sender(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = MyNFT{
            id          : 0x2::object::new(arg3),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            url         : 0x2::url::new_unsafe_from_bytes(arg2),
        };
        0x2::transfer::public_transfer<MyNFT>(v0, 0x2::tx_context::sender(arg3));
    }

    public fun name(arg0: &MyNFT) : &0x1::string::String {
        &arg0.name
    }

    // decompiled from Move bytecode v7
}

