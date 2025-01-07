module 0xaf55134544dc078b194b6afcd84790c2e7fbb3274dd49ceea4c7beb1012dc31::pfff {
    struct PFFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: PFFF, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<PFFF>(arg0, 18288493705853390685, b"HONEY BADGER", b"PFFF", b"You wanna fuck with me? Okay. You wanna play rough? Okay. Say hello to my little friend!", b"https://images.hop.ag/ipfs/QmfDEy6nyLvbqLJUJHQHeAFxTMFmMPm6DeJZxcruNQtewL", 0x1::string::utf8(b"https://x.com/PFFF_SUI"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

