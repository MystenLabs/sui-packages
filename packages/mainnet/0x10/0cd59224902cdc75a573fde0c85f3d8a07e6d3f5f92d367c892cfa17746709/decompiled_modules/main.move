module 0x100cd59224902cdc75a573fde0c85f3d8a07e6d3f5f92d367c892cfa17746709::main {
    struct NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    struct ClaimTracker has store, key {
        id: 0x2::object::UID,
        claimed: 0x2::vec_map::VecMap<address, bool>,
    }

    public entry fun initialize(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ClaimTracker{
            id      : 0x2::object::new(arg0),
            claimed : 0x2::vec_map::empty<address, bool>(),
        };
        0x2::transfer::public_share_object<ClaimTracker>(v0);
    }

    public entry fun mint_nft(arg0: &mut ClaimTracker, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(!0x2::vec_map::contains<address, bool>(&arg0.claimed, &v0), 0);
        let v1 = NFT{
            id        : 0x2::object::new(arg3),
            name      : 0x1::string::utf8(arg1),
            image_url : 0x1::string::utf8(arg2),
        };
        0x2::vec_map::insert<address, bool>(&mut arg0.claimed, v0, true);
        0x2::transfer::public_transfer<NFT>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

