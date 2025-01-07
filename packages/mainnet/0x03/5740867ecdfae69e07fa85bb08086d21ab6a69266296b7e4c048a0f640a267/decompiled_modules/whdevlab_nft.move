module 0x35740867ecdfae69e07fa85bb08086d21ab6a69266296b7e4c048a0f640a267::whdevlab_nft {
    struct WHDEVLAB_NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
    }

    struct WHDEVLAB_NFT_EVENT has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    struct WHDEVLAB_NFT_TRANSFER_EVENT has copy, drop {
        object_id: 0x2::object::ID,
        from: address,
        to: address,
    }

    struct WHDEVLAB_NFT_BURN_EVENT has copy, drop {
        object_id: 0x2::object::ID,
    }

    public fun url(arg0: &WHDEVLAB_NFT) : 0x2::url::Url {
        arg0.url
    }

    public entry fun burn(arg0: WHDEVLAB_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let WHDEVLAB_NFT {
            id          : v0,
            name        : _,
            description : _,
            url         : _,
        } = arg0;
        let v4 = v0;
        let v5 = WHDEVLAB_NFT_BURN_EVENT{object_id: 0x2::object::uid_to_inner(&v4)};
        0x2::event::emit<WHDEVLAB_NFT_BURN_EVENT>(v5);
        0x2::object::delete(v4);
    }

    public fun description(arg0: &WHDEVLAB_NFT) : 0x1::string::String {
        arg0.description
    }

    public entry fun mint_nft(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = WHDEVLAB_NFT{
            id          : 0x2::object::new(arg3),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            url         : 0x2::url::new_unsafe_from_bytes(arg2),
        };
        let v2 = WHDEVLAB_NFT_EVENT{
            object_id : 0x2::object::id<WHDEVLAB_NFT>(&v1),
            creator   : v0,
            name      : v1.name,
        };
        0x2::event::emit<WHDEVLAB_NFT_EVENT>(v2);
        0x2::transfer::public_transfer<WHDEVLAB_NFT>(v1, v0);
    }

    public fun name(arg0: &WHDEVLAB_NFT) : 0x1::string::String {
        arg0.name
    }

    public entry fun transfer_nft(arg0: WHDEVLAB_NFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = WHDEVLAB_NFT_TRANSFER_EVENT{
            object_id : 0x2::object::id<WHDEVLAB_NFT>(&arg0),
            from      : 0x2::tx_context::sender(arg2),
            to        : arg1,
        };
        0x2::event::emit<WHDEVLAB_NFT_TRANSFER_EVENT>(v0);
        0x2::transfer::public_transfer<WHDEVLAB_NFT>(arg0, arg1);
    }

    public entry fun update_description(arg0: &mut WHDEVLAB_NFT, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.description = 0x1::string::utf8(arg1);
    }

    // decompiled from Move bytecode v6
}

