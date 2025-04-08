module 0x2f9c499aad6ab171955146a76914d68ba1441ef89557a45d0d61b496baa2f70e::nft_module {
    struct NFT has store, key {
        id: 0x2::object::UID,
        name: vector<u8>,
        description: vector<u8>,
        image_url: vector<u8>,
    }

    public entry fun mint_nft(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
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

