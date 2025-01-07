module 0xa3304eb951cce3f30b5b506ce5257c707d121d8fe78edc99ffcb91d54465cad4::vance {
    struct VANCE has drop {
        dummy_field: bool,
    }

    fun init(arg0: VANCE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VANCE>(arg0, 9, b"VANCE", b"TrumpVance", b"In celebration of the bull run ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/30abdcac-1992-409c-8cbd-ee3498c0b8c6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VANCE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VANCE>>(v1);
    }

    // decompiled from Move bytecode v6
}

