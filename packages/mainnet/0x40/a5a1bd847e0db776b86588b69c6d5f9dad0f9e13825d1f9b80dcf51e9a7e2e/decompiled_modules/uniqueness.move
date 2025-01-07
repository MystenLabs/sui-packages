module 0x40a5a1bd847e0db776b86588b69c6d5f9dad0f9e13825d1f9b80dcf51e9a7e2e::uniqueness {
    struct UNIQUENESS has drop {
        dummy_field: bool,
    }

    fun init(arg0: UNIQUENESS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UNIQUENESS>(arg0, 9, b"UNIQUENESS", b"Pretty pet", b"This pet looks very amazing.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e619294a-5a46-4abd-9f49-0cd1e7826546.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UNIQUENESS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UNIQUENESS>>(v1);
    }

    // decompiled from Move bytecode v6
}

