module 0x3d38ebd42bd97da1c603781d4ec1ea1cd56821a32fb88530e68ee5d2844643c0::mynft {
    struct MySelfNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
    }

    struct NFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    public fun transfer(arg0: MySelfNFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<MySelfNFT>(arg0, arg1);
    }

    public fun url(arg0: &MySelfNFT) : &0x2::url::Url {
        &arg0.url
    }

    public fun description(arg0: &MySelfNFT) : &0x1::string::String {
        &arg0.description
    }

    public entry fun mint(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = MySelfNFT{
            id          : 0x2::object::new(arg3),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            url         : 0x2::url::new_unsafe_from_bytes(arg2),
        };
        let v2 = NFTMinted{
            object_id : 0x2::object::id<MySelfNFT>(&v1),
            creator   : v0,
            name      : v1.name,
        };
        0x2::event::emit<NFTMinted>(v2);
        0x2::transfer::public_transfer<MySelfNFT>(v1, v0);
    }

    public fun name(arg0: &MySelfNFT) : &0x1::string::String {
        &arg0.name
    }

    // decompiled from Move bytecode v6
}

