module 0x511214a24468376c16a206df06dddee83394c7e0dd6f82accdbb8ec8f1121d4d::nakawewe {
    struct NAKAWEWE has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAKAWEWE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAKAWEWE>(arg0, 9, b"NAKAWEWE", b"WEWE", b"Suitoshi Nakawewe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/058327f3-fd8c-4cfe-a56e-4da27db4ddfe.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAKAWEWE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NAKAWEWE>>(v1);
    }

    // decompiled from Move bytecode v6
}

