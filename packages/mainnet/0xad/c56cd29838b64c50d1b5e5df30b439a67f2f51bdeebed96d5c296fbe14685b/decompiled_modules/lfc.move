module 0xadc56cd29838b64c50d1b5e5df30b439a67f2f51bdeebed96d5c296fbe14685b::lfc {
    struct LFC has drop {
        dummy_field: bool,
    }

    fun init(arg0: LFC, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<LFC>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<LFC>(arg0, b"LFC", b"Liverpool FC", b"You Will Never Walk Alone", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/Qmau52UsKC8meDkzrW971gryaeUMaZBi5tQk8N2Sn7Denw")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00b70154f612fed710c635ffe4bc2fa80af9092c62f3f7925c9ac13de74929310634290311da139b3bb82adc74264943dd04e9226ef13417d5ab178d233c3d3d09d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748150847"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

