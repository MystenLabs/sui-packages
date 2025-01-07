module 0xdf0501a9f82786a54dfe943d5642fbac72a684e98f28256ce75512bcdb3b63cc::zaza {
    struct ZAZA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZAZA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZAZA>(arg0, 9, b"ZAZA", b"Zazah", b"United we stand ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b06e75b6-01f8-4c9d-aad8-85fe8ebb4d22.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZAZA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZAZA>>(v1);
    }

    // decompiled from Move bytecode v6
}

