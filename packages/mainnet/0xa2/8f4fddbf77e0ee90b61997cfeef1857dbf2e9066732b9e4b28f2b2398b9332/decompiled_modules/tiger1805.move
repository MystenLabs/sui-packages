module 0xa28f4fddbf77e0ee90b61997cfeef1857dbf2e9066732b9e4b28f2b2398b9332::tiger1805 {
    struct TIGER1805 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIGER1805, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TIGER1805>(arg0, 9, b"TIGER1805", b"Tiger Inu", b"A Tiger is revealed for Shiba Inu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cf557adb-64cc-42f6-8b6b-38a5ff68c3b7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIGER1805>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TIGER1805>>(v1);
    }

    // decompiled from Move bytecode v6
}

