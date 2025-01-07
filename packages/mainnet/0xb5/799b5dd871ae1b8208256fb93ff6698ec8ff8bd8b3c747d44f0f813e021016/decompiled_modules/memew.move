module 0xb5799b5dd871ae1b8208256fb93ff6698ec8ff8bd8b3c747d44f0f813e021016::memew {
    struct MEMEW has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMEW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMEW>(arg0, 9, b"MEMEW", b"Memew coin", b"Memew coin untuk alat pembayaran mem emew", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/85651587-9ee4-4b0e-9ac6-8b94ca5c16e1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMEW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMEW>>(v1);
    }

    // decompiled from Move bytecode v6
}

