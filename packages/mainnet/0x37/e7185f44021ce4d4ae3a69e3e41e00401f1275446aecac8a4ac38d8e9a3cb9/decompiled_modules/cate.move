module 0x37e7185f44021ce4d4ae3a69e3e41e00401f1275446aecac8a4ac38d8e9a3cb9::cate {
    struct CATE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATE>(arg0, 6, b"CATE", b"Cate on Sui", x"54686520317374202443415445206465706c6f796564206f6e205375692c20636f6d6d756e6974792d6d616e616765642e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/O_O_O_U_U_O_U_4_4ffd2735fa.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATE>>(v1);
    }

    // decompiled from Move bytecode v6
}

