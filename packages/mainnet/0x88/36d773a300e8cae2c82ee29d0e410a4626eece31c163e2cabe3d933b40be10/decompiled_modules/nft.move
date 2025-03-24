module 0x8836d773a300e8cae2c82ee29d0e410a4626eece31c163e2cabe3d933b40be10::nft {
    struct BirdNFT has store, key {
        id: 0x2::object::UID,
        xid: u128,
        type: u16,
        sub_type: u16,
        rare: u16,
        value: u64,
    }

    public fun burn(arg0: BirdNFT) {
        let BirdNFT {
            id       : v0,
            xid      : _,
            type     : _,
            sub_type : _,
            rare     : _,
            value    : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun info(arg0: &BirdNFT) : (u128, u16, u16, u16, u64) {
        (arg0.xid, arg0.type, arg0.sub_type, arg0.rare, arg0.value)
    }

    // decompiled from Move bytecode v6
}

