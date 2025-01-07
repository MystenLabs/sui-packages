module 0x2c211d7cf3b22dafe733ae0b982a418e2c3297d3a438bc1445644da9bb38875b::evancheng {
    struct EVANCHENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: EVANCHENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EVANCHENG>(arg0, 6, b"EvanCheng", b"Evan Cheng", b"Founder of Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_10_01_48_37_fb64e38b9c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EVANCHENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EVANCHENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

