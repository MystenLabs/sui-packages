module 0x3dcd37e8c8038be1d22fc676147da4cf45c4fbbca912532bf27874239c2d9b59::minimal_nft {
    struct MinimalNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
    }

    public fun mint_to(arg0: 0x1::string::String, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = MinimalNFT{
            id   : 0x2::object::new(arg2),
            name : arg0,
        };
        0x2::transfer::public_transfer<MinimalNFT>(v0, arg1);
    }

    public fun mint_to_sender(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = MinimalNFT{
            id   : 0x2::object::new(arg1),
            name : arg0,
        };
        0x2::transfer::public_transfer<MinimalNFT>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun name(arg0: &MinimalNFT) : &0x1::string::String {
        &arg0.name
    }

    // decompiled from Move bytecode v7
}

