module 0x75a2c73c911163d02d9f759f1798a57051ddcc1a10cf8b1b6989c28663450e45::brok {
    struct BROK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BROK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BROK>(arg0, 6, b"BROK", b"BROK on sui", b"BORK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_24_03_36_09_64b0f3a23b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BROK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BROK>>(v1);
    }

    // decompiled from Move bytecode v6
}

