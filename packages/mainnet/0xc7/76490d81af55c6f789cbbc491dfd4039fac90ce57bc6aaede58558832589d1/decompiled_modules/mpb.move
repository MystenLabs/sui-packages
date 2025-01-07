module 0xc776490d81af55c6f789cbbc491dfd4039fac90ce57bc6aaede58558832589d1::mpb {
    struct MPB has drop {
        dummy_field: bool,
    }

    fun init(arg0: MPB, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2a20d4c2d103816de4bbc8a56d627834e591fcf70f284279e77586a4a32a570b::bonding_curve::BondingCurveStartCap<MPB>>(0x2a20d4c2d103816de4bbc8a56d627834e591fcf70f284279e77586a4a32a570b::bonding_curve::create_bonding_curve<MPB>(arg0, b"MPB", b"Master Polar Bear", b"The most powerful polar bear on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump-static.cetus.zone/icon/c6444bd2-f1d1-4cff-9ff3-b73884bb7cf3")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0097ad17947491293046f4c941f8b8e5ba373cbefb31dc587d4208580eb78a6794ad4d4ca66617e789ba06e44dea3a7849485cb93b3a4bf9884def44a3f533de002b29e6d9d2f97b81d63bdea83da70b8c1ba172cabaeef1786acbe6c04a2125da"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

