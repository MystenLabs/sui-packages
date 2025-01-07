module 0xe7349ecbcce0619db3ab7dad39e81fc48059ba57c4fcc6ce62b162687786cd47::trumpe {
    struct TRUMPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPE>(arg0, 6, b"TRUMPE", b"$TRUMPE", b"$TRUMPE is ready to conquer the MATRIX", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730999260164.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMPE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

