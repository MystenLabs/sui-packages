module 0x5daa386d9c9aeeae196071a16f066cd76512044794841afdd83739e2aefafbd1::burn_any {
    struct PfpNFT has store, key {
        id: 0x2::object::UID,
        token_id: u64,
    }

    public fun burn_pfp_nft_completely(arg0: PfpNFT) {
        let PfpNFT {
            id       : v0,
            token_id : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    // decompiled from Move bytecode v6
}

