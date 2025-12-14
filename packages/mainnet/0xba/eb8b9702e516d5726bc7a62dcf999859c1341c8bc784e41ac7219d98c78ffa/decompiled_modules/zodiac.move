module 0xbaeb8b9702e516d5726bc7a62dcf999859c1341c8bc784e41ac7219d98c78ffa::zodiac {
    struct ZodiacNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        metadata_url: 0x1::string::String,
    }

    struct ZodiacNFTMinted has copy, drop {
        nft_id: address,
        name: 0x1::string::String,
        creator: address,
    }

    public fun get_description(arg0: &ZodiacNFT) : &0x1::string::String {
        &arg0.description
    }

    public fun get_metadata_url(arg0: &ZodiacNFT) : &0x1::string::String {
        &arg0.metadata_url
    }

    public fun get_name(arg0: &ZodiacNFT) : &0x1::string::String {
        &arg0.name
    }

    public fun mint(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::object::new(arg3);
        let v2 = ZodiacNFT{
            id           : v1,
            name         : arg0,
            description  : arg1,
            metadata_url : arg2,
        };
        let v3 = ZodiacNFTMinted{
            nft_id  : 0x2::object::uid_to_address(&v1),
            name    : arg0,
            creator : v0,
        };
        0x2::event::emit<ZodiacNFTMinted>(v3);
        0x2::transfer::transfer<ZodiacNFT>(v2, v0);
    }

    // decompiled from Move bytecode v6
}

