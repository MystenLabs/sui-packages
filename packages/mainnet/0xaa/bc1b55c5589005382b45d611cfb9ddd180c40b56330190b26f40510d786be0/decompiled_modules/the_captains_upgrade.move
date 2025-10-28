module 0xaabc1b55c5589005382b45d611cfb9ddd180c40b56330190b26f40510d786be0::the_captains_upgrade {
    struct PfpNFT has store, key {
        id: 0x2::object::UID,
        token_id: u64,
    }

    public fun burn_nft(arg0: PfpNFT) {
        let PfpNFT {
            id       : v0,
            token_id : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    // decompiled from Move bytecode v6
}

