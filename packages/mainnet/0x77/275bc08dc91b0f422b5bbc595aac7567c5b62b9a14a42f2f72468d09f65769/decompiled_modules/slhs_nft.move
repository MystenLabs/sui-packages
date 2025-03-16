module 0x77275bc08dc91b0f422b5bbc595aac7567c5b62b9a14a42f2f72468d09f65769::slhs_nft {
    struct NFT has store, key {
        id: 0x2::object::UID,
        name: vector<u8>,
        description: vector<u8>,
        image_url: vector<u8>,
    }

    public entry fun mint(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = NFT{
            id          : 0x2::object::new(arg4),
            name        : arg0,
            description : arg1,
            image_url   : arg2,
        };
        0x2::transfer::transfer<NFT>(v0, arg3);
    }

    // decompiled from Move bytecode v6
}

