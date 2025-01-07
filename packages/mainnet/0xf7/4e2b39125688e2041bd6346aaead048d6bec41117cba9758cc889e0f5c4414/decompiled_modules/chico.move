module 0xf74e2b39125688e2041bd6346aaead048d6bec41117cba9758cc889e0f5c4414::chico {
    struct CHICO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHICO, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<CHICO>(arg0, 16953120692126350675, b"Chico BOSS", b"Chico ", b"Chico BOSS is boss!", b"https://images.hop.ag/ipfs/QmZJaT6nhd46xwPYDHLdAPrKQXrT3Ua84N5sGxoJiHvGiF", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

