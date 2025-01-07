module 0x107cd5fe76e5df1aa9dd86480ed6b61d61c10cc780c1f11fabce3b4d20cf54f7::dfsa {
    struct DFSA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DFSA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DFSA>(arg0, 9, b"DFSA", b"B", b"GEW", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/11bdbb2b-d906-43a0-b0ee-367917e389ea.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DFSA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DFSA>>(v1);
    }

    // decompiled from Move bytecode v6
}

