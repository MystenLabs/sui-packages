module 0x37069ea9837758dc7ecb1327dd40f4b17c71885642d0735703e46d735c046a9::owkdn {
    struct OWKDN has drop {
        dummy_field: bool,
    }

    fun init(arg0: OWKDN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OWKDN>(arg0, 9, b"OWKDN", b"jsjdn", b"bene", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/01fcaafb-758f-4a52-a6f5-9d5ea0086750.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OWKDN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OWKDN>>(v1);
    }

    // decompiled from Move bytecode v6
}

