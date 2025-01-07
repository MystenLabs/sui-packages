module 0xd931803a88d22d5b3e465d291f4d91c576f7d1483917aa6fc3baf285a00908b7::fomo {
    struct FOMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOMO>(arg0, 6, b"FOMO", b"Fear of Missing Out", b"FOMO Factory ($FOMO) is a cutting-edge token designed to capture the true essence of FOMO (Fear of Missing Out). Built for thrill-seekers and trendsetters alike, $FOMO thrives on spontaneity, community-driven action, and high-energy market moves.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/49beeba8_44c2_4117_b71c_8b446bf74166_5284d1cb8a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FOMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

