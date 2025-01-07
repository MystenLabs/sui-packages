module 0x4cc17195ab82765727ab119af4e12dcd1769d82dc7cf7aefd23d9ef5f82f443d::pfff {
    struct PFFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: PFFF, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<PFFF>(arg0, 5123290285838595067, b"HONEY BADGER", b"PFFF", b"You wanna fuck with me? Okay. You wanna play rough? Okay. Say hello to my little friend!", b"https://images.hop.ag/ipfs/QmfDEy6nyLvbqLJUJHQHeAFxTMFmMPm6DeJZxcruNQtewL", 0x1::string::utf8(b"https://x.com/PFFF_SUI"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

