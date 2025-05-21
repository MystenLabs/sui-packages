module 0xe7f81a996b2fdba82b22ee0437bc081d79741df694b15157a02b91c2b67428f7::s2022 {
    struct S2022 has drop {
        dummy_field: bool,
    }

    fun init(arg0: S2022, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<S2022>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<S2022>(arg0, b"S2022", b"Sou2022", b"sou2022 report", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmVC3Nsdn9sBBfx44nhJKDHR3wSrpoLryByirF9NqDeXAi")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0092e064f68c42fd9d7497ba2616971a826ad16ed90905a0094801b39a4e37d7271a7b43db7441bfafc01eab59eaff5273d428a545bb9736344a3e16306ba2b10cd598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747797662"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

