module 0x44f054bfa2ef21350d8a0303ee78d0bc342d19d74982c9f887237a5f7f7aa7c3::joy {
    struct JOY has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOY>(arg0, 9, b"JOY", b"joy inu", b"Fly with your lovable character", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f70ff63d-3cf0-4014-ab72-8ca5c147dda9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JOY>>(v1);
    }

    // decompiled from Move bytecode v6
}

