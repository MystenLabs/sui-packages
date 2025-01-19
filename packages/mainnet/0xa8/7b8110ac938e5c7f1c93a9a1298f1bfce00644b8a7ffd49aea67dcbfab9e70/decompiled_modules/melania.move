module 0xa87b8110ac938e5c7f1c93a9a1298f1bfce00644b8a7ffd49aea67dcbfab9e70::melania {
    struct MELANIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MELANIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MELANIA>(arg0, 6, b"MELANIA", b"Melania Meme", x"546865204f6666696369616c204d656c616e6961204d656d65206973206c697665210a0a596f752063616e2062757920244d454c414e4941206e6f772e2020", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737323339644.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MELANIA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MELANIA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

