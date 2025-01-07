module 0xf2ff2aa355b94f3bb4f0f4781d7c4df708002192d27c7e84ae509fd3a0889de0::jmagiccnft {
    struct JmagiccNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
        ex_param: 0x1::string::String,
    }

    struct NFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    public entry fun transfer(arg0: JmagiccNFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<JmagiccNFT>(arg0, arg1);
    }

    public fun url(arg0: &JmagiccNFT) : &0x2::url::Url {
        &arg0.url
    }

    public entry fun burn(arg0: JmagiccNFT, arg1: &mut 0x2::tx_context::TxContext) {
        let JmagiccNFT {
            id          : v0,
            name        : _,
            description : _,
            url         : _,
            ex_param    : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun description(arg0: &JmagiccNFT) : &0x1::string::String {
        &arg0.description
    }

    public entry fun mint_ntf(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::ascii::string(b"mint ntf");
        0x1::debug::print<0x1::ascii::String>(&v0);
        let v1 = 0x2::tx_context::sender(arg0);
        let v2 = JmagiccNFT{
            id          : 0x2::object::new(arg0),
            name        : 0x1::string::utf8(b"Jmagicc NTF"),
            description : 0x1::string::utf8(b"This is the description of Jmagicc NTF"),
            url         : 0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/58356228"),
            ex_param    : 0x1::string::utf8(b"ex param"),
        };
        let v3 = NFTMinted{
            object_id : 0x2::object::id<JmagiccNFT>(&v2),
            creator   : v1,
            name      : v2.name,
        };
        0x2::event::emit<NFTMinted>(v3);
        0x2::transfer::public_transfer<JmagiccNFT>(v2, v1);
    }

    public entry fun mint_to_sender(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = JmagiccNFT{
            id          : 0x2::object::new(arg4),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            url         : 0x2::url::new_unsafe_from_bytes(arg2),
            ex_param    : 0x1::string::utf8(arg3),
        };
        let v2 = NFTMinted{
            object_id : 0x2::object::id<JmagiccNFT>(&v1),
            creator   : v0,
            name      : v1.name,
        };
        0x2::event::emit<NFTMinted>(v2);
        0x2::transfer::public_transfer<JmagiccNFT>(v1, v0);
    }

    public fun name(arg0: &JmagiccNFT) : &0x1::string::String {
        &arg0.name
    }

    public entry fun update_description(arg0: &mut JmagiccNFT, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.description = 0x1::string::utf8(arg1);
    }

    // decompiled from Move bytecode v6
}

