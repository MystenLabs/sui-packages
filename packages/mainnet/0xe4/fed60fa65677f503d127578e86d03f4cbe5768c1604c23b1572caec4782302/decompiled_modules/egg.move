module 0xe4fed60fa65677f503d127578e86d03f4cbe5768c1604c23b1572caec4782302::egg {
    struct EGG has drop {
        dummy_field: bool,
    }

    fun init(arg0: EGG, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2a20d4c2d103816de4bbc8a56d627834e591fcf70f284279e77586a4a32a570b::bonding_curve::BondingCurveStartCap<EGG>>(0x2a20d4c2d103816de4bbc8a56d627834e591fcf70f284279e77586a4a32a570b::bonding_curve::create_bonding_curve<EGG>(arg0, b"EGG", b"Egg", b"some egg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump-static.cetus.zone/icon/e117c32d-9798-45ed-94ef-21c71543940b")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0041ab826dab77feb459e3fa93c624be6adabc6419f06daca35a952ed05bb1740a08242e8b1375dfaa767edeb7c29c8171e771eaf558949b32a531ce17d3c1020c2b29e6d9d2f97b81d63bdea83da70b8c1ba172cabaeef1786acbe6c04a2125da"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

