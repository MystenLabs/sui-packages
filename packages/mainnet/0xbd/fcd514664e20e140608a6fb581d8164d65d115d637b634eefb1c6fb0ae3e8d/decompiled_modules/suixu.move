module 0xbdfcd514664e20e140608a6fb581d8164d65d115d637b634eefb1c6fb0ae3e8d::suixu {
    struct SUIXU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIXU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIXU>(arg0, 6, b"SUIXU", b"Suixu", b"A curious blue alien from a distant galaxy, lands on the SUI Network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_17_20_22_11_5591525d15.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIXU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIXU>>(v1);
    }

    // decompiled from Move bytecode v6
}

