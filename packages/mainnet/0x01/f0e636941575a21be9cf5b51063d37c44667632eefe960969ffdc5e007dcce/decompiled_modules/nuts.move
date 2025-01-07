module 0x1f0e636941575a21be9cf5b51063d37c44667632eefe960969ffdc5e007dcce::nuts {
    struct NUTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: NUTS, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<NUTS>(arg0, 11547103052621217703, b"DeezNuts", b"NUTS", b"Official account for Turbos, the first rent-free token standard on SUI. Home to Deez $NUTS", b"https://images.hop.ag/ipfs/QmXH3ZSR5rpGPyrAAWv9WmH5uRqSyyK1H9y95GTKB8xB82", 0x1::string::utf8(b"https://x.com/deeznuts_sui"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

