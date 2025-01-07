module 0x27ad3d698300ba27364a09443d291efcf6aef90f2f407922cc0bffd18b25ee91::suilt {
    struct SUILT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILT>(arg0, 6, b"SUILT", b"SuiVOLT", b"Volt on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_05_21_24_02_95bd7e49b1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUILT>>(v1);
    }

    // decompiled from Move bytecode v6
}

