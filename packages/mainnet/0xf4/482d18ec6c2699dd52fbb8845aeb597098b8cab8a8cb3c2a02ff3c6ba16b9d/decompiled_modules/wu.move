module 0xf4482d18ec6c2699dd52fbb8845aeb597098b8cab8a8cb3c2a02ff3c6ba16b9d::wu {
    struct WU has drop {
        dummy_field: bool,
    }

    fun init(arg0: WU, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<WU>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<WU>(arg0, b"WU", b"WU keep", b"A couple carrying dreams", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/Qma8yqgThyz8Ckapp18AWQdUKTEZC9nhcYtkupN7KfGagM")), b"WEBSITE", b"https://x.com/shih89229WU", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0072474e2b0091b16f7eef1441bdcb586326c6d2a6c5ec0a8494a1c9b6ba147216ed26c7b268c52059fcaa5476c9a7b486a55adff067b3b7e654a6ec96469d3b0dd598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747914820"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

