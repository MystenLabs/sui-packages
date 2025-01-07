module 0xb63a856500a49b77c8d96e1d61b73dc67fad4139154c23f66f995b3c7406fc25::amaia {
    struct AMAIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AMAIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AMAIA>(arg0, 6, b"Amaia", b"Amaia Morales", b"Its a very beautiful girl", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731000761580.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AMAIA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AMAIA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

