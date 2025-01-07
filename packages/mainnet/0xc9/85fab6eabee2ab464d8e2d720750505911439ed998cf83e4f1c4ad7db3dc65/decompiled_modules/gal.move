module 0xc985fab6eabee2ab464d8e2d720750505911439ed998cf83e4f1c4ad7db3dc65::gal {
    struct GAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: GAL, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<GAL>(arg0, 10635353706269178323, b"Galileo Origins", b"GAL", b"Exploring the Great Beyond", b"https://images.hop.ag/ipfs/Qmd2pRf6wwvWAKfN3yCBRZGgzrqGgZy2XWXwL9ToLeQtDi", 0x1::string::utf8(b"https://x.com/galileoorigins"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

