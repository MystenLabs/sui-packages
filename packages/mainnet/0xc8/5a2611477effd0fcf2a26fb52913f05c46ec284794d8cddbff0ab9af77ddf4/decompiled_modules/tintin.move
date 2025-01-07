module 0xc85a2611477effd0fcf2a26fb52913f05c46ec284794d8cddbff0ab9af77ddf4::tintin {
    struct TINTIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TINTIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TINTIN>(arg0, 9, b"TINTIN", b"Tin", b"Ok", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c668bed1-f1a9-41f2-bc8c-e19edcfa1fa8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TINTIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TINTIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

