module 0xb145c71ea166a5e4276da7bdae7ca5ded35b6317aea9c6a41af67c015a21ddba::lofiai {
    struct LOFIAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOFIAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOFIAI>(arg0, 6, b"LOFIAI", b"LOFI AI", b"LUL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/lofi_ai_df10b16b84.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOFIAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOFIAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

