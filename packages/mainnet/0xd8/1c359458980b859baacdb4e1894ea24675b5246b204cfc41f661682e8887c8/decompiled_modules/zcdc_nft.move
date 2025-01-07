module 0xd81c359458980b859baacdb4e1894ea24675b5246b204cfc41f661682e8887c8::zcdc_nft {
    struct ZCDCNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
    }

    struct ZCDCNFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
    }

    public entry fun transfer(arg0: ZCDCNFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<ZCDCNFT>(arg0, arg1);
    }

    public entry fun burn(arg0: ZCDCNFT, arg1: &mut 0x2::tx_context::TxContext) {
        let ZCDCNFT {
            id          : v0,
            name        : _,
            description : _,
            url         : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public entry fun mint(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = ZCDCNFT{
            id          : 0x2::object::new(arg0),
            name        : 0x1::string::utf8(b"zcdc nft"),
            description : 0x1::string::utf8(b"zcdc nft"),
            url         : 0x2::url::new_unsafe_from_bytes(b"https://aggregator.walrus-testnet.walrus.space/v1/_4ApAD7Xujmz6YxCKIdvYf-mXa0x050LqV93qTm4Q20"),
        };
        let v2 = ZCDCNFTMinted{
            object_id   : 0x2::object::id<ZCDCNFT>(&v1),
            creator     : v0,
            name        : v1.name,
            description : v1.description,
            url         : v1.url,
        };
        0x2::event::emit<ZCDCNFTMinted>(v2);
        0x2::transfer::public_transfer<ZCDCNFT>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

