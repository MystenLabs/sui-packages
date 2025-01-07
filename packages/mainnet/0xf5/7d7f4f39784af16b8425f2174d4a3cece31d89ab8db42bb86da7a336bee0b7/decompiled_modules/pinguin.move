module 0xf57d7f4f39784af16b8425f2174d4a3cece31d89ab8db42bb86da7a336bee0b7::pinguin {
    struct PINGUIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PINGUIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PINGUIN>(arg0, 6, b"PINGUIN", b"TURBO PINGUIN", b"Suipinguin on turbos", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730989359229.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PINGUIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PINGUIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

