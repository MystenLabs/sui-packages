module 0x841c63db1f1ac8fc3c870e66f814851f48d8bfd5f29dab3dee07104bb72a1645::wkne {
    struct WKNE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WKNE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WKNE>(arg0, 9, b"WKNE", b"zbnd", b"jdnd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b0aaf5db-c36f-4bb6-8fd8-f3b09c050bf9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WKNE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WKNE>>(v1);
    }

    // decompiled from Move bytecode v6
}

