module 0xc937685ecc2e849f3bbb7281f07fabfc849361bf200e3e892f5d146ee47dc139::frog {
    struct FROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROG, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<FROG>(arg0, 4042289800786407433, b"HopFrog", b"FROG", b"From the ashes, a new community rose: not just a Frog, but a more grounded, united Shinobi Dojo.", b"https://images.hop.ag/ipfs/QmS3d7FimZaUyPSrkZgtdAc5CgXoz5yZNAPePH3p78fjoA", 0x1::string::utf8(b"https://x.com/HopFrogSui"), 0x1::string::utf8(b"https://hopfrog.fun/"), 0x1::string::utf8(b"https://t.me/HopFrogSui"), arg1);
    }

    // decompiled from Move bytecode v6
}

