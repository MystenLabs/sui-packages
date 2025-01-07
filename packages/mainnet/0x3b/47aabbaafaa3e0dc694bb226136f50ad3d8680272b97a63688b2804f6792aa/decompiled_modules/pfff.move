module 0x3b47aabbaafaa3e0dc694bb226136f50ad3d8680272b97a63688b2804f6792aa::pfff {
    struct PFFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: PFFF, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<PFFF>(arg0, 14926728228097120957, b"HONEY BADGER", b"PFFF", b"You wanna fuck with me? Okay. You wanna play rough? Okay. Say hello to my little friend!", b"https://images.hop.ag/ipfs/QmfDEy6nyLvbqLJUJHQHeAFxTMFmMPm6DeJZxcruNQtewL", 0x1::string::utf8(b"https://x.com/PFFF_SUI"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

