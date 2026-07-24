module 0x126e82e8a0cde2b56e27f7d1a0e0944056ab5360f08cfc9f7e4469789b1be4cd::immutable_nft {
    struct ImmutableNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
    }

    struct NFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        name: 0x1::string::String,
    }

    public fun mint_immutable(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = ImmutableNFT{
            id          : 0x2::object::new(arg3),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            url         : 0x2::url::new_unsafe_from_bytes(arg2),
        };
        let v1 = NFTMinted{
            object_id : 0x2::object::id<ImmutableNFT>(&v0),
            name      : v0.name,
        };
        0x2::event::emit<NFTMinted>(v1);
        0x2::transfer::public_freeze_object<ImmutableNFT>(v0);
    }

    // decompiled from Move bytecode v7
}

