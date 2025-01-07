module 0x6c465b7d56b25293eb9a8700e6ad7202f4ef6b0842968469ed91513b4fcf1b3c::frog {
    struct FROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROG, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<FROG>(arg0, 6211656398257922839, b"HopFrog", b"Frog", b"$FROG the Victorious warriors win first and then go to war, while defeated warriors go to war first and then seek to win.", b"https://images.hop.ag/ipfs/QmYnrdqtZMDYALuM24jvjXR9HBQZQRdkvgCrUhcUKcUBNE", 0x1::string::utf8(b"https://x.com/HopFrogSui"), 0x1::string::utf8(b"https://hopfrog.fun/"), 0x1::string::utf8(b"https://t.me/HopFrogSui"), arg1);
    }

    // decompiled from Move bytecode v6
}

