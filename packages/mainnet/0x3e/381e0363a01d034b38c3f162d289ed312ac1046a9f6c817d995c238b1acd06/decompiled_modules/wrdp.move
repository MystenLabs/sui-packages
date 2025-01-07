module 0x3e381e0363a01d034b38c3f162d289ed312ac1046a9f6c817d995c238b1acd06::wrdp {
    struct WRDP has drop {
        dummy_field: bool,
    }

    fun init(arg0: WRDP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WRDP>(arg0, 9, b"WRDP", b"Wardep", b"Wardep is better", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0edc417f-bd38-41a2-a75f-21d7b93d6947.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WRDP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WRDP>>(v1);
    }

    // decompiled from Move bytecode v6
}

