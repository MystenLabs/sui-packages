module 0xae2f1365b8411e3b8f48714806f812d1f0c0beb1a208d163226540bab280baaa::slhs_nft {
    struct NFT has store, key {
        id: 0x2::object::UID,
        metadata_uri: vector<u8>,
    }

    public entry fun mint(arg0: vector<u8>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = NFT{
            id           : 0x2::object::new(arg2),
            metadata_uri : arg0,
        };
        0x2::transfer::transfer<NFT>(v0, arg1);
    }

    // decompiled from Move bytecode v6
}

