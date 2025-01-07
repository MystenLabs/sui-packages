module 0x9b0090de2b8dd31e529ab3e58d4808b2bcc4468178f0b003466b7836fbcab0ab::ducky {
    struct DUCKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUCKY, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<DUCKY>(arg0, 9508609371576906542, b"Ducky", b"DUCKY", b"SUI Rich Ducks meme", b"https://images.hop.ag/ipfs/QmWrS7RWj4Wx16s6Jg6ApqGRxCmchNVMeidZvS2zrgdSqk", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

