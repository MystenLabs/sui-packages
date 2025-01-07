module 0xe40cbedec90334f5cb1f3912932e07792279a9e6b713a1a7a3cb6c0ccbbcb743::mirai {
    struct MIRAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIRAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIRAI>(arg0, 6, b"MIRAI", b"STUDIO MIRAI", x"53545544494f204d495241492020415254544f4f0a0a4a61792053746576656e73202831393938202d2050726573656e7429200a52656372656174696f6e732032303234207c204469676974616c204172740a5072696d65204d616368696e2023323935360a0a496e7370697265642062792048656e7269204d6174697373652773204e6174757265206d6f7274652061766563206465732066727569747320283138393829", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Xpgr_M2b_YAAU_8_ZR_f8e9153c44.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIRAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MIRAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

