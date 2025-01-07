module 0xcfcff29e0ec5415ab28c84b6f391fbad0b42dfde43ab0dcd16098a654038d9a7::juzy {
    struct JUZY has drop {
        dummy_field: bool,
    }

    fun init(arg0: JUZY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JUZY>(arg0, 6, b"Juzy", b"Juzy ", b"building Sui apps & tools", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730956907629.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JUZY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JUZY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

