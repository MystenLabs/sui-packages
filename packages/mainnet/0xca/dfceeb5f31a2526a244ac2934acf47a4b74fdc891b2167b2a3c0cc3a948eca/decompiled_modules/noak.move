module 0xcadfceeb5f31a2526a244ac2934acf47a4b74fdc891b2167b2a3c0cc3a948eca::noak {
    struct NOAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOAK, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<NOAK>(arg0, 1418766158154365906, b"Quack Vador", b"Noak", x"49e280996d20796f757220666174686572", b"https://images.hop.ag/ipfs/QmPbW9uPqXktPHw4jsXBvtShhQiaQDfRmh99Xhio4165Jx", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

