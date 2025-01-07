module 0xa009a0f50c6c89d1a58c49fc51d53e0f623357fd9e5677fd05524f7753c055a::pitzos {
    struct PITZOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PITZOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PITZOS>(arg0, 6, b"PITZOS", b"PENA", b"feliz jueves pena; el menu de hoy son: besitos", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Zg3bi2_WUAQK_Pnd_bf24d23afb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PITZOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PITZOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

