module 0x3ef0f61dc065718a25ae3f8e4c6d34d25b80e8923a23b3a5f023a855a798fad3::planks {
    struct PLANKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLANKS, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<PLANKS>(arg0, 5865447128965397807, b"PlanktonSui", b"PLANKS", x"416c6f6e6520576527726520536d616c6c2c20546f676574686572205765277265c2a04769616e7473", b"https://images.hop.ag/ipfs/QmVAYRnyxTY32wK1DnuBVbSzPrVRjtekeB8qFPCq8y6qHU", 0x1::string::utf8(b"https://x.com/planktonsui"), 0x1::string::utf8(b"https://planktonsui.xyz/"), 0x1::string::utf8(b"https://t.me/PlanktonSui"), arg1);
    }

    // decompiled from Move bytecode v6
}

