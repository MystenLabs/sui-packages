module 0x266ede028bdf026f90667d5ebd62072967a1308dc15cb596beb237446c25d808::ringo {
    struct RINGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: RINGO, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<RINGO>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<RINGO>(arg0, b"Ringo", b"RingoOnSui", b"First Good boy on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmZceBg513EGL3eVwMRyHofPRVXKUc9SmBXWfzHHckVK67")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0027a74e9635806539ada26fa756759353bdc711312ac5f1f8f4ee70a2c7d8350f1b5203b3470cf05221ca5dd4add41992578fa7b511bb961e80551bd73f280e09d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747771682"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

