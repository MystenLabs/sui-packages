module 0xfc9b2f54288426b5c3c7469af5f46143de6fe550b27ac7c1ef070b001202f9d2::sui_mascot {
    struct SUI_MASCOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI_MASCOT, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<SUI_MASCOT>(arg0, 5197780315456376512, b"Sui Mascot", b"Sui Mascot", b"Driven by Community", b"https://images.hop.ag/ipfs/QmUh478vwZtvhdWyZUc3UafgfiezzsktEjqrg4tpzeMU3d", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

