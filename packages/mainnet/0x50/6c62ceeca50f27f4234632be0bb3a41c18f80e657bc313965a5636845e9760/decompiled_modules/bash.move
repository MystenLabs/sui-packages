module 0x506c62ceeca50f27f4234632be0bb3a41c18f80e657bc313965a5636845e9760::bash {
    struct BASH has drop {
        dummy_field: bool,
    }

    fun init(arg0: BASH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BASH>(arg0, 9, b"BASH", b"Bashir", b"Bashtoken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cd9a02bb-9555-4bca-ab84-8767cc578686.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BASH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BASH>>(v1);
    }

    // decompiled from Move bytecode v6
}

