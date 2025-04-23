module 0xf815febc68f6e5ee98df25b180f461ead6bee623a6f8e4a19480580cdea6d48c::nft_mint {
    struct NFT has store, key {
        id: 0x2::object::UID,
        name: vector<u8>,
        description: vector<u8>,
        url: vector<u8>,
        creator: address,
    }

    public fun mint(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) : NFT {
        NFT{
            id          : 0x2::object::new(arg3),
            name        : arg0,
            description : arg1,
            url         : arg2,
            creator     : 0x2::tx_context::sender(arg3),
        }
    }

    public entry fun mint_and_send(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<NFT>(mint(arg0, arg1, arg2, arg4), arg3);
    }

    // decompiled from Move bytecode v6
}

