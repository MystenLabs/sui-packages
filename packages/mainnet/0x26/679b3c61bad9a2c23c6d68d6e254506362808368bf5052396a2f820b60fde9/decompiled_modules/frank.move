module 0x26679b3c61bad9a2c23c6d68d6e254506362808368bf5052396a2f820b60fde9::frank {
    struct FRANK has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRANK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRANK>(arg0, 9, b"FRANK", b"Franklin", b"Personal name", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e32ba54e-d31c-44ee-adca-8bcd016f0d86.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRANK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FRANK>>(v1);
    }

    // decompiled from Move bytecode v6
}

