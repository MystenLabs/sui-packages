module 0xaabc1b55c5589005382b45d611cfb9ddd180c40b56330190b26f40510d786be0::burn_any {
    struct PfpNFT has store, key {
        id: 0x2::object::UID,
        token_id: u64,
    }

    public fun burn_any_object<T0: store + key>(arg0: T0) {
        0x2::transfer::public_transfer<T0>(arg0, @0x0);
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

