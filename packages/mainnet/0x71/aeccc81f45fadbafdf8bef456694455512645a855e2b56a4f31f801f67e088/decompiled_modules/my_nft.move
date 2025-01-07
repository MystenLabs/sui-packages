module 0x71aeccc81f45fadbafdf8bef456694455512645a855e2b56a4f31f801f67e088::my_nft {
    struct MyNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
    }

    struct EMyNFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    struct EMyNFTTransferred has copy, drop {
        object_id: 0x2::object::ID,
        from: address,
        to: address,
    }

    struct EMyNFTBurnt has copy, drop {
        object_id: 0x2::object::ID,
    }

    public fun transfer(arg0: MyNFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = EMyNFTTransferred{
            object_id : 0x2::object::id<MyNFT>(&arg0),
            from      : 0x2::tx_context::sender(arg2),
            to        : arg1,
        };
        0x2::event::emit<EMyNFTTransferred>(v0);
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
        let v4 = v0;
        let v5 = EMyNFTBurnt{object_id: 0x2::object::uid_to_inner(&v4)};
        0x2::event::emit<EMyNFTBurnt>(v5);
        0x2::object::delete(v4);
    }

    public fun description(arg0: &MyNFT) : &0x1::string::String {
        &arg0.description
    }

    public fun mint(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = MyNFT{
            id          : 0x2::object::new(arg3),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            url         : 0x2::url::new_unsafe_from_bytes(arg2),
        };
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = EMyNFTMinted{
            object_id : 0x2::object::id<MyNFT>(&v0),
            creator   : v1,
            name      : v0.name,
        };
        0x2::event::emit<EMyNFTMinted>(v2);
        0x2::transfer::public_transfer<MyNFT>(v0, v1);
    }

    public fun name(arg0: &MyNFT) : &0x1::string::String {
        &arg0.name
    }

    public fun update_description(arg0: &mut MyNFT, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.description = 0x1::string::utf8(arg1);
    }

    // decompiled from Move bytecode v6
}

