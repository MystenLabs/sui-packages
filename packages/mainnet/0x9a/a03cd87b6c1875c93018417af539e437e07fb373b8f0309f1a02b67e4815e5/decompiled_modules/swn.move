module 0x9aa03cd87b6c1875c93018417af539e437e07fb373b8f0309f1a02b67e4815e5::swn {
    struct SWN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWN, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SWN>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SWN>(arg0, b"SWN", b"SOWON", b"She was born in Eunpyeong-gu, Seoul, South Korea and has one older sister. She trained at DSP Media for about 3 years and moved to Source Music and trained for another year and a half to debut in GFriend. She attended the Hanlim Multi Arts High School and", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmYrL3GGkcU7ECDa1Frq2Vw8nzLtLjt4dmTRDwxyxw2LwU")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00ff476a4597c66877530c183115a4f368655262e11871193e1cb80084d398433f40eacee6211ac82d041708c820c6af089879e70b072bc859416a2a4c2a85210ed598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748086883"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

