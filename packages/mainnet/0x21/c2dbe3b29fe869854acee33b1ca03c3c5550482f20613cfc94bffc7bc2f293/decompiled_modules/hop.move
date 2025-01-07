module 0x21c2dbe3b29fe869854acee33b1ca03c3c5550482f20613cfc94bffc7bc2f293::hop {
    struct HOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOP, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<HOP>(arg0, 17329323549176432205, b"Hiphop", b"HOP", b"Sponsor by jumper.com", b"https://images.hop.ag/ipfs/QmRMTtYNAe6Frjm33UkdZMAcx9twKZz3bCF4ZpxV6Qmupn", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

