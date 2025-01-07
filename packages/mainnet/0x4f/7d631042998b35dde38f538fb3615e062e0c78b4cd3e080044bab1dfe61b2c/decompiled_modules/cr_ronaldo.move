module 0x4f7d631042998b35dde38f538fb3615e062e0c78b4cd3e080044bab1dfe61b2c::cr_ronaldo {
    struct CR_RONALDO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CR_RONALDO, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<CR_RONALDO>(arg0, 202699204856554262, b"Cristiano Ronaldo", b"CR Ronaldo", b"Welcome to the official Token", b"https://images.hop.ag/ipfs/QmREzKE4GDC2Qih5vw9VRSfEKtoDhurM2eTErEbi9ptMn8", 0x1::string::utf8(b"https://x.com/Cristiano"), 0x1::string::utf8(b"https://www.cristianoronaldo.com/#cr7"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

