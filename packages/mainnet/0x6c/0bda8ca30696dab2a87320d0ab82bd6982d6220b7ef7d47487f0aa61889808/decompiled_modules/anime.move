module 0x6c0bda8ca30696dab2a87320d0ab82bd6982d6220b7ef7d47487f0aa61889808::anime {
    struct ANIME has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANIME, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<ANIME>(arg0, 11298215050157974280, b"happy", b"anime", b"to the moon", b"https://images.hop.ag/ipfs/QmZW1XPjKkopD5s8fyzT3r8jtGR3aUq4hCxg1nvzq6Jxwb", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

