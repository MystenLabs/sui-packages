module 0x6dcdbfb6ca590d3297156d04cb9d58b08129de2d40771bf7c7a5d45a83ab23f2::gwog {
    struct GWOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GWOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GWOG>(arg0, 6, b"GWOG", b"Golden Wog", b"Not all wogs are blessed with gold, but Golden Wog $GWOG was born different. Your future self will thank you. Ribbit!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0x2c797e1ec4a5e7d7ce4d8ca23145052544117676_dd5834ad32.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GWOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GWOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

