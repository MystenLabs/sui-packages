module 0x24b55a3170ec1ffbba1529bd39e01b813978d88865f2fd599de739fd46822fa1::ultn {
    struct ULTN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ULTN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ULTN>(arg0, 9, b"ULTN", b"Ultron ", b"Ultron marvel's movie character. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/dcc2285c-4f1c-461b-9dd1-29261f9a2de7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ULTN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ULTN>>(v1);
    }

    // decompiled from Move bytecode v6
}

