module 0xa4b3674a619b0f757b08b29735bf610966034ebfca96a6d685a460a84db5647a::ejen {
    struct EJEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: EJEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EJEN>(arg0, 9, b"EJEN", x"d181d0bed0bb", b"rnne", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7186a49f-6c0b-47e4-a1ab-9b1f9d01fe36.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EJEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EJEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

