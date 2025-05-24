module 0x9bef1be73a4bbfb8c4ccbc3a3372e2b10f7613093c8b95c4ccafd142ca5c9a9f::dripz {
    struct DRIPZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRIPZ, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<DRIPZ>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<DRIPZ>(arg0, b"DRIPZ", b"Splash Drop", b"Splash Drop ($DRIPZ) is a meme token making waves in the crypto sea. Fueled by fun, vibes, and pure drip energy, $DRIPZ brings the splash of memes, hype, and community to Web3. Join the wave, ride the drip, and flex your splash power!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/Qmb53VvyQnVCE2qjXRmDMVJDWf8Fo9HUvftrq7HfyaSrum")), b"WEBSITE", b"https://x.com/splash_xyz/status/1926293310949171589", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00a846ebbd7ca90636374a823e80c57e6bbefd258e720e8319dc9cb19c6ea65ba52089fc46e89c4ececa324f426e51c049884bfb703d709e941cb9221a85e3740ad598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748099712"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

