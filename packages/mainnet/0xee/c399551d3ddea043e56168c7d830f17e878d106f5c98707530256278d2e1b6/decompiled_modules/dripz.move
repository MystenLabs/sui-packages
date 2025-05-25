module 0xeec399551d3ddea043e56168c7d830f17e878d106f5c98707530256278d2e1b6::dripz {
    struct DRIPZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRIPZ, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<DRIPZ>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<DRIPZ>(arg0, b"DRIPZ", b"Splash Drop", b"Splash Drop ($DRIPZ) is a meme token making waves in the crypto sea. Fueled by fun, vibes, and pure drip energy, $DRIPZ brings the splash of memes, hype, and community to Web3. Join the wave, ride the drip, and flex your splash power!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/Qmb53VvyQnVCE2qjXRmDMVJDWf8Fo9HUvftrq7HfyaSrum")), b"https://x.com/splash_xyz/status/1926293310949171589", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"009cdca44d163d2faf0152da6be67a220620aab3e285d83a2fe74234371077c35e5894cfa5fe0b317d7824bb7ef1dc7d518e691cc68e6cfeca1474190cff03f302d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748150224"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

