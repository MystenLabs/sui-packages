module 0xd898a50defaddfff78197f864fde5a101eb3729484c0ea8bf088b4c1b53fe5b9::bbull {
    struct BBULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBULL, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<BBULL>(arg0, 14017078186894834392, b"BLUE BULL", b"BBULL", x"4d65657420426c75652042756c6c2c2074686520756e73746f707061626c652063727970746f20666f726365206f6e2074686520535549204e6574776f726b2e20496620796f75e28099726520726561647920746f20726964652c207468656e20426c75652042756c6c20697320796f75722067757921", b"https://images.hop.ag/ipfs/QmZCCpU9PMobuzBX9sNa9pXKeFktyhD8b27xdtXbjYDtTj", 0x1::string::utf8(b"https://x.com/BBullSui"), 0x1::string::utf8(b"https://bluebull.one/"), 0x1::string::utf8(b"https://t.me/BBullSui"), arg1);
    }

    // decompiled from Move bytecode v6
}

