module 0x29cdcd09c6ff9cab35d740879e1141dbe88d596450ac2ca62b6c1ab4b5f4bfdd::suip {
    struct SUIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIP, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SUIP>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SUIP>(arg0, b"Suip", b"SuiPresident", b"Sui president. future of the ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmeqNGFxKvys54Ct4A5CqSbj8fJky4T6ATvzLgsfmveaFw")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"000795fe2717fc29cc10957879551ea40c03fb507ee3f0a807dc78db5da1269b1667804184b68d9913ad55554a8cacb58d5d6870a906d0f5a9730c9d1c4774fd0bd598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747758885"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

