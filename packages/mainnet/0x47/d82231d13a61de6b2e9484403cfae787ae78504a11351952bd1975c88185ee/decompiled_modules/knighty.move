module 0x47d82231d13a61de6b2e9484403cfae787ae78504a11351952bd1975c88185ee::knighty {
    struct KNIGHTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: KNIGHTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KNIGHTY>(arg0, 9, b"KNIGHTY", b"Knight", b"Knighty kitty", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/535a27a5-3069-494a-9c8f-6f1d1614df23.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KNIGHTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KNIGHTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

