module 0x9f34c5967c8f7a6625cfcce718d14db90f421992f9c7b15151c922b3643e96af::rasta {
    struct RASTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: RASTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RASTA>(arg0, 6, b"Rasta", b"Chill Rasta Rat", b"Just a chill rasta rat with good vibes! Ladamercy! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736279592042.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RASTA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RASTA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

