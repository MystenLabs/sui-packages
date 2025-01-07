module 0x4ce4bdd97297115dcc99f310c4639930d4e4e25a33b83614c0c0c530e14d1154::xushizhao_nft {
    struct XUSHiZHAO_NFT has store, key {
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

    public entry fun transfer(arg0: XUSHiZHAO_NFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<XUSHiZHAO_NFT>(arg0, arg1);
    }

    public entry fun mint_to_sender(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = XUSHiZHAO_NFT{
            id          : 0x2::object::new(arg3),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            url         : 0x2::url::new_unsafe_from_bytes(arg2),
        };
        let v2 = NFTMinted{
            object_id : 0x2::object::id<XUSHiZHAO_NFT>(&v1),
            creator   : v0,
            name      : v1.name,
        };
        0x2::event::emit<NFTMinted>(v2);
        0x2::transfer::public_transfer<XUSHiZHAO_NFT>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

