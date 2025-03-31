module 0xed1b315462f15c03dfcd21e5bc3824844cd05d5d563be190dcb12a450d3c83c0::aquamint_nft {
    struct AquamintNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
    }

    struct NFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    public fun description(arg0: &AquamintNFT) : &0x1::string::String {
        &arg0.description
    }

    public fun image_url(arg0: &AquamintNFT) : &0x2::url::Url {
        &arg0.image_url
    }

    public entry fun mint_aquamint_nft(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = AquamintNFT{
            id          : 0x2::object::new(arg3),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            image_url   : 0x2::url::new_unsafe_from_bytes(arg2),
        };
        let v2 = NFTMinted{
            object_id : 0x2::object::id<AquamintNFT>(&v1),
            creator   : v0,
            name      : v1.name,
        };
        0x2::event::emit<NFTMinted>(v2);
        0x2::transfer::public_transfer<AquamintNFT>(v1, v0);
    }

    public fun name(arg0: &AquamintNFT) : &0x1::string::String {
        &arg0.name
    }

    // decompiled from Move bytecode v6
}

