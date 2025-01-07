module 0xafbb6ea2109e859d9f8cc27a310497f11e938dd7c17e861b8c830919b177a6b7::tipsy {
    struct TIPSY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIPSY, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<TIPSY>(arg0, 15314350951499026362, b"Tipsy on SUI", b"Tipsy", b"Boozing my sorrows in the oceans deep, a narwhal adrift in sorrows keep!", b"https://images.hop.ag/ipfs/Qmbvts3x9xeTMKXRwjb4J1N3jS7LARsTyzKmA3mH4qVB7B", 0x1::string::utf8(b"https://x.com/tipsyonsui"), 0x1::string::utf8(b"https://x.com/tipsyonsu"), 0x1::string::utf8(b"https://t.me/tipsyonsuiportal"), arg1);
    }

    // decompiled from Move bytecode v6
}

