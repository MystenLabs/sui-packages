module 0x5f6a401b0f21f46c0a8db62ea3bf2d7831647d0791076a2d69a8f6c1aa112578::soy {
    struct SOY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOY>(arg0, 9, b"SOY", b"OMAME", b"oishiiiiiii", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9e928bfa-c05d-4b12-ad67-b2ba63ac7466.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SOY>>(v1);
    }

    // decompiled from Move bytecode v6
}

