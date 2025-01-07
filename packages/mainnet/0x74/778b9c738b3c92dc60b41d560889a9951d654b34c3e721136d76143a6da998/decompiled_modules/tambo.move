module 0x74778b9c738b3c92dc60b41d560889a9951d654b34c3e721136d76143a6da998::tambo {
    struct TAMBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAMBO, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<TAMBO>(arg0, 2808381483375929662, b"Trump Lambo", b"TAMBO", b"TRUMP LAMBO IS THE BEST", b"https://images.hop.ag/ipfs/QmWCvp9JaEhespJDnADWtzAyVVdYG1KXhz47duWwW8zo5f", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

