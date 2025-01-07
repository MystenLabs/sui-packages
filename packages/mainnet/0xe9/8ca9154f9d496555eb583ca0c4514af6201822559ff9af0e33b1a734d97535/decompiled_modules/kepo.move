module 0xe98ca9154f9d496555eb583ca0c4514af6201822559ff9af0e33b1a734d97535::kepo {
    struct KEPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: KEPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KEPO>(arg0, 9, b"KEPO", b"Kepolu", b"Kepolisian banteng", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0c32a25e-c28d-4b65-bece-9ee15c11b547.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KEPO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KEPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

