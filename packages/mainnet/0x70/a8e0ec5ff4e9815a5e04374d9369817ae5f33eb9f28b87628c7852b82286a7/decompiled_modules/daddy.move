module 0x70a8e0ec5ff4e9815a5e04374d9369817ae5f33eb9f28b87628c7852b82286a7::daddy {
    struct DADDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DADDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DADDY>(arg0, 6, b"DADDY", b"Daddy LongNeck", x"4461646479204c6f6e674e65636b20686173206265656e20612067726561742073656e736174696f6e20666f722068697320736c696d20617070656172616e636520616e642065787472656d656c79206c6f6e67206e65636b20696e20686973206e65696768626f72686f6f642e0a496620752077616e6e61206a6f696e206869732063726577206174207468652070756220636f6d6520616e64206a6f696e2068697320746720", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/log_A_1_c8108d09fc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DADDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DADDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

