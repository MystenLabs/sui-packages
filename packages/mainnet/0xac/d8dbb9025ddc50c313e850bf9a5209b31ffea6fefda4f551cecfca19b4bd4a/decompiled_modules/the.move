module 0xacd8dbb9025ddc50c313e850bf9a5209b31ffea6fefda4f551cecfca19b4bd4a::the {
    struct THE has drop {
        dummy_field: bool,
    }

    fun init(arg0: THE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THE>(arg0, 6, b"The", b"the", b"the gold", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1750389505254.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<THE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

