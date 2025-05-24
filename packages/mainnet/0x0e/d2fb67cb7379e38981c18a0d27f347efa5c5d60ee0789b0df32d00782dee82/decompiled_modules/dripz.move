module 0xed2fb67cb7379e38981c18a0d27f347efa5c5d60ee0789b0df32d00782dee82::dripz {
    struct DRIPZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRIPZ, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<DRIPZ>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<DRIPZ>(arg0, b"DRIPZ", b"Splash Drop", b"Splash Drop ($DRIPZ) is a meme token making waves in the crypto sea. Fueled by fun, vibes, and pure drip energy, $DRIPZ brings the splash of memes, hype, and community to Web3. Join the wave, ride the drip, and flex your splash power!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/Qmb53VvyQnVCE2qjXRmDMVJDWf8Fo9HUvftrq7HfyaSrum")), b"WEBSITE", b"https://x.com/splash_xyz/status/1926293310949171589", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00579ad228f057e54aca72931d60e77893eb8c0955743bdb00e060d47d36356f389b8be1bab27b6acdcaa4ba4f7e84892cbf1b292f87561fdfacd168ff63ca8406d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748100036"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

