module 0xa2f7ca3c78cbb20d931b9423745eb6d6151d45f409f5f179a53ddae4eb943866::sspx {
    struct SSPX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSPX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSPX>(arg0, 6, b"SSPX", b"SUISPX6990", b"SUISPX6900", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SPX_17b36364db.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSPX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSPX>>(v1);
    }

    // decompiled from Move bytecode v6
}

