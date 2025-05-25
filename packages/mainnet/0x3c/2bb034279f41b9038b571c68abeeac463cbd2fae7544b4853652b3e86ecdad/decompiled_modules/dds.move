module 0x3c2bb034279f41b9038b571c68abeeac463cbd2fae7544b4853652b3e86ecdad::dds {
    struct DDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DDS, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<DDS>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<DDS>(arg0, b"DDS", b"DUTERTE", b"DUTERTE & SARA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmcX6in292ooNLq6pMYGTc1QhxAAtw6nk77nhvF2eNJcD8")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00cc05d1dfb8f0cdff4e413840c37f323b9744e3ef32f2ca0aadb7d0748358eec2be0fde988751dd3c66682d1ace7cf01fd311799dbb232443709e7c5e5b2cb501d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748199028"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

