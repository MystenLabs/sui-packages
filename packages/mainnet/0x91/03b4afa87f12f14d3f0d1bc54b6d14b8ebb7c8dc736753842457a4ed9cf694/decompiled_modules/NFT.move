module 0x9103b4afa87f12f14d3f0d1bc54b6d14b8ebb7c8dc736753842457a4ed9cf694::NFT {
    struct NFT has key {
        id: 0x2::object::UID,
        owner: address,
        benefits: 0x2::vec_map::VecMap<0x1::string::String, u8>,
    }

    public fun create_nft(arg0: &mut 0x2::tx_context::TxContext, arg1: address, arg2: 0x2::vec_map::VecMap<0x1::string::String, u8>) {
        let v0 = NFT{
            id       : 0x2::object::new(arg0),
            owner    : arg1,
            benefits : arg2,
        };
        0x2::transfer::transfer<NFT>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun transfer_nft(arg0: &mut NFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.owner = arg1;
    }

    // decompiled from Move bytecode v6
}

