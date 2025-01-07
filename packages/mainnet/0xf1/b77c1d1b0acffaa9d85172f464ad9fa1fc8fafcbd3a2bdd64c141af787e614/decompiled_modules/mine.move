module 0xf1b77c1d1b0acffaa9d85172f464ad9fa1fc8fafcbd3a2bdd64c141af787e614::mine {
    struct MINE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MINE, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<MINE>(arg0, 10450464276406393185, b"Minecraft", b"MINE", b"MINCRAFT IT'S MY LIFE!!", b"https://images.hop.ag/ipfs/QmdjapCt9NYQs86aznLuuBJjwtkhKrSD6rnt1fHR2aq9uu", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

