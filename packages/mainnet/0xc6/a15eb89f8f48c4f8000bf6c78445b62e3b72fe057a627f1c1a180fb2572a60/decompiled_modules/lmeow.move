module 0xc6a15eb89f8f48c4f8000bf6c78445b62e3b72fe057a627f1c1a180fb2572a60::lmeow {
    struct LMEOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: LMEOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LMEOW>(arg0, 6, b"LMEOW", b"woman yelling at a cat", b"$LMEOW is a memecoin based on the famous \"woman yelling at a cat\" meme and summoned into existence by a GCR tweet. not your grandmas LMEOW  .", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/72_Br_N_Km_P_Wi_TJ_3f1fzjv_Xqt_Pg_D_Ce_Dvy_W_Ud_W6_R_Td41_Y_Mz5_1088b7632b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LMEOW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LMEOW>>(v1);
    }

    // decompiled from Move bytecode v6
}

