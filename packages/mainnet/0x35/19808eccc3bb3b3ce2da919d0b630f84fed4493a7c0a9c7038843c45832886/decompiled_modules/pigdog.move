module 0x3519808eccc3bb3b3ce2da919d0b630f84fed4493a7c0a9c7038843c45832886::pigdog {
    struct PIGDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIGDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIGDOG>(arg0, 9, b"PIGDOG", b"PIGDOG Pig", b"PIGDOG is Pigdog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0e128e20-4add-47bf-83b7-cf680108d7c3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIGDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PIGDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

