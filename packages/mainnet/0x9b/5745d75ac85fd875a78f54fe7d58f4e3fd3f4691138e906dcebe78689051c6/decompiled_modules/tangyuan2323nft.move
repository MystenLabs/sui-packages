module 0x9b5745d75ac85fd875a78f54fe7d58f4e3fd3f4691138e906dcebe78689051c6::tangyuan2323nft {
    struct TANGYUAN2323NFT has store, key {
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

    struct NFTTransfered has copy, drop {
        object_id: 0x2::object::ID,
        from: address,
        to: address,
    }

    struct NftBurn has copy, drop {
        object_id: 0x2::object::ID,
    }

    public fun transfer(arg0: TANGYUAN2323NFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = NFTTransfered{
            object_id : 0x2::object::id<TANGYUAN2323NFT>(&arg0),
            from      : 0x2::tx_context::sender(arg2),
            to        : arg1,
        };
        0x2::event::emit<NFTTransfered>(v0);
        0x2::transfer::public_transfer<TANGYUAN2323NFT>(arg0, arg1);
    }

    public fun url(arg0: &TANGYUAN2323NFT) : &0x2::url::Url {
        &arg0.url
    }

    public fun burn(arg0: TANGYUAN2323NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let TANGYUAN2323NFT {
            id          : v0,
            name        : _,
            description : _,
            url         : _,
        } = arg0;
        let v4 = v0;
        let v5 = NftBurn{object_id: 0x2::object::uid_to_inner(&v4)};
        0x2::event::emit<NftBurn>(v5);
        0x2::object::delete(v4);
    }

    public fun description(arg0: &TANGYUAN2323NFT) : &0x1::string::String {
        &arg0.description
    }

    public fun mint(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = TANGYUAN2323NFT{
            id          : 0x2::object::new(arg0),
            name        : 0x1::string::utf8(b"0x4E33"),
            description : 0x1::string::utf8(b"my first nft series"),
            url         : 0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/70282618?v=4"),
        };
        let v2 = NFTMinted{
            object_id : 0x2::object::id<TANGYUAN2323NFT>(&v1),
            creator   : v0,
            name      : v1.name,
        };
        0x2::event::emit<NFTMinted>(v2);
        0x2::transfer::public_transfer<TANGYUAN2323NFT>(v1, v0);
    }

    public fun mint_to(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = TANGYUAN2323NFT{
            id          : 0x2::object::new(arg1),
            name        : 0x1::string::utf8(b"TANGYUAN2323NFT"),
            description : 0x1::string::utf8(b"my first nft"),
            url         : 0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/70282618?v=4"),
        };
        0x2::transfer::public_transfer<TANGYUAN2323NFT>(v0, arg0);
    }

    public fun name(arg0: &TANGYUAN2323NFT) : &0x1::string::String {
        &arg0.name
    }

    public fun update_description(arg0: &mut TANGYUAN2323NFT, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.description = 0x1::string::utf8(arg1);
    }

    // decompiled from Move bytecode v6
}

