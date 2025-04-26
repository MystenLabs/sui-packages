module 0x4ed6c454a8d2cc9d37535ce7d59c2a1584591e0dc331ad7783c8e0f939f55b50::nft_mint {
    struct Nft has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x1::string::String,
        creator: address,
    }

    struct NftDisplay has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        creator: address,
    }

    struct Dummy has store, key {
        id: 0x2::object::UID,
    }

    public entry fun create_dummy(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Dummy{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<Dummy>(v0, 0x2::tx_context::sender(arg0));
    }

    fun mint(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) : Nft {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = Nft{
            id          : 0x2::object::new(arg3),
            name        : 0x1::string::utf8(*0x1::string::as_bytes(&arg0)),
            description : 0x1::string::utf8(*0x1::string::as_bytes(&arg1)),
            url         : 0x1::string::utf8(*0x1::string::as_bytes(&arg2)),
            creator     : v0,
        };
        let v2 = NftDisplay{
            id          : 0x2::object::new(arg3),
            name        : arg0,
            description : arg1,
            image_url   : arg2,
            creator     : v0,
        };
        0x2::transfer::public_transfer<NftDisplay>(v2, v0);
        v1
    }

    public entry fun mint_and_send(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<Nft>(mint(arg0, arg1, arg2, arg4), arg3);
    }

    public entry fun test_dummy_object(arg0: &Dummy, arg1: &mut 0x2::tx_context::TxContext) {
    }

    // decompiled from Move bytecode v6
}

