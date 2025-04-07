module 0x7d2351984d7d5b931d4e798318d46fdde4d459989fe03c1c15978f3e7d3e978e::nft_module {
    struct NFT has store, key {
        id: 0x2::object::UID,
        name: vector<u8>,
        description: vector<u8>,
        image_url: vector<u8>,
    }

    public fun mint_nft(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = NFT{
            id          : 0x2::object::new(arg4),
            name        : b"SherVite",
            description : arg1,
            image_url   : b"https://avatars.githubusercontent.com/u/201323230?v=4&size=64",
        };
        0x2::transfer::transfer<NFT>(v0, arg3);
    }

    // decompiled from Move bytecode v6
}

