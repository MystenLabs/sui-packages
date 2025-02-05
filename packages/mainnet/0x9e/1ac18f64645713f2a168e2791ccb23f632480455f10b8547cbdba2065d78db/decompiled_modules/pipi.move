module 0x9e1ac18f64645713f2a168e2791ccb23f632480455f10b8547cbdba2065d78db::pipi {
    struct PIPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIPI>(arg0, 6, b"Pipi", b"pipi", b"Pipilover", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1738765069686.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PIPI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIPI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

