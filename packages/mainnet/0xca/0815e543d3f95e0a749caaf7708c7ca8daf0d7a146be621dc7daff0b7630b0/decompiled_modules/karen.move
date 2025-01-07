module 0xca0815e543d3f95e0a749caaf7708c7ca8daf0d7a146be621dc7daff0b7630b0::karen {
    struct KAREN has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAREN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAREN>(arg0, 6, b"KAREN", b"SuiKaren", b"first ever karen on sui. buy or else she will be angry you know. pump da bich ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000015296_b259102056.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAREN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KAREN>>(v1);
    }

    // decompiled from Move bytecode v6
}

