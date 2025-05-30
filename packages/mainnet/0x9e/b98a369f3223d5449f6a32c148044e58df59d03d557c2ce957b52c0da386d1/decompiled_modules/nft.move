module 0x9eb98a369f3223d5449f6a32c148044e58df59d03d557c2ce957b52c0da386d1::nft {
    struct NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        img_url: 0x2::url::Url,
        kind: 0x1::string::String,
        series: 0x1::string::String,
        number: 0x1::string::String,
        symbol: 0x1::string::String,
        image_url: 0x2::url::Url,
        ipfs_url: 0x2::url::Url,
    }

    struct NFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    public entry fun transfer(arg0: NFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<NFT>(arg0, arg1);
    }

    public fun description(arg0: &NFT) : &0x1::string::String {
        &arg0.description
    }

    public fun img_url(arg0: &NFT) : &0x2::url::Url {
        &arg0.img_url
    }

    public entry fun mint_to_sender(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg9);
        assert!(v0 == @0xc8008f590b556643edebfd9bd1ca9e64894007ad0536df70b0d845ff5d8db73 || v0 == @0x2e4c7fd751c91c9934e0311aa5441b43c4d2af06ad9e5b58c366784ce84914e2, 0);
        let v1 = NFT{
            id          : 0x2::object::new(arg9),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            img_url     : 0x2::url::new_unsafe_from_bytes(arg2),
            kind        : 0x1::string::utf8(arg3),
            series      : 0x1::string::utf8(arg4),
            number      : 0x1::string::utf8(arg5),
            symbol      : 0x1::string::utf8(arg6),
            image_url   : 0x2::url::new_unsafe_from_bytes(arg7),
            ipfs_url    : 0x2::url::new_unsafe_from_bytes(arg8),
        };
        let v2 = NFTMinted{
            object_id : 0x2::object::id<NFT>(&v1),
            creator   : v0,
            name      : v1.name,
        };
        0x2::event::emit<NFTMinted>(v2);
        0x2::transfer::transfer<NFT>(v1, v0);
    }

    public fun name(arg0: &NFT) : &0x1::string::String {
        &arg0.name
    }

    public entry fun update_description(arg0: &mut NFT, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.description = 0x1::string::utf8(arg1);
    }

    // decompiled from Move bytecode v6
}

