module 0x4ecd0e607d712bb3e3998957198b31c1799cc68fdf02c953a8c7aebfd8fd14d2::drowning {
    struct DROWNING has drop {
        dummy_field: bool,
    }

    fun init(arg0: DROWNING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DROWNING>(arg0, 6, b"DROWNING", b"Drowning on Sui", b"Help! Glub, glub...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Drowning_2769f2bc99.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DROWNING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DROWNING>>(v1);
    }

    // decompiled from Move bytecode v6
}

