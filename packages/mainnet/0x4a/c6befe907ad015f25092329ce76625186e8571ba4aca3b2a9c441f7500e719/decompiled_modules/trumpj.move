module 0x4ac6befe907ad015f25092329ce76625186e8571ba4aca3b2a9c441f7500e719::trumpj {
    struct TRUMPJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPJ>(arg0, 6, b"TRUMPJ", b"TRUMPJAK", b"MAGA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730957904036.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMPJ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPJ>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

