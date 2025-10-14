module 0x5e9230a98b80b122499f195c87c4754332bbf4b4191f32b4242f5eda7f49a1ca::xb {
    struct XB has drop {
        dummy_field: bool,
    }

    fun init(arg0: XB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve_v2<XB>(arg0, b"XB", b"Cute X", b"A meme token on SUI born on Hippo.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmaVKpSdPP4PAZZynt3iXFAJxUst9noMWMKYMwPiTzyB6m")), b"https://cute-jogja-girl.blogspot.com", b"TWITTER", b"DISCORD", b"https://t.me/ppgbg", 0x1::string::utf8(b"00c6215099338bc02adbbb5d09e488090ea287f8befab1b5c3efd2d9f030a5ca1a77c079a8783a60592c6d39f4f80e48e0e61825591e19cf71bad1132a606ffd0ad598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1760411994"), arg1);
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCapV2>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XB>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

