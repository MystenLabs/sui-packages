module 0x1679c198fafcf215d821d35fe88570813ac3cc91404d4644439ed2999e071524::fibl {
    struct FIBL has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIBL, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<FIBL>(arg0, 6770803152724320635, b"FIBLU", b"FIBL", b"FIBL", b"https://images.hop.ag/ipfs/QmaPvEXoERWVvL7pBvC55ow8okgXtkVhVdVKYVbcsokChk", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"https://t.me/fiblsui"), arg1);
    }

    // decompiled from Move bytecode v6
}

