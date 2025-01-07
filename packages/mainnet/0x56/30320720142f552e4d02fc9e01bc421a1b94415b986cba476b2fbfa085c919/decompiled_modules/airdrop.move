module 0x5630320720142f552e4d02fc9e01bc421a1b94415b986cba476b2fbfa085c919::airdrop {
    struct NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    public entry fun transfer(arg0: NFT, arg1: address) {
        0x2::transfer::transfer<NFT>(arg0, arg1);
    }

    public entry fun mint(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = NFT{
            id          : 0x2::object::new(arg4),
            name        : arg0,
            description : arg1,
            image_url   : arg2,
        };
        0x2::transfer::public_transfer<NFT>(v0, arg3);
    }

    // decompiled from Move bytecode v6
}

