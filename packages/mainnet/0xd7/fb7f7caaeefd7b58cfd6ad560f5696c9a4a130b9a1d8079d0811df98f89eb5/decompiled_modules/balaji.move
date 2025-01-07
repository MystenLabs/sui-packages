module 0xd7fb7f7caaeefd7b58cfd6ad560f5696c9a4a130b9a1d8079d0811df98f89eb5::balaji {
    struct BALAJI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BALAJI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BALAJI>(arg0, 9, b"BALAJI", b"Salasar", b"Salasar Balaji Temple Charitable Trust ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e40407f3-7e0d-4142-904c-af775ab352a6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BALAJI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BALAJI>>(v1);
    }

    // decompiled from Move bytecode v6
}

