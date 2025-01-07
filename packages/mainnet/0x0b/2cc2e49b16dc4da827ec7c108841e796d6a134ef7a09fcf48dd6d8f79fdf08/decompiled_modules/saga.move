module 0xb2cc2e49b16dc4da827ec7c108841e796d6a134ef7a09fcf48dd6d8f79fdf08::saga {
    struct SAGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAGA>(arg0, 9, b"SAGA", b"Sage", b"Mid", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/463e6c76-fafb-4ce0-bfa1-f7a73842a9cd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SAGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

