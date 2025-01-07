module 0x418e577082464c06defa841d9830e5ca81a3f5cb711fae0562e89cae7e0b4abe::ivan {
    struct IVAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: IVAN, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<IVAN>(arg0, 3580848755303019954, b"IVAN", b"IVAN", b"IVAN IZ GRUZII", b"https://images.hop.ag/ipfs/QmNTmbjNW37d6ioMXDy9zRwn2anqPHJRR1dWZcsUrNd31g", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

