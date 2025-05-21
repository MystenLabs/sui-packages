module 0x9c30e60677d6a75dc5b44837617898a68943f1abb5daa623cf69937907990534::stc {
    struct STC has drop {
        dummy_field: bool,
    }

    fun init(arg0: STC, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<STC>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<STC>(arg0, b"STC", b"Suitich", b"Suitich a meme token on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmP6TLKSCm9TH6CUTYURT6w4JJTQD43izvag49JKVhoTMt")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00b20611c6a02b5a43aba7848d0ec8519dbe15f75bcea2a8d2664f74945c6a9c4b6ae1ae549a78fcd5eb78dbbe33639568239560cf1af60cda0fe64988b4cab90cd598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747846220"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

