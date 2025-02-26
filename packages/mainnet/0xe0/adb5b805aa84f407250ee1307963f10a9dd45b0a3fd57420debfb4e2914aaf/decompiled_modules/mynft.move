module 0xe0adb5b805aa84f407250ee1307963f10a9dd45b0a3fd57420debfb4e2914aaf::mynft {
    struct NFT has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        link: 0x1::string::String,
        image_url: 0x1::string::String,
        description: 0x1::string::String,
    }

    public entry fun mint_nft(arg0: address, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = NFT{
            id          : 0x2::object::new(arg4),
            name        : arg1,
            link        : arg2,
            image_url   : arg2,
            description : arg3,
        };
        0x2::transfer::transfer<NFT>(v0, arg0);
    }

    // decompiled from Move bytecode v6
}

