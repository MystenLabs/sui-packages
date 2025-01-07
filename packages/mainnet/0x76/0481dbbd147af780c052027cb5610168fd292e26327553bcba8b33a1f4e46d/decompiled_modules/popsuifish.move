module 0x760481dbbd147af780c052027cb5610168fd292e26327553bcba8b33a1f4e46d::popsuifish {
    struct POPSUIFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPSUIFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPSUIFISH>(arg0, 6, b"POPSUIFISH", b"POP SUI FISH", b"POP POP POP POP POP POP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730960862544.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POPSUIFISH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPSUIFISH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

