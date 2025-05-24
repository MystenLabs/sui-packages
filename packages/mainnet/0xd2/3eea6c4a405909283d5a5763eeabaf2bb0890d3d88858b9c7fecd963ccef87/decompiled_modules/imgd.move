module 0xd23eea6c4a405909283d5a5763eeabaf2bb0890d3d88858b9c7fecd963ccef87::imgd {
    struct IMGD has drop {
        dummy_field: bool,
    }

    fun init(arg0: IMGD, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<IMGD>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<IMGD>(arg0, b"IMGD", b"Imaginary Doodle", b"Nothing", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmYaWxYPEvWaY1LGcxMqne8MQR6K4C5LLemmLSMJ9vt2xZ")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0087b7a2083fdee22d2f99a22e63a3162ceca03c317463d860af5eb87974260ad26d5a35dace194ed7800ea1bfcbd677ac54ab49ee21bba311f293bcb53c5e3c0dd598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748095780"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

