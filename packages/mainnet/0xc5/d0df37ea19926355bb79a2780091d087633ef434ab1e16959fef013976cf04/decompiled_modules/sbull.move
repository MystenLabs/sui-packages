module 0xc5d0df37ea19926355bb79a2780091d087633ef434ab1e16959fef013976cf04::sbull {
    struct SBULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBULL, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<SBULL>(arg0, 7800799163448830626, b"SUI BULL", b"SBULL", b"The new era of Pitbull token has launched on Sui chain. Dont sleep on SBULL", b"https://images.hop.ag/ipfs/Qmbi3q5pdD4gp8av2gyChbUhhfpKBCe9ujg4RvcpzuLx7F", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

