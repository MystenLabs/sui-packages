module 0x54094dc450e7b99a8b0c92031cd7e00c6c0df03b2894799953584431f51fcc59::ocean {
    struct OCEAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: OCEAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OCEAN>(arg0, 9, b"OCEAN", b"OCEAN ", b"OCEAN back King", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/80117869-d1c0-4a5c-82ed-087bcb86ac26.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OCEAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OCEAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

