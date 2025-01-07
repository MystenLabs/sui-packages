module 0x8a55f71a6b686f7f47776a03298985b5b9b4c116a60c8cd2c6ff6fbd6fd59c63::miaw {
    struct MIAW has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIAW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIAW>(arg0, 6, b"MIAW", b"miaw", b"$MIAW is the cutiest cat in sui chain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_27_21_05_30_c29cf9d097.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIAW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MIAW>>(v1);
    }

    // decompiled from Move bytecode v6
}

