module 0xbc6d501fef3818e6f4002c9508660f761a3548eb087c91e0e8730d03efe7abb5::hopfrog {
    struct HOPFROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPFROG, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<HOPFROG>(arg0, 5956144140752887429, b"Hopfrogsui", b"HopFrog", b"Time spins like a clock, turning endlessly, much like a ninja star whirling through the air.", b"https://images.hop.ag/ipfs/QmcXXk1TuZ3zWUy6Ta7dTnzEUbhmbihnBpXgb9trbvSchL", 0x1::string::utf8(b"https://x.com/HopFrogSui?t=XG78H5HUWw7hgRcf_wBDuQ&s=09"), 0x1::string::utf8(b"https://hopfrog.fun/"), 0x1::string::utf8(b"https://t.me/HopFrogSui"), arg1);
    }

    // decompiled from Move bytecode v6
}

