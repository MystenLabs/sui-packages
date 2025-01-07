module 0xb8c4a7985b8fe353d47db9fb0bf9a9d3ba4daf6fd54987a676b3fbac2092dc67::kittycap {
    struct KITTYCAP has drop {
        dummy_field: bool,
    }

    fun init(arg0: KITTYCAP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KITTYCAP>(arg0, 6, b"KittyCap", b"Kitty Cap", b"Little bit of fluff", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730981321200.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KITTYCAP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KITTYCAP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

