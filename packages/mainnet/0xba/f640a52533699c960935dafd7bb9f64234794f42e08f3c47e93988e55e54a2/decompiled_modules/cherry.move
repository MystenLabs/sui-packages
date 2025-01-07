module 0xbaf640a52533699c960935dafd7bb9f64234794f42e08f3c47e93988e55e54a2::cherry {
    struct CHERRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHERRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHERRY>(arg0, 6, b"CHERRY", b"Sui Cherry", b"cherry is better than cherry", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730960408948.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHERRY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHERRY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

