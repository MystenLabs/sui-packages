module 0x75d7ff295d57f62d82b02ec1b7d5c448bee78e5f624207a33beda8e13f2628ea::hard {
    struct HARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: HARD, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<HARD>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<HARD>(arg0, b"HARD", b"Evry1havingahardtime", b"Everyone is having a hard time and its just the 5th month in the new year.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmQTYe5qRSdkkKWJzy34288XUs65TzmMdBfzLMaZasREks")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0037043e80263ac48bb548d8e5d3589b73c02023d95117edbc338485fcb2e1f84ec62e442b2f4d51fecfd3d1b5524a34546e2e3d1ecd3317d848654d8916d8470bd598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747783333"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

