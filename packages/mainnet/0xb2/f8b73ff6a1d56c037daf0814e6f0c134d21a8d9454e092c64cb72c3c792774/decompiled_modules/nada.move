module 0xb2f8b73ff6a1d56c037daf0814e6f0c134d21a8d9454e092c64cb72c3c792774::nada {
    struct NADA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NADA, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<NADA>(arg0, 9320824891957218173, b"Nada", b"NADA", b"Absolutely NADA. Don't buy!", b"https://images.hop.ag/ipfs/QmUfp61rrMbCwSyxsHAfv1xJed3itxrCSLWXstuauiRoa6", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

