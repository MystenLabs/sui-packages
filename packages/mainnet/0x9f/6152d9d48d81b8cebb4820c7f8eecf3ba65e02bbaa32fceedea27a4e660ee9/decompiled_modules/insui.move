module 0x9f6152d9d48d81b8cebb4820c7f8eecf3ba65e02bbaa32fceedea27a4e660ee9::insui {
    struct INSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: INSUI, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<INSUI>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<INSUI>(arg0, b"INSUI", b"Interleon On Sui", b"Interleon is Ticker!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/Qmf14DT9aLnh6JnY8Tw82ywSMG7RKuLV8isHbobE5xQd1k")), b"WEBSITE", b"https://x.com/Suiderace", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"000f34c7961baf5611ba722c052e4e3c2c5836760bf2fe1409ede290279ee4f8f717088d483ed26a7116856cf2aeab54c7fd04539a465eddeb3ba6408f22cb8300d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747770143"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

