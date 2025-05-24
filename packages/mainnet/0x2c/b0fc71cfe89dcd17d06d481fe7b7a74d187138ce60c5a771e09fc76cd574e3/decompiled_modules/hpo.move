module 0x2cb0fc71cfe89dcd17d06d481fe7b7a74d187138ce60c5a771e09fc76cd574e3::hpo {
    struct HPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HPO, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<HPO>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<HPO>(arg0, b"HPO", b"hippo", b"This is a story about the journey of a little hippo, how she found out who she is, where she comes from, and how she likes to travel.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmR1aA1eR322Y3D1TQrwUxLmf2BmXstKoX4pJjEjUWmMu9")), b"WEBSITE", b"https://x.com/Masikhoda", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00d4898dcb8e0f063c2c1a47405cab10b2b30c247d26fabaf534f895136f24f54b5bcaa3b93841e00f2cc73bd8055601ade7e5ca6ba24f6c3c42d33019edb0b809d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748092395"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

