module 0x5253cec5522d07601896f0c989e5d5f01a2daa7b105be41ee6900c04b5b43693::lofi {
    struct LOFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOFI, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<LOFI>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<LOFI>(arg0, b"LOFI", b"Lofi The Yeti", b"I was frozen for centuries, but I've awakened and am ready to build a brighter future.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmdFUZgiyvXwvVLR1Miwp7m8dMXM5iPMvaPKxoXLmmjHFu")), b"https://lofitheyeti.com/", b"https://x.com/lofitheyeti", b"DISCORD", b"https://t.me/LofiOnSui", 0x1::string::utf8(b"00ae6861a3e43f9e0dd4beb173c8deb6c1a2258c6c03884d8c4492fb65a1e63d2eb49be7798ff23dedf1be3875e549990e79cac118597724606072a54d7a93720dd598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747757713"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

