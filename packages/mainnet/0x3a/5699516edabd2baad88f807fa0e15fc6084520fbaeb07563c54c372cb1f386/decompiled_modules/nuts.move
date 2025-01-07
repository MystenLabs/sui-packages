module 0x3a5699516edabd2baad88f807fa0e15fc6084520fbaeb07563c54c372cb1f386::nuts {
    struct NUTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: NUTS, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<NUTS>(arg0, 6109863091777670880, b"DeezNuts", b"NUTS", b"Official account for Turbos, the first rent-free token standard on SUI. Home to Deez $NUTS", b"https://images.hop.ag/ipfs/QmXH3ZSR5rpGPyrAAWv9WmH5uRqSyyK1H9y95GTKB8xB82", 0x1::string::utf8(b"https://x.com/deeznuts_sui"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

