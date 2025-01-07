module 0xd7a6785956bdcf881dc38d3a56cee4856eff6d88f5640f2f40de2f21634566e8::blb {
    struct BLB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLB, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<BLB>(arg0, 14044448252821967669, b"Blooby", b"Blb", b"This bird is called the Blue-footed booby", b"https://images.hop.ag/ipfs/QmW56VAB4FaHBk6td6umyb3DPVwTruBrimT7SL4xCuvLx5", 0x1::string::utf8(b"https://x.com/shouldhaveanima/status/1663467650775916546?s=46"), 0x1::string::utf8(b"https://galapagosconservation.org.uk/species/blue-footed-booby/"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

