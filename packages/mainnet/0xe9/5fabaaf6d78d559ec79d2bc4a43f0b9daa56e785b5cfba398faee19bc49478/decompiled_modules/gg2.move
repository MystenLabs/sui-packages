module 0xe95fabaaf6d78d559ec79d2bc4a43f0b9daa56e785b5cfba398faee19bc49478::gg2 {
    struct GG2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: GG2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GG2>(arg0, 6, b"Gg2", b"Gg", b"gg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732616260852.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GG2>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GG2>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

