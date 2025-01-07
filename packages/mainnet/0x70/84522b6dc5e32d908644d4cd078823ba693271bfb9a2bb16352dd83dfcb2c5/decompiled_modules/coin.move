module 0x7084522b6dc5e32d908644d4cd078823ba693271bfb9a2bb16352dd83dfcb2c5::coin {
    struct COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: COIN, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<COIN>(arg0, 668431194192201900, b"The Coin", b"COIN", b"the coin will rule them all", b"https://images.hop.ag/ipfs/Qma5YHdKD3HdrzSCsqzNkBoeARp2PmLfeywtYZi6PAzprT", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

