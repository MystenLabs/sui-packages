module 0xf03d911ff76560b51d102bdc943210195012ea4fb1e97eabc0dbd22ba28ce90a::okko {
    struct OKKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: OKKO, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<OKKO>(arg0, 1750969998348956283, b"OKX Mascot", b"OKKO", b"OKX Mascot OKKO", b"https://images.hop.ag/ipfs/QmQyKKJ47QwQRmrGWhuxk8kdTJ2zKaJSPjzVRyrnTZtGAi", 0x1::string::utf8(b"https://x.com/okx/status/1857551840453279993"), 0x1::string::utf8(b"https://x.com/okx"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

