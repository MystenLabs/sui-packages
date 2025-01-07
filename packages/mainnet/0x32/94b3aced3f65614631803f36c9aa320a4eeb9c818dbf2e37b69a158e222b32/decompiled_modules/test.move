module 0x3294b3aced3f65614631803f36c9aa320a4eeb9c818dbf2e37b69a158e222b32::test {
    struct TEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2a20d4c2d103816de4bbc8a56d627834e591fcf70f284279e77586a4a32a570b::bonding_curve::BondingCurveStartCap<TEST>>(0x2a20d4c2d103816de4bbc8a56d627834e591fcf70f284279e77586a4a32a570b::bonding_curve::create_bonding_curve<TEST>(arg0, b"TEST", b"test", b"des", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump-static.cetus.zone/icon/7f534e4c-031b-42f7-8d94-934d1d4e200a")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0078ec13f24cce9945e8a67a1fd3e2d133ff717b49fde2e5184d4bbc5f5a7a064ee8448119875eb8f3c96f1299045a0a1e3a0b6c7aeb65c3728617d7275669e7062b29e6d9d2f97b81d63bdea83da70b8c1ba172cabaeef1786acbe6c04a2125da"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

