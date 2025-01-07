module 0xe8fe638c30e0d6fa0348b7dfefda2543f9e878d1732bd5e6238c715fa0479ff1::troll {
    struct TROLL has drop {
        dummy_field: bool,
    }

    fun init(arg0: TROLL, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<TROLL>(arg0, 7665182184254690862, b"hopfun localhost", b"troll", b"hop fun super troll us", b"https://images.hop.ag/ipfs/QmY8uzV5WrdvPfnXUQMwnahbgMShiSN2NbQirtqCwx8dYt", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

