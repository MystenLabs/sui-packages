module 0x510177c53d685c9487cede6f99c12260a35ee6313a4006eac718a0d947a76a8::fncz {
    struct FNCZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: FNCZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FNCZ>(arg0, 9, b"FNCZ", b"KONGz", b"Smoking is harmful to health, everyone should not smoke", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a4f8dbc7-1e9b-4bf4-8148-a1068719a54b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FNCZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FNCZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

