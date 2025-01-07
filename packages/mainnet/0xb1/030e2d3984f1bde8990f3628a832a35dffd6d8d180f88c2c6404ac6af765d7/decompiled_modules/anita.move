module 0xb1030e2d3984f1bde8990f3628a832a35dffd6d8d180f88c2c6404ac6af765d7::anita {
    struct ANITA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANITA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANITA>(arg0, 6, b"ANITA", b"Anita Max Wynn", b"Red your mind. You need ta Max $WYNN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000006046_f4ced9405f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANITA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ANITA>>(v1);
    }

    // decompiled from Move bytecode v6
}

