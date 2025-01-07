module 0x4453b4db69d71dc8ce657ff9868b5f51e1035af0caa69959ebada2819e530102::volt {
    struct VOLT has drop {
        dummy_field: bool,
    }

    fun init(arg0: VOLT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VOLT>(arg0, 6, b"VOLT", b"SuiVolt", b"Volt on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_05_21_24_02_61ac93dfb3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VOLT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VOLT>>(v1);
    }

    // decompiled from Move bytecode v6
}

