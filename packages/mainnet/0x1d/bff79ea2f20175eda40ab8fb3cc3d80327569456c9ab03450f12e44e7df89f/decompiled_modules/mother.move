module 0x1dbff79ea2f20175eda40ab8fb3cc3d80327569456c9ab03450f12e44e7df89f::mother {
    struct MOTHER has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOTHER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOTHER>(arg0, 9, b"MOTHER", b"MAMI", b"I LOVE MY MOTHER SO MUCH SHE HAS CANCER AND WILL HAVE TO LEAVE ME FOREVER.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/07cbf483-ef36-43f5-8826-85a562f49bd6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOTHER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOTHER>>(v1);
    }

    // decompiled from Move bytecode v6
}

