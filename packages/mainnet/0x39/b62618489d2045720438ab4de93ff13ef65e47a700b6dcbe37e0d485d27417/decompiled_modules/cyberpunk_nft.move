module 0x39b62618489d2045720438ab4de93ff13ef65e47a700b6dcbe37e0d485d27417::cyberpunk_nft {
    struct CyberPunkNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
        is_burnable: bool,
    }

    struct NFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
        url: 0x2::url::Url,
    }

    public entry fun burn(arg0: CyberPunkNFT, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.is_burnable, 0);
        let CyberPunkNFT {
            id          : v0,
            name        : _,
            description : _,
            url         : _,
            is_burnable : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public entry fun mint(arg0: vector<u8>, arg1: vector<u8>, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = CyberPunkNFT{
            id          : 0x2::object::new(arg3),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            url         : 0x2::url::new_unsafe_from_bytes(b"https://cyberpunkcat.s3.ap-southeast-1.amazonaws.com/0051.png"),
            is_burnable : arg2,
        };
        let v2 = NFTMinted{
            object_id : 0x2::object::id<CyberPunkNFT>(&v1),
            creator   : v0,
            name      : v1.name,
            url       : v1.url,
        };
        0x2::event::emit<NFTMinted>(v2);
        0x2::transfer::transfer<CyberPunkNFT>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

