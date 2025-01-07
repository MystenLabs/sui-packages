module 0x6d284f696412670cc82395c3ce331bcf15064c6f3a28bdc01c74002d55d0aca7::esc {
    struct ESC has drop {
        dummy_field: bool,
    }

    fun init(arg0: ESC, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<ESC>(arg0, 8934832238043870836, b"escottr", b"ESC", x"4c6574277320726169736520616e6420676f20746f20447562616920776974682077686f7265732e0a536f6369616c732077696c6c2062652063726561746564206c617465722e", b"https://images.hop.ag/ipfs/QmcksqNFwDcrDTKaL7Vik1g6f8JDsTrDzJbfyUptnQSpuR", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

