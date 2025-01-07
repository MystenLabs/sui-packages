module 0x40e4bc6f73c58b1c548f5d7e68a6ba88bc46ad1ad0e0225716d83d72d7a9fd4d::kang_nft {
    struct KangNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        url: 0x2::url::Url,
    }

    struct ENFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    struct ENFTTransferred has copy, drop {
        object_id: 0x2::object::ID,
        from: address,
        to: address,
    }

    public fun transfer(arg0: KangNFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = ENFTTransferred{
            object_id : 0x2::object::id<KangNFT>(&arg0),
            from      : 0x2::tx_context::sender(arg2),
            to        : arg1,
        };
        0x2::event::emit<ENFTTransferred>(v0);
        0x2::transfer::public_transfer<KangNFT>(arg0, arg1);
    }

    public fun url(arg0: &KangNFT) : &0x2::url::Url {
        &arg0.url
    }

    public fun mint(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = KangNFT{
            id   : 0x2::object::new(arg2),
            name : 0x1::string::utf8(arg0),
            url  : 0x2::url::new_unsafe_from_bytes(arg1),
        };
        let v1 = 0x2::tx_context::sender(arg2);
        let v2 = ENFTMinted{
            object_id : 0x2::object::id<KangNFT>(&v0),
            creator   : v1,
            name      : v0.name,
        };
        0x2::event::emit<ENFTMinted>(v2);
        0x2::transfer::public_transfer<KangNFT>(v0, v1);
    }

    public fun name(arg0: &KangNFT) : &0x1::string::String {
        &arg0.name
    }

    // decompiled from Move bytecode v6
}

