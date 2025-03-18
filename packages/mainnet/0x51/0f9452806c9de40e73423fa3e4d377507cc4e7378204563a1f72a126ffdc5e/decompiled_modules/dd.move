module 0x510f9452806c9de40e73423fa3e4d377507cc4e7378204563a1f72a126ffdc5e::dd {
    struct DD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DD, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::BondingCurveStartCap<DD>>(0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::create_bonding_curve<DD>(arg0, b"DD", b"DOG", b"BIG SUI DOG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS4TwIgPB6TjUQ9xM31ZkwSMfNl-EAvCVfYO_O8xydPH9srjpMneXgQAMaq5qvl9829CcxMrllZfatY0z-QKeJwvFji_AbRAn16y061Og")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0x4ae71b052fdd9cb7240641605c9b1f1b35b813cfa30400cb0d39fd2723306ea6"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

