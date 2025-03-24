module 0x8ea46045eac523380788958e34a90c6d025300b965cd0bbd333b969b09ee3b9a::birds_nft {
    struct BirdNFT has store, key {
        id: 0x2::object::UID,
        xid: u64,
        type: u8,
        sub_type: u8,
    }

    public fun info(arg0: &BirdNFT) : (u64, u8, u8) {
        (arg0.xid, arg0.type, arg0.sub_type)
    }

    // decompiled from Move bytecode v6
}

