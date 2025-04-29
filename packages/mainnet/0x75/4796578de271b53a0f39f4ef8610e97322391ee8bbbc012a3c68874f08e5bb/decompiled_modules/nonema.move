module 0x754796578de271b53a0f39f4ef8610e97322391ee8bbbc012a3c68874f08e5bb::nonema {
    struct NONEMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NONEMA, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::BondingCurveStartCap<NONEMA>>(0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::create_bonding_curve<NONEMA>(arg0, b"NONEMA", b"Token", b"desc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmXDPZaQ9kiLncSfiarJthyzeQXpVf83X24VZHBrdPzDEu")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"004b5dafb5c40f1159d174c6a6c4afec1aa4d2c9a586be8327d2231025f86f0440927fbbfc26ef777e32fb99d4026dc60b411750891bbcb27ebbec3b85b2bc7b0aed4877f4aa041dd7e483be109b3b253b6804cf63717f0c9f7ea244f99ce13efc1745944186"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

