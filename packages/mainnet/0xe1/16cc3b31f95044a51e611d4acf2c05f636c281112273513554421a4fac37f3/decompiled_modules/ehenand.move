module 0xe116cc3b31f95044a51e611d4acf2c05f636c281112273513554421a4fac37f3::ehenand {
    struct EHENAND has drop {
        dummy_field: bool,
    }

    fun init(arg0: EHENAND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EHENAND>(arg0, 9, b"EHENAND", b"Aushnwjs", b"Cnkdkd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a9cf5678-2227-44a5-80b7-a07f39e16c33.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EHENAND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EHENAND>>(v1);
    }

    // decompiled from Move bytecode v6
}

