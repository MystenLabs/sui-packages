module 0xe5a52bda9769b34ddd03363eb2b78070c477a921709e2675d65a7b23a33bf161::nood {
    struct NOOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOOD, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<NOOD>(arg0, 17425832815521355742, b"Noodle the toffee glow", b"NOOD", b"The sweetest hognose snake", b"https://images.hop.ag/ipfs/QmSXkaYa9qEFareEFLBbJ6BHe22ZXpRMncToaJaLLaZio7", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

