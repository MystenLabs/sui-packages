module 0x81ba44ca10980d596e91f4695dcf92fc82cec2b5f2b14e5637bf97b9d20c6bba::fish0 {
    struct FISH0 has drop {
        dummy_field: bool,
    }

    fun init(arg0: FISH0, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<FISH0>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<FISH0>(arg0, b"Fish0", b"FishGirl", b"Fish0, the Chinese name is JINYU and nickname is Fish, its fish-like lips are exquisitely beautiful.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmQFu55dMsQHtXQBcwWwsfKZakZEVvotgqp31ggSjoYrhi")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"008936c2e8a98d2d91ec5f8198e44ce568a03e46bc78fd4c7f3bd63ccbfb967f1ceb2c54114c22d162109db412942a5979cc1f8cba5afce34afad6991484474f02d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747846573"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

