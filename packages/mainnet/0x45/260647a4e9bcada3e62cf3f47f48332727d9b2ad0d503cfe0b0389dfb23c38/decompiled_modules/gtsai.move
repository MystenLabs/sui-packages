module 0x45260647a4e9bcada3e62cf3f47f48332727d9b2ad0d503cfe0b0389dfb23c38::gtsai {
    struct GTSAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTSAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GTSAI>(arg0, 6, b"GTSai", b"Greg The Samurai", b"This avatar picture is famous on late 20s", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732010482008.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GTSAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GTSAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

