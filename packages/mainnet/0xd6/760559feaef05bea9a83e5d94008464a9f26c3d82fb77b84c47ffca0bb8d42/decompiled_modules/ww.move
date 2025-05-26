module 0xd6760559feaef05bea9a83e5d94008464a9f26c3d82fb77b84c47ffca0bb8d42::ww {
    struct WW has drop {
        dummy_field: bool,
    }

    fun init(arg0: WW, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<WW>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<WW>(arg0, b"WW", b"Wolf", b"wolf and nature", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmNsrh4zbuvQb5vCkXTw8m3LjExD5Qn9BGygSdkQQVCiQL")), b"https://app.splash.xyz/create", b"https://x.com/Alik0551974", b"https://discord.com/channels/1206782626786971679/1220406290090557440/1346477835568680970", b"https://t.me/Alik13651", 0x1::string::utf8(b"00db1a1e3f25fed68316d011ca92e38b458712e1bc6c8549f26c04189e524aa413b2aed70700b14d88459520ef20063c34a65314d2a1a19294d199f999d49fd90fd598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748241328"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

