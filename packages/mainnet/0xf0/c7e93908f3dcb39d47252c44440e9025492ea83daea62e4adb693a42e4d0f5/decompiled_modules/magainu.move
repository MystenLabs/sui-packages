module 0xf0c7e93908f3dcb39d47252c44440e9025492ea83daea62e4adb693a42e4d0f5::magainu {
    struct MAGAINU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAGAINU, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<MAGAINU>(arg0, 7722264449835165040, b"MAGA INU", b"MAGAINU", b"My name is MAGA!", b"https://images.hop.ag/ipfs/QmZixLpRRGUiJdxfoUyA3RS7RZUdEu7auLS3BVNuAVrMiS", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

