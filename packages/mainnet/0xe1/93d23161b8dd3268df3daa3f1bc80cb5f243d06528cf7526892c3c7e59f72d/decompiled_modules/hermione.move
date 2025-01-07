module 0xe193d23161b8dd3268df3daa3f1bc80cb5f243d06528cf7526892c3c7e59f72d::hermione {
    struct HERMIONE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HERMIONE, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<HERMIONE>(arg0, 13262411039022820706, b"her", b"hermione", b"Hermione Granger was the cleverest witch of her age and one of Harry Potter's closest friends.", b"https://images.hop.ag/ipfs/QmUmpsxeF17WKdZLikkR9GgWMRE7ZDPvhPmDY1VnQt6cGj", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

