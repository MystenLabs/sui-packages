module 0x45214e6a0947241eef9025199cf7c7cbbc783a7b1ec4abb3a6794e76bc635e28::hopdog {
    struct HOPDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPDOG, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<HOPDOG>(arg0, 8246032104584294834, b"HopDog", b"HopDog", b"HopDog", b"https://images.hop.ag/ipfs/QmU77wwd4BuLvZ3w9uAdGhRhLUGtdiKtmGurGmFUvKt2Um", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

