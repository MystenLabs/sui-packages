module 0xb4aaee8ebc118be7eb02f56c99a37ecffcabb3bc3beba0fb08b2ed1be8c04909::fff {
    struct FFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: FFF, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2a20d4c2d103816de4bbc8a56d627834e591fcf70f284279e77586a4a32a570b::bonding_curve::BondingCurveStartCap<FFF>>(0x2a20d4c2d103816de4bbc8a56d627834e591fcf70f284279e77586a4a32a570b::bonding_curve::create_bonding_curve<FFF>(arg0, b"FFF", b"dd", b"GGGGGG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump-static.cetus.zone/icon/4bc8c655-5405-4774-b1c0-5bbdba5bb6d2")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00b08cd8089375b21ed1a85aba8835136b29e4911c0b233251750211719f1bfd9fce631f65ad15083a7a3042b439ff21179c2ebc85096fdbba5771a1d47e3dfb0b2b29e6d9d2f97b81d63bdea83da70b8c1ba172cabaeef1786acbe6c04a2125da"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

