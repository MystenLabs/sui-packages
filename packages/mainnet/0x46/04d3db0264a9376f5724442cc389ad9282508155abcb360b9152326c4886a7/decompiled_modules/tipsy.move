module 0x4604d3db0264a9376f5724442cc389ad9282508155abcb360b9152326c4886a7::tipsy {
    struct TIPSY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIPSY, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<TIPSY>(arg0, 372654247785864375, b"Tipsy", b"Tipsy", b"DRUNK ASF", b"https://images.hop.ag/ipfs/Qmbvts3x9xeTMKXRwjb4J1N3jS7LARsTyzKmA3mH4qVB7B", 0x1::string::utf8(b"https://x.com/tipsyonsui"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

