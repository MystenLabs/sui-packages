module 0x5262b018ce1c42651af4db272ef8d2a5cd97b8b7dd1a44faa83e80cd90e0d579::batch_burn {
    struct SimpleNFT has store, key {
        id: 0x2::object::UID,
    }

    public fun burn_simple_nfts(arg0: vector<SimpleNFT>, arg1: &mut 0x2::tx_context::TxContext) {
        while (!0x1::vector::is_empty<SimpleNFT>(&arg0)) {
            let SimpleNFT { id: v0 } = 0x1::vector::pop_back<SimpleNFT>(&mut arg0);
            0x2::object::delete(v0);
        };
        0x1::vector::destroy_empty<SimpleNFT>(arg0);
    }

    // decompiled from Move bytecode v6
}

