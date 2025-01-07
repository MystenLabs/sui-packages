module 0x72e6b1683c4cc4a3e214f3c124be58953a6825c3561a9aef1e907968b540ca86::orange {
    struct ORANGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ORANGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ORANGE>(arg0, 6, b"ORANGE", b"Orange", x"f09f9fa7f09f9fa7f09f9fa720f09f9fa7f09f9fa7f09f9fa7f09f9fa7f09f9fa7f09f9fa7", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732549016117.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ORANGE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ORANGE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

