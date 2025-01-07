module 0x3a74a967dfb96f41d488d041943591dc87c0006cf0dd50273e00387e5e831019::snt {
    struct SNT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNT, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<SNT>(arg0, 15452510268743030473, b"SANTA", b"SNT", b"Get ready for gifts from SUI SANTA", b"https://images.hop.ag/ipfs/QmatxJYBxrfqM1i5Kc9FB5vh7T7G4FArwGGTTnSDYFdXWR", 0x1::string::utf8(b"https://x.com/FilthyrichDAO"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

