module 0x7a4a4cbaac03b48a5431fb3a8110e27623e5a0be33a7b78ca17b5dcc7391d779::lekdn {
    struct LEKDN has drop {
        dummy_field: bool,
    }

    fun init(arg0: LEKDN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LEKDN>(arg0, 9, b"LEKDN", b"hejen", b"vebe ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2d7a02dd-e86a-4757-ab3b-b3bc63429778.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LEKDN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LEKDN>>(v1);
    }

    // decompiled from Move bytecode v6
}

