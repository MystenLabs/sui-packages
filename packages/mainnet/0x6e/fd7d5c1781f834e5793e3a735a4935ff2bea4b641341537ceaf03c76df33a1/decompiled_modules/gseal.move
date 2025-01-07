module 0x6efd7d5c1781f834e5793e3a735a4935ff2bea4b641341537ceaf03c76df33a1::gseal {
    struct GSEAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: GSEAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GSEAL>(arg0, 9, b"GSEAL", b"Gangsta Seal", b"Just a Chill Gangsta Seal", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/1d10de43cce34a3d6ddb4a72d6772c35blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GSEAL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GSEAL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

