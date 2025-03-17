module 0x8f795db8ad8fe3779be9a62254ceeb075e2cc2d135e2f737557256459870048d::nft {
    struct NFT has store, key {
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

    public entry fun mint_to_address(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = NFT{
            id          : 0x2::object::new(arg4),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            url         : 0x2::url::new_unsafe_from_bytes(arg2),
        };
        let v1 = NFTMinted{
            object_id : 0x2::object::id<NFT>(&v0),
            creator   : 0x2::tx_context::sender(arg4),
            name      : v0.name,
        };
        0x2::event::emit<NFTMinted>(v1);
        0x2::transfer::public_transfer<NFT>(v0, arg3);
    }

    // decompiled from Move bytecode v6
}

