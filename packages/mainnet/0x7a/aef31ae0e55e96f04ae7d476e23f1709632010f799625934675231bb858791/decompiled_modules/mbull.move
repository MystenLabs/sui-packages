module 0x7aaef31ae0e55e96f04ae7d476e23f1709632010f799625934675231bb858791::mbull {
    struct MBULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: MBULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MBULL>(arg0, 6, b"Mbull", b"MoonBULL", b"Biggest bull ever", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_25_16_06_44_a66778ded2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MBULL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MBULL>>(v1);
    }

    // decompiled from Move bytecode v6
}

