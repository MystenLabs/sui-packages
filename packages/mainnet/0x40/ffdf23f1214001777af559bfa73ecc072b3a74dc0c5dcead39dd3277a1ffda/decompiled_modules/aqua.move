module 0x40ffdf23f1214001777af559bfa73ecc072b3a74dc0c5dcead39dd3277a1ffda::aqua {
    struct AQUA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AQUA, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<AQUA>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<AQUA>(arg0, b"Aqua", b"Aquamon", b"The first Sui Pokemon born on Splashy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmTKJRSVdkse8WFAYbZ2aidjFhprD3Diy6RGVP3PQMzCsM")), b"https://splash.xyz/", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00e254724087b7e9c1d15394dcf1f993fd593e9acd0b481f4b2212377955d1977f9f9af2e1270a85b4b87770c01786d73f370c570aacf89061c10242e06e187804d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747763314"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

