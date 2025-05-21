module 0x923557ce5a76d52abf75ef82353799555266e7e9f887fd6cbe7f4482cd361efb::fish0 {
    struct FISH0 has drop {
        dummy_field: bool,
    }

    fun init(arg0: FISH0, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<FISH0>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<FISH0>(arg0, b"Fish0", b"FishGirl", b"FishGirl, whose Chinese name is JINYU Zhang and nickname is Fish.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmQFu55dMsQHtXQBcwWwsfKZakZEVvotgqp31ggSjoYrhi")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00f2bea20658e2d7afe9a9c75d6e84517df0e3f2da21e15f3883fa5b68fb0f93d1cf3b32d459e9b3a1c7191a42344f38fa33687652ab0b8cf8559fe4560e0e4208d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747845980"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

