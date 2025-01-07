module 0xc6e9b7e0885b44871671fd76f36dc3f49e26e04c2a0436b8466d270f6526a84a::sub {
    struct SUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUB>(arg0, 6, b"SUB", b"Suibubbles", x"427562626c65732073706c617368206f6e20737569636861696e2e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735991738985.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

