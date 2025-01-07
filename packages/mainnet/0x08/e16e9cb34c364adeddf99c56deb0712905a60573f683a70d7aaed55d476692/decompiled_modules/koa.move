module 0x8e16e9cb34c364adeddf99c56deb0712905a60573f683a70d7aaed55d476692::koa {
    struct KOA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOA, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2a20d4c2d103816de4bbc8a56d627834e591fcf70f284279e77586a4a32a570b::bonding_curve::BondingCurveStartCap<KOA>>(0x2a20d4c2d103816de4bbc8a56d627834e591fcf70f284279e77586a4a32a570b::bonding_curve::create_bonding_curve<KOA>(arg0, b"KOA", b"Cute Koala", b"Cute Koala .", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump-static.cetus.zone/icon/77a017dd-a047-4c5f-af6c-91ef5c5b4683")), b"https://docs.sui.io/paper/sui.pdf", b"https://x.com/SuiNetwork", b"https://discord.com/invite/sui", b"https://t.me/Sui_Blockchain_Chinese", 0x1::string::utf8(b"00ff9e0e7820cfdec703da7476bc2a20f59124a9363abc2642e0ac150623341228635b60073da07c8dea4e72a7664723ea791e72ee9c12243a16ee57015f91bb0d2b29e6d9d2f97b81d63bdea83da70b8c1ba172cabaeef1786acbe6c04a2125da"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

