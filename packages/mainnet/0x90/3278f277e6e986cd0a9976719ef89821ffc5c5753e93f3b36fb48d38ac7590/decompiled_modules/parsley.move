module 0x903278f277e6e986cd0a9976719ef89821ffc5c5753e93f3b36fb48d38ac7590::parsley {
    struct PARSLEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PARSLEY, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<PARSLEY>(arg0, 10466879425319387167, b"Fish & Parsley", b"PARSLEY", b"Let's grow like a parsley branch and cook and flavour all the fish in the place.", b"https://images.hop.ag/ipfs/QmWZTxYEJSEXUvTTZaLbF2QiccmzKyXZoXh9f8ujwhocUz", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

