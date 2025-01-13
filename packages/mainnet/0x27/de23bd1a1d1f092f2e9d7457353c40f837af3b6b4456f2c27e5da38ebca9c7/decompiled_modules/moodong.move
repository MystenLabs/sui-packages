module 0x27de23bd1a1d1f092f2e9d7457353c40f837af3b6b4456f2c27e5da38ebca9c7::moodong {
    struct MOODONG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOODONG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOODONG>(arg0, 6, b"MOODONG", b"Moodong", b"The greates memecoin on this year", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20250113_155416_924d50e422.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOODONG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOODONG>>(v1);
    }

    // decompiled from Move bytecode v6
}

