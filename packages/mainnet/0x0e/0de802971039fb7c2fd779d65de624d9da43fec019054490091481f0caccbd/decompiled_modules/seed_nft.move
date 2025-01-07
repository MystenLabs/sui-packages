module 0xe0de802971039fb7c2fd779d65de624d9da43fec019054490091481f0caccbd::seed_nft {
    struct SeedNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
        nft_url: 0x2::url::Url,
    }

    struct NFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    public fun transfer(arg0: SeedNFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<SeedNFT>(arg0, arg1);
    }

    public fun url(arg0: &SeedNFT) : &0x2::url::Url {
        &arg0.url
    }

    public fun burn(arg0: SeedNFT, arg1: &mut 0x2::tx_context::TxContext) {
        let SeedNFT {
            id          : v0,
            name        : _,
            description : _,
            url         : _,
            nft_url     : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun description(arg0: &SeedNFT) : &0x1::string::String {
        &arg0.description
    }

    public fun mint_to_sender(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = SeedNFT{
            id          : 0x2::object::new(arg4),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            url         : 0x2::url::new_unsafe_from_bytes(arg2),
            nft_url     : 0x2::url::new_unsafe_from_bytes(arg3),
        };
        let v2 = NFTMinted{
            object_id : 0x2::object::id<SeedNFT>(&v1),
            creator   : v0,
            name      : v1.name,
        };
        0x2::event::emit<NFTMinted>(v2);
        0x2::transfer::public_transfer<SeedNFT>(v1, v0);
    }

    public fun name(arg0: &SeedNFT) : &0x1::string::String {
        &arg0.name
    }

    public fun nft_url(arg0: &SeedNFT) : &0x2::url::Url {
        &arg0.nft_url
    }

    public fun update_description(arg0: &mut SeedNFT, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.description = 0x1::string::utf8(arg1);
    }

    // decompiled from Move bytecode v6
}

