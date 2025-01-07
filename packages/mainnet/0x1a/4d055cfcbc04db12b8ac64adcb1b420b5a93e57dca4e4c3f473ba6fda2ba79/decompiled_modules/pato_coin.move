module 0x1a4d055cfcbc04db12b8ac64adcb1b420b5a93e57dca4e4c3f473ba6fda2ba79::pato_coin {
    struct PATO_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PATO_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<PATO_COIN>(arg0, 17217491758310110688, b"PATOX", b"Pato Coin", b"Bringing a better world for ducks", b"https://images.hop.ag/ipfs/QmW58PDwL1YTkS9rxZnfXtq8tfbrJE8oXaLsBwKxDk2moa", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

