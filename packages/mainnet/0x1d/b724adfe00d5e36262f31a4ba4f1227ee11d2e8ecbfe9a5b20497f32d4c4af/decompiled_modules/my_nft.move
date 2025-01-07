module 0x1db724adfe00d5e36262f31a4ba4f1227ee11d2e8ecbfe9a5b20497f32d4c4af::my_nft {
    struct MyNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::ascii::String,
        description: 0x1::ascii::String,
        image_url: 0x2::url::Url,
    }

    public entry fun burn(arg0: MyNFT, arg1: &mut 0x2::tx_context::TxContext) {
        let MyNFT {
            id          : v0,
            name        : _,
            description : _,
            image_url   : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun description(arg0: &MyNFT) : 0x1::ascii::String {
        arg0.description
    }

    public fun image_url(arg0: &MyNFT) : 0x1::ascii::String {
        0x2::url::inner_url(&arg0.image_url)
    }

    public entry fun mint_to_address(arg0: address, arg1: 0x1::ascii::String, arg2: 0x1::ascii::String, arg3: 0x1::ascii::String, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = MyNFT{
            id          : 0x2::object::new(arg4),
            name        : arg1,
            description : arg2,
            image_url   : 0x2::url::new_unsafe(arg3),
        };
        0x2::transfer::transfer<MyNFT>(v0, arg0);
    }

    public entry fun mint_to_sender(arg0: 0x1::ascii::String, arg1: 0x1::ascii::String, arg2: 0x1::ascii::String, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = MyNFT{
            id          : 0x2::object::new(arg3),
            name        : arg0,
            description : arg1,
            image_url   : 0x2::url::new_unsafe(arg2),
        };
        0x2::transfer::transfer<MyNFT>(v0, 0x2::tx_context::sender(arg3));
    }

    public fun name(arg0: &MyNFT) : 0x1::ascii::String {
        arg0.name
    }

    // decompiled from Move bytecode v6
}

