module 0xf1d11b4ae56105dcf31b0008d0d6a788ace8b35f2bb891570acdf44b685475d9::light {
    struct LIGHT has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIGHT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIGHT>(arg0, 9, b"LIGHT", b"BOM", b"Bomb token that will explode", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8f33a11b-3f21-4c7e-a7b5-4ab337550033.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIGHT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LIGHT>>(v1);
    }

    // decompiled from Move bytecode v6
}

