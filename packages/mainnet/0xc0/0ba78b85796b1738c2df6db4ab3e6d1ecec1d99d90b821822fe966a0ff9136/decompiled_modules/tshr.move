module 0xc00ba78b85796b1738c2df6db4ab3e6d1ecec1d99d90b821822fe966a0ff9136::tshr {
    struct TSHR has drop {
        dummy_field: bool,
    }

    fun init(arg0: TSHR, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<TSHR>(arg0, 16656552323025646358, b"TOSHIRO", b"TSHR", b"By a popular designer of Japan", b"https://images.hop.ag/ipfs/QmSSAbMC9d7GW9nF2PySsbcjx6bM1PsYsyABGJ3UwgH79N", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

