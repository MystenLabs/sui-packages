module 0xe2a826be5579eeaca41b25be8e32550622ec4f709c0b1cc9150464c72261f1b3::slhs_nft {
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

