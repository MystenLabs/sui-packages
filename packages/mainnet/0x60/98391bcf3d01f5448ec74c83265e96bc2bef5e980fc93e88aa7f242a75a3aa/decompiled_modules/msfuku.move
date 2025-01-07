module 0x6098391bcf3d01f5448ec74c83265e96bc2bef5e980fc93e88aa7f242a75a3aa::msfuku {
    struct MSFUKU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MSFUKU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MSFUKU>(arg0, 6, b"MSFUKU", b"MSUI FUKU", b"The beloved wife of Fuku who share his joy and sorrow, from sickness to heath, from poor to riches", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_28_01_25_55_81f1740067.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MSFUKU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MSFUKU>>(v1);
    }

    // decompiled from Move bytecode v6
}

