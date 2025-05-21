module 0x2c9f9e83fdbf34bb954d43ff18db62e7140cf3875cfd892b77e0e06b20b9848e::eos {
    struct EOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: EOS, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<EOS>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<EOS>(arg0, b"Eos", b"Eros", b"babynozst", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmaR8tw9m928M3kz9fi4K4YdubQEHh4x3M6GMkseUU5kRo")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0082ef5a3d53912c74c1d0f8715b6e1f9d07464eeee2e6b616a5a9938502c7eb529a07f4a51877729378ca3835d54c8b8dfcbe175152373ba1732b7dac286b6002d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747843612"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

