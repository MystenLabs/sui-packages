module 0xd471388c091a942fe768bc58604450830c9da8f3667219791f41d85a129ddcf2::buck {
    struct BUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUCK>(arg0, 6, b"BUCK", b"GME Mascot", b"The official Mascot for Gamestop", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731838973574.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BUCK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUCK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

