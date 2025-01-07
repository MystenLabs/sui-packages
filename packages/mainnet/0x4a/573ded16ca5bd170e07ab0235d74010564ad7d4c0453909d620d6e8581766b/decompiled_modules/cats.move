module 0x4a573ded16ca5bd170e07ab0235d74010564ad7d4c0453909d620d6e8581766b::cats {
    struct CATS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATS>(arg0, 9, b"CATS", b"Komaru", b"Komaru the cat ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/db77aa25-c177-44ae-aa5d-c713a808122f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CATS>>(v1);
    }

    // decompiled from Move bytecode v6
}

