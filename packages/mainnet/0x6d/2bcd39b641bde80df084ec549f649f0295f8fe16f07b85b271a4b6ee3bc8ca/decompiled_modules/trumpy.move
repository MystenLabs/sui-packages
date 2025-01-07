module 0x6d2bcd39b641bde80df084ec549f649f0295f8fe16f07b85b271a4b6ee3bc8ca::trumpy {
    struct TRUMPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPY>(arg0, 6, b"TRUMPY", b"Trumpy Trout", b"You found it, congratulations.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730962327133.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMPY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

