module 0x89d206c318e0fe64478d04342187105f90c32ec1767cacd96fb128157d43d4ff::mood {
    struct MOOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOOD>(arg0, 6, b"MOOD", b"MOODENG", b"FUN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736917704378.avif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOOD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOOD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

