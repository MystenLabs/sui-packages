module 0x4fdf7b7d96d4452e7262ffd517174233fd81423626bd763471e1205cd106f8a8::pppp {
    struct PPPP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PPPP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PPPP>(arg0, 6, b"Pppp", b"Peepeepoopoo", b"Peepee poopoo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9487_1ef937f63d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PPPP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PPPP>>(v1);
    }

    // decompiled from Move bytecode v6
}

