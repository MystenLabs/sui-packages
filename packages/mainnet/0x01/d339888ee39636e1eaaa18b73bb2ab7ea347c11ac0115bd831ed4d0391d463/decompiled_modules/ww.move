module 0x1d339888ee39636e1eaaa18b73bb2ab7ea347c11ac0115bd831ed4d0391d463::ww {
    struct WW has drop {
        dummy_field: bool,
    }

    fun init(arg0: WW, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<WW>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<WW>(arg0, b"WW", b"Wolf", b"wolf and nature", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmNsrh4zbuvQb5vCkXTw8m3LjExD5Qn9BGygSdkQQVCiQL")), b"https://app.splash.xyz/create", b"https://x.com/Alik0551974", b"https://discord.com/channels/1206782626786971679/1220406290090557440/1346477835568680970", b"https://t.me/Alik13651", 0x1::string::utf8(b"004563d3bce82bae0a7b32f2a7c6455b96746c94b0f8de28a6153b30361b434314b8342900d97632b06a8f3625efe82aad4fbcca0a1d20c0c528e7b2bee0b39004d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748240965"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

