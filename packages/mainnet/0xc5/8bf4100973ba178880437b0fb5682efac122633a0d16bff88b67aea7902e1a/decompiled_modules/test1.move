module 0xc58bf4100973ba178880437b0fb5682efac122633a0d16bff88b67aea7902e1a::test1 {
    struct TEST1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST1, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2a20d4c2d103816de4bbc8a56d627834e591fcf70f284279e77586a4a32a570b::bonding_curve::BondingCurveStartCap<TEST1>>(0x2a20d4c2d103816de4bbc8a56d627834e591fcf70f284279e77586a4a32a570b::bonding_curve::create_bonding_curve<TEST1>(arg0, b"TEST1", b"tEST", b"2222", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump-static.cetus.zone/icon/54e98b8c-e55f-40cf-92ac-f4447c958bce")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00f106bc5b056406c5ac2eef2536310fec878dca23ff02dcf4fcdcf89b5a63b03fcfa1a05e3ee43081bc8d2d6398491523feda9b5949bf08b5a678e80b19e62c032b29e6d9d2f97b81d63bdea83da70b8c1ba172cabaeef1786acbe6c04a2125da"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

