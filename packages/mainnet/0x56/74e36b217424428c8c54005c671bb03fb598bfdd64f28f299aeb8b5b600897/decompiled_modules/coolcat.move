module 0x5674e36b217424428c8c54005c671bb03fb598bfdd64f28f299aeb8b5b600897::coolcat {
    struct COOLCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: COOLCAT, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<COOLCAT>(arg0, 11321828367713897474, b"COOLCAT", b"COOLCAT", b"just a cool cat", b"https://images.hop.ag/ipfs/QmemuBkZP7AiPFrA223qwtNXiPx41wXPn1d1Vku5m7uVaA", 0x1::string::utf8(b"https://x.com/coolcatsui"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

