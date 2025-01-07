module 0xb19f7869ce76396169c43c860ca89618cbf01bfa4f675633ede3c3a3141ec749::kabo {
    struct KABO has drop {
        dummy_field: bool,
    }

    fun init(arg0: KABO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KABO>(arg0, 6, b"KABO", b"KABOSUI", b"Hello, I'm KABOSUI, the cute KABOSUI DOGE on $ui! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000006956_8104c627bb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KABO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KABO>>(v1);
    }

    // decompiled from Move bytecode v6
}

