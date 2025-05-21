module 0x8617ed96a457e2dae39323db306f8ac0ad840ff86aca3e11099dfc71d11260c1::suip {
    struct SUIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIP, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SUIP>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SUIP>(arg0, b"SUIP", b"suip", b"just suip", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmNQit9SBwwsH1dzVSShLNevLQkXK5ZRPMD91bnxx8Gic8")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0033d4493d9fb2ae6a9781df43dc0ab416d9583e9bd92dec3ef04e87a1a87242f5322c3d98ab403bf04ff3b8206a783f227c507bd60c66a26bf10c56117f6b3a07d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747858151"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

