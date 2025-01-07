module 0x64291b4895e53bc57bab79e00034c07fe7b7ca67fffa96913d755c382bf8279e::szilla {
    struct SZILLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SZILLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SZILLA>(arg0, 6, b"SZILLA", b"SuiZilla", b"baby SUIZILLA growing on the SUI waters", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cd9b4cc65d6e4513af19581f16f5a10a_logo_logo_9086c7a99e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SZILLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SZILLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

