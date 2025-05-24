module 0xe0582abe99bcd78007f7fb7c8b65bd0239816b061494185a39840d28ae25fe64::martonsui {
    struct MARTONSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARTONSUI, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<MARTONSUI>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<MARTONSUI>(arg0, b"MARTONSUI", b"Marathon", x"537563636573732069732061206d61726174686f6e20f09f929c", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmTNGyNywPm8zJ4ikoeJHTfmYuxSLbCWmt1LC7QwtaNB7X")), b"https://x.com/Lordmarathonx?t=vxvm4d32ie8yUgsOYQhs4Q&s=09", b"TWITTER", b"DISCORD", b"https://t.me/decryptomanians", 0x1::string::utf8(b"00830b98af84f404c0bb91c5d2fa43687a5876ee1dafa7356f23a80830c68b6bad91dc0d754276209aa7e1c06ce1f9e87632696ce6ead31272f5c477a39a140e06d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748086680"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

