module 0x7bed95a13c50c1a87e2cbb342aabe5571f5ba662b38379057caf415459d896c7::mwoof {
    struct MWOOF has drop {
        dummy_field: bool,
    }

    fun init(arg0: MWOOF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MWOOF>(arg0, 6, b"MWOOF", b"MeowWoof", b"Look no further, the MEW Pack is here! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730956996734.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MWOOF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MWOOF>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

